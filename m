From: Juan RP <xtraeme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Avoid annonying warnings when pkg-config is not installed.
Date: Wed, 6 Jun 2012 14:27:34 +0200
Message-ID: <20120606142734.a7abbbd9.xtraeme@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Jd2F4almsqi3MUKYCCXaqqTMW8NgXnhkot1KoqZRedA=;
        b=bqx7olRBohzOw/89ul3zDNNafxR7RmBRdkNnoH2MLXoqS0XNfW4GuDTdl40RU9TQ8K
         /dbaZG1k0uFr9hrQ1BzO19gZFN0SwM3L1SjvI/wvhkfvrLuRHm3PepqTzvFs4X8Cs/SU
         RfFJiuc0j78jbr/1Cp3nchXT2ZKIvpY9+iZGkCcr9ewkmWyMVs55OIQcKnFo1gz7Cade
         eGXfnXfY4PQVqN0C4Oc6SYRJw3dgjPF7LXO1fi4OqvSuODnfmHEkdsj9RXmUU/9bw1km
         VRiwElNge1EVplinNKPqxs7n85I2hWyk4VyDMIU32x4fUb/aZ5FjLNESMpjaO5U7xwTh
         p7PQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


From 7f805792b626e10baa87554dc5efc48cc86c6e5d Mon Sep 17 00:00:00 2001
From: Juan RP <xtraeme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 6 Jun 2012 14:19:59 +0200
Subject: [PATCH] Avoid annonying warnings when pkg-config is not installed.

---
 dracut-functions.sh                    |    2 +-
 modules.d/95udev-rules/module-setup.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index f788878..4180f03 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -531,7 +531,7 @@ inst_symlink() {
     ln -sfn $(convert_abs_rel "${_target}" "${_realsrc}") "$initdir/$_target"
 }
 
-udevdir=$(pkg-config udev --variable=udevdir)
+udevdir=$(pkg-config udev --variable=udevdir 2>/dev/null)
 if ! [[ -d "$udevdir" ]]; then
     [[ -d /lib/udev ]] && udevdir=/lib/udev
     [[ -d /usr/lib/udev ]] && udevdir=/usr/lib/udev
diff --git a/modules.d/95udev-rules/module-setup.sh b/modules.d/95udev-rules/module-setup.sh
index e8c1c04..ff47021 100755
--- a/modules.d/95udev-rules/module-setup.sh
+++ b/modules.d/95udev-rules/module-setup.sh
@@ -5,13 +5,13 @@
 install() {
     local _i
 
-    systemdutildir=$(pkg-config systemd --variable=systemdutildir)
+    systemdutildir=$(pkg-config systemd --variable=systemdutildir 2>/dev/null)
     if ! [[ -d "$systemdutildir" ]]; then
         [[ -d /lib/systemd ]] && systemdutildir=/lib/systemd
         [[ -d /usr/lib/systemd ]] && systemdutildir=/usr/lib/systemd
     fi
 
-    udevdir=$(pkg-config udev --variable=udevdir)
+    udevdir=$(pkg-config udev --variable=udevdir 2>/dev/null)
     if ! [[ -d "$udevdir" ]]; then
         [[ -d /lib/udev ]] && udevdir=/lib/udev
         [[ -d /usr/lib/udev ]] && udevdir=/usr/lib/udev
-- 
1.7.10.3

