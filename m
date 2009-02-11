From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/9] Dracut cleanups, part 2
Date: Wed, 11 Feb 2009 03:46:38 -0800 (PST)
Message-ID: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=V3I66006UJPi4qfGAh59yExcIHN+ymYZ7r0Jsv9Hq3U=;
        b=bldfCwgOnjl23Dt6Z6Db8tUQq4/jQISQDDIPYHxullFBkFaxyZnR+3X8lgBjb8Pslr
         5YjDTEb/qz9vMnR1xJyqgEydY4DqLsec3vVWFboSR3vkZFVuhSC/3zMElmFugmxKx7L5
         n7+MoHLllXp1QxlaPdDvTOlGsYUpO+8UxuGys=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The first third of this patch series (which applies on top of my last one) 
adds three hook points into the init script:
     one just before udev kicks off, 
     one just before we try to mount the root filesystem, 
     and one just before we switch to the root filesystem. 

It moves encrypted root support and setting the initial SELinux policy to 
hooks, and adds support for resuming from hibernate.

The second two-thirds POSIX-izes all the scripts that are part of dracut that 
end up on the initramfs, and arranges for dash to be used as /bin/sh on the 
initramfs if it is available. 
--- 
Created pre-mount hook directory

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
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
