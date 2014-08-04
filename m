From: Major Hayden <major-rCS72UCksqc@public.gmane.org>
Subject: [PATCH] Adding support for read/write filesystem images
Date: Mon, 04 Aug 2014 10:47:32 -0500
Message-ID: <53DFAB14.1020201@mhtx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mhtx.net; s=default;
	t=1407167214; bh=fMkI6R83iG3sToYbu2JFceWXUZJ+/6tYAj7kaJFjF5s=;
	h=Date:From:To:Subject;
	b=g/gEPcOIl+38UoYx/kI4aVWILsbX/E1sqzIz1PK3g+mwFg5g9PA55NlEGI8ieSS7N
	 WxcT9XWHnoK6ucXM/eSFpwgZqfYAVrDePCbPlWJ0phNvyDwmj/SVoE0yNs4SGPXNc7
	 qyCWtVDJyNyiAbEYmh9lSc/pFvGfL7IX6YyGhF/LF/syBRenzI7Lc0jQOoBsAKa9gK
	 mZG6+vKkVg3e2tOGOg9Iai2qzv9IGnBa5iP2AK99RydoJRAE9Z7bC/PiVFeMqOuYBy
	 B9VeW9C1bO6Fc88kXAMx3yKGbOESNkzknZGnNAeXLCWAl6RiHw5rVcdVSrnibAuqVG
	 y/+kRuQpsuq8A==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

A user can provide a filesystem image (rootfs.img) inside a compressed
tarball and that filesystem image will be mounted read/write.  This provides
some benefits over a device mapper snapshot overlay, especially when the
live system becomes full.  The boot command line simple needs
"rd.writable.fsimg" added to utilize this feature.

Signed-off-by: Major Hayden <major-rCS72UCksqc@public.gmane.org>
---
 modules.d/90dmsquash-live/dmsquash-live-root.sh | 16 ++++++++++++++--
 modules.d/90dmsquash-live/module-setup.sh       |  2 +-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh
b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index 5705e8d..c6c02c7 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -4,6 +4,8 @@

 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

+command -v unpack_archive >/dev/null || . /lib/img-lib.sh
+
 PATH=/usr/sbin:/usr/bin:/sbin:/bin

 if getargbool 0 rd.live.debug -n -y rdlivedebug; then
@@ -26,6 +28,7 @@ getargbool 0 rd.live.ram -d -y live_ram && live_ram="yes"
 getargbool 0 rd.live.overlay.reset -d -y reset_overlay &&
reset_overlay="yes"
 getargbool 0 rd.live.overlay.readonly -d -y readonly_overlay &&
readonly_overlay="--readonly" || readonly_overlay=""
 overlay=$(getarg rd.live.overlay -d overlay)
+getargbool 0 rd.writable.fsimg -d -y writable_fsimg && writable_fsimg="yes"

 # CD/DVD media check
 [ -b $livedev ] && fs=$(blkid -s TYPE -o value $livedev)
@@ -180,9 +183,18 @@ fi

 if [ -n "$FSIMG" ] ; then
     BASE_LOOPDEV=$( losetup -f )
-    losetup -r $BASE_LOOPDEV $FSIMG

-    do_live_from_base_loop
+    if [ -n "$writable_fsimg" ] ; then
+        # mount the provided fileysstem read/write
+        echo "Unpacking live filesystem (may take some time)"
+        unpack_archive $FSIMG /tmp/fsimg/
+        losetup $BASE_LOOPDEV /tmp/fsimg/rootfs.img
+        echo "0 $( blockdev --getsize $BASE_LOOPDEV ) linear
$BASE_LOOPDEV 0" | dmsetup create live-rw
+    else
+        # mount the filesystem read-only and add a dm snapshot for writes
+        losetup -r $BASE_LOOPDEV $FSIMG
+        do_live_from_base_loop
+    fi
 fi

 # we might have an embedded fs image on squashfs (compressed live)
diff --git a/modules.d/90dmsquash-live/module-setup.sh
b/modules.d/90dmsquash-live/module-setup.sh
index 851fd1a..95c3566 100755
--- a/modules.d/90dmsquash-live/module-setup.sh
+++ b/modules.d/90dmsquash-live/module-setup.sh
@@ -13,7 +13,7 @@ check() {
 depends() {
     # if dmsetup is not installed, then we cannot support fedora/red hat
     # style live images
-    echo dm rootfs-block
+    echo dm rootfs-block img-lib
     return 0
 }

--
2.0.3
