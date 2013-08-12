From: Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Boot a Live USB device as read-only after persisting some changes.
Date: Mon, 12 Aug 2013 00:46:27 -0400
Message-ID: <CAEcBt+WE6RKc_QBSrn8WM_Q6tcrbxS8+ZoqXhQMXzyJ7gOuDyA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=OoCBGOMqa4FhAqGuM6/Mw1A1iu2ro1f941drx96vp/Y=;
        b=EJ9hOxgAugjs9DDLON/frTwMvOnbaDs71qdp6O1JwW5WF/andP+lpk9od6d/smvYWF
         9lIvDII4iSZidNYGJRw/hHn5Es97cwJCX7g2wMLw5UJ00G7p8vq2tZhIXq5QrPLqhBf4
         cslbPPgoauESn9px1qYeN0VlgPvenUDJiAu3oqW5X3/U4F6qXg72G8rMfvnWa/U6DvYS
         EfAtK3Pbpgwjxun9eDwhQl3sUs2MAvRe7If7LNRK9W0JmogkRmMyUguA3u4dKLGdRtmJ
         m2l6PK+GFhzxHQOZqsdD7MsQl9blaAji7pRU8wK7Zzp78Cfer1cdNB+lTeK3qVFkOnTt
         iF8w==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, livecd-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org, spins-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org

In cases where one would like to make some changes or customizations
on an installed Live USB device and then protect the device
filesystems from further persistent changes, one can boot the device
with the rd.live.overlay.readonly option.  This protects the root
operating filesystem, but leaves as read-write both the home.img
filesystem, if used, (needed for encrypting the /home contents) and
the base device filesystem, such as /dev/sdc1.

The following patches adjust the boot scripts dmsquash-live-root.sh
and livesys to enable the base device filesystem, livedev, and the
home.img filesystem, if present, to be mounted read-only at boot and
stay read-only during use.  Temporary overlays are created in memory
for device-mapper snapshot targets for the filesystems to handle
non-persistent storage content.

Adjust the boot command line option from rw to ro to invoke the
read-only configuration on all of the discussed filesystems.
rd.live.overlay.readonly may be used as before to add a non-persistent
overlay over an existing persistent overlay to limit further root
filesystem changes.  Adjust the /syslinux/syslinux.cfg or
extlinux.conf file on the device to standardize the desired default
configuration.  Adjust further, if one wishes later to make more
persistent changes.

The following patches have been tested for the common configurations
described above.  Special devspec or pathspec arguments for overlay=
or persistenthome= command line options should be further tested.

A method to call for the check of a persistent home filesystem before
mounting during the next boot has also been added.

           --Fred

commit a6cd70fc9df2d299ed4f347461c33e4824df62f0
Author: Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>
Date:   Mon Aug 12 00:12:25 2013 -0400

    Enable read-only mounting of a persistent home.img filesystem.
    Enable one to call for filesystem checking of home.img before
    mounting on the next boot.

