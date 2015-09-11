From: Fabian <fvogt-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH] dracut.sh: Support --mount with just mountpoint as parameter
Date: Fri, 11 Sep 2015 13:35:57 +0200
Message-ID: <1602461.PPk7fxS36o@linux-lm3i>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Right now the --mount parameter of dracut expects a rather long fstab-like 
line. This makes it possible to invoke dracut with e.g. --mount /boot.

---
 dracut.8.asc |  4 ++++
 dracut.sh    | 16 +++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/dracut.8.asc b/dracut.8.asc
index 7a7ef9d..eeb3dd9 100644
--- a/dracut.8.asc
+++ b/dracut.8.asc
@@ -338,6 +338,10 @@ provide a valid _/etc/fstab_.
     The default _<dump frequency>_ is "0".
     the default _<fsck order>_ is "2".
 
+**--mount** "_<mountpoint>_"::
+    Like above, but _<device>_, _<filesystem type>_ and _<filesystem 
options>_
+    are determined by looking at the current mounts.
+
 **--add-device** _<device>_ ::
     Bring up _<device>_ in initramfs, _<device>_ should be the device name.
     This can be useful in hostonly mode for resume support when your swap is 
on
diff --git a/dracut.sh b/dracut.sh
index f7d31a4..c41cbe3 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -160,6 +160,8 @@ Creates initial ramdisk images for preloading modules
   --mount "[DEV] [MP] [FSTYPE] [FSOPTS]"
                         Mount device [DEV] on mountpoint [MP] with filesystem
                         [FSTYPE] and options [FSOPTS] in the initramfs
+  --mount "[MP]"	Same as above, but [DEV], [FSTYPE] and [FSOPTS] are
+			determined by looking at the current mounts.
   --add-device "[DEV]"  Bring up [DEV] in initramfs
   -i, --include [SOURCE] [TARGET]
                         Include the files in the SOURCE directory into the
@@ -1460,9 +1462,21 @@ if [[ $kernel_only != yes ]]; then
 
     for line in "${fstab_lines[@]}"; do
         line=($line)
-        [ -z "${line[3]}" ] && line[3]="defaults"
+
+        if [ -z "${line[1]}" ]; then
+            # Determine device and mount options from current system
+            mountpoint -q "${line[0]}" || derror "${line[0]} is not a mount 
point!"
+            line=($(findmnt --raw -n --target "${line[0]}" --
output=source,target,fstype,options))
+            dinfo "Line for ${line[1]}: ${line[@]}"
+        else
+            # Use default options
+            [ -z "${line[3]}" ] && line[3]="defaults"
+        fi
+
+        # Default options for freq and passno
         [ -z "${line[4]}" ] && line[4]="0"
         [ -z "${line[5]}" ] && line[5]="2"
+
         strstr "${line[2]}" "nfs" && line[5]="0"
         echo "${line[@]}" >> "${initdir}/etc/fstab"
     done
-- 
2.5.1

