From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] dracut: Introduce --force-drivers parameter and force_drivers=+ config option
Date: Wed, 07 May 2014 18:00:06 +0200
Message-ID: <2956069.N6upzrOyu5@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Which will not only add listed drivers, but also enforce that they are tried
 to be loaded at early boot time.

This is needed if drivers which are not autoloaded (e.g. loop and a lot others)
shall get loaded via initramfs.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

Index: dracut-037/dracut.sh
===================================================================
--- dracut-037.orig/dracut.sh
+++ dracut-037/dracut.sh
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
@@ -299,6 +303,7 @@ rearrange_params()
         --long add: \
         --long force-add: \
         --long add-drivers: \
+        --long force-drivers: \
         --long omit-drivers: \
         --long modules: \
         --long omit: \
@@ -463,6 +468,7 @@ while :; do
         -a|--add)      push add_dracutmodules_l  "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
         --force-add)   push force_add_dracutmodules_l  "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
         --add-drivers) push add_drivers_l        "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
+        --force-drivers) push force_drivers_l        "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
         --omit-drivers) push omit_drivers_l      "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
         -m|--modules)  push dracutmodules_l      "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
         -o|--omit)     push omit_dracutmodules_l "$2"; PARMS_TO_STORE+=" '$2'"; shift;;
@@ -880,6 +886,13 @@ if (( ${#add_drivers_l[@]} )); then
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
@@ -896,6 +909,7 @@ fi
 omit_drivers_corrected=""
 for d in $omit_drivers; do
     [[ " $drivers $add_drivers " == *\ $d\ * ]] && continue
+    [[ " $drivers $force_drivers " == *\ $d\ * ]] && continue
     omit_drivers_corrected+="$d|"
 done
 omit_drivers="${omit_drivers_corrected%|}"
@@ -1287,6 +1301,13 @@ if [[ $no_kernel != yes ]]; then
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
Index: dracut-037/dracut.8.asc
===================================================================
--- dracut-037.orig/dracut.8.asc
+++ dracut-037/dracut.8.asc
@@ -136,6 +136,19 @@ example:
 ----
 ===============================
 
+**--force-drivers** _<list of kernel modules>_::
+    See add-drivers above. But in this case it is ensured that the drivers
+    are tried to be loaded early via modprobe.
++
+[NOTE]
+===============================
+If [LIST] has multiple arguments, then you have to put these in quotes. For
+example:
+----
+# dracut --force-drivers "kmodule1 kmodule2"  ...
+----
+===============================
+
 **--omit-drivers** _<list of kernel modules>_::
     specify a space-separated list of kernel modules not to add to the
     initramfs.
