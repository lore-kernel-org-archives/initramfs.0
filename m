From: Roberto Sassu <roberto.sassu@polito.it>
Subject: [PATCH 2/2] main: added support for loading IMA custom policies
Date: Wed, 15 Feb 2012 14:23:41 +0100
Message-ID: <1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----14FEF9169809D790281CF3B676D40890"
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type;
        bh=cJ3eQ6aeV4JXEMJcc+SSXhOut2X667XgsYUeCbT6C1M=;
        b=oxNl7Ww6/Ut6y1M/dcDNFoekHHjCocPCdEeSiyHCNY7uzWNZkXZJ6sz06F8yypiNi9
         lZcmbD+JgnclhchuD9QMufK4DElMLCs5dwRNCQSxPDVlQeKhwNgQIduAlnHqbkawMp9T
         QrJE0TClvlPIUvGQBHhFSSK+MeLNLVNS8CU7g=
In-Reply-To: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
To: systemd-devel@lists.freedesktop.org
Cc: linux-security-module@vger.kernel.org, linux-ima-user@lists.sourceforge.net, initramfs@vger.kernel.org, ramunno@polito.it, zohar@linux.vnet.ibm.com, mzerqung@0pointer.de, harald@redhat.com, Roberto Sassu <roberto.sassu@polito.it>

This is an S/MIME signed message

------14FEF9169809D790281CF3B676D40890

The new function ima_setup() loads an IMA custom policy from a file in the
default location '/etc/sysconfig/ima-policy', if present, and writes it to
the path 'ima/policy' in the security filesystem. This function is executed
at early stage in order to avoid that some file operations are not measured
by IMA and it is placed after the initialization of SELinux because IMA
needs the latter (or other security modules) to understand LSM-specific
rules.

Signed-off-by: Roberto Sassu <roberto.sassu@polito.it>
Acked-by: Gianluca Ramunno <ramunno@polito.it>
---
 Makefile.am     |    1 +
 src/ima-setup.c |  114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ima-setup.h |   29 ++++++++++++++
 src/main.c      |    6 ++-
 4 files changed, 149 insertions(+), 1 deletions(-)
 create mode 100644 src/ima-setup.c
 create mode 100644 src/ima-setup.h

diff --git a/Makefile.am b/Makefile.am
index d3d0ed8..7476caa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -515,6 +515,7 @@ libsystemd_core_la_SOURCES = \
 	src/mount-setup.c \
 	src/hostname-setup.c \
 	src/selinux-setup.c \
+	src/ima-setup.c \
 	src/loopback-setup.c \
 	src/kmod-setup.c \
 	src/locale-setup.c \
