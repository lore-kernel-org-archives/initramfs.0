From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/3] dracut: Generlize microcode early cpio usage
Date: Tue, 24 Sep 2013 19:02:55 +0200
Message-ID: <1380042177-66221-2-git-send-email-trenn@suse.de>
References: <1380042177-66221-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1380042177-66221-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald@redhat.com
Cc: initramfs@vger.kernel.org, yinghai@kernel.org, hpa@zytor.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

ACPI early table override also may need to place files into an early cpio.
Reflect this in variable and file names.
This change is renaming only and does not introduce any real change.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 dracut.sh |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 196b3ad..0dd1e8b 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -696,9 +696,9 @@ readonly initdir="$(mktemp --tmpdir="$TMPDIR/" -d -t initramfs.XXXXXX)"
 }
 
 if [[ $early_microcode = yes ]]; then
-    readonly microcode_dir="$(mktemp --tmpdir="$TMPDIR/" -d -t early_microcode.XXXXXX)"
-    [ -d "$microcode_dir" ] || {
-        printf "%s\n" "dracut: mktemp --tmpdir=\"$TMPDIR/\" -d -t early_microcode.XXXXXX failed." >&2
+    readonly early_cpio_dir="$(mktemp --tmpdir="$TMPDIR/" -d -t early_cpio.XXXXXX)"
+    [ -d "$early_cpio_dir" ] || {
+        printf "%s\n" "dracut: mktemp --tmpdir=\"$TMPDIR/\" -d -t early_cpio.XXXXXX failed." >&2
         exit 1
     }
 fi
@@ -707,7 +707,7 @@ trap '
     ret=$?;
     [[ $outfile ]] && [[ -f $outfile.$$ ]] && rm -f -- "$outfile.$$";
     [[ $keep ]] && echo "Not removing $initdir." >&2 || { [[ $initdir ]] && rm -rf -- "$initdir"; };
-    [[ $keep ]] && echo "Not removing $microcode_dir." >&2 || { [[ $microcode_dir ]] && rm -Rf -- "$microcode_dir"; };
+    [[ $keep ]] && echo "Not removing $early_cpio_dir." >&2 || { [[ $early_cpio_dir ]] && rm -Rf -- "$early_cpio_dir"; };
     [[ $_dlogdir ]] && rm -Rf -- "$_dlogdir";
     exit $ret;
     ' EXIT
@@ -1301,7 +1301,7 @@ if [[ $early_microcode = yes ]]; then
     dinfo "*** Generating early-microcode cpio image ***"
     ucode_dir=(amd-ucode intel-ucode)
     ucode_dest=(AuthenticAMD.bin GenuineIntel.bin)
-    _dest_dir="$microcode_dir/d/kernel/x86/microcode"
+    _dest_dir="$early_cpio_dir/d/kernel/x86/microcode"
     _dest_idx="0 1"
     mkdir -p $_dest_dir
     if [[ $hostonly ]]; then
@@ -1321,14 +1321,15 @@ if [[ $early_microcode = yes ]]; then
             fi
         done
     done
-    (cd "$microcode_dir/d"; find . -print0 | cpio --null -o -H newc --quiet >../ucode.cpio)
+    create_early_cpio="yes"
 fi
 
 rm -f -- "$outfile"
 dinfo "*** Creating image file ***"
-if [[ $early_microcode = yes ]]; then
+if [[ $create_early_cpio = yes ]]; then
     # The microcode blob is _before_ the initramfs blob, not after
-    mv $microcode_dir/ucode.cpio $outfile.$$
+    (cd "$early_cpio_dir/d"; find . -print0 | cpio --null -o -H newc --quiet >../early.cpio)
+    mv $early_cpio_dir/early.cpio $outfile.$$
 fi
 if ! ( umask 077; cd "$initdir"; find . -print0 | cpio --null -R 0:0 -H newc -o --quiet| \
     $compress >> "$outfile.$$"; ); then
-- 
1.7.6.1

