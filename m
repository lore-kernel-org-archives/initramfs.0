From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 18/18] Modified lvm hostonly checking to use dracut-functions
Date: Sun, 16 Aug 2009 16:14:55 -0500 (CDT)
Message-ID: <d7df77d172cd9be7a2bc9572d8d8c0f3b3db16a0.1250455879.git.victor.lowther@gmail.com>
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
 modules.d/{90mdraid => 90lvm}/check |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/modules.d/90mdraid/check b/modules.d/90lvm/check
similarity index 54%
copy from modules.d/90mdraid/check
copy to modules.d/90lvm/check
index d002bdc..3e6a990 100755
--- a/modules.d/90mdraid/check
+++ b/modules.d/90lvm/check
@@ -1,21 +1,21 @@
 #!/bin/bash
 
-# No mdadm?  No mdraid support.
-which mdadm >/dev/null 2>&1 || exit 1
+# No point trying to support lvm if the binaries are missing
+which lvm >/dev/null 2>&1 || exit 1
 
 . $dracutfunctions
 
-is_mdraid() { /lib/udev/vol_id /dev/block/$1 |egrep -q '(linux|isw)_raid'; }
+is_lvm() { /lib/udev/vol_id /dev/block/$1 |grep -q LVM2_member; }
 
 [[ $1 = '-h' ]] && {
     rootdev=$(find_root_block_device)
     if [[ $rootdev ]]; then
 	# root lives on a block device, so we can be more precise about 
 	# hostonly checking
-	check_block_and_slaves is_mdraid "$rootdev" || exit 1
+	check_block_and_slaves is_lvm "$rootdev" || exit 1
     else
 	# root is not on a block device, use the shotgun approach
-	blkid | grep -q linux_raid || exit 1
+	blkid | grep -q lvm2pv || exit 1
     fi
 }
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
