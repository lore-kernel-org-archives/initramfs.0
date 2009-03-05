From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] Modify getarg to be slightly more useful.
Date: Wed, 04 Mar 2009 18:40:34 -0800 (PST)
Message-ID: <d19ad762e4184f1c95abf050775e5b27ca927c44.1236220506.git.victor.lowther@gmail.com>
References: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1236220506.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=kRkaejhKktvuUmCFG4jwU25QX1X7qB44cou3yNhDJDI=;
        b=VYy5IJp8OmCAB+KmfDAr3Vlxfgpc72H4DRYTETo8Cr19IDn31Z3cqaNzgUt1r/iRsB
         EI10o+q/EN1hgtYLkKZUbxvBiuU1H9hSCD+H/Gr5YVU6/CibL8Ehk8IwRiw11VrwdsQC
         SNC2TScLn9Unun98lWvgj8JjyuJJLgkrqS/aA=
In-Reply-To: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1236220506.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If the last character in the argument to search for is "=", then
getarg will echo all the text after the = as well as returning 0 or 1 depending
on whether or not the arg is found.
Otherwise, getarg will just return 0 if the exact test of the argument is found,
1 otherwise.

---
 hooks/mount-partition.sh |   17 +++++++----------
 hooks/resume.sh          |   13 +++++--------
 init                     |   20 +++++++++-----------
 modules/95udev-rules.sh  |    4 +++-
 4 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/hooks/mount-partition.sh b/hooks/mount-partition.sh
index 53a0f4c..f554c28 100755
--- a/hooks/mount-partition.sh
+++ b/hooks/mount-partition.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 [ "$root" ] || {
-    root=$(getarg root); root=${root#root=}
+    root=$(getarg root=)
     case $root in
 	LABEL=*) root=${root#LABEL=}
             root="$(echo $root |sed 's,/,\\x2f,g')"
@@ -12,19 +12,16 @@
 }
 
 [ "$rflags" ] || {
-    if rflags="$(getarg rootflags)"; then
-	rflags="${rflags#rootflags=}"
-	getarg rw >/dev/null && rflags="${rflags},rw" || rflags="${rflags},ro"
+    if rflags="$(getarg rootflags=)"; then
+	getarg rw && rflags="${rflags},rw" || rflags="${rflags},ro"
     else
-	getarg rw >/dev/null && rflags=rw || rflags=ro
+	getarg rw && rflags=rw || rflags=ro
     fi
 }
 
 [ "$fstype" ] || {
-    fstype="$(getarg rootfstype)" && fstype="-t ${fstype#rootfstype=}"
+    fstype="$(getarg rootfstype=)" && fstype="-t ${fstype}"
 }
 
-[ -e "$root" ] && {
-    ln -sf "$root" /dev/root
-    mount $fstype -o $rflags /dev/root $NEWROOT && ROOTFS_MOUNTED=yes
-}
+[ -e "$root" ] && mount $fstype -o "$rflags" "$root" "$NEWROOT" && \
+    ROOTFS_MOUNTED=yes
diff --git a/hooks/resume.sh b/hooks/resume.sh
index 619d634..a01a613 100755
--- a/hooks/resume.sh
+++ b/hooks/resume.sh
@@ -1,10 +1,7 @@
 #!/bin/sh
-resume=$(getarg resume) && [ "$(getarg noresume)" = "" ] && {
-    resume=${resume#resume=}
-    [ -b "$resume" ] && {
-        # parsing the output of ls is Bad, but until there is a better way...
-	ls -lH "$resume" | ( 
-	    read x x x x maj min x;
-	    echo "${maj%,}:$min"> /sys/power/resume)
-    }
+resume=$(getarg resume=) && ! getarg noresume && [ -b "$resume" ] && {
+    # parsing the output of ls is Bad, but until there is a better way...
+    ls -lH "$resume" | ( 
+	read x x x x maj min x;
+	echo "${maj%,}:$min"> /sys/power/resume)
 }
diff --git a/init b/init
index 3652216..c3f5150 100755
--- a/init
+++ b/init
@@ -16,7 +16,8 @@ emergency_shell()
 getarg() {
     local o line
     for o in $CMDLINE; do
-	[ "${o%%=*}" = "$1" ] && { echo $o; return 0; }
+	[ "$o" = "$1" ] && return 0
+	[ "${o%%=*}" = "${1%=}" ] && { echo ${o#*=}; return 0; }
     done
     return 1
 }
@@ -75,17 +76,14 @@ while :; do
 done
 
 # by the time we get here, the root filesystem should be mounted.
-
-INIT=$(getarg init)
+# Try to find init.
+for i in "$(getarg init=)" /sbin/init /etc/init /init /bin/sh; do
+    [ -f "$NEWROOT$i" -a -x "$NEWROOT$i" ] && { INIT="$i"; break; }
+done
 [ "$INIT" ] || {
-    for i in /sbin/init /etc/init /init /bin/sh; do
-	[ -x "$NEWROOT$i" ] && { INIT="$i"; break; }
-    done
-    [ "$INIT" ] || {
-	echo "Cannot find init! Please check to make sure you passed"
-	echo "a valid root filesystem!  Dropping to a shell."
-	emergency_shell
-    }
+    echo "Cannot find init! Please check to make sure you passed"
+    echo "a valid root filesystem!  Dropping to a shell."
+    emergency_shell
 }
 
 # pre pivot scripts are sourced just before we switch over to the new root.
diff --git a/modules/95udev-rules.sh b/modules/95udev-rules.sh
index 9801e7e..61125cd 100755
--- a/modules/95udev-rules.sh
+++ b/modules/95udev-rules.sh
@@ -7,4 +7,6 @@ dracut_install udevd udevadm /lib/udev/*_id /lib/udev/console_*
 inst_rules /lib/udev/rules.d/10-console* /lib/udev/rules.d/40-redhat* \
     /lib/udev/rules.d/50* /lib/udev/rules.d/60-persistent-storage.rules \
     /lib/udev/rules.d/61*edd* /lib/udev/rules.d/64* /lib/udev/rules.d/80* \
-    /lib/udev/rules.d/95*
\ No newline at end of file
+    /lib/udev/rules.d/95*
+# make udevadm shut up about missing udev.conf
+inst /etc/udev/udev.conf
\ No newline at end of file
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
