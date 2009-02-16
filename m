From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 26/50] Make init less noisy and load fs modules for all mounted filesystems
Date: Mon, 16 Feb 2009 14:06:37 -0500
Message-ID: <200902161906.n1GJ6boh028209@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=bc6b0dec9e077468d45ae3248eb196c92a9e7b31
Commit:     bc6b0dec9e077468d45ae3248eb196c92a9e7b31
Parent:     213c781797a697b89fa1a7eb1214d1a74f71c8cb
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:33 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 26/50] Make init less noisy and load fs modules for all mounted filesystems
---
 dracut |    5 +++++
 init   |    9 +++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/dracut b/dracut
index c444c92..eb6632d 100755
--- a/dracut
+++ b/dracut
@@ -115,6 +115,11 @@ for d in etc proc sys sysroot dev/pts; do mkdir -p "$initdir/$d"; done
 
 instmods $modules
 
+# Grab modules for all filesystem types we currently know about
+while read d mp t rest; do
+    instmods "$t"
+done </proc/mounts
+
 /sbin/depmod -a -b "$initdir" $kernel || {
     error "\"/sbin/depmod -a $kernel\" failed."
     exit 1
diff --git a/init b/init
index d5095ea..10a789b 100755
--- a/init
+++ b/init
@@ -41,6 +41,7 @@ mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts
 mknod /dev/tty0 c 4 0
 mknod /dev/tty1 c 4 1
+mknod /dev/null c 1 3
 
 # start plymouth if it's available
 # arguably we need some of udev run first for fbmods and above devnodes :/
@@ -50,7 +51,7 @@ mknod /dev/tty1 c 4 1
 
 # start up udev and trigger cold plugs
 udevd --daemon
-udevadm trigger
+udevadm trigger >/dev/null 2>&1
 
 # mount the rootfs
 NEWROOT="/sysroot"
@@ -59,7 +60,7 @@ NEWROOT="/sysroot"
 # it'd be nice if we had a udev rule that just did all of the bits for
 # figuring out what the specified root is and linking it /dev/root
 root=$(getarg 'root=*'); root=${root#root=}
-echo -n "Going to mount rootfs ($root)"
+plymouth --update "Going to mount rootfs ($root)"
 case $root in
     LABEL=*) root=${root#LABEL=}
              root=${root//\//\\x2f}
@@ -71,12 +72,12 @@ esac
 
 # should we have a timeout?
 tries=0
+plymouth --update "Waiting up to 30 seconds for $root to become available"
 until [[ -e $root ]]; do
-  echo -n "."
   sleep 1
   ((tries++ > 30)) && emergency_shell
 done
-echo -e "\n\nMounting rootfs after $tries seconds"
+plymouth --update "Mounting rootfs after $tries seconds"
 ln -s "$root" /dev/root    
 mount -o ro /dev/root $NEWROOT || emergency_shell
 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
