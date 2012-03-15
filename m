From: Roberto Sassu <roberto.sassu@polito.it>
Subject: [PATCH-v4 2/2] main: added support for loading IMA
	custom policies
Date: Thu, 15 Mar 2012 19:06:11 +0100
Message-ID: <1331834775-7188-2-git-send-email-roberto.sassu@polito.it>
References: <1331834775-7188-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1842515777=="
Return-path: <systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
	:references:mime-version:content-type;
	bh=PxseuYHfGj3p9yvgytfZRVN+CabFLY3R/toV1Tp4wF0=;
	b=hZdtPNutlZGzEG/hYVT6aVi6xbIwpiJ3fCg8alFk4LCPJrCKyvLxXy2QEeJn/oxxqY
	lVrdiPQAi+Qx9H5zDaIzP92W5Aeo9UT4PLI8FjTWRlep7lBN2AjHFMflDEEWZPz0fjf5
	doFtR0lBzw5EHrx6ynCXOKpVFlGYj39oGfUv7mqoDoe+eyWYqt+jGecdD9uLq63PrmDw
	WWpnkzRWS/sPotTqc/elo25HCfKOpiDu+oE5BrYIxNgqG4eEhChVWO9jgSXzn77qSCDD
	1E3z+p6m+jdf4d0Piu0xvnvwfTIjcnJM3QK2Mwnl13zvHZSKGsUIF/eCSmaxFpBhq/lv
	3ZCg==
In-Reply-To: <1331834775-7188-1-git-send-email-roberto.sassu@polito.it>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
Errors-To: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
To: systemd-devel@lists.freedesktop.org
Cc: initramfs@vger.kernel.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, mzerqung@0pointer.de, Roberto Sassu <roberto.sassu@polito.it>, zohar@linux.vnet.ibm.com, harald@redhat.com, ramunno@polito.it

This is an S/MIME signed message

--===============1842515777==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----A879508705D7EAC8E50E36E721D58FC3"

This is an S/MIME signed message

------A879508705D7EAC8E50E36E721D58FC3

The new function ima_setup() loads an IMA custom policy from a file in the
default location '/etc/ima/ima-policy', if present, and writes it to the
path 'ima/policy' in the security filesystem. This function is executed
at early stage in order to avoid that some file operations are not measured
by IMA and it is placed after the initialization of SELinux because IMA
needs the latter (or other security modules) to understand LSM-specific
rules. This feature is enabled by default and can be disabled by providing
the option '--disable-ima' to the configure script.

Signed-off-by: Roberto Sassu <roberto.sassu@polito.it>
Acked-by: Gianluca Ramunno <ramunno@polito.it>
---
 Makefile.am     |    1 +
 configure.ac    |   14 +++++++
 src/build.h     |    8 +++-
 src/ima-setup.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ima-setup.h |   29 ++++++++++++++
 src/main.c      |    6 ++-
 6 files changed, 171 insertions(+), 2 deletions(-)
 create mode 100644 src/ima-setup.c
 create mode 100644 src/ima-setup.h

diff --git a/Makefile.am b/Makefile.am
index c0fcd70..08c7ea7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -516,6 +516,7 @@ libsystemd_core_la_SOURCES = \
 	src/mount-setup.c \
 	src/hostname-setup.c \
 	src/selinux-setup.c \
+	src/ima-setup.c \
 	src/loopback-setup.c \
 	src/kmod-setup.c \
 	src/locale-setup.c \
diff --git a/configure.ac b/configure.ac
index 3860088..b562078 100644
--- a/configure.ac
+++ b/configure.ac
@@ -127,6 +127,19 @@ PKG_CHECK_MODULES(UDEV, [ libudev >= 172 ])
 PKG_CHECK_MODULES(DBUS, [ dbus-1 >= 1.3.2 ])
 PKG_CHECK_MODULES(KMOD, [ libkmod >= 5 ])
 
+have_ima=yes
+AC_ARG_ENABLE([ima], AS_HELP_STRING([--disable-ima],[Disable optional IMA support]),
+                [case "${enableval}" in
+                        yes) have_ima=yes ;;
+                        no) have_ima=no ;;
+                        *) AC_MSG_ERROR(bad value ${enableval} for --disable-ima) ;;
+                esac],
+                [have_ima=yes])
+
+if test "x${have_ima}" != xno ; then
+        AC_DEFINE(HAVE_IMA, 1, [Define if IMA is available])
+fi
+
 have_selinux=no
 AC_ARG_ENABLE(selinux, AS_HELP_STRING([--disable-selinux], [Disable optional SELINUX support]))
 if test "x$enable_selinux" != "xno"; then
