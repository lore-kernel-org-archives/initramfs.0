From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 16/18] Make dmraid checking use stuff in dracut-functions
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <bc9ae19deb70f27a54bd2f7904cb3059f6d06568.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/90dmraid/check |   66 ++++++++++++++++-----------------------------
 1 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/modules.d/90dmraid/check b/modules.d/90dmraid/check
dissimilarity index 79%
index 1757dfd..7008f81 100755
--- a/modules.d/90dmraid/check
+++ b/modules.d/90dmraid/check
@@ -1,42 +1,24 @@
-#!/bin/bash
-
-# if we don't have dmraid installed on the host system, no point
-# in trying to support it in the initramfs.
-which dmraid >/dev/null 2>&1 || exit 1
-
-is_dmraid() { /lib/udev/vol_id /dev/block/$1 |grep -v linux_raid_member | \
-    grep -q _raid_member; }
-
-check_block_and_slaves() (
-    # $1 = block device in major:minor format
-    local x
-    cd /sys/dev/block/$1
-    [[ -b /dev/block/$1 ]] || return 1 # Not a block device? So sorry.
-    is_dmraid $1 && return
-    [[ -d slaves ]] || return 1 # there are no underlying devices, done.
-    # we want to search the tree breadthwise, so...
-    for x in slaves/*/dev; do
-	is_dmraid $(cat "$x") && return 0
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
-    [[ -b $rootdev ]] || exit 1 # Not on a block device?  Definitly not dmraid
-    # get major/minor for the device
-    majmin=$(ls -nLl "$rootdev" | \
-	(read x x x x maj min x; maj=${maj//,/}; echo $maj:$min))
-    # now, walk backwards though our master/slave relationships looking
-    # for a dmraid device
-    check_block_and_slaves $majmin || exit 1
-fi
-
-exit 0
+#!/bin/bash
+
+# if we don't have dmraid installed on the host system, no point
+# in trying to support it in the initramfs.
+which dmraid >/dev/null 2>&1 || exit 1
+
+. $dracutfunctions
+
+is_dmraid() { /lib/udev/vol_id /dev/block/$1 |grep -v linux_raid_member | \
+    grep -q _raid_member; }
+
+[[ $1 = '-h' ]] && {
+    rootdev=$(find_root_block_device)
+    if [[ $rootdev ]]; then
+	# root lives on a block device, so we can be more precise about 
+	# hostonly checking
+	check_block_and_slaves is_dmraid "$rootdev" || exit 1
+    else
+	# root is not on a block device, use the shotgun approach
+	dmraid -r | grep -q ok || exit 1
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
