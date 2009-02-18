From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Goodbye, nash.  We won't miss you.
Date: Wed, 18 Feb 2009 05:00:02 GMT
Message-ID: <200902180500.n1I50274022927@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=6b0daf2e25a1fcd270eb89dc6b36d7e4432b1ca8
Commit:     6b0daf2e25a1fcd270eb89dc6b36d7e4432b1ca8
Parent:     c968efbb13b3d1d88e6a3bc8f7b96f4bce9cee99
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Mon Feb 16 19:16:31 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Tue Feb 17 11:05:46 2009 -0500

    Goodbye, nash.  We won't miss you.
    
    This supercedes my previous switch_root patches, and applies on top of davej's
    repo at git.kernel.org.
    
    Nash is gone.  In its place we have a reasonable switch_root implementation.
    
    Of course, this switch_root is written in some rather hideous shell script,
    and relies on some rather dodgy hacks.  Rewriting in C would help things out.
    
    However, it should be distro-independent, and it gets the job done.
---
 TODO           |    9 +---
 dracut.spec    |    2 -
 init           |   43 ++++++++++-----------
 modules/99base |    1 -
 switch_root    |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 134 insertions(+), 34 deletions(-)

diff --git a/TODO b/TODO
index e04be3a..3ced6f7 100644
--- a/TODO
+++ b/TODO
@@ -4,12 +4,9 @@ are/should be marked with "FIXME" in the code
 
 INITRAMFS TODO
 --------------
-* Currently, our switch_root command uses nash's switchroot.  Getting
-a reasonable switchroot implementation into util-linux-ng is a
-pre-condition for support on other distros.  pjones has a basic
-implementation at
-http://pjones.fedorapeople.org/mkstart/usr/lib/mkstart/switchroot.c
-and I've asked kzak about util-linux inclusion
+* We have a horribly ugly switchroot implementation whose only
+  good point is that it gets rid of our dependency on nash.
+  It needs to be replaced by something nicer.
 * The hard-coded list of udev rules that we care about is kind of
 lame.  See about getting /lib/udev/initrules.d or similar for storing
 the rules that we care about in the initramfs.  These could be
diff --git a/dracut.spec b/dracut.spec
index 24f6513..04590cd 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -19,9 +19,7 @@ Requires: findutils
 Requires: grep
 Requires: mktemp
 Requires: mount
-Requires: nash
 Requires: bash
-Requires: /usr/bin/eu-readelf
 Obsoletes: mkinitrd < 7.0
 Provides: mkinitrd = 7.0
 BuildArch: noarch
diff --git a/init b/init
index c8ac4e5..ad6c06f 100755
--- a/init
+++ b/init
@@ -10,13 +10,12 @@ emergency_shell()
     echo ; echo
     echo "Bug in initramfs /init detected. Dropping to a shell. Good luck!"
     echo
