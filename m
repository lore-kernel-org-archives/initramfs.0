From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v1] dracut.sh: Support early microcode loading.
Date: Tue,  9 Jul 2013 15:24:09 -0400
Message-ID: <1373397849-11397-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Implement it per Linux kernel Documentation/x86/early-microcode.txt
(from v3.11-rc0):

<start>
Early load microcode
====================
By Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Kernel can update microcode in early phase of boot time. Loading microcode early
can fix CPU issues before they are observed during kernel boot time.

Microcode is stored in an initrd file. The microcode is read from the initrd
file and loaded to CPUs during boot time.

The format of the combined initrd image is microcode in cpio format followed by
the initrd image (maybe compressed). Kernel parses the combined initrd image
during boot time. The microcode file in cpio name space is:
on Intel: kernel/x86/microcode/GenuineIntel.bin
on AMD  : kernel/x86/microcode/AuthenticAMD.bin

During BSP boot (before SMP starts), if the kernel finds the microcode file in
the initrd file, it parses the microcode and saves matching microcode in memory.
If matching microcode is found, it will be uploaded in BSP and later on in all
APs.

The cached microcode patch is applied when CPUs resume from a sleep state.

There are two legacy user space interfaces to load microcode, either through
/dev/cpu/microcode or through /sys/devices/system/cpu/microcode/reload file
in sysfs.

In addition to these two legacy methods, the early loading method described
here is the third method with which microcode can be uploaded to a system's
CPUs.

The following example script shows how to generate a new combined initrd file in
/boot/initrd-3.5.0.ucode.img with original microcode microcode.bin and
original initrd image /boot/initrd-3.5.0.img.

mkdir initrd
cd initrd
mkdir -p kernel/x86/microcode
cp ../microcode.bin kernel/x86/microcode/GenuineIntel.bin (or AuthenticAMD.bin)
find . | cpio -o -H newc >../ucode.cpio
cd ..
cat ucode.cpio /boot/initrd-3.5.0.img >/boot/initrd-3.5.0.ucode.img
<end>

That is what we do in the patch. Furthermoere there is also
an off-switch: "no-early-microcode" to disable it.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
 dracut.sh | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 42a261e..01d96dd 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -91,6 +91,7 @@ Creates initial ramdisk images for preloading modules
                          firmwares, separated by :
   --kernel-only         Only install kernel drivers and firmware files
   --no-kernel           Do not install kernel drivers and firmware files
+  --no-early-microcode  Do not combine early microcode with ramdisk
   --kernel-cmdline [PARAMETERS] Specify default kernel command line parameters
   --strip               Strip binaries in the initramfs
   --nostrip             Do not strip binaries in the initramfs
@@ -376,6 +377,7 @@ while :; do
         -f|--force)    force=yes;;
         --kernel-only) kernel_only="yes"; no_kernel="no";;
         --no-kernel)   kernel_only="no"; no_kernel="yes";;
+        --no-early-microcode) early_microcode="no";;
         --strip)       do_strip_l="yes";;
         --nostrip)     do_strip_l="no";;
         --hardlink)    do_hardlink_l="yes";;
@@ -634,6 +636,7 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
 [[ $show_modules_l ]] && show_modules=$show_modules_l
 [[ $nofscks_l ]] && nofscks="yes"
 [[ $ro_mnt_l ]] && ro_mnt="yes"
+[[ ! $early_microcode ]] && early_microcode="yes"
 # eliminate IFS hackery when messing with fw_dir
 fw_dir=${fw_dir//:/ }
 
@@ -659,9 +662,15 @@ readonly initdir=$(mktemp --tmpdir="$TMPDIR/" -d -t initramfs.XXXXXX)
     echo "dracut: mktemp --tmpdir=\"$TMPDIR/\" -d -t initramfs.XXXXXX failed." >&2
     exit 1
 }
-
+if [[ $early_microcode = yes ]]; then
+    readonly microcode_dir=$(mktemp --tmpdir="$TMPDIR/" -d -t early_microcode.XXXXXX)
+    [ -d "$microcode_dir" ] || {
+        echo "dracut: mktemp --tmpdir=\"$TMPDIR/\" -d -t early_microcode.XXXXXX failed." >&2
+        exit 1
+    }
+fi
 # clean up after ourselves no matter how we die.
-trap 'ret=$?;[[ $outfile ]] && [[ -f $outfile.$$ ]] && rm -f "$outfile.$$";[[ $keep ]] && echo "Not removing $initdir." >&2 || { [[ $initdir ]] && rm -rf "$initdir";exit $ret; };' EXIT
+trap 'ret=$?;[[ $outfile ]] && [[ -f $outfile.$$ ]] && rm -f "$outfile.$$";[[ $keep ]] && echo "Not removing $initdir." >&2 || { [[ $initdir ]] && rm -rf "$initdir"; [[ $microcode_dir ]] && rm -Rf "$microcode_dir"; exit $ret; };' EXIT
 # clean up after ourselves no matter how we die.
 trap 'exit 1;' SIGINT
 
@@ -1204,11 +1213,31 @@ if [[ $do_strip = yes ]] ; then
 
     dinfo "*** Stripping files done ***"
 fi
-
+if [[ $early_microcode = yes ]]; then
+    dinfo "*** Generating early-microcode cpio image ***"
+    ucode_dir=(amd-ucode intel-ucode)
+    ucode_dest=(AuthenticAMD.bin GenuineIntel.bin)
+    _dest_dir="$microcode_dir/d/kernel/x86/microcode"
+    mkdir -p $_dest_dir
+    for idx in 0 1; do
+        _fw=${ucode_dir[$idx]}
+        for _fwdir in $fw_dir; do
+            if [[ -d $_fwdir && -d $_fwdir/$_fw ]]; then
+                dinfo "*** Constructing ${ucode_dest[$idx]} ****"
+                cat $_fwdir/$_fw/* > $_dest_dir/${ucode_dest[$idx]}
+            fi
+        done
+    done
+    (cd "$microcode_dir/d"; find . | cpio -o -H newc --quiet >../ucode.cpio)
+fi
 rm -f "$outfile"
 dinfo "*** Creating image file ***"
+if [[ $early_microcode = yes ]]; then
+    # The microcode blob is _before_ the initramfs blob, not after
+    mv $microcode_dir/ucode.cpio $outfile.$$
+fi
 if ! ( umask 077; cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet| \
-    $compress > "$outfile.$$"; ); then
+    $compress >> "$outfile.$$"; ); then
     dfatal "dracut: creation of $outfile.$$ failed"
     exit 1
 fi
-- 
1.8.1.4
