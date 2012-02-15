From: Roberto Sassu <roberto.sassu@polito.it>
Subject: [PATCH 1/2] systemd: mount the securityfs filesystem at early stage
Date: Wed, 15 Feb 2012 14:23:40 +0100
Message-ID: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----0CF1E78FFB0B549AFCE36E209493F469"
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type;
        bh=WrUKfj258AhJAxyAKm4tcpDW/mMYJEs9HLiY5fDSjqA=;
        b=L23e2jU++o/4Nn7Cnqq7lz6yEiXw8YUNqGfY/kDuE0If9LCZKy0IB9xPZzdMlolOuA
         grdU+cAU5FH5bAr6FzzVnxst9ahtUPC7JpjO3wl5YSjKGQMg40YVc7qyNPYhy3LLtwzz
         bDk+CM6V2uwTJ6mmCB+2iTjylNFNdcuCsIdkQ=
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
To: systemd-devel@lists.freedesktop.org
Cc: linux-security-module@vger.kernel.org, linux-ima-user@lists.sourceforge.net, initramfs@vger.kernel.org, ramunno@polito.it, zohar@linux.vnet.ibm.com, mzerqung@0pointer.de, harald@redhat.com, Roberto Sassu <roberto.sassu@polito.it>

This is an S/MIME signed message

------0CF1E78FFB0B549AFCE36E209493F469

The mount of the securityfs filesystem is now performed in the main systemd
executable as it is used by IMA to provide the interface for loading custom
policies. The unit file 'units/sys-kernel-security.mount' has been removed
because it is not longer necessary.

Signed-off-by: Roberto Sassu <roberto.sassu@polito.it>
Acked-by: Gianluca Ramunno <ramunno@polito.it>
---
 Makefile.am                     |    3 ---
 src/mount-setup.c               |    6 ++++--
 src/mount-setup.h               |    2 ++
 units/sys-kernel-security.mount |   17 -----------------
 4 files changed, 6 insertions(+), 22 deletions(-)
 delete mode 100644 units/sys-kernel-security.mount

diff --git a/Makefile.am b/Makefile.am
index 983ea16..d3d0ed8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -291,7 +291,6 @@ dist_systemunit_DATA = \
 	units/dev-mqueue.mount \
 	units/sys-kernel-config.mount \
 	units/sys-kernel-debug.mount \
-	units/sys-kernel-security.mount \
 	units/sys-fs-fuse-connections.mount \
 	units/var-run.mount \
 	units/media.mount \
@@ -2374,7 +2373,6 @@ systemd-install-data-hook:
 			dev-mqueue.mount \
 			sys-kernel-config.mount \
 			sys-kernel-debug.mount \
-			sys-kernel-security.mount \
 			sys-fs-fuse-connections.mount \
 			systemd-modules-load.service \
 			systemd-tmpfiles-setup.service \
@@ -2384,7 +2382,6 @@ systemd-install-data-hook:
 		$(LN_S) ../dev-mqueue.mount dev-mqueue.mount && \
 		$(LN_S) ../sys-kernel-config.mount sys-kernel-config.mount && \
 		$(LN_S) ../sys-kernel-debug.mount sys-kernel-debug.mount && \
-		$(LN_S) ../sys-kernel-security.mount sys-kernel-security.mount && \
 		$(LN_S) ../sys-fs-fuse-connections.mount sys-fs-fuse-connections.mount && \
 		$(LN_S) ../systemd-modules-load.service systemd-modules-load.service && \
 		$(LN_S) ../systemd-tmpfiles-setup.service systemd-tmpfiles-setup.service && \
diff --git a/src/mount-setup.c b/src/mount-setup.c
index 7c14ea8..62bf743 100644
--- a/src/mount-setup.c
+++ b/src/mount-setup.c
@@ -51,13 +51,15 @@ typedef struct MountPoint {
 } MountPoint;
 
 /* The first three entries we might need before SELinux is up. The
- * other ones we can delay until SELinux is loaded. */
-#define N_EARLY_MOUNT 3
+ * fourth (securityfs) is needed by IMA to load a custom policy. The
+ * other ones we can delay until SELinux and IMA are loaded. */
+#define N_EARLY_MOUNT 4
 
 static const MountPoint mount_table[] = {
         { "proc",     "/proc",                  "proc",     NULL,                MS_NOSUID|MS_NOEXEC|MS_NODEV, true },
         { "sysfs",    "/sys",                   "sysfs",    NULL,                MS_NOSUID|MS_NOEXEC|MS_NODEV, true },
         { "devtmpfs", "/dev",                   "devtmpfs", "mode=755",          MS_NOSUID,                    true },
+        { "securityfs", SECURITYFS_MNTPOINT,    "securityfs", NULL,              MS_NOSUID|MS_NOEXEC|MS_NODEV, false },
         { "tmpfs",    "/dev/shm",               "tmpfs",    "mode=1777",         MS_NOSUID|MS_NODEV,           true },
         { "devpts",   "/dev/pts",               "devpts",   "mode=620,gid=" STRINGIFY(TTY_GID), MS_NOSUID|MS_NOEXEC, false },
         { "tmpfs",    "/run",                   "tmpfs",    "mode=755",          MS_NOSUID|MS_NODEV, true },
diff --git a/src/mount-setup.h b/src/mount-setup.h
index c1a27ba..df6f518 100644
--- a/src/mount-setup.h
+++ b/src/mount-setup.h
@@ -24,6 +24,8 @@
 
 #include <stdbool.h>
 
+#define SECURITYFS_MNTPOINT "/sys/kernel/security"
+
 int mount_setup_early(void);
 
 int mount_setup(bool loaded_policy);
diff --git a/units/sys-kernel-security.mount b/units/sys-kernel-security.mount
deleted file mode 100644
index 80cd761..0000000
--- a/units/sys-kernel-security.mount
+++ /dev/null
@@ -1,17 +0,0 @@
-#  This file is part of systemd.
-#
-#  systemd is free software; you can redistribute it and/or modify it
-#  under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-
-[Unit]
-Description=Security File System
-DefaultDependencies=no
-ConditionPathExists=/sys/kernel/security
-Before=sysinit.target
-
-[Mount]
-What=securityfs
-Where=/sys/kernel/security
-Type=securityfs
-- 
1.7.7.6


------0CF1E78FFB0B549AFCE36E209493F469
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMjAyMTUxMzIzNDlaMCMGCSqG
SIb3DQEJBDEWBBTqs1TwZoNSaKFuTdqPSin2ZLtoEjB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAQCSqPdw4cjRTVd6DhdseIuTkOIp
6n3A/gaCKY+rh8uHFDKewEWmfybu4fYnFeD11wQRjL4uwxvMFj0xj9hyAkroA2EW
TFpE2/HIvlBI1PGaHCsweBkU9w5xb/n5E8LxOqh6rpOQZy/wp9U37XxBMNzEwfJ6
FXsukyq6y2R6HM8iiV8yWB3LdUHFrR5qfRQSZiE4wCT7AwgMrL6iyVIYbJub9JD0
Qyxtfdgz/oxBSNmdH+UX4nKhwLS1cKb8trComaU4GPv63hCPInUqzvhBN/noL1JH
HqgGC38hfDaj4VNs12tC3wwoR2/5XkHkt3Ouzl9U4QqcTOjyhoetPgKvYjvk

------0CF1E78FFB0B549AFCE36E209493F469--


