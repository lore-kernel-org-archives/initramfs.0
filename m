From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 12/18] Tighten up lvm hostonly checking.
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <b5ccf21d2b5f04bf27873a02d9983915591047e3.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Make the script really check to see if root is on an lvm device somehow 
when run in hostonly mode.

---
 modules.d/90lvm/check |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/modules.d/90lvm/check b/modules.d/90lvm/check
index 35f9344..03281a9 100755
--- a/modules.d/90lvm/check
+++ b/modules.d/90lvm/check
@@ -1,8 +1,42 @@
-#!/bin/sh
+#!/bin/bash
 
 # No point trying to support lvm if the binaries are missing
 which lvm >/dev/null 2>&1 || exit 1
 
+is_lvm() { /lib/udev/vol_id /dev/block/$1 |grep -q LVM2_member; }
+
+check_block_and_slaves() (
+    # $1 = block device in major:minor format
+    local x
+    cd /sys/dev/block/$1
+    [[ -b /dev/block/$1 ]] || return 1 # Not a block device? So sorry.
+    is_lvm $1 && return
+    [[ -d slaves ]] || return 1 # there are no underlying devices, done.
+    # we want to search the tree breadthwise, so...
+    for x in slaves/*/dev; do
+	is_lvm $(cat "$x") && return 0
+    done
+    for x in slaves/*/dev; do
+	check_block_and_slaves $(cat "$x") &&  return 0
+    done
+    return 1
+)
+
+if [[ $1 = '-h' ]] ; then
+    rootdev=''
+    while read blkdev fs type opts misc; do
+	[[ $blkdev = rootfs ]] && continue # skip rootfs entry
+	[[ $fs = / ]] && { rootdev=$blkdev; break; }
+    done < /proc/mounts
+    [[ -b $rootdev ]] || exit 1 # Not on a block device?  Definitly not crypted.
+    # get major/minor for the device
+    majmin=$(ls -nLl "$rootdev" | \
+	(read x x x x maj min x; maj=${maj//,/}; echo $maj:$min))
+    # now, walk backwards though our master/slave relationships looking
+    # for a LVM2_member device
+    check_block_and_slaves $majmin || exit 1
+fi
+
 # We should really just check to see if root is on a logical volume
 # when running in hostonly mode. I am lazy. Therefore, fail the hostonly
 # check unless there is a logical volume in use somewhere.
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
