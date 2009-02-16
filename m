From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 32/50] Created pre-mount hook directory
Date: Mon, 16 Feb 2009 14:06:49 -0500
Message-ID: <200902161906.n1GJ6ntG028388@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=cd20f1f6ebed3c50d69db35d22519d57ae846ecc
Commit:     cd20f1f6ebed3c50d69db35d22519d57ae846ecc
Parent:     b32f55156d345ddc52c16482ade1766acdda666b
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:48 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 32/50] Created pre-mount hook directory
    
    This is for tasks that should run after device discovery, but before
    mounting the new rootfs.  Things like cryptoroot and resume from hibernate
    should go here.
    
    Hooks are sourced, not executed as separate scripts.
---
 init                  |   16 ++++++++++------
 pre-mount/50cryptroot |    6 ++++++
 pre-mount/99resume    |    7 +++++++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/init b/init
index b12743c..0b158dc 100755
--- a/init
+++ b/init
@@ -14,9 +14,17 @@ emergency_shell()
 }
 
 getarg() {
+    local o;
     for o in $(< /proc/cmdline); do
 	[[ $o == $1 ]] && { echo $o; break; }
     done
+    return 1
+}
+
+source_all() {
+    local f
+    [[ -d $1 ]] || return
+    for f in "$d"/*; do; . "$f"; done
 }
 
 echo "Starting initrd..."
@@ -67,12 +75,8 @@ esac
 tries=0
 echo "Waiting up to 30 seconds for $root to become available"
 udevadm settle --timeout=30
-[[ -f /cryptroot ]] && {
-    echo "Encrypted root detected."
-    cryptopts=$(< /cryptroot)
-    /sbin/cryptsetup luksOpen $cryptopts || emergency_shell
-    udevadm settle --timeout=30
-}
+source_all /pre-mount
+
 echo "Trying to mount rootfs $root"
 [[ -e $root ]] || emergency_shell
 ln -s "$root" /dev/root    
diff --git a/pre-mount/50cryptroot b/pre-mount/50cryptroot
new file mode 100644
index 0000000..39e6e6e
--- /dev/null
+++ b/pre-mount/50cryptroot
@@ -0,0 +1,6 @@
+#!/bin/bash
+[[ -f /cryptroot ]] || return
+echo "Encrypted root detected."
+cryptopts=$(< /cryptroot)
+/sbin/cryptsetup luksOpen $cryptopts || emergency_shell
+udevadm settle --timeout=30
diff --git a/pre-mount/99resume b/pre-mount/99resume
new file mode 100644
index 0000000..7eacd38
--- /dev/null
+++ b/pre-mount/99resume
@@ -0,0 +1,7 @@
+#!/bin/bash
+resume=$(getarg 'resume=*') || return
+resume=${resume#resume=}
+[[ -b $resume ]] || return
+# parsing the output of ls is Bad, but until there is a better way...
+read x x x x maj min x < <(ls -lH "$resume")
+echo "${maj/,/}:$min"> /sys/power/resume
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
