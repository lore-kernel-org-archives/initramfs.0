From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] use mount --rbind to move submounts under /run into $NEWROOT
Date: Mon, 19 Mar 2012 14:01:20 -0400
Message-ID: <1332180080-13762-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

With mount --bind, anything mounted under /run will disappear after
switch_root. This behavior is sort of surprising, since /run is supposed
to be preserved.

This patch uses --rbind so submounts of /run get put into $NEWROOT.

It also does the same thing for 98selinux/selinux-loadpolicy.sh when it
bind-mounts /dev into $NEWROOT so it can run restorecon on it.
---
 modules.d/98selinux/selinux-loadpolicy.sh |    2 +-
 modules.d/99base/init.sh                  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/98selinux/selinux-loadpolicy.sh b/modules.d/98selinux/selinux-loadpolicy.sh
index 6eb1dbb..d6e24d6 100755
--- a/modules.d/98selinux/selinux-loadpolicy.sh
+++ b/modules.d/98selinux/selinux-loadpolicy.sh
@@ -43,7 +43,7 @@ rd_load_policy()
         if [ $ret -eq 0 -o $ret -eq 2 ]; then
             # If machine requires a relabel, force to permissive mode
             [ -e "$NEWROOT"/.autorelabel ] && LANG=C /usr/sbin/setenforce 0
-            mount --bind /dev "$NEWROOT/dev"
+            mount --rbind /dev "$NEWROOT/dev"
             LANG=C chroot "$NEWROOT" /sbin/restorecon -R /dev
             return 0
         fi
diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index 5d51c9d..05da6bb 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -314,7 +314,7 @@ fi
 
 if [ -d "$NEWROOT"/run ]; then
     NEWRUN="${NEWROOT}/run"
-    mount --bind /run "$NEWRUN"
+    mount --rbind /run "$NEWRUN"
     NEWINITRAMFSROOT="$NEWRUN/initramfs"
 
     if [ "$NEWINITRAMFSROOT/lib" -ef "/lib" ]; then
@@ -325,7 +325,7 @@ if [ -d "$NEWROOT"/run ]; then
 else
     NEWRUN=/dev/.initramfs
     mkdir -m 0755 "$NEWRUN"
-    mount --bind /run/initramfs "$NEWRUN"
+    mount --rbind /run/initramfs "$NEWRUN"
 fi
 
 wait_for_loginit
-- 
1.7.7.6
