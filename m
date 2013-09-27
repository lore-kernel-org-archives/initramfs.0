From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/4] dracut: Implement ACPI table overriding
Date: Fri, 27 Sep 2013 20:10:39 +0200
Message-ID: <1380305440-63843-4-git-send-email-trenn@suse.de>
References: <1380305440-63843-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1380305440-63843-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald@redhat.com
Cc: initramfs@vger.kernel.org, linux-acpi@vger.kernel.org, konrad.wilk@oracle.com, Thomas Renninger <trenn@suse.de>

An example config file for this feature could be:

/etc/dracut.conf.d/03-acpi-override.conf

with this content:
acpi_override="yes"
acpi_table_dir="/etc/dracut.conf.d/acpi_tables"

Then all files ending with *.aml will be put into the early cpio
(kernel/firmware/acpi) and will be used to replace the BIOS provided tables
if the kernel supports this feature.

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 dracut.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 618c301..b94224d 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1305,6 +1305,17 @@ if [[ $early_microcode = yes ]]; then
     done
 fi
 
+if [[ $acpi_override = yes ]] && [[ -d $acpi_table_dir ]]; then
+    dinfo "*** Packaging ACPI tables to override BIOS provided ones ***"
+    _dest_dir="$early_cpio_dir/d/kernel/firmware/acpi"
+    mkdir -p $_dest_dir
+    for table in $acpi_table_dir/*.aml; do
+        dinfo "   Adding ACPI table: $table"
+        cp $table $_dest_dir
+        create_early_cpio="yes"
+    done
+fi
+
 rm -f -- "$outfile"
 dinfo "*** Creating image file ***"
 if [[ $create_early_cpio = yes ]]; then
-- 
1.7.6.1

