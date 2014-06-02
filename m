From: Hari Bathini <hbathini-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] lsinird: Adding option "-m|--mod" to list dracut modules in
 the image
Date: Mon, 02 Jun 2014 16:27:37 +0530
Message-ID: <20140602105737.11356.69989.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

This patch adds option "-m|--mod" to lsinitrd to list dracut
modules in the image  because sometimes  having an option to
only list the dracut modules in the image could be handy.

Sample output:
--------------

[hbathini@localhost dracut]$ sudo ./lsinitrd.sh initramfs-3.11.10-100.fc18.x86_64.img -m
Image: initramfs-3.11.10-100.fc18.x86_64.img: 33M
========================================================================
Version: dracut-029-1.fc18.2

dracut modules:
i18n
network
ifcfg
drm
plymouth
btrfs
crypt
dm
dmraid
kernel-modules
lvm
mdraid
cifs
iscsi
nfs
resume
rootfs-block
terminfo
udev-rules
biosdevname
systemd
usrmount
base
fs-lib
shutdown
========================================================================

Signed-off-by: Hari Bathini <hbathini-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 lsinitrd.sh |   30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/lsinitrd.sh b/lsinitrd.sh
index a697bc2..8e4baaf 100755
--- a/lsinitrd.sh
+++ b/lsinitrd.sh
@@ -27,6 +27,7 @@ usage()
         echo
         echo "-h, --help                  print a help message and exit."
         echo "-s, --size                  sort the contents of the initramfs by size."
+        echo "-m, --mod                   list modules."
         echo "-f, --file <filename>       print the contents of <filename>."
         echo "-k, --kver <kernel version> inspect the initramfs of <kernel version>."
         echo
@@ -37,13 +38,15 @@ usage()
 [[ $dracutbasedir ]] || dracutbasedir=/usr/lib/dracut
 
 sorted=0
+modules=0
 declare -A filenames
 
 unset POSIXLY_CORRECT
 TEMP=$(getopt \
-    -o "shf:k:" \
+    -o "shmf:k:" \
     --long kver: \
     --long file: \
+    --long mod \
     --long help \
     --long size \
     -- "$@")
@@ -61,6 +64,7 @@ while (($# > 0)); do
         -f|--file)  filenames[${2#/}]=1; shift;;
         -s|--size)  sorted=1;;
         -h|--help)  usage; exit 0;;
+        -m|--mod)   modules=1;;
         --)         shift;break;;
         *)          usage; exit 1;;
     esac
@@ -119,6 +123,13 @@ extract_files()
     done
 }
 
+list_modules()
+{
+    echo "dracut modules:"
+    $CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- 'lib/dracut/modules.txt' 'usr/lib/dracut/modules.txt' 2>/dev/null
+    ((ret+=$?))
+}
+
 list_files()
 {
     echo "========================================================================"
@@ -209,13 +220,16 @@ else
     ((ret+=$?))
     echo "Version: $version"
     echo
-    echo -n "Arguments: "
-    $CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- 'lib/dracut/build-parameter.txt' 'usr/lib/dracut/build-parameter.txt' 2>/dev/null
-    echo
-    echo "dracut modules:"
-    $CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- 'lib/dracut/modules.txt' 'usr/lib/dracut/modules.txt' 2>/dev/null
-    ((ret+=$?))
-    list_files
+    if [ "$modules" -eq 1 ]; then
+        list_modules
+        echo "========================================================================"
+    else
+        echo -n "Arguments: "
+        $CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- 'lib/dracut/build-parameter.txt' 'usr/lib/dracut/build-parameter.txt' 2>/dev/null
+        echo
+        list_modules
+        list_files
+    fi
 fi
 
 exit $ret
