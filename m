From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] Goodbye nash dependency!
Date: Sat, 14 Feb 2009 05:50:49 -0800 (PST)
Message-ID: <87fce43b083281714e24852cd20a86836667bdcf.1234619174.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=qXk9LkeQzgEcPagLWs7dAQhVJtoZICOl0Hc2KFacSu0=;
        b=Z6JCJW4tL8yAGj2UuVA9p5DZtcGhts+WMvIe0FcUpUBWnYaYLE1ukNVr2G4SB85zt1
         gqssfCq9emJN18oBDKfXgb3DQ/RQoIb1NdjQBbOwNy4vzarkm9bBUWhsWdO1mxkeuacL
         uRl4YytRnmfg+HEOM3yXMPSn7rAr4u571ySW4=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

dracut now has a horribly ugly switchroot implementation whose only
good point is that it allows us to get rid of nash.  It needs to be
replaced by something more flexible as soon as possible, but it works
well enough for testing purposes.

As usual, this applies on top of my previous patch series.

---
 TODO                      |    9 +++------
 dracut.spec               |    2 --
 init                      |   33 ++++++++++-----------------------
 modules/90gen-switch_root |   28 ++++++++++++++++++++++++++++
 modules/99base            |    2 +-
 switch_root               |    3 ---
 switch_root.in            |   30 ++++++++++++++++++++++++++++++
 7 files changed, 72 insertions(+), 35 deletions(-)

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
index c8ac4e5..69f4b7a 100755
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
@@ -31,20 +30,18 @@ source_all() {
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
-mknod /dev/console c 5 0
 mknod /dev/fb c 29 0
 mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts
@@ -59,7 +56,7 @@ udevd --daemon
 udevadm trigger >/dev/null 2>&1
 
 # mount the rootfs
-NEWROOT="/sysroot"
+export NEWROOT="/sysroot"
 
 # FIXME: there's got to be a better way ...
 # it'd be nice if we had a udev rule that just did all of the bits for
@@ -85,22 +82,12 @@ echo "Trying to mount rootfs $root"
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
+i=$(getarg init)
+[ "$i" ] && export INIT="${i#init=}"
 
 source_all pre-pivot
 
-# kill off udev
-kill $(pidof udevd)
-
-# FIXME: nash die die die
-exec switch_root
+exec switch_root $CMDLINE
 # davej doesn't like initrd bugs
 echo "Something went very badly wrong in the initrd.  Please "
 echo "file a bug against mkinitrd."
diff --git a/modules/90gen-switch_root b/modules/90gen-switch_root
new file mode 100755
index 0000000..0699aed
--- /dev/null
+++ b/modules/90gen-switch_root
@@ -0,0 +1,28 @@
+#!/bin/bash
+(
+    RM=$(find_binary rm)
+    INIT=$(find_binary init)
+    CHROOT=$(find_binary chroot)
+    LIBPATH=":"
+    for bin in "$RM" "$INIT" "$CHROOT"; do
+	while read line; do
+    	    [[ $line =~ '(([^ ]*/lib[^/]*)/[^ ]*\.so[^ ]*)' ]] || continue
+	    strstr "$LIBPATH" ":/sysroot${BASH_REMATCH[2]}:" || \
+	  	LIBPATH+="/sysroot${BASH_REMATCH[2]}:"
+	    [[ ! $LDSO && ${BASH_REMATCH[1]} = */ld-linux*.so.* ]] && {
+		LDSO=${BASH_REMATCH[1]} 
+		LIBDIR="${LDSO%/*}"
+	    }
+	done < <(ldd "$bin")
+    done
+    LIBPATH=${LIBPATH%:}; LIBPATH=${LIBPATH#:}
+    
+    sed -e "s,[@]RM[@],${RM}," \
+	-e "s,[@]INIT[@],${INIT}," \
+	-e "s,[@]CHROOT[@],${CHROOT}," \
+	-e "s,[@]LIBPATH[@],${LIBPATH}," \
+	-e "s,[@]LIBDIR[@],${LIBDIR}," \
+	-e "s,[@]LDSO[@],${LDSO}," <"$dsrc/switch_root.in" >"$dsrc/switch_root"
+    chmod 775 "$dsrc/switch_root"
+    inst "$dsrc/switch_root" /sbin/switch_root
+)
diff --git a/modules/99base b/modules/99base
index c746abc..e566a19 100755
--- a/modules/99base
+++ b/modules/99base
@@ -1,5 +1,5 @@
 #!/bin/bash
-dracut_install mount mknod mkdir modprobe pidof sleep chroot echo sed sh ls
+dracut_install mount mknod mkdir modprobe pidof sleep chroot echo sed sh ls umount
 
 # install our scripts and hooks
 inst "$initfile" "/init"
diff --git a/switch_root b/switch_root
deleted file mode 100755
index 2f0b8fa..0000000
--- a/switch_root
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/sbin/nash
-
-nash-switchroot
diff --git a/switch_root.in b/switch_root.in
new file mode 100755
index 0000000..88548c7
--- /dev/null
+++ b/switch_root.in
@@ -0,0 +1,30 @@
+#!/bin/sh
+LIBDIR="${NEWROOT}@LIBDIR@"
+LDSO="${NEWROOT}@LDSO@"
+INIT="@INIT@"
+CHROOT="${NEWROOT}@CHROOT@"
+RM="${NEWROOT}@RM@"
+LIB="${LIBDIR##*/}"
+LIBPATH="@LIBPATH@"
+die() { echo "$1"; exit 1; }
+[ -d "$LIBDIR" ] || die "No /lib dir on $NEWROOT, dying horribly." 
+[ -f "$LDSO" ] || die "No library interpreter on $NEWROOT, dying horribly."
+[ -x "$NEWROOT/$INIT" ] || die "No init on $NEWROOT, dying horribly."
+[ -x "$CHROOT" ] || die "No chroot on $NEWROOT, dying horribly"
+[ -x "$RM" ] || die "No rm on $NEWROOT, dying horribly"
+cd /
+# kill udevd, move all our mounts over to the new root
+kill $(pidof udevd)
+mount --move /proc $NEWROOT/proc
+mount --move /sys $NEWROOT/sys
+mount --move /dev $NEWROOT/dev
+# redirect to new console. Our old initramfs will not be freed otherwise
+CONSOLE=$NEWROOT/dev/console
+[ -c $CONSOLE ] && exec >$CONSOLE 2>&1 <$CONSOLE
+# remove everything on the initramfs
+for x in *; do
+    [ "/$x" = "$NEWROOT" ] && continue
+    LD_LIBRARY_PATH="$LIBDIR" "$LDSO" "$RM" -rf "$x"
+done
+# start running on the real root filesystem
+exec "$LDSO" --library-path "$LIBPATH" "$CHROOT" "$NEWROOT" "$INIT" "$@"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
