From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 4/4] 95rootfs-block: skip checks rel. to fsck if rd.skipfsck is supplied
Date: Fri, 29 Jun 2012 13:58:21 +0200
Message-ID: <1340971101-1729-4-git-send-email-aidecoe@aidecoe.name>
References: <1340971101-1729-1-git-send-email-aidecoe@aidecoe.name>
 <1340971101-1729-2-git-send-email-aidecoe@aidecoe.name>
 <1340971101-1729-3-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340971101-1729-3-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/95rootfs-block/mount-root.sh |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index 9109638..19f59fa 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -54,20 +54,23 @@ mount_root() {
         fsckoptions=$(cat "$NEWROOT"/fsckoptions)
     fi
 
-    if [ -f "$NEWROOT"/forcefsck ] || getargbool 0 forcefsck ; then
-        fsckoptions="-f $fsckoptions"
-    elif [ -f "$NEWROOT"/.autofsck ]; then
-        [ -f "$NEWROOT"/etc/sysconfig/autofsck ] && . "$NEWROOT"/etc/sysconfig/autofsck
-        if [ "$AUTOFSCK_DEF_CHECK" = "yes" ]; then
-            AUTOFSCK_OPT="$AUTOFSCK_OPT -f"
-        fi
-        if [ -n "$AUTOFSCK_SINGLEUSER" ]; then
-            warn "*** Warning -- the system did not shut down cleanly. "
-            warn "*** Dropping you to a shell; the system will continue"
-            warn "*** when you leave the shell."
-            emergency_shell
+    if ! getargbool 0 rd.skipfsck; then
+        if [ -f "$NEWROOT"/forcefsck ] || getargbool 0 forcefsck ; then
+            fsckoptions="-f $fsckoptions"
+        elif [ -f "$NEWROOT"/.autofsck ]; then
+            [ -f "$NEWROOT"/etc/sysconfig/autofsck ] && \
+                . "$NEWROOT"/etc/sysconfig/autofsck
+            if [ "$AUTOFSCK_DEF_CHECK" = "yes" ]; then
+                AUTOFSCK_OPT="$AUTOFSCK_OPT -f"
+            fi
+            if [ -n "$AUTOFSCK_SINGLEUSER" ]; then
+                warn "*** Warning -- the system did not shut down cleanly. "
+                warn "*** Dropping you to a shell; the system will continue"
+                warn "*** when you leave the shell."
+                emergency_shell
+            fi
+            fsckoptions="$AUTOFSCK_OPT $fsckoptions"
         fi
-        fsckoptions="$AUTOFSCK_OPT $fsckoptions"
     fi
 
     rootopts=
-- 
1.7.8.6
