From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/9] Dracut cleanups, part 2
Date: Wed, 11 Feb 2009 03:46:45 -0800 (PST)
Message-ID: <11dcae9d640427ac5d7ed2ea9b5ee3603c6b2eae.1234351770.git.victor.lowther@gmail.com>
References: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=FanNlzLU5ms/bcuPFHc4IAElQtCbKVvbyo0jV2tugkI=;
        b=hK7+NHEiTEE8XmIgJ0KFD8vOJH6oFlFEdppz13MMpo4OibO7J83qC2+17X4wE6uY+b
         c4Coq/jzejfjK54BLVN6KBwFZURZ47VLIPbLGlxAnEdxAcgfKK5Wfs4TgJaUHffpQr9B
         EQVAWO6oLxn21LN/oQZMGGT8Qz+ahFyreCx8g=
In-Reply-To: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

POSIX-ize all the shell scripts that get installed to the initramfs.

Also install all the scripts using inst, so that we can install the right
shell interpreter for our scripts.  We still install bash as well.
---
 dracut                         |    6 +++---
 echoer                         |    2 +-
 init                           |   18 +++++++++---------
 pre-mount/50cryptroot          |   13 +++++++------
 pre-mount/99resume             |   17 ++++++++++-------
 pre-pivot/50selinux-loadpolicy |   19 ++++++++++---------
 6 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/dracut b/dracut
index aec20c0..c5f68c7 100755
--- a/dracut
+++ b/dracut
@@ -108,9 +108,9 @@ if [ -f /etc/sysconfig/i18n ]; then
 fi
 
 # install our files
-cp $initfile "$initdir/init"
-cp $switchroot "$initdir/sbin/switch_root"
-cp $echoer "$initdir/echoer"
+inst "$initfile" "/init"
+inst "$switchroot" "/sbin/switch_root"
+inst "$echoer" "/echoer"
 for hookdir in $hookdirs; do
     for hook in "$dsrc/$hookdir"/*; do
 	[[ -f $hook ]] && inst "$hook" "/$hookdir/${hook##*/}"
diff --git a/echoer b/echoer
index 249155d..9fc7abf 100755
--- a/echoer
+++ b/echoer
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 target=$1
 shift
 echo "$@" >"$target"
\ No newline at end of file
diff --git a/init b/init
index 611781c..84ae051 100755
--- a/init
+++ b/init
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Licensed under the GPLv2
 #
@@ -10,28 +10,28 @@ emergency_shell()
     echo ; echo
     echo "Bug in initramfs /init detected. Dropping to a shell. Good luck!"
     echo
-    bash < /dev/console
+    sh < /dev/console
 }
 
 getarg() {
     local o;
-    for o in $(< /proc/cmdline); do
-	[[ $o == $1 ]] && { echo $o; break; }
+    for o in $(cat /proc/cmdline); do
+	[ "${o%%=*}" = "$1" ] && { echo $o; break; }
     done
     return 1
 }
 
 source_all() {
     local f
-    [[ $1 &&  -d /$1 ]] || return
-    for f in "/$1"/*; do [[ -f $f ]] && . "$f"; done
+    [ "$1" ] && [  -d "/$1" ] || return
+    for f in "/$1"/*; do [ -f "$f" ] && . "$f"; done
 }
 
 echo "Starting initrd..."
 export PATH=/sbin:/bin:/usr/sbin:/usr/bin
 export TERM=linux
 
-trap "emergency_shell" 0 2
+trap "emergency_shell" 0
 # /dev/console comes from the built-in initramfs crud in the kernel
 # someday, we may need to mkdir /dev first here
 exec > /dev/console 2>&1 < /dev/console
@@ -63,7 +63,7 @@ NEWROOT="/sysroot"
 # FIXME: there's got to be a better way ...
 # it'd be nice if we had a udev rule that just did all of the bits for
 # figuring out what the specified root is and linking it /dev/root
-root=$(getarg 'root=*'); root=${root#root=}
+root=$(getarg root); root=${root#root=}
 case $root in
     LABEL=*) root=${root#LABEL=}
              root=${root//\//\\x2f}
@@ -80,7 +80,7 @@ udevadm settle --timeout=30
 source_all pre-mount
 
 echo "Trying to mount rootfs $root"
-[[ -e $root ]] || emergency_shell
+[ -e "$root" ] || emergency_shell
 ln -s "$root" /dev/root    
 mount -o ro /dev/root $NEWROOT || emergency_shell
 
diff --git a/pre-mount/50cryptroot b/pre-mount/50cryptroot
index 39e6e6e..de7eca4 100755
--- a/pre-mount/50cryptroot
+++ b/pre-mount/50cryptroot
@@ -1,6 +1,7 @@
-#!/bin/bash
-[[ -f /cryptroot ]] || return
-echo "Encrypted root detected."
-cryptopts=$(< /cryptroot)
-/sbin/cryptsetup luksOpen $cryptopts || emergency_shell
-udevadm settle --timeout=30
+#!/bin/sh
+[ -f /cryptroot ] && { 
+    echo "Encrypted root detected."
+    cryptopts=$(cat /cryptroot)
+    /sbin/cryptsetup luksOpen $cryptopts || emergency_shell
+    udevadm settle --timeout=30
+}
diff --git a/pre-mount/99resume b/pre-mount/99resume
index 7eacd38..4f1d6c3 100755
--- a/pre-mount/99resume
+++ b/pre-mount/99resume
@@ -1,7 +1,10 @@
-#!/bin/bash
-resume=$(getarg 'resume=*') || return
-resume=${resume#resume=}
-[[ -b $resume ]] || return
-# parsing the output of ls is Bad, but until there is a better way...
-read x x x x maj min x < <(ls -lH "$resume")
-echo "${maj/,/}:$min"> /sys/power/resume
+#!/bin/sh
+resume=$(getarg resume) && {
+    resume=${resume#resume=}
+    [ -b "$resume" ] && {
+        # parsing the output of ls is Bad, but until there is a better way...
+	ls -lH "$resume" | ( 
+	    read x x x x maj min x;
+	    echo "${maj%,}:$min"> /sys/power/resume)
+    }
+}
diff --git a/pre-pivot/50selinux-loadpolicy b/pre-pivot/50selinux-loadpolicy
index 8cc3133..ceece63 100755
--- a/pre-pivot/50selinux-loadpolicy
+++ b/pre-pivot/50selinux-loadpolicy
@@ -1,10 +1,11 @@
-#!/bin/bash
+#!/bin/sh
 # FIXME: load selinux policy.  this should really be done after we switchroot 
-[[ -x $NEWROOT/usr/sbin/load_policy ]] || return
-chroot $NEWROOT /usr/sbin/load_policy -i
-if (($? == 3)); then
-   echo "Initial SELinux policy load failed and enforcing mode requested."
-   echo "Not continuing"
-   sleep 100d
-   exit 1
-fi
+[ -x "$NEWROOT/usr/sbin/load_policy" ] && {
+    chroot $NEWROOT /usr/sbin/load_policy -i
+    if [ $? -eq 3 ]; then
+	echo "Initial SELinux policy load failed and enforcing mode requested."
+	echo "Not continuing"
+	sleep 100d
+	exit 1
+    fi
+}
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
