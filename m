From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 01/33] mkinitrd-suse: Update to sles12 SUSE state
Date: Thu, 20 Nov 2014 15:56:36 +0100
Message-ID: <1416495428-36978-2-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Incorporates these patches:
- 0013 mkinitrd-suse: do not update bootloader if no kernel was found
  bnc#858268
- 0018 mkinitrd-suse: Fix whitespaces when adding drivers
- 0032 mkinitrd-suse.sh: Use '--hostonly' and '--hostonly-cmdline' corr=
ectly
  bnc#874000,bnc#874905,bnc#874363
- 0039 Remove --force parameter from mkinitrd
- 0041 mkinitd-suse: remove --hostonly and --hostonly-cmdline
  Should be set via configuration files, not in the script itself.
- 0051 mkinitrd-suse: add 'update bootloader' message
- 0120 mkinitrd-suse.sh: Bail out with exit 1 if initrd cannot be gener=
ated
  bnc#886630

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 mkinitrd-suse.8.asc |  7 +++---
 mkinitrd-suse.sh    | 66 +++++++++++++++++++++++++--------------------=
--------
 2 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/mkinitrd-suse.8.asc b/mkinitrd-suse.8.asc
index 9eb8fc9..cdb8e3a 100644
--- a/mkinitrd-suse.8.asc
+++ b/mkinitrd-suse.8.asc
@@ -76,7 +76,9 @@ OPTIONS
=20
 **-A**::
     Create a so called "monster initrd" which includes all available
-    features and modules.
+    features and modules. This calls dracut with --no-hostonly and
+    --no-hostonly-cmdline parameters internally, instead of the defaul=
t
+    --hostonly and --hostonly-cmdline.
=20
 **-v, --verbose**::
     increase verbosity level
@@ -85,9 +87,6 @@ OPTIONS
     Disable logging to _/var/log/YaST2/mkinitrd.log_. This is useful f=
or
     testing if you don=E2=80=99t want to clutter the system log.
=20
-**--force**::
-    overwrite existing initramfs file.
-
 **--help**::
     print a help message and exit.
=20
diff --git a/mkinitrd-suse.sh b/mkinitrd-suse.sh
index 23dc262..af42cbe 100755
--- a/mkinitrd-suse.sh
+++ b/mkinitrd-suse.sh
@@ -20,8 +20,6 @@
=20
 boot_dir=3D"/boot"
 quiet=3D0
-host_only=3D1
-force=3D0
 logfile=3D/var/log/YaST2/mkinitrd.log
 dracut_cmd=3Ddracut
