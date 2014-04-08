From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [RFC] Force to add and load kernel modules other than via boot param
Date: Tue, 08 Apr 2014 19:33:34 +0200
Message-ID: <4042595.ArByetRvkY@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I may oversee something:
Is it possible to specify a kernel module/driver via
dracut paramter and/or config option (/etc/dracut.conf.d/..)
to get it added to the initrd for sure and on boot it is ensured
it tries to get loaded not depending on any udev rules, systemd, etc.?

If there currently is no way, below is a patch which introduces:
--force-drivers
parameter and
force_drivers=+
config option to do that.
Tested as far as that:
etc/cmdline.d/20-force_drivers.conf
is created inside the initrd when the parameter or config
option is passed.

If this makes sense, I can send something cleaner with documentation
etc. adjusted.

Thanks,

      Thomas

Index: dracut-036/dracut.sh
===================================================================
--- dracut-036.orig/dracut.sh
+++ dracut-036/dracut.sh
@@ -81,6 +81,10 @@ Creates initial ramdisk images for prelo
                          exclusively include in the initramfs.
   --add-drivers [LIST]  Specify a space-separated list of kernel
                          modules to add to the initramfs.
+  --force-drivers [LIST] Specify a space-separated list of kernel
+                         modules to add to the initramfs and make sure they
+                         are tried to be loaded via modprobe same as passing
+                         rd.driver.pre=DRIVER kernel parameter.
   --omit-drivers [LIST] Specify a space-separated list of kernel
                          modules not to add to the initramfs.
   --filesystems [LIST]  Specify a space-separated list of kernel filesystem
@@ -295,6 +299,7 @@ rearrange_params()
         --long add: \
         --long force-add: \
         --long add-drivers: \
+        --long force-drivers: \
         --long omit-drivers: \
         --long modules: \
         --long omit: \
@@ -457,6 +462,7 @@ while :; do
         -a|--add)      push add_dracutmodules_l  "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
         --force-add)   push force_add_dracutmodules_l  "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
         --add-drivers) push add_drivers_l        "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
+        --force-drivers) push force_drivers_l        "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
         --omit-drivers) push omit_drivers_l      "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
         -m|--modules)  push dracutmodules_l      "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
         -o|--omit)     push omit_dracutmodules_l "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
@@ -867,6 +873,13 @@ if (( ${#add_drivers_l[@]} )); then
 fi
 add_drivers=${add_drivers/-/_}
 
+if (( ${#force_drivers_l[@]} )); then
+    while pop force_drivers_l val; do
+        force_drivers+=" $val "
+    done
+fi
+force_drivers=${force_drivers/-/_}
+
 if (( ${#omit_drivers_l[@]} )); then
     while pop omit_drivers_l val; do
         omit_drivers+=" $val "
@@ -883,6 +896,7 @@ fi
 omit_drivers_corrected=""
 for d in $omit_drivers; do
     [[ " $drivers $add_drivers " == *\ $d\ * ]] && continue
+    [[ " $drivers $force_drivers " == *\ $d\ * ]] && continue
     omit_drivers_corrected+="$d|"
 done
 omit_drivers="${omit_drivers_corrected%|}"
@@ -1274,6 +1288,13 @@ if [[ $no_kernel != yes ]]; then
     if [[ $add_drivers ]]; then
         hostonly='' instmods -c $add_drivers
     fi
+    if [[ $force_drivers ]]; then
+        hostonly='' instmods -c $force_drivers
+        rm -f $initdir/etc/cmdline.d/20-force_driver.conf
+        for mod in $force_drivers; do
+            echo "rd.driver.pre=$mod" >>$initdir/etc/cmdline.d/20-force_drivers.conf
+        done
+    fi
     if [[ $filesystems ]]; then
         hostonly='' instmods -c $filesystems
     fi
