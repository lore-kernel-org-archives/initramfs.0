From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v1] dracut.sh: Support early microcode loading.
Date: Fri, 12 Jul 2013 17:02:54 -0400
Message-ID: <20130712210254.GA26664@phenom.dumpdata.com>
References: <1373397849-11397-1-git-send-email-konrad.wilk@oracle.com>
 <3E5A0FA7E9CA944F9D5414FEC6C712205A528195@ORSMSX106.amr.corp.intel.com>
 <51DD0F27.70202@redhat.com>
 <20130710145815.GD11007@phenom.dumpdata.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130710145815.GD11007-6K5HmflnPlqSPmnEAIUT9EEOCMrvLtNR@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Yu, Fenghua" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Jul 10, 2013 at 10:58:15AM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Jul 10, 2013 at 09:37:11AM +0200, Harald Hoyer wrote:
> > On 07/10/2013 02:29 AM, Yu, Fenghua wrote:
> > >> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org]
> > >> Sent: Tuesday, July 09, 2013 12:24 PM
> > >> Implement it per Linux kernel Documentation/x86/early-microcode.txt
> > >> (from v3.11-rc0):
> > [...]
> > > This patch works fine with one microcode blob in binary format. There are situations that the microcode is not delivered in one blob in binary format:
> > > 
> > > First, each microcode patch is one file instead all microcode patches are in one big blob. Secondly, old delivered microcode file is in ascii format.
> > > 
> > > To handle those formats, additional code needs to convert the formats into one big binary microcode blob. I'm not sure if we should consider the code and if we should put the code in dracut.
> > > 
> > > Thanks.
> > > 
> > > -Fenghua
> > > 
> > 
> > 
> > $ ls /lib/firmware/amd-ucode
> > microcode_amd.bin  microcode_amd_fam15h.bin  microcode_amd_solaris.bin
> 
> Right, so all of those blobs (for AMD) get stuck in AuthenticAMD.bin.
> 
> > $ ls /lib/firmware/intel-ucode
> > 06-03-02  06-06-00  06-07-02  06-08-0a  06-0b-04  06-0f-06  06-16-01  06-1c-02
> > 06-25-02  06-2d-07  0f-01-02  0f-02-09  0f-04-03  0f-04-0a
> > 06-05-00  06-06-05  06-07-03  06-09-05  06-0d-06  06-0f-07  06-17-06  06-1c-0a
> > 06-25-05  06-2f-02  0f-02-04  0f-03-02  0f-04-04  0f-06-02
> > 06-05-01  06-06-0a  06-08-01  06-0a-00  06-0e-08  06-0f-0a  06-17-07  06-1d-01
> > 06-26-01  06-3a-09  0f-02-05  0f-03-03  0f-04-07  0f-06-04
> > 06-05-02  06-06-0d  06-08-03  06-0a-01  06-0e-0c  06-0f-0b  06-17-0a  06-1e-04
> > 06-2a-07  0f-00-07  0f-02-06  0f-03-04  0f-04-08  0f-06-05
> > 06-05-03  06-07-01  06-08-06  06-0b-01  06-0f-02  06-0f-0d  06-1a-04  06-1e-05
> > 06-2d-06  0f-00-0a  0f-02-07  0f-04-01  0f-04-09  0f-06-08
> 
> And all of those get catted in GenuineIntel.bin.
> 
> > 
> > Also, for [[ $hostonly ]], we only want to add the current running CPU microcode.
> 
> <nods> Will do that. Are you OK with me adding some of this CPU detection logic
> in dracut-functions.sh?

This is still RFC, as I had not done the --no-compress logic (or tested it).
Please see if this is OK:


From 5f853d2ececd4cadff648e22cb9c9287a01a9783 Mon Sep 17 00:00:00 2001
From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Date: Tue, 9 Jul 2013 13:57:01 -0400
Subject: [PATCH] dracut.sh: Support early microcode loading.

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
[v1: Support --host-only parameter]
---
 dracut-functions.sh |   33 +++++++++++++++++++++++++++++++++
 dracut.sh           |   46 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 7ecd551..4375b26 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -1653,3 +1653,36 @@ instmods() {
     _ret=$?
     return $_ret
 }
+# get_cpu_vendor
+# Only two values are returned: AMD or Intel
+get_cpu_vendor ()
+{
+    if grep -qE AMD /proc/cpuinfo; then
+        printf "AMD"
+    fi
+    if grep -qE Intel /proc/cpuinfo; then
+        printf "Intel"
+    fi
+}
+
+# get_host_ucode
+# Get the hosts' ucode file based on the /proc/cpuinfo
+get_ucode_file ()
+{
+    local family=`grep -E "cpu family" /proc/cpuinfo | head -1 | sed s/.*:\ //`
+    local model=`grep -E "model" /proc/cpuinfo |grep -v name | head -1 | sed s/.*:\ //`
+    local stepping=`grep -E "stepping" /proc/cpuinfo | head -1 | sed s/.*:\ //`
+
+    if [[ "$(get_cpu_vendor)" == "AMD" ]]; then
+        # If family greater or equal than 0x15
+        if [[ $family -ge 21 ]]; then
+            printf "microcode_amd_fam15h.bin"
+        else
+            printf "microcode_amd.bin"
+        fi
+    fi
+    if [[ "$(get_cpu_vendor)" == "Intel" ]]; then
+        # The /proc/cpuinfo are in decimal.
+        printf "%02x-%02x-%02x" ${family} ${model} ${stepping}
+    fi
+}
diff --git a/dracut.sh b/dracut.sh
index 42a261e..d52b71c 100755
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
 
@@ -1204,11 +1213,40 @@ if [[ $do_strip = yes ]] ; then
 
     dinfo "*** Stripping files done ***"
 fi
-
+if [[ $early_microcode = yes ]]; then
+    dinfo "*** Generating early-microcode cpio image ***"
+    ucode_dir=(amd-ucode intel-ucode)
+    ucode_dest=(AuthenticAMD.bin GenuineIntel.bin)
+    _dest_dir="$microcode_dir/d/kernel/x86/microcode"
+    _dest_idx="0 1"
+    mkdir -p $_dest_dir
+    if [[ $hostonly ]]; then
+        [[ $(get_cpu_vendor) == "AMD" ]] && _dest_idx="0"
+        [[ $(get_cpu_vendor) == "Intel" ]] && _dest_idx="1"
+    fi
+    for idx in $_dest_idx; do
+        _fw=${ucode_dir[$idx]}
+        for _fwdir in $fw_dir; do
+            if [[ -d $_fwdir && -d $_fwdir/$_fw ]]; then
+                _src="*"
+                dinfo "*** Constructing ${ucode_dest[$idx]} ****"
+                if [[ $hostonly ]]; then
+                    _src=$(get_ucode_file)
+                fi
+                cat $_fwdir/$_fw/$_src > $_dest_dir/${ucode_dest[$idx]}
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
1.7.7.6
