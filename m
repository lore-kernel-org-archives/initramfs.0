From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 17/18] Make mdraid checking use stuff in dracut-functions
Date: Sun, 16 Aug 2009 16:14:55 -0500 (CDT)
Message-ID: <7e2b4f8367df360d326fe1497d1a3c009c2acc5c.1250455879.git.victor.lowther@gmail.com>
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
 modules.d/90mdraid/check |   62 ++++++++++++++++-----------------------------
 1 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/modules.d/90mdraid/check b/modules.d/90mdraid/check
dissimilarity index 86%
index a13d671..d002bdc 100755
--- a/modules.d/90mdraid/check
+++ b/modules.d/90mdraid/check
@@ -1,40 +1,22 @@
-#!/bin/bash
-
-# No mdadm?  No mdraid support.
-which mdadm >/dev/null 2>&1 || exit 1
-
-is_mdraid() { /lib/udev/vol_id /dev/block/$1 |egrep -q '(linux|isw)_raid'; }
-
-check_block_and_slaves() (
-    # $1 = block device in major:minor format
-    local x
-    cd /sys/dev/block/$1
-    [[ -b /dev/block/$1 ]] || return 1 # Not a block device? So sorry.
-    is_mdraid $1 && return
-    [[ -d slaves ]] || return 1 # there are no underlying devices, done.
-    # we want to search the tree breadthwise, so...
-    for x in slaves/*/dev; do
-	is_mdraid $(cat "$x") && return 0
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
-    [[ -b $rootdev ]] || exit 1 # Not on a block device?  Definitly not mdraid.
-    # get major/minor for the device
-    majmin=$(ls -nLl "$rootdev" | \
-	(read x x x x maj min x; maj=${maj//,/}; echo $maj:$min))
-    # now, walk backwards though our master/slave relationships looking
-    # for a mdraid device
-    check_block_and_slaves $majmin || exit 1
-fi
-
-exit 0
+#!/bin/bash
+
+# No mdadm?  No mdraid support.
+which mdadm >/dev/null 2>&1 || exit 1
+
+. $dracutfunctions
+
+is_mdraid() { /lib/udev/vol_id /dev/block/$1 |egrep -q '(linux|isw)_raid'; }
+
+[[ $1 = '-h' ]] && {
+    rootdev=$(find_root_block_device)
+    if [[ $rootdev ]]; then
+	# root lives on a block device, so we can be more precise about 
+	# hostonly checking
+	check_block_and_slaves is_mdraid "$rootdev" || exit 1
+    else
+	# root is not on a block device, use the shotgun approach
+	blkid | grep -q linux_raid || exit 1
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
