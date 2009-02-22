From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH] Move actually mounting the root filesystem into its own series of hooks.
Date: Sat, 21 Feb 2009 22:33:10 -0800 (PST)
Message-ID: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=Jegkg0wEBJLEA0KobZN2OjMgk37lsvLph8TmgnK71PI=;
        b=lfKpn2KPIgWgXpw/vXHv0JhTKmBs2Zpk1aw/vtDc3c3oYjBbEi0Xpj+ktBUUyYFQaI
         A7IxVD5DH5HfVGYfnRO5FT3+JA9gjagA7mtzpdcQw4Iq2SXfX/aq93hShmmIWuu5QFwl
         kjYLoErn1Hk0sH67Pge4oJSnFMtyLxxIeOPyw=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

We now have mount hooks.  They are sourced in an infinite loop until one of
them actually mounts the real root filesystem.

This makes it easier to add support for arbitrarily complex schemes to find
the root filesystem without having to patch the init script.

Having an infinite loop is definitly a Bad Idea for production systems, but
people testing initramfs'es using code from some random guy on the Internet
know better than to overwrite the old one, right?

Anyways, this should make adding nfsroot, root on iscsi, root on multipath,
and a whole bunch of other stuff I do not have the environment to code and 
test on easier.

As usual, this patch applies cleanly on top on the rest of my patches, and is
also available at http://git.fnordovax.org/dracut/log/?h=hookify-finding-root

comments, flames, etc. welcome.

---
 hooks/mount-partition.sh |   30 ++++++++++++++++++++++++++++
 init                     |   49 ++++++++++++++++-----------------------------
 modules/90crypt.sh       |    2 +-
 modules/99base.sh        |    4 +-
 4 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/hooks/mount-partition.sh b/hooks/mount-partition.sh
new file mode 100755
index 0000000..53a0f4c
--- /dev/null
+++ b/hooks/mount-partition.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+[ "$root" ] || {
+    root=$(getarg root); root=${root#root=}
+    case $root in
+	LABEL=*) root=${root#LABEL=}
+            root="$(echo $root |sed 's,/,\\x2f,g')"
+            root="/dev/disk/by-label/${root}" ;;
+        UUID=*) root="/dev/disk/by-uuid/${root#UUID=}" ;;
+        '') echo "Warning: no root specified"
+            root="/dev/sda1" ;;
+    esac
+}
+
+[ "$rflags" ] || {
+    if rflags="$(getarg rootflags)"; then
+	rflags="${rflags#rootflags=}"
+	getarg rw >/dev/null && rflags="${rflags},rw" || rflags="${rflags},ro"
+    else
+	getarg rw >/dev/null && rflags=rw || rflags=ro
+    fi
+}
+
+[ "$fstype" ] || {
+    fstype="$(getarg rootfstype)" && fstype="-t ${fstype#rootfstype=}"
+}
+
+[ -e "$root" ] && {
+    ln -sf "$root" /dev/root
+    mount $fstype -o $rflags /dev/root $NEWROOT && ROOTFS_MOUNTED=yes
+}
diff --git a/init b/init
index 581c2b9..3652216 100755
--- a/init
+++ b/init
@@ -50,45 +50,31 @@ mknod /dev/tty0 c 4 0
 mknod /dev/tty1 c 4 1
 mknod /dev/null c 1 3
 
+# pre-udev scripts run before udev starts, and are run only once.
 source_all pre-udev
 
 # start up udev and trigger cold plugs
 udevd --daemon
 udevadm trigger >/dev/null 2>&1
+udevadm settle --timeout=30
 
-# mount the rootfs
 NEWROOT="/sysroot"
-
-# FIXME: there's got to be a better way ...
-# it'd be nice if we had a udev rule that just did all of the bits for
-# figuring out what the specified root is and linking it /dev/root
-root=$(getarg root); root=${root#root=}
-case $root in
-    LABEL=*) root=${root#LABEL=}
-             root="$(echo $root |sed 's,/,\\x2f,g')"
-	     root="/dev/disk/by-label/${root}" ;;
-    UUID=*) root="/dev/disk/by-uuid/${root#UUID=}" ;;
-    '') echo "Warning: no root specified"
-	root="/dev/sda1" ;;
-esac
-
-# should we have a timeout?
-tries=0
-echo "Waiting up to 30 seconds for $root to become available"
-udevadm settle --timeout=30
+# pre-mount happens before we try to mount the root filesystem,
+# and happens once.
 source_all pre-mount
 
-echo "Trying to mount rootfs $root"
-if rflags="$(getarg rootflags)"; then
-    rflags="${rflags#rootflags=}"
-    getarg rw >/dev/null && rflags="${rflags},rw" || rflags="${rflags},ro"
-else
-     getarg rw >/dev/null && rflags=rw || rflags=ro
-fi
-[ -e "$root" ] || emergency_shell
-ln -s "$root" /dev/root 
-fstype="$(getarg rootfstype)" && fstype="-t ${fstype#rootfstype=}" 
-mount $fstype -o $rflags /dev/root $NEWROOT || emergency_shell
+# mount scripts actually try to mount the root filesystem, and may
+# be sourced any number of times. As soon as one suceeds, no more are sourced.
+while :; do
+    for f in /mount/*.sh; do
+	[ -x "$f" ] && . "$f";
+	[ "$ROOTFS_MOUNTED" ] && break;
+    done
+    [ "$ROOTFS_MOUNTED" ] && break;
+    sleep 1
+done
+
+# by the time we get here, the root filesystem should be mounted.
 
 INIT=$(getarg init)
 [ "$INIT" ] || {
@@ -101,7 +87,8 @@ INIT=$(getarg init)
 	emergency_shell
     }
 }
-	    
+
+# pre pivot scripts are sourced just before we switch over to the new root.
 source_all pre-pivot
 echo "Switching to real root filesystem $root"
 exec switch_root "$NEWROOT" "$INIT"  $CMDLINE || {
diff --git a/modules/90crypt.sh b/modules/90crypt.sh
index 9793a4f..5e8f4cb 100755
--- a/modules/90crypt.sh
+++ b/modules/90crypt.sh
@@ -1,4 +1,4 @@
 #!/bin/bash
 inst cryptsetup
 inst_rules "$dsrc/rules.d/63-luks.rules"
-inst_hook pre-mount 50 "$dsrc/hooks/cryptroot.sh"
\ No newline at end of file
+inst_hook mount 10 "$dsrc/hooks/cryptroot.sh"
\ No newline at end of file
diff --git a/modules/99base.sh b/modules/99base.sh
index 1d9f86e..580fb03 100755
--- a/modules/99base.sh
+++ b/modules/99base.sh
@@ -4,5 +4,5 @@ dracut_install mount mknod mkdir modprobe pidof sleep chroot echo sed sh ls
 inst "$initfile" "/init"
 inst "$switchroot" "/sbin/switch_root"
 inst_hook pre-pivot 50 "$dsrc/hooks/selinux-loadpolicy.sh"
-inst_hook pre-mount 99 "$dsrc/hooks/resume.sh"
-
+inst_hook mount 90 "$dsrc/hooks/resume.sh"
+inst_hook mount 99 "$dsrc/hooks/mount-partition.sh"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