diff --git a/src/ima-setup.c b/src/ima-setup.c
new file mode 100644
index 0000000..45afc0c
--- /dev/null
+++ b/src/ima-setup.c
@@ -0,0 +1,114 @@
+/*-*- Mode: C; c-basic-offset: 8; indent-tabs-mode: nil -*-*/
+
+/***
+  This file is part of systemd.
+
+  Copyright 2010 Lennart Poettering
+  Copyright (C) 2012 Roberto Sassu - Politecnico di Torino, Italy
+                                     TORSEC group -- http://security.polito.it
+
+  systemd is free software; you can redistribute it and/or modify it
+  under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  systemd is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with systemd; If not, see <http://www.gnu.org/licenses/>.
+***/
+
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+#include "ima-setup.h"
+#include "mount-setup.h"
+#include "macro.h"
+#include "util.h"
+#include "log.h"
+#include "label.h"
+
+#define IMA_SECFS_DIR SECURITYFS_MNTPOINT "/ima"
+#define IMA_SECFS_POLICY IMA_SECFS_DIR "/policy"
+#define IMA_POLICY_PATH "/etc/sysconfig/ima-policy"
+
+int ima_setup(void) {
+       struct stat st;
+       ssize_t policy_size = 0, written = 0;
+       char *policy;
+       int policyfd = -1, imafd = -1;
+       int result = 0;
+
+#ifndef HAVE_SELINUX
+       /* Mount the securityfs filesystem */
+       mount_setup_early();
+#endif
+
+       if (stat(IMA_POLICY_PATH, &st) == -1)
+               return 0;
+
+       policy_size = st.st_size;
+       if (stat(IMA_SECFS_DIR, &st) == -1) {
+               log_debug("IMA support is disabled in the kernel, ignoring.");
+               return 0;
+       }
+
+       if (stat(IMA_SECFS_POLICY, &st) == -1) {
+               log_error("Another IMA custom policy has already been loaded, "
+                         "ignoring.");
+               return 0;
+       }
+
+       policyfd = open(IMA_POLICY_PATH, O_RDONLY);
+       if (policyfd < 0) {
+               log_error("Failed to open the IMA custom policy file %s (%s), "
+                         "ignoring.", IMA_POLICY_PATH, strerror(errno));
+               return 0;
+       }
+
+       imafd = open(IMA_SECFS_POLICY, O_WRONLY);
+       if (imafd < 0) {
+               log_error("Failed to open the IMA kernel interface %s (%s), "
+                         "ignoring.", IMA_SECFS_POLICY, strerror(errno));
+               goto out;
+       }
+
+       policy = mmap(NULL, policy_size, PROT_READ, MAP_PRIVATE, policyfd, 0);
+       if (policy == NULL) {
+               log_error("mmap() failed (%s), freezing", strerror(errno));
+               result = -errno;
+               goto out;
+       }
+
+       while(written < policy_size) {
+               ssize_t len = write(imafd, policy + written,
+                                   policy_size - written);
+               if (len <= 0) {
+                         log_error("Failed to load the IMA custom policy "
+                                   "file %s (%s), ignoring.", IMA_POLICY_PATH,
+                                   strerror(errno));
+                         goto out_mmap;
+               }
+               written += len;
+       }
+
+       log_info("Successfully loaded the IMA custom policy %s.",
+                IMA_POLICY_PATH);
+out_mmap:
+       munmap(policy, policy_size);
+out:
+       if (policyfd >= 0)
+                close_nointr_nofail(policyfd);
+       if (imafd >= 0)
+                close_nointr_nofail(imafd);
+       return result;
+}
diff --git a/src/ima-setup.h b/src/ima-setup.h
new file mode 100644
index 0000000..7d677cf
--- /dev/null
+++ b/src/ima-setup.h
@@ -0,0 +1,29 @@
+/*-*- Mode: C; c-basic-offset: 8; indent-tabs-mode: nil -*-*/
+
+#ifndef fooimasetuphfoo
+#define fooimasetuphfoo
+
+/***
+  This file is part of systemd.
+
+  Copyright 2010 Lennart Poettering
+  Copyright (C) 2012 Roberto Sassu - Politecnico di Torino, Italy
+                                     TORSEC group -- http://security.polito.it
+
+  systemd is free software; you can redistribute it and/or modify it
+  under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  systemd is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with systemd; If not, see <http://www.gnu.org/licenses/>.
+***/
+
+int ima_setup(void);
+
+#endif
diff --git a/src/main.c b/src/main.c
index ed317b4..7ae8841 100644
--- a/src/main.c
+++ b/src/main.c
@@ -41,6 +41,7 @@
 #include "kmod-setup.h"
 #include "locale-setup.h"
 #include "selinux-setup.h"
+#include "ima-setup.h"
 #include "machine-id-setup.h"
 #include "load-fragment.h"
 #include "fdset.h"
