From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 06/10] check root candidates more carefully
Date: Tue, 18 Oct 2011 20:33:22 +0200
Message-ID: <1318962806-24000-7-git-send-email-soltys@ziu.info>
References: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318962806-24000-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is from the following thread:

http://thread.gmane.org/gmane.linux.raid/35753/focus=35795

Additional tests + more specific info.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |   11 +++++++++++
 modules.d/99base/init          |   12 ++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 62c3bf5..cf5aae6 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -544,3 +544,14 @@ foreach_uuid_until() (
 
     return 1
 )
+
+usable_root() {
+    local _d
+    [ -d $1 ] || return 1
+    for _d in "$1"/{etc,proc,sys,dev,tmp,usr,var}; do
+        [ -e $_d ] || return 1
+    done
+    [ -e "$1/bin" -o -e "$1/sbin" ] || return 1
+    [ -e "$1/lib" -o -e "$1/lib64" ] || return 1
+    return 0
+}
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 0970a48..bc5d2ba 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -298,10 +298,18 @@ getarg 'rd.break=mount' 'rdbreak=mount' && emergency_shell -n mount "Break mount
 # be sourced any number of times. As soon as one suceeds, no more are sourced.
 i=0
 while :; do
-    [ -d "$NEWROOT/proc" ] && break;
+    if ismounted "$NEWROOT"; then
+        usable_root "$NEWROOT" && break;
+        umount "$NEWROOT"
+    fi
     for f in $hookdir/mount/*.sh; do
         [ -f "$f" ] && . "$f"
-        [ -d "$NEWROOT/proc" ] && break;
+        if ismounted "$NEWROOT"; then
+            usable_root "$NEWROOT" && break;
+            warn "$NEWROOT has no proper rootfs layout, ignoring and removing offending mount hook"
+            umount "$NEWROOT"
+            rm -f "$f"
+        fi
     done
 
     i=$(($i+1))
-- 
1.7.5.3