-    sh -i 2>/dev/console
+    sh -i
 }
 
 getarg() {
     local o line
-    read -r line </proc/cmdline
-    for o in $line; do
+    for o in $CMDLINE; do
 	[ "${o%%=*}" = "$1" ] && { echo $o; break; }
     done
     return 1
@@ -31,16 +30,15 @@ source_all() {
 echo "Starting initrd..."
 export PATH=/sbin:/bin:/usr/sbin:/usr/bin
 export TERM=linux
-
+CONSOLE=/dev/console
+[ -c $CONSOLE ] && exec >$CONSOLE 2>&1 <$CONSOLE
 trap "emergency_shell" 0
-# /dev/console comes from the built-in initramfs crud in the kernel
-# someday, we may need to mkdir /dev first here
-# exec > /dev/console 2>&1 < /dev/console
-
 # mount some important things
 mount -t proc /proc /proc
 mount -t sysfs /sys /sys
 mount -t tmpfs -omode=0755 udev /dev
+read CMDLINE </proc/cmdline;
+
 
 # FIXME: what device nodes does plymouth really _need_ ?
 mknod /dev/ptmx c 5 2
@@ -59,7 +57,7 @@ udevd --daemon
 udevadm trigger >/dev/null 2>&1
 
 # mount the rootfs
-NEWROOT="/sysroot"
+export NEWROOT="/sysroot"
 
 # FIXME: there's got to be a better way ...
 # it'd be nice if we had a udev rule that just did all of the bits for
@@ -85,22 +83,21 @@ echo "Trying to mount rootfs $root"
 ln -s "$root" /dev/root    
 mount -o ro /dev/root $NEWROOT || emergency_shell
 
-# now we need to prepare to switchroot
-mount --bind /dev $NEWROOT/dev
-
-# FIXME: now for a bunch of boiler-plate mounts.  really, we should have 
-# some like /etc/fstab.sys that's provided by filesystem/initscripts
-# and then do mount -f /etc/fstab.sys -a
-mount -t proc /proc $NEWROOT/proc
-mount -t sysfs /sys $NEWROOT/sys
-
+INIT=$(getarg init)
+[ "$INIT" ] || {
+    for i in /sbin/init /etc/init /init /bin/sh; do
+	[ -x "$NEWROOT$i" ] && { INIT="$i"; break; }
+    done
+    [ "$INIT" ] || {
+	echo "Cannot find init! Please check to make sure you passed"
+	echo "a valid root filesystem!  Dropping to a shell."
+	emergency_shell
+    }
+}
+	    
 source_all pre-pivot
 
-# kill off udev
-kill $(pidof udevd)
-
-# FIXME: nash die die die
-exec switch_root
+exec switch_root "$NEWROOT" "$INIT"  $CMDLINE
 # davej doesn't like initrd bugs
 echo "Something went very badly wrong in the initrd.  Please "
 echo "file a bug against mkinitrd."
diff --git a/modules/99base b/modules/99base
index c746abc..4963beb 100755
--- a/modules/99base
+++ b/modules/99base
@@ -1,6 +1,5 @@
 #!/bin/bash
 dracut_install mount mknod mkdir modprobe pidof sleep chroot echo sed sh ls
-
 # install our scripts and hooks
 inst "$initfile" "/init"
 inst "$switchroot" "/sbin/switch_root"
diff --git a/switch_root b/switch_root
index 2f0b8fa..1cc80e9 100755
--- a/switch_root
+++ b/switch_root
@@ -1,3 +1,112 @@
-#!/sbin/nash
+#!/bin/sh
+# Copyright (c) Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+# Licensed under the terms of the GNU GPL v2 or later.
 
-nash-switchroot
+# some utility functions first
+# this is so we can scroll back.
+
+die() { echo "${1}, dying horribly."; while :;do read line; done }
+
+# jsut enough to get the job done
+simple_find() {
+    # $1 = file to look for
+    # $rest = places to look for it
+    local file=$1
+    shift
+    for loc in "$@"; do
+	[ -f "$NEWROOT$loc/$file" ] && { echo "$loc/$file"; return 0; }
+    done
+    return 1
+}
+
+# We really should not be doing this from here, but...
+find_interp() {
+    local ldso=$("$NEWROOT$CHROOT" "$NEWROOT" "$LDD" "$1" |
+	while read interp rest; do
+	    [ -f "${NEWROOT}$interp" ] || continue
+	    echo "$interp"
+	    break
+	done);
+    [ "$ldso" ] && echo $ldso
+}
+
+# this makes it easier to run a command entirely from newroot
+# $1 = elf interpreter (must pass empty string if none)
+# $2 = command or "exec"
+# $3 = command if exec was passed
+run_from_newroot() {
+    local ldso="$1" cmd="$2"; shift; shift
+    if [ "$cmd" = "exec" ]; then
+	cmd="$1"; shift
+	if [ "$ldso" ]; then
+	    exec "$NEWROOT$ldso" --library-path "$LIBPATH" "$NEWROOT$cmd" "$@"
+	else
+	    exec "$NEWROOT$cmd" "$@"
+	fi
+    else
+	if [ "$ldso" ]; then
+	    "$NEWROOT$ldso" --library-path "$LIBPATH" "$NEWROOT$cmd" "$@"
+	else
+	    "$NEWROOT$cmd" "$@"
+	fi
+    fi
+}
+# update the path to find our dynamic libraries on newroot
+update_newroot_libpath() {
+    local x
+    LIBPATH=":"
+    LIBDIRS="$(echo $NEWROOT/lib* $NEWROOT/usr/lib*)"
+    for x in $LIBDIRS; do
+	[ -d "$x" ] && LIBPATH="${LIBPATH}${x}:"
+    done
+    LIBPATH="${LIBPATH%:}"; LIBPATH="${LIBPATH#:}"
+    [ "$LIBPATH" ] || die "Cannot find shared library diectories on $NEWROOT"
+}
+NEWROOT="$1"
+INIT="$2"
+[ -d "$NEWROOT" ] || die "$NEWROOT is not a directory"
+[ -x "$NEWROOT$INIT" ] || die "$NEWROOT/$INIT is not executable."
+shift; shift
+
+update_newroot_libpath
+
+# start looking for required binaries and bits of infrastructure
+BINDIRS="/bin /sbin /usr/bin /usr/sbin"
+INITDIRS="/sbin /etc /"
+RM=$(simple_find rm $BINDIRS) || die "Cannnot find rm on $NEWROOT"
+CHROOT=$(simple_find chroot $BINDIRS) || die "Cannot find chroot on $NEWROOT"
+LDD=$(simple_find ldd $BINDIRS) || die "Cannot find ldd on $NEWROOT"
+MOUNT=$(simple_find mount $BINDIRS) || die "Cannot find mount on $NEWROOT"
+
+# now, start the real process of switching the root
+cd /
+
+# kill udevd, move all our mounts over to the new root
+kill $(pidof udevd)
+mount --move /proc $NEWROOT/proc
+mount --move /sys $NEWROOT/sys
+mount --move /dev $NEWROOT/dev
+
+# Find the binary interpreter for our three required binaries.
+# We do it here so that ldd does not complain about a missing /dev/null.
+CHROOT_LDSO=$(find_interp "$CHROOT")
+RM_LDSO=$(find_interp "$RM")
+MOUNT_LDSO=$(find_interp "$MOUNT")
+
+# redirect to new console. Our old initramfs will not be freed otherwise
+CONSOLE=$NEWROOT/dev/console
+[ -c $CONSOLE ] && exec >$CONSOLE 2>&1 <$CONSOLE
+for x in *; do
+    [ "/$x" = "$NEWROOT" ] || run_from_newroot "$RM_LDSO" "$RM" -rf -- "$x"
+done
+# switch to our new root dir
+cd "$NEWROOT"
+# this moves rootfs to the actual root...
+run_from_newroot "$MOUNT_LDSO" "$MOUNT" -n --move . /
+# but does not update where / is in directory lookups.
+# Therefore, newroot is now ".".  Update things accordingly, then chroot and
+# exec init.
+NEWROOT="."
+update_newroot_libpath
+run_from_newroot "$CHROOT_LDSO" exec "$CHROOT" "$NEWROOT" "$INIT" "$@"
+die "The chroot did not take for some reason"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