diff --git a/fedora-live-base.ks b/fedora-live-base.ks
index 6c76e96..0512f67 100644
--- a/fedora-live-base.ks
+++ b/fedora-live-base.ks
@@ -116,9 +116,13 @@ mountPersistentHome() {
   elif [ ! -b "\$homedev" ]; then
     loopdev=\`losetup -f\`
     if [ "\${homedev##/run/initramfs/live}" != "\${homedev}" ]; then
-      action "Remounting live store r/w" mount -o remount,rw
/run/initramfs/live
+        if [ "\$liverw" = rw ]; then
+            action "Remounting live store r/w" mount -o remount,rw
/run/initramfs/live
+        else
+            opts="-r"
+        fi
     fi
-    losetup \$loopdev \$homedev
+    losetup \$opts \$loopdev \$homedev
     homedev=\$loopdev
   fi

@@ -130,6 +134,22 @@ mountPersistentHome() {
     homedev=/dev/mapper/EncHome
   fi

+  # If read-only is requested, prepare a non-persistent overlay and
snapshot target.
+  if [ "\$opts" = "-r" ]; then
+    dd if=/dev/null of=/run/initramfs/overlayfs/home_overlay bs=1024
count=1 seek=\$((512*1024)) 2> /dev/null
+    HOME_OVERLAY_LOOPDEV=\$(losetup -f)
+    losetup \$HOME_OVERLAY_LOOPDEV /run/initramfs/overlayfs/home_overlay
+    sz=\$(blockdev --getsz \$homedev)
+    echo 0 \$sz snapshot \$homedev \$HOME_OVERLAY_LOOPDEV N 8 |
dmsetup create home-rw
+    homedev=/dev/mapper/home-rw
+  fi
+
+  # Check the filesystem, if requested.
+  if [ -e /forcehomefsck ]; then
+    e2fsck -f -y -v \$homedev || e2fsck -f -y \$homedev
+    rm /forcehomefsck
+  fi
+
   # and finally do the mount
   mount \$mountopts \$homedev /home
   # if we have /home under what's passed for persistent home, then



commit 96ff19a87c0be1eca27860aeef5434513b0e8c61
Author: Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>
Date:   Mon Aug 12 00:29:27 2013 -0400

    Allow read-only mounting of the base device filesystem, livedev.
    Use read-only loop devices and non-persistent overlay targets.

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh
b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index 14e84e1..af0022f 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -24,7 +24,7 @@ squash_image=$(getarg rd.live.squashimg)

 getargbool 0 rd.live.ram -d -y live_ram && live_ram="yes"
 getargbool 0 rd.live.overlay.reset -d -y reset_overlay && reset_overlay="yes"
-getargbool 0 rd.live.overlay.readonly -d -y readonly_overlay &&
readonly_overlay="--readonly" || readonly_overlay=""
+getargbool 0 rd.live.overlay.readonly -d -y readonly_overlay &&
readonly_overlay="-r" || readonly_overlay=""
 overlay=$(getarg rd.live.overlay -d overlay)

 # CD/DVD media check
@@ -105,17 +105,23 @@ do_live_overlay() {
     setup=""
     if [ -n "$devspec" -a -n "$pathspec" -a -n "$overlay" ]; then
         mkdir -m 0755 /run/initramfs/overlayfs
-        mount -n -t auto $devspec /run/initramfs/overlayfs || :
-        if [ -f /run/initramfs/overlayfs$pathspec -a -w
/run/initramfs/overlayfs$pathspec ]; then
-            losetup $OVERLAY_LOOPDEV /run/initramfs/overlayfs$pathspec
-            if [ -n "$reset_overlay" ]; then
-                dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k count=1
conv=fsync 2>/dev/null
+        mount -n -t auto -o $liverw $devspec /run/initramfs/overlayfs || :
+        if [ -f /run/initramfs/overlayfs$pathspec ]; then
+            if [ "$liverw" = ro ]; then
+                readonly_overlay='-r'
+            fi
+            losetup $readonly_overlay $OVERLAY_LOOPDEV
/run/initramfs/overlayfs$pathspec
+            if [ -w /run/initramfs/overlayfs$pathspec ]; then
+                if [ -n "$reset_overlay" ]; then
+                    dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k
count=1 conv=fsync 2>/dev/null
+                fi
             fi
             setup="yes"
         fi
         umount -l /run/initramfs/overlayfs || :
     fi

+    persistent='P'
     if [ -z "$setup" -o -n "$readonly_overlay" ]; then
         if [ -n "$setup" ]; then
             warn "Using temporary overlay."
@@ -123,6 +129,7 @@ do_live_overlay() {
             warn "Unable to find persistent overlay; using temporary"
             sleep 5
         fi
+        persistent='N'

         dd if=/dev/null of=/overlay bs=1024 count=1
seek=$((512*1024)) 2> /dev/null
         if [ -n "$setup" -a -n "$readonly_overlay" ]; then
@@ -136,14 +143,14 @@ do_live_overlay() {
     # set up the snapshot
     sz=$(blockdev --getsz $BASE_LOOPDEV)
     if [ -n "$readonly_overlay" ]; then
-        echo 0 $sz snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV p 8 |
dmsetup create $readonly_overlay live-ro
+        echo 0 $sz snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV N 8 |
dmsetup create $readonly_overlay live-ro
         base="/dev/mapper/live-ro"
         over=$RO_OVERLAY_LOOPDEV
     else
         base=$BASE_LOOPDEV
         over=$OVERLAY_LOOPDEV
     fi
-    echo 0 $sz snapshot $base $over p 8 | dmsetup create live-rw
+    echo 0 $sz snapshot $base $over $persistent 8 | dmsetup create live-rw
 }

 # live cd helper function
@@ -217,7 +224,7 @@ fi
 if [ -b "$OSMIN_LOOPDEV" ]; then
     # set up the devicemapper snapshot device, which will merge
     # the normal live fs image, and the delta, into a minimzied fs image
-    echo "0 $( blockdev --getsz $BASE_LOOPDEV ) snapshot
$BASE_LOOPDEV $OSMIN_LOOPDEV p 8" | dmsetup create --readonly
live-osimg-min
+    echo "0 $( blockdev --getsz $BASE_LOOPDEV ) snapshot
$BASE_LOOPDEV $OSMIN_LOOPDEV N 8" | dmsetup create --readonly
live-osimg-min
 fi

 ROOTFLAGS="$(getarg rootflags)"
