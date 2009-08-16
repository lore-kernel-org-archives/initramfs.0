From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 11/18] Tighen up mdraid hostonly checking.
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <62bde8ed7eb95ba1aad7ff3eca35eeb6c4f8a99f.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Have the script really check to see of the rootfs is on an mdraid block 
device when run in hostonly mode.

---
 modules.d/{90dmraid => 90mdraid}/check |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/modules.d/90dmraid/check b/modules.d/90mdraid/check
similarity index 73%
copy from modules.d/90dmraid/check
copy to modules.d/90mdraid/check
index 1757dfd..a13d671 100755
--- a/modules.d/90dmraid/check
+++ b/modules.d/90mdraid/check
@@ -1,22 +1,20 @@
 #!/bin/bash
 
-# if we don't have dmraid installed on the host system, no point
-# in trying to support it in the initramfs.
-which dmraid >/dev/null 2>&1 || exit 1
+# No mdadm?  No mdraid support.
+which mdadm >/dev/null 2>&1 || exit 1
 
-is_dmraid() { /lib/udev/vol_id /dev/block/$1 |grep -v linux_raid_member | \
-    grep -q _raid_member; }
+is_mdraid() { /lib/udev/vol_id /dev/block/$1 |egrep -q '(linux|isw)_raid'; }
 
 check_block_and_slaves() (
     # $1 = block device in major:minor format
     local x
     cd /sys/dev/block/$1
     [[ -b /dev/block/$1 ]] || return 1 # Not a block device? So sorry.
-    is_dmraid $1 && return
+    is_mdraid $1 && return
     [[ -d slaves ]] || return 1 # there are no underlying devices, done.
     # we want to search the tree breadthwise, so...
     for x in slaves/*/dev; do
-	is_dmraid $(cat "$x") && return 0
+	is_mdraid $(cat "$x") && return 0
     done
     for x in slaves/*/dev; do
 	check_block_and_slaves $(cat "$x") &&  return 0
@@ -30,12 +28,12 @@ if [[ $1 = '-h' ]] ; then
 	[[ $blkdev = rootfs ]] && continue # skip rootfs entry
 	[[ $fs = / ]] && { rootdev=$blkdev; break; }
     done < /proc/mounts
-    [[ -b $rootdev ]] || exit 1 # Not on a block device?  Definitly not dmraid
+    [[ -b $rootdev ]] || exit 1 # Not on a block device?  Definitly not mdraid.
     # get major/minor for the device
     majmin=$(ls -nLl "$rootdev" | \
 	(read x x x x maj min x; maj=${maj//,/}; echo $maj:$min))
     # now, walk backwards though our master/slave relationships looking
-    # for a dmraid device
+    # for a mdraid device
     check_block_and_slaves $majmin || exit 1
 fi
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
