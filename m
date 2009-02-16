From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 30/50] We no longer need plymouth.
Date: Mon, 16 Feb 2009 14:06:45 -0500
Message-ID: <200902161906.n1GJ6jcp028326@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=7924b2127923b35c8c6ef25c19164751fa4d7096
Commit:     7924b2127923b35c8c6ef25c19164751fa4d7096
Parent:     933a523af36fec75f5b7dd5a6bf97c699e16e2bb
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:43 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 30/50] We no longer need plymouth.
    
    init will ask for a passphrase directly if an encrypted root is detected.
    
    Also, use udevadm settle with a 30 second timeout instead of a hardcoded
    30 count loop.
---
 dracut |    5 -----
 init   |   36 +++++++++++-------------------------
 2 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/dracut b/dracut
index cade0e9..382290e 100755
--- a/dracut
+++ b/dracut
@@ -128,9 +128,4 @@ done </proc/mounts
     exit 1
 }
 
-# plymouth
-if [ -x /usr/libexec/plymouth/plymouth-populate-initrd ]; then
-    /usr/libexec/plymouth/plymouth-populate-initrd -t "$initdir" || :
-fi
-
 ( cd "$initdir"; find . |cpio -H newc -o |gzip -9 > "$outfile"; )
diff --git a/init b/init
index ea06687..b12743c 100755
--- a/init
+++ b/init
@@ -7,7 +7,6 @@
 
 emergency_shell()
 {
-    [ -x /bin/plymouth ] && plymouth --hide-splash
     echo ; echo
     echo "Bug in initramfs /init detected. Dropping to a shell. Good luck!"
     echo
@@ -36,6 +35,7 @@ mount -t tmpfs -omode=0755 udev /dev
 
 # FIXME: what device nodes does plymouth really _need_ ?
 mknod /dev/ptmx c 5 2
+mknod /dev/console c 5 0
 mknod /dev/fb c 29 0
 mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts
@@ -43,12 +43,6 @@ mknod /dev/tty0 c 4 0
 mknod /dev/tty1 c 4 1
 mknod /dev/null c 1 3
 
-# start plymouth if it's available
-# arguably we need some of udev run first for fbmods and above devnodes :/
-[ -x /bin/plymouthd ] && plymouthd
-[ -x /bin/plymouth ] && plymouth --show-splash
-
-
 # start up udev and trigger cold plugs
 udevd --daemon
 udevadm trigger >/dev/null 2>&1
@@ -60,7 +54,6 @@ NEWROOT="/sysroot"
 # it'd be nice if we had a udev rule that just did all of the bits for
 # figuring out what the specified root is and linking it /dev/root
 root=$(getarg 'root=*'); root=${root#root=}
-plymouth --update "Going to mount rootfs ($root)"
 case $root in
     LABEL=*) root=${root#LABEL=}
              root=${root//\//\\x2f}
@@ -72,21 +65,16 @@ esac
 
 # should we have a timeout?
 tries=0
-plymouth --update "Waiting up to 30 seconds for $root to become available"
-until [[ -e $root ]]; do
-    [[ -f /cryptroot ]] && {
-	tries=27
-	cryptopts=$(< /cryptroot)
-	if [ -x /bin/plymouth ] && plymouth --ping; then
-	    /bin/plymouth ask-for-password \
-		--command "/sbin/cryptsetup luksOpen $cryptopts" && break
-	else
-	    /sbin/cryptsetup luksOpen $cryptopts && break
-	fi
-    sleep 1
-    ((tries++ > 30)) && emergency_shell
-done
-plymouth --update "Mounting rootfs after $tries seconds"
+echo "Waiting up to 30 seconds for $root to become available"
+udevadm settle --timeout=30
+[[ -f /cryptroot ]] && {
+    echo "Encrypted root detected."
+    cryptopts=$(< /cryptroot)
+    /sbin/cryptsetup luksOpen $cryptopts || emergency_shell
+    udevadm settle --timeout=30
+}
+echo "Trying to mount rootfs $root"
+[[ -e $root ]] || emergency_shell
 ln -s "$root" /dev/root    
 mount -o ro /dev/root $NEWROOT || emergency_shell
 
@@ -113,8 +101,6 @@ fi
 # kill off udev
 kill $(pidof udevd)
 
-[ -x /bin/plymouth ] && plymouth --newroot=$NEWROOT
-
 # FIXME: nash die die die
 exec switch_root
 # davej doesn't like initrd bugs
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