=20
@@ -68,10 +66,7 @@ usage () {
     $cmd "	-j device		Journal device"
     $cmd "	-D interface		Run dhcp on the specified interface."
     $cmd "	-I interface		Configure the specified interface statically.=
"
-    $cmd "	-a acpi_dsdt		Attach compiled ACPI DSDT (Differentiated"
-    $cmd "				System Description Table) to initrd. This"
-    $cmd "				replaces the DSDT of the BIOS. Defaults to"
-    $cmd "				the ACPI_DSDT variable in /etc/sysconfig/kernel."
+    $cmd "	-a acpi_dsdt		Obsolete, do not use."
     $cmd "	-s size			Add splash animation and bootscreen to initrd."
=20
     [[ $1 =3D '-n' ]] && exit 0
@@ -204,8 +199,6 @@ default_kernel_images() {
     for initrd_image in $initrd_images;do
 	targets=3D"$targets $initrd_image"
     done
-    host_only=3D1
-    force=3D1
 }
=20
 while (($# > 0)); do
@@ -218,8 +211,6 @@ while (($# > 0)); do
 	    for kernel_image in $kernel_images;do
 		kernels=3D"$kernels ${kernel_image#*-}"
 	    done
-	    host_only=3D1
-	    force=3D1
 	    ;;
 	-i) read_arg initrd_images "$@" || shift $?
 	    for initrd_image in $initrd_images;do
@@ -261,7 +252,7 @@ while (($# > 0)); do
 	    dracut_cmdline=3D"${dracut_cmdline} ip=3D$(ipconfig $static_if)":
 	    ;;
 	-a) read_arg acpi_dsdt "$@" || shift $?
-	    echo "mkinitrd: custom DSDT not yet supported"
+	    echo "Obsolete -a param, use acpi_table_dir=3D and acpi_override=3D=
 variables in /etc/dracut.conf.d/"
 	    exit 1
 	    ;;
 	-s) read_arg boot_splash "$@" || shift $?
@@ -275,7 +266,6 @@ while (($# > 0)); do
         --version|-R)
             echo "mkinitrd: dracut compatibility wrapper"
             exit 0;;
-        --force) force=3D1;;
 	--quiet|-q) quiet=3D1;;
         *)  if [[ ! $targets ]]; then
             targets=3D$1
@@ -289,15 +279,17 @@ while (($# > 0)); do
 done
=20
 [[ $targets && $kernels ]] || default_kernel_images
-[[ $targets && $kernels ]] || (error "No kernel found in $boot_dir" &&=
 usage)
+if [[ ! $targets || ! $kernels ]];then
+    error "No kernel found in $boot_dir"
+fi
=20
 # We can have several targets/kernels, transform the list to an array
 targets=3D( $targets )
 [[ $kernels ]] && kernels=3D( $kernels )
=20
 [[ $logfile ]]        && dracut_args=3D"${dracut_args} --logfile $logf=
ile"
-[[ $host_only =3D=3D 1 ]] && dracut_args=3D"${dracut_args} --hostonly"
-[[ $force =3D=3D 1 ]]     && dracut_args=3D"${dracut_args} --force"
+dracut_args=3D"${dracut_args} --force"
+
 [[ $dracut_cmdline ]] && dracut_args=3D"${dracut_args} --kernel-cmdlin=
e ${dracut_cmdline}"
 [ -z "$(type -p update-bootloader)" ] && skip_update_bootloader=3D1
=20
@@ -306,11 +298,9 @@ if [ -f /etc/sysconfig/kernel ] ; then
     . /etc/sysconfig/kernel
 fi
 [[ $module_list ]] || module_list=3D"${INITRD_MODULES}"
-basicmodules=3D"$basicmodules ${module_list}"
 [[ $domu_module_list ]] || domu_module_list=3D"${DOMU_INITRD_MODULES}"
-[[ $acpi_dsdt ]] || acpi_dsdt=3D"${ACPI_DSDT}"
+shopt -s extglob
=20
-echo "Creating: target|kernel|dracut args|basicmodules "
 for ((i=3D0 ; $i<${#targets[@]} ; i++)); do
=20
     if [[ $img_vers ]];then
@@ -320,28 +310,34 @@ for ((i=3D0 ; $i<${#targets[@]} ; i++)); do
     fi
     kernel=3D"${kernels[$i]}"
=20
+    if is_xen_kernel $kernel $rootfs ; then
+	modules_all=3D"${module_list} ${domu_module_list}"
+    else
+        modules_all=3D"${module_list}"
+    fi
+
+    # Remove leading and trailing spaces needs (set above): shopt -s e=
xtglob
+    modules_all=3D${modules_all%%+([[:space:]])}
+    modules_all=3D${modules_all##+([[:space:]])}
+
+    echo "Creating initrd: $target"
+
     # Duplicate code: No way found how to redirect output based on $qu=
iet
     if [[ $quiet =3D=3D 1 ]];then
-	echo "$target|$kernel|$dracut_args|$basicmodules"
-	if is_xen_kernel $kernel $rootfs ; then
-	    basicmodules=3D"$basicmodules ${domu_module_list}"
-	fi
-	if [[ $basicmodules ]]; then
-            $dracut_cmd $dracut_args --add-drivers "$basicmodules" "$t=
arget" \
-		"$kernel" &>/dev/null
-	else
+        # Duplicate code: --force-drivers must not be called with empt=
y string
+        # -> dracut bug workarounded ugly, because of complex whitespa=
ce
+        # expansion magics
+        if [ -n "${modules_all}" ];then
+            $dracut_cmd $dracut_args --force-drivers "${modules_all}" =
"$target" "$kernel" &>/dev/null
+        else
             $dracut_cmd $dracut_args "$target" "$kernel" &>/dev/null
-	fi
+        fi
     else
-	if is_xen_kernel $kernel $rootfs ; then
-	    basicmodules=3D"$basicmodules ${domu_module_list}"
-	fi
-	if [[ $basicmodules ]]; then
-            $dracut_cmd $dracut_args --add-drivers "$basicmodules" "$t=
arget" \
-		"$kernel"
-	else
+        if [ -n "${modules_all}" ];then
+            $dracut_cmd $dracut_args --force-drivers "${modules_all}" =
"$target" "$kernel"
+        else
             $dracut_cmd $dracut_args "$target" "$kernel"
-	fi
+        fi
     fi
 done
=20
--=20
1.8.5.2
