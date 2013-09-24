From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 3/3] dracut: Implement ACPI table overriding
Date: Tue, 24 Sep 2013 19:02:57 +0200
Message-ID: <1380042177-66221-4-git-send-email-trenn@suse.de>
References: <1380042177-66221-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380042177-66221-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

An example config file for this feature could be:

/etc/dracut.conf.d/03-acpi-override.conf

with this content:
acpi_override="yes"
acpi_table_dir="/etc/dracut.conf.d/acpi_tables"

Then all files ending with *.aml will be put into the early cpio
(kernel/firmware/acpi) and will be used to replace the BIOS provided tables
if the kernel supports this feature.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 671f53f..352b546 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1327,6 +1327,17 @@ if [[ $early_microcode = yes ]]; then
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
