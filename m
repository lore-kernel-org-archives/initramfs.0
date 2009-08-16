From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 10/18] Tighten hostonly check for dmraid.
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <dc670134f8adac834426cf4c2151ba505359dcb3.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Only pass if root is really on a dmraid volume somehow.

---
 modules.d/{90crypt => 90dmraid}/check |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/modules.d/90crypt/check b/modules.d/90dmraid/check
similarity index 66%
copy from modules.d/90crypt/check
copy to modules.d/90dmraid/check
index 7d78c4b..1757dfd 100755
--- a/modules.d/90crypt/check
+++ b/modules.d/90dmraid/check
@@ -1,24 +1,22 @@
 #!/bin/bash
 
-# if cryptsetup is not installed, then we cannot support encrypted devices.
-which cryptsetup >/dev/null 2>&1 || exit 1
+# if we don't have dmraid installed on the host system, no point
+# in trying to support it in the initramfs.
+which dmraid >/dev/null 2>&1 || exit 1
 
-# hostonly checking should only return true if root is on a LUKS device
-# in some way, but I am too lazy to figure out how to do that.
-# Instead, fail if we do not have a LUKS device in use somewhere.
-
-is_crypt() { /lib/udev/vol_id /dev/block/$1 |grep -q crypto_LUKS; }
+is_dmraid() { /lib/udev/vol_id /dev/block/$1 |grep -v linux_raid_member | \
+    grep -q _raid_member; }
 
 check_block_and_slaves() (
     # $1 = block device in major:minor format
     local x
     cd /sys/dev/block/$1
     [[ -b /dev/block/$1 ]] || return 1 # Not a block device? So sorry.
-    is_crypt $1 && return
+    is_dmraid $1 && return
     [[ -d slaves ]] || return 1 # there are no underlying devices, done.
     # we want to search the tree breadthwise, so...
     for x in slaves/*/dev; do
-	is_crypt $(cat "$x") && return 0
+	is_dmraid $(cat "$x") && return 0
     done
     for x in slaves/*/dev; do
 	check_block_and_slaves $(cat "$x") &&  return 0
@@ -32,12 +30,12 @@ if [[ $1 = '-h' ]] ; then
 	[[ $blkdev = rootfs ]] && continue # skip rootfs entry
 	[[ $fs = / ]] && { rootdev=$blkdev; break; }
     done < /proc/mounts
-    [[ -b $rootdev ]] || exit 1 # Not on a block device?  Definitly not crypted.
+    [[ -b $rootdev ]] || exit 1 # Not on a block device?  Definitly not dmraid
     # get major/minor for the device
     majmin=$(ls -nLl "$rootdev" | \
 	(read x x x x maj min x; maj=${maj//,/}; echo $maj:$min))
     # now, walk backwards though our master/slave relationships looking
-    # for a crypt_LUKS device
+    # for a dmraid device
     check_block_and_slaves $majmin || exit 1
 fi
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
