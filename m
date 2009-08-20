From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 20/18] Abstract out vol_id vs. blkid usage
Date: Wed, 19 Aug 2009 22:25:01 -0500 (CDT)
Message-ID: <59c88f499f404429ea331252bd6ad8c9d537f7d3.1250738566.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Since different distros may or may not use vol_id in udev, and blkid
is generally replacing vol_id, abstract them out into a function which
tries to use vol_id first and blkid second, on the assumption that
blkid can take over for vol_id if vol_id is no longer there.
---
 dracut-functions         |   11 +++++++++++
 modules.d/90crypt/check  |    2 +-
 modules.d/90dmraid/check |    2 +-
 modules.d/90lvm/check    |    4 ++--
 modules.d/90mdraid/check |    2 +-
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 1df2045..655d311 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -48,6 +48,17 @@ derror() {
     [[ -w $dracutlogfile ]] && echo "E: $@" >>"$dracutlogfile"
 }
 
+get_fs_type() (
+    if [[ -x /lib/udev/vol_id ]]; then
+	eval /usr/udev/vol_id --export $1
+	echo $ID_FS_TYPE
+    elif find_binary >/dev/null; then
+	blkid -o value -s TYPE $1
+    else
+	return 1
+    fi
+)
+
 # finds the major:minor of the block device backing the root filesystem.
 find_root_block_device() {
     local rootdev blkdev fs type opts misc
diff --git a/modules.d/90crypt/check b/modules.d/90crypt/check
index edd450d..07c53f9 100755
--- a/modules.d/90crypt/check
+++ b/modules.d/90crypt/check
@@ -9,7 +9,7 @@ which cryptsetup >/dev/null 2>&1 || exit 1
 
 . $dracutfunctions
 
-is_crypt() { /lib/udev/vol_id /dev/block/$1 |grep -q crypto_LUKS; }
+is_crypt() { [[ $(get_fs_type /dev/block/$1) = crypto_LUKS ]]; }
 
 [[ $1 = '-h' ]] && {
     rootdev=$(find_root_block_device)
diff --git a/modules.d/90dmraid/check b/modules.d/90dmraid/check
index 7008f81..4dd9d7a 100755
--- a/modules.d/90dmraid/check
+++ b/modules.d/90dmraid/check
@@ -6,7 +6,7 @@ which dmraid >/dev/null 2>&1 || exit 1
 
 . $dracutfunctions
 
-is_dmraid() { /lib/udev/vol_id /dev/block/$1 |grep -v linux_raid_member | \
+is_dmraid() { get_fs_type /dev/block/$1 |grep -v linux_raid_member | \
     grep -q _raid_member; }
 
 [[ $1 = '-h' ]] && {
diff --git a/modules.d/90lvm/check b/modules.d/90lvm/check
index 3e6a990..e57d60f 100755
--- a/modules.d/90lvm/check
+++ b/modules.d/90lvm/check
@@ -5,7 +5,7 @@ which lvm >/dev/null 2>&1 || exit 1
 
 . $dracutfunctions
 
-is_lvm() { /lib/udev/vol_id /dev/block/$1 |grep -q LVM2_member; }
+is_lvm() { [[ $(get_fs_type /dev/block/$1) = LVM2_member ]]; }
 
 [[ $1 = '-h' ]] && {
     rootdev=$(find_root_block_device)
@@ -15,7 +15,7 @@ is_lvm() { /lib/udev/vol_id /dev/block/$1 |grep -q LVM2_member; }
 	check_block_and_slaves is_lvm "$rootdev" || exit 1
     else
 	# root is not on a block device, use the shotgun approach
-	blkid | grep -q lvm2pv || exit 1
+	blkid | grep -q LVM2_member || exit 1
     fi
 }
 
diff --git a/modules.d/90mdraid/check b/modules.d/90mdraid/check
index d002bdc..5bffd36 100755
--- a/modules.d/90mdraid/check
+++ b/modules.d/90mdraid/check
@@ -5,7 +5,7 @@ which mdadm >/dev/null 2>&1 || exit 1
 
 . $dracutfunctions
 
-is_mdraid() { /lib/udev/vol_id /dev/block/$1 |egrep -q '(linux|isw)_raid'; }
+is_mdraid() { get_fs_type /dev/block/$1 |egrep -q '(linux|isw)_raid'; }
 
 [[ $1 = '-h' ]] && {
     rootdev=$(find_root_block_device)
-- 
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
