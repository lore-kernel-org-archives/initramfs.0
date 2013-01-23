From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/6] rootfs-block: Support lilo style device numbers.
Date: Wed, 23 Jan 2013 20:15:04 +0000
Message-ID: <1358972106-2395-5-git-send-email-colin@mageia.org>
References: <1358972106-2395-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358972106-2395-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

Lilo supplies root=900 rather than root=/dev/md0. Similarly it would say root=801 rather
than root=/dev/sda1.

This patch simply interprets that number and creates appropriate udev rules
to create the /dev/root symlink as needed.
---
 modules.d/95rootfs-block/block-genrules.sh | 11 ++++++++++-
 modules.d/95rootfs-block/parse-block.sh    |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/modules.d/95rootfs-block/block-genrules.sh b/modules.d/95rootfs-block/block-genrules.sh
index 7f894ee..161183e 100755
--- a/modules.d/95rootfs-block/block-genrules.sh
+++ b/modules.d/95rootfs-block/block-genrules.sh
@@ -2,7 +2,16 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
-if [ "${root%%:*}" = "block" ]; then
+if [ -n "$rootdevnum" ]; then
+    major=$(( 0x$rootdevnum / 256 ))
+    minor=$(( 0x$rootdevnum - ( $major * 256 ) ))
+    {
+        printf 'ACTION=="add|change", ENV{MAJOR}=="%d", ENV{MINOR}=="%d", SYMLINK+="root"\n' \
+            $major $minor
+    } >> /etc/udev/rules.d/99-root.rules
+
+    wait_for_dev /dev/root
+elif [ "${root%%:*}" = "block" ]; then
     {
         printf 'KERNEL=="%s", SYMLINK+="root"\n' \
             ${root#block:/dev/}
diff --git a/modules.d/95rootfs-block/parse-block.sh b/modules.d/95rootfs-block/parse-block.sh
index 3745352..9efc51f 100755
--- a/modules.d/95rootfs-block/parse-block.sh
+++ b/modules.d/95rootfs-block/parse-block.sh
@@ -19,4 +19,8 @@ case "$root" in
     /dev/*)
         root="block:${root}"
         rootok=1 ;;
+    [1-9][0-9][0-9])
+        rootdevnum=$root
+        root=block:/dev/root
+        rootok=1 ;;
 esac
-- 
1.8.1
