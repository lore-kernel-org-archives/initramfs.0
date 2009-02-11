From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/9] Dracut cleanups, part 2
Date: Wed, 11 Feb 2009 03:46:40 -0800 (PST)
Message-ID: <5f5cc0230741fef545dc2d6ee5b0fdb0cb0192b7.1234351770.git.victor.lowther@gmail.com>
References: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=VSyXD7llOzAaN1aXLgDUtv0ugubFkPkrT9edrivQJIc=;
        b=ib2SsU4eB7z0z979lZkd6xGPcFkAzfFqcj+ffJY2HMZgEXjs3SfA5RlMn64veEZlof
         VHcm2rfjAtcil0iIVfj4V1Fcttn59NqiKKfglICOChkUq/cLkTvN9d8uEPjGhf68wG5O
         HTTVJ9oBzXjqi1LQhstUF5ZYkgWhg+xLhqVm0=
In-Reply-To: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

We now have a simple hook structure and 3 defined hook points.

Any script placed in /pre-udev will be sourced just before udev starts
device scanning and loading.

Any script placed in /pre-mount will be sourced just before we try to
mount a root filesystem.

Any script placed in /pre-pivot will be sourced just before we switch to the
new root filesystem.

These hooks should be the minimum needed to add back plymouth and deal with
more advanced filesysem mounting needs (multipath, iscsi, nfs, nbd, etc.)
---
 Makefile                       |    5 ++++-
 dracut                         |    5 +++++
 init                           |   19 ++++++-------------
 pre-pivot/50selinux-loadpolicy |   10 ++++++++++
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index a4d1348..6d7cb68 100644
--- a/Makefile
+++ b/Makefile
@@ -4,6 +4,9 @@ all:
 install:
 	mkdir -p $(DESTDIR)/usr/libexec/dracut
 	mkdir -p $(DESTDIR)/sbin
+	mkdir -p $(DESTDIR)/usr/libexec/dracut/pre-mount
+	mkdir -p $(DESTDIR)/usr/libexec/dracut/pre-udev
+	mkdir -p $(DESTDIR)/usr/libexec/dracut/pre-pivot
 	install -m 0755 dracut $(DESTDIR)/sbin/dracut
 	install -m 0755 init $(DESTDIR)/usr/libexec/dracut/init
 	install -m 0755 switch_root $(DESTDIR)/usr/libexec/dracut/switch_root
@@ -11,7 +14,7 @@ install:
 	install -m 0755 echoer $(DESTDIR)/usr/libexec/dracut/echoer
 	mkdir $(DESTDIR)/usr/libexec/dracut/rules.d
 	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut/rules.d ; done
-
+	for hooks in pre-*/* ; do install -m 0755 $$hook $(DESTDIR/usr/libexec/dracut ; done
 clean:
 	rm -f *~
 
diff --git a/dracut b/dracut
index 382290e..ecf58dc 100755
--- a/dracut
+++ b/dracut
@@ -110,6 +110,11 @@ fi
 cp $initfile "$initdir/init"
 cp $switchroot "$initdir/sbin/switch_root"
 cp $echoer "$initdir/echoer"
+for hookdir in $hookdirs; do
+    for hook in "$dsrc/$hookdir"/*; do
+	[[ -f $hook ]] && inst "$hook" "/$hookdir/${hook##*/}"
+    done
+done
 
 # and create some directory structure
 for d in etc proc sys sysroot dev/pts; do mkdir -p "$initdir/$d"; done
diff --git a/init b/init
index 0b158dc..611781c 100755
--- a/init
+++ b/init
@@ -23,8 +23,8 @@ getarg() {
 
 source_all() {
     local f
-    [[ -d $1 ]] || return
-    for f in "$d"/*; do; . "$f"; done
+    [[ $1 &&  -d /$1 ]] || return
+    for f in "/$1"/*; do [[ -f $f ]] && . "$f"; done
 }
 
 echo "Starting initrd..."
@@ -51,6 +51,8 @@ mknod /dev/tty0 c 4 0
 mknod /dev/tty1 c 4 1
 mknod /dev/null c 1 3
 
+source_all pre-udev
+
 # start up udev and trigger cold plugs
 udevd --daemon
 udevadm trigger >/dev/null 2>&1
@@ -75,7 +77,7 @@ esac
 tries=0
 echo "Waiting up to 30 seconds for $root to become available"
 udevadm settle --timeout=30
-source_all /pre-mount
+source_all pre-mount
 
 echo "Trying to mount rootfs $root"
 [[ -e $root ]] || emergency_shell
@@ -91,16 +93,7 @@ mount --bind /dev $NEWROOT/dev
 mount -t proc /proc $NEWROOT/proc
 mount -t sysfs /sys $NEWROOT/sys
 
-# FIXME: load selinux policy.  this should really be done after we switchroot 
-if [ -x $NEWROOT/usr/sbin/load_policy ]; then
-  chroot $NEWROOT /usr/sbin/load_policy -i
-  if (($? == 3)); then
-    echo "Initial SELinux policy load failed and enforcing mode requested."
-    echo "Not continuing"
-    sleep 100d
-    exit 1
-  fi
-fi
+source_all pre-pivot
 
 # kill off udev
 kill $(pidof udevd)
diff --git a/pre-mount/50cryptroot b/pre-mount/50cryptroot
old mode 100644
new mode 100755
diff --git a/pre-mount/99resume b/pre-mount/99resume
old mode 100644
new mode 100755
diff --git a/pre-pivot/50selinux-loadpolicy b/pre-pivot/50selinux-loadpolicy
new file mode 100755
index 0000000..8cc3133
--- /dev/null
+++ b/pre-pivot/50selinux-loadpolicy
@@ -0,0 +1,10 @@
+#!/bin/bash
+# FIXME: load selinux policy.  this should really be done after we switchroot 
+[[ -x $NEWROOT/usr/sbin/load_policy ]] || return
+chroot $NEWROOT /usr/sbin/load_policy -i
+if (($? == 3)); then
+   echo "Initial SELinux policy load failed and enforcing mode requested."
+   echo "Not continuing"
+   sleep 100d
+   exit 1
+fi
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
