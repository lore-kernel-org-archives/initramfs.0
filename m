From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut-lib.sh: add copytree(), use it where applicable
Date: Tue, 22 May 2012 17:55:00 -0400
Message-ID: <1337723700-5123-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

copytree() recursively copies the contents of SRC into DEST.

If DEST doesn't exist it is created; if it exists the contents of SRC
get merged into it (duplicate files are overwritten).
---
 modules.d/45ifcfg/write-ifcfg.sh        |    2 +-
 modules.d/90livenet/fetch-liveupdate.sh |    3 +--
 modules.d/99base/dracut-lib.sh          |   11 +++++++++++
 modules.d/99img-lib/img-lib.sh          |    2 +-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index 2b7cb5c..202a16a 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -225,6 +225,6 @@ echo "files /var/lib/dhclient" >> /run/initramfs/rwtab
 {
     cp /tmp/net.* /run/initramfs/
     cp /tmp/net.$netif.resolv.conf /run/initramfs/state/etc/resolv.conf
-    cp -a -t /run/initramfs/state/etc/sysconfig/network-scripts/ /tmp/ifcfg/*
+    copytree /tmp/ifcfg /run/initramfs/state/etc/sysconfig/network-scripts
     cp /tmp/ifcfg-leases/* /run/initramfs/state/var/lib/dhclient
 } > /dev/null 2>&1
diff --git a/modules.d/90livenet/fetch-liveupdate.sh b/modules.d/90livenet/fetch-liveupdate.sh
index 8a5fdec..88aa2b1 100755
--- a/modules.d/90livenet/fetch-liveupdate.sh
+++ b/modules.d/90livenet/fetch-liveupdate.sh
@@ -27,6 +27,5 @@ if [ $? != 0 ]; then
     warn "url: $url"
     return 1
 fi
-rm -rf /updates
-mv -f /updates.tmp.$$ /updates
+copytree /updates.tmp.$$ /updates
 mv /tmp/liveupdates.info /tmp/liveupdates.done
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 2fe8a5e..8a54a7a 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -532,6 +532,17 @@ mkuniqdir() {
     echo "${retdir}"
 }
 
+# Copy the contents of SRC into DEST, merging the contents of existing
+# directories (kinda like rsync, or cpio -p).
+# Creates DEST if it doesn't exist. Overwrites files with the same names.
+#
+# copytree SRC DEST
+copytree() {
+    local src="$1" dest="$2"
+    mkdir -p "$dest"; dest=$(readlink -e -q "$dest")
+    ( cd "$src"; cp -af . -t "$dest" )
+}
+
 # Evaluates command for UUIDs either given as arguments for this function or all
 # listed in /dev/disk/by-uuid.  UUIDs doesn't have to be fully specified.  If
 # beginning is given it is expanded to all matching UUIDs.  To pass full UUID to
diff --git a/modules.d/99img-lib/img-lib.sh b/modules.d/99img-lib/img-lib.sh
index 22507aa..48e56ce 100755
--- a/modules.d/99img-lib/img-lib.sh
+++ b/modules.d/99img-lib/img-lib.sh
@@ -53,7 +53,7 @@ unpack_fs() {
     local img="$1" outdir="$2" mnt="$(mkuniqdir /tmp unpack_fs.)"
     mount -o loop $img $mnt || { rmdir $mnt; return 1; }
     mkdir -p $outdir; outdir="$(cd $outdir; pwd)"
-    ( cd $mnt; cp -a -t $outdir . )
+    copytree $mnt $outdir
     umount $mnt
     rmdir $mnt
 }
-- 
1.7.10.1