@@ -629,6 +642,7 @@ AC_MSG_RESULT([
         tcpwrap:                 ${have_tcpwrap}
         PAM:                     ${have_pam}
         AUDIT:                   ${have_audit}
+        IMA:                     ${have_ima}
         SELinux:                 ${have_selinux}
         XZ:                      ${have_xz}
         ACL:                     ${have_acl}
diff --git a/src/build.h b/src/build.h
index 50cd79d..0619013 100644
--- a/src/build.h
+++ b/src/build.h
@@ -46,6 +46,12 @@
 #define _SELINUX_FEATURE_ "-SELINUX"
 #endif
 
+#ifdef HAVE_IMA
+#define _IMA_FEATURE_ "+IMA"
+#else
+#define _IMA_FEATURE_ "-IMA"
+#endif
+
 #ifdef HAVE_SYSV_COMPAT
 #define _SYSVINIT_FEATURE_ "+SYSVINIT"
 #else
@@ -58,6 +64,6 @@
 #define _LIBCRYPTSETUP_FEATURE_ "-LIBCRYPTSETUP"
 #endif
 
-#define SYSTEMD_FEATURES _PAM_FEATURE_ " " _LIBWRAP_FEATURE_ " " _AUDIT_FEATURE_ " " _SELINUX_FEATURE_ " " _SYSVINIT_FEATURE_ " " _LIBCRYPTSETUP_FEATURE_
+#define SYSTEMD_FEATURES _PAM_FEATURE_ " " _LIBWRAP_FEATURE_ " " _AUDIT_FEATURE_ " " _SELINUX_FEATURE_ " " _IMA_FEATURE_ " " _SYSVINIT_FEATURE_ " " _LIBCRYPTSETUP_FEATURE_
 
 #endif
diff --git a/src/ima-setup.c b/src/ima-setup.c
new file mode 100644
index 0000000..03e43dc
--- /dev/null
+++ b/src/ima-setup.c
@@ -0,0 +1,115 @@
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
+#define IMA_SECFS_DIR "/sys/kernel/security/ima"
+#define IMA_SECFS_POLICY IMA_SECFS_DIR "/policy"
+#define IMA_POLICY_PATH "/etc/ima/ima-policy"
+
+int ima_setup(void) {
+
+#ifdef HAVE_IMA
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
+       if (stat(IMA_POLICY_PATH, &st) < 0)
+               return 0;
+
+       policy_size = st.st_size;
+       if (stat(IMA_SECFS_DIR, &st) < 0) {
+               log_debug("IMA support is disabled in the kernel, ignoring.");
+               return 0;
+       }
+
+       if (stat(IMA_SECFS_POLICY, &st) < 0) {
+               log_error("Another IMA custom policy has already been loaded, "
+                         "ignoring.");
+               return 0;
+       }
+
+       policyfd = open(IMA_POLICY_PATH, O_RDONLY|O_CLOEXEC);
+       if (policyfd < 0) {
+               log_error("Failed to open the IMA custom policy file %s (%m), "
+                         "ignoring.", IMA_POLICY_PATH);
+               return 0;
+       }
+
+       imafd = open(IMA_SECFS_POLICY, O_WRONLY|O_CLOEXEC);
+       if (imafd < 0) {
+               log_error("Failed to open the IMA kernel interface %s (%m), "
+                         "ignoring.", IMA_SECFS_POLICY);
+               goto out;
+       }
+
+       policy = mmap(NULL, policy_size, PROT_READ, MAP_PRIVATE, policyfd, 0);
+       if (policy == MAP_FAILED) {
+               log_error("mmap() failed (%m), freezing");
+               result = -errno;
+               goto out;
+       }
+
+       written = loop_write(imafd, policy, (size_t)policy_size, false);
+       if (written != policy_size) {
+               log_error("Failed to load the IMA custom policy file %s (%m), "
+                         "ignoring.", IMA_POLICY_PATH);
+               goto out_mmap;
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
+       if (result)
+                return result;
+#endif /* HAVE_IMA */
+
+       return 0;
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


------A879508705D7EAC8E50E36E721D58FC3
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMjAzMTUxODA2NDVaMCMGCSqG
SIb3DQEJBDEWBBSTpKAFKGkdvaQupM4LREeW2XgwOjB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAQBnVoAXum6W4H8Iq68ERfscre/U
tr1oWqKLkwwrhH05O5kGBZoAn6Srcf4V0MspNJ3Zhe+UPewajQixbTn9fvsvudOy
vbbM1yAbB87C15rRLS6wX02vjmRJRyavzmz4dtrflBOcuzH1QR2KdfBucijw2Ujt
FHeA+xqDZ6+D3C88jRWdPfas6U4g+cNccEeYa6mPkD+e8BrwAaEEhcIquSrK4t5F
hMA5VFm3Okz3kVVJK5ceO1/0Lp6a0HKQ6sXglDxUlNbaQT4rDrZe/Q3wmh1CfxO9
NyJ4tUD6d2Rkh6IqQbLvkUoTgQvNYMfTYBla55kRiPFIf+8Ew31RVyHEtGmA

------A879508705D7EAC8E50E36E721D58FC3--



--===============1842515777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
systemd-devel mailing list
systemd-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/systemd-devel

--===============1842515777==--