@@ -1203,9 +1204,12 @@ int main(int argc, char *argv[]) {
                 arg_running_as = MANAGER_SYSTEM;
                 log_set_target(detect_container(NULL) > 0 ? LOG_TARGET_CONSOLE : LOG_TARGET_JOURNAL_OR_KMSG);
 
-                if (!is_reexec)
+                if (!is_reexec) {
                         if (selinux_setup(&loaded_policy) < 0)
                                 goto finish;
+                        if (ima_setup() < 0)
+                                goto finish;
+                }
 
                 log_open();
 
-- 
1.7.7.6


------14FEF9169809D790281CF3B676D40890
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIICQYJKoZIhvcNAQcCoIIH+jCCB/YCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCBWQwggVgMIIESKADAgECAgICuzANBgkqhkiG9w0BAQUFADBlMQswCQYD
VQQGEwJJVDEeMBwGA1UEChMVUG9saXRlY25pY28gZGkgVG9yaW5vMTYwNAYDVQQD
Ey1Qb2xpdGVjbmljbyBkaSBUb3Jpbm8gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkw
HhcNMTAxMjIwMTExOTU0WhcNMTUxMjMxMjM1OTU5WjBfMQswCQYDVQQGEwJJVDEe
MBwGA1UEChMVUG9saXRlY25pY28gZGkgVG9yaW5vMRcwFQYDVQQDEw5Sb2JlcnRv
ICBTYXNzdTEXMBUGCgmSJomT8ixkAQETB2QwMjEzMDUwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDS6p4SaJdmmJHJu9On9ZohhBFE2GgYiY7YtRnhhQJA
NfOtHEhSbpUMaSOfq/Pna6ipR5nAFrlM8cOGcSHZdxrPcgzeJU7F2v1fl2ThvFOc
TIkcC1aAJGQUuCaCXDlQt+KFecJWTrRZnalMHZueO+J6cgHcvR1CQz5e88dSzo3Q
XZy0w/hxGL9Ht9velqsl48ohBk2rs/svAOCp6GfqT1Yxwx1p87d3ViTrmuZB4/X+
da39nJqmo6AZ/y3Zg+r91BgNcfsHVqFT0JTcG6qRIaeqTtqVYpYl+rH1rZzYCakD
yQyys66sBvaXyaiMr0M+SpyH+LaGz5bDn5Odq16FYEq7AgMBAAGjggIeMIICGjAO
BgNVHQ8BAf8EBAMCA/gwJwYDVR0lBCAwHgYIKwYBBQUHAwIGCCsGAQUFBwMDBggr
BgEFBQcDBDAiBgNVHREEGzAZgRdyb2JlcnRvLnNhc3N1QHBvbGl0by5pdDAMBgNV
HRMBAf8EAjAAMB0GA1UdDgQWBBQgKbXSXn+j769x0tsZQ9pSOzIIdDAfBgNVHSME
GDAWgBTNm1tbnup2IcQQaOjSLTfbHy/I5DCBywYDVR0gBIHDMIHAMD4GCisGAQQB
qQcBAQIwMDAuBggrBgEFBQcCARYiaHR0cDovL3d3dy5ldXJvcGtpLm9yZy9jYS9j
cHMvMS4yLzBEBgorBgEEAakHAgECMDYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cu
aXRhbHkuZXVyb3BraS5vcmcvY2EvY3BzLzEuMi8wOAYKKwYBBAGVYgECAjAqMCgG
CCsGAQUFBwIBFhxodHRwOi8vY2EucG9saXRvLml0L2Nwcy8yLjIvMGYGCCsGAQUF
BwEBBFowWDAhBggrBgEFBQcwAYYVaHR0cDovL29jc3AucG9saXRvLml0MDMGCCsG
AQUFBzAChidodHRwOi8vY2EucG9saXRvLml0L2NlcnRzL3BvbGl0b19jYS5jZXIw
NwYDVR0fBDAwLjAsoCqgKIYmaHR0cDovL2NhLnBvbGl0by5pdC9jcmwvcG9saXRv
X2NybC5jcmwwDQYJKoZIhvcNAQEFBQADggEBADMe0aHcBJXV6pMJPVVSt1Vazd8Y
LuTLO45Igs9Sb2LuaO6pvcDGvq9dEJnBhP1B+zBAK6WEA1PWb66xC4QXaJnlGZTX
S3XeBivHWm6BNOH2kNeU0HBeGZCV/n5r70TPxkEAcc7u8YY2i6CiMM428YhZK8Zj
oN9D3QNIRf4HZgh0FTbf8eL/XvBbK/oPC+Rew+Qql6M3DHnaS1q2SKUwwO/4VXA4
JsOdatFI68AMXH0Xx9UIcjRi+kvsyvwHlc0Z8AoAtfRMoIl4zFF4Qaowec2UunBK
YlqPpFTtU9czuoEP12A86nqSVsoNok2mZOeYa9IdIjeE2rfdKx6k3YNRg08xggJt
MIICaQIBATBrMGUxCzAJBgNVBAYTAklUMR4wHAYDVQQKExVQb2xpdGVjbmljbyBk
aSBUb3Jpbm8xNjA0BgNVBAMTLVBvbGl0ZWNuaWNvIGRpIFRvcmlubyBDZXJ0aWZp
Y2F0aW9uIEF1dGhvcml0eQICArswCQYFKw4DAhoFAKCB2DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMjAyMTUxMzI0MTZaMCMGCSqG
SIb3DQEJBDEWBBRtaQoeVWU1dslo1E9kr/yP9rtKiDB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAQBKjvqpNC1O9gIlLHLoCbDb+XXJ
PlOI4WF3JDkLiVxzT8+yBcLDVKY0incpoX6K8gOllVxqd/sLhaRY8zWhXK5lt7o6
8CcD7dTsjCos2EBbscz/LAE2LNhihgDl8/BX9X/uh2+/wKT2nhwx116rZ8Vjg7wD
6a0la1aWdy0xu/ducgMLC/jV3dPv0jWY3QSCYt30PRres91z2Ys3dN+rdCzQKiFm
S1i2UqpUOhJn0VeDngsvNmLufyflGzNjtmaQx7+Y1W1/VhJmm1HydzQcMr6x567w
Bk1ndc4Fs/uL0eVRIjlYd8Hugm/oDJnx5utJ6G9mGT6B3N3DBrSeYYrZBSHz

------14FEF9169809D790281CF3B676D40890--


