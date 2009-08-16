From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 15/18] Move common rootfs finding and backing store functions.
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <17829e94aa40321961b4211bc2d893f3c0d23b60.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The code for crupt, mdraid, dmraid, and lvm is nearly identical, so factor
the common stuff into dracut-functions.

---
 dracut-functions        |   32 +++++++++++++++++++++
 modules.d/90crypt/check |   70 +++++++++++++++++-----------------------------
 2 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 66e0e20..1df2045 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -48,6 +48,38 @@ derror() {
     [[ -w $dracutlogfile ]] && echo "E: $@" >>"$dracutlogfile"
 }
 
+# finds the major:minor of the block device backing the root filesystem.
+find_root_block_device() {
+    local rootdev blkdev fs type opts misc
+    while read blkdev fs type opts misc; do
+	[[ $blkdev = rootfs ]] && continue # skip rootfs entry
+	[[ $fs = / ]] && { rootdev=$blkdev; break; } # we have a winner!
+    done < /proc/mounts
+    [[ -b $rootdev ]] || return 1 # oops, not a block device.
+    # get major/minor for the device
+    ls -nLl "$rootdev" | \
+	(read x x x x maj min x; maj=${maj//,/}; echo $maj:$min)
+}
+
+# Walk all the slave relationships for a given block device.
+# Stop when our helper function returns success
+# $1 = function to call on every found block device
+# $2 = block device in major:minor format
+check_block_and_slaves() {    
+    local x 
+    [[ -b /dev/block/$2 ]] || return 1 # Not a block device? So sorry.
+    "$1" $2 && return
+    [[ -d /sys/dev/block/$2/slaves ]] || return 1
+    # we want to search the tree breadthwise, so...
+    for x in /sys/dev/block/$2/slaves/*/dev; do
+	$1 $(cat "$x") && return 0
+    done
+    for x in /sys/dev/block/$2/slaves/*/dev; do
+	check_block_and_slaves $1 $(cat "$x") &&  return 0
+    done
+    return 1
+}
+
 # $1 = file to copy to ramdisk
 # $2 (optional) Name for the file on the ramdisk
 # Location of the image dir is assumed to be $initdir
diff --git a/modules.d/90crypt/check b/modules.d/90crypt/check
dissimilarity index 72%
index 7d78c4b..edd450d 100755
--- a/modules.d/90crypt/check
+++ b/modules.d/90crypt/check
@@ -1,44 +1,26 @@
-#!/bin/bash
-
-# if cryptsetup is not installed, then we cannot support encrypted devices.
-which cryptsetup >/dev/null 2>&1 || exit 1
-
-# hostonly checking should only return true if root is on a LUKS device
-# in some way, but I am too lazy to figure out how to do that.
-# Instead, fail if we do not have a LUKS device in use somewhere.
-
-is_crypt() { /lib/udev/vol_id /dev/block/$1 |grep -q crypto_LUKS; }
-
-check_block_and_slaves() (
-    # $1 = block device in major:minor format
-    local x
-    cd /sys/dev/block/$1
-    [[ -b /dev/block/$1 ]] || return 1 # Not a block device? So sorry.
-    is_crypt $1 && return
-    [[ -d slaves ]] || return 1 # there are no underlying devices, done.
-    # we want to search the tree breadthwise, so...
-    for x in slaves/*/dev; do
-	is_crypt $(cat "$x") && return 0
-    done
-    for x in slaves/*/dev; do
-	check_block_and_slaves $(cat "$x") &&  return 0
-    done
-    return 1
-)
-
-if [[ $1 = '-h' ]] ; then
-    rootdev=''
-    while read blkdev fs type opts misc; do
-	[[ $blkdev = rootfs ]] && continue # skip rootfs entry
-	[[ $fs = / ]] && { rootdev=$blkdev; break; }
-    done < /proc/mounts
-    [[ -b $rootdev ]] || exit 1 # Not on a block device?  Definitly not crypted.
-    # get major/minor for the device
-    majmin=$(ls -nLl "$rootdev" | \
-	(read x x x x maj min x; maj=${maj//,/}; echo $maj:$min))
-    # now, walk backwards though our master/slave relationships looking
-    # for a crypt_LUKS device
-    check_block_and_slaves $majmin || exit 1
-fi
-
-exit 0
+#!/bin/bash
+
+# if cryptsetup is not installed, then we cannot support encrypted devices.
+which cryptsetup >/dev/null 2>&1 || exit 1
+
+# hostonly checking should only return true if root is on a LUKS device
+# in some way, but I am too lazy to figure out how to do that.
+# Instead, fail if we do not have a LUKS device in use somewhere.
+
+. $dracutfunctions
+
+is_crypt() { /lib/udev/vol_id /dev/block/$1 |grep -q crypto_LUKS; }
+
+[[ $1 = '-h' ]] && {
+    rootdev=$(find_root_block_device)
+    if [[ $rootdev ]]; then
+	# root lives on a block device, so we can be more precise about 
+	# hostonly checking
+	check_block_and_slaves is_crypt "$rootdev" || exit 1
+    else
+	# root is not on a block device, use the shotgun approach
+	blkid | grep -q crypt_LUKS || exit 1
+    fi
+}
+
+exit 0
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
