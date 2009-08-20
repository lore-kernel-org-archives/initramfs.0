From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 21/18] Speed up loading block drivers with --hostonly
Date: Wed, 19 Aug 2009 22:25:01 -0500 (CDT)
Message-ID: <f76ef3aa3dd61cae9ea434bcec5eca006b1ab472.1250738566.git.victor.lowther@gmail.com>
References: <59c88f499f404429ea331252bd6ad8c9d537f7d3.1250738566.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <59c88f499f404429ea331252bd6ad8c9d537f7d3.1250738566.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Instead of grovelling through all the modules available for the
kernel looking for block devices, only look at the modules that are
actually loaded. This speeds things up by a rather large amount
when generating the initramfs with --hostonly.

While we are at it, only load the filesystem module that will actually
be used for the root filesystem when running in --hostonly instead
of all the filesystem modules that happen to be loaded at the time.
---
 dracut-functions                         |    8 +++++---
 modules.d/90kernel-modules/installkernel |   23 +++++++++++++++++------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 655d311..f2a9202 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -22,7 +22,7 @@ IF_RTLD=""
 IF_dynamic=""
 
 # Generic substring function.  If $2 is in $1, return 0.
-strstr() { [[ ! ${1#*$2*} = $1 ]]; }
+strstr() { [[ $1 =~ $2 ]]; }
 
 # Log initrd creation.
 if ! [[ $dracutlogfile ]]; then
@@ -60,11 +60,11 @@ get_fs_type() (
 )
 
 # finds the major:minor of the block device backing the root filesystem.
-find_root_block_device() {
+find_block_device() {
     local rootdev blkdev fs type opts misc
     while read blkdev fs type opts misc; do
 	[[ $blkdev = rootfs ]] && continue # skip rootfs entry
-	[[ $fs = / ]] && { rootdev=$blkdev; break; } # we have a winner!
+	[[ $fs = $1 ]] && { rootdev=$blkdev; break; } # we have a winner!
     done < /proc/mounts
     [[ -b $rootdev ]] || return 1 # oops, not a block device.
     # get major/minor for the device
@@ -72,6 +72,8 @@ find_root_block_device() {
 	(read x x x x maj min x; maj=${maj//,/}; echo $maj:$min)
 }
 
+find_root_block_device() { find_block_device /; }
+
 # Walk all the slave relationships for a given block device.
 # Stop when our helper function returns success
 # $1 = function to call on every found block device
diff --git a/modules.d/90kernel-modules/installkernel b/modules.d/90kernel-modules/installkernel
index f9a1ab4..253cdc0 100755
--- a/modules.d/90kernel-modules/installkernel
+++ b/modules.d/90kernel-modules/installkernel
@@ -1,13 +1,24 @@
 #!/bin/bash
 if [[ -z $drivers ]]; then
-  drivers="sd_mod =fs"
+  drivers="sd_mod"
   # Include block controller drivers
   blockfuncs='ata_scsi_ioctl|scsi_add_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device'
-  for modname in $(find "$srcmods/kernel/drivers" -name '*.ko'); do
-    if nm -uPA $modname | egrep -q "$blockfuncs"; then
-      drivers="${drivers} $modname"
-    fi
-  done
+  if [[ $hostonly = "" ]]; then
+      for modname in $(find "$srcmods/kernel/drivers" -name '*.ko'); do
+	  if nm -uPA $modname | egrep -q "$blockfuncs"; then
+	      drivers="${drivers} $modname"
+	  fi
+      done
+      drivers="${drivers} =fs"
+  else
+      while read modname rest; do
+	  modname=$(modinfo -F filename -k $kernel $modname)
+	  if nm -uPA $modname |egrep -q "$blockfuncs"; then
+	      drivers="${drivers} $modname"
+	  fi
+      done </proc/modules
+      instmods $(get_fs_type "/dev/block/$(find_root_block_device)")
+  fi
   instmods $drivers
   # hardcoded list of exceptions
   rm -fr ${initdir}/lib/modules/*/kernel/fs/ocfs2
-- 
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
