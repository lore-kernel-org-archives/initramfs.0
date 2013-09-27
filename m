From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 4/4] dracut.conf.5.asc: Add ACPI table override and uncompressed cpio doc
Date: Fri, 27 Sep 2013 20:10:40 +0200
Message-ID: <1380305440-63843-5-git-send-email-trenn@suse.de>
References: <1380305440-63843-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380305440-63843-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut.conf.5.asc |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/dracut.conf.5.asc b/dracut.conf.5.asc
index a32516c..d471f4b 100644
--- a/dracut.conf.5.asc
+++ b/dracut.conf.5.asc
@@ -122,6 +122,21 @@ If chrooted to another root other than the real root device, use --fstab and pro
 *no_kernel=*"{yes|no}"::
     Do not install kernel drivers and firmware files (default=no)
 
+*acpi_override=*"{yes|no}"::
+    [WARNING] ONLY USE THIS IF YOU KNOW WHAT YOU ARE DOING! +
+    Override BIOS provided ACPI tables. For further documentation read
+    Documentation/acpi/initrd_table_override.txt in the kernel sources.
+    Search for ACPI table files (must have .aml suffix) in acpi_table_dir=
+    directory (see below) and add them to a separate uncompressed cpio
+    archive. This cpio archive gets glued (concatenated, uncompressed one
+    must be the first one) to the compressed cpio archive. The first,
+    uncompressed cpio archive is for data which the kernel must be able
+    to access very early (and cannot make use of uncompress alogrithms yet)
+    like microcode or ACPI tables (default=no).
+
+*acpi_table_dir=*"__<dir>__"::
+    Directory to search for ACPI tables if acpi_override= is set to yes.
+
 *early_microcode=*"{yes|no}"::
     Combine early microcode with ramdisk (default=no)
 
-- 
1.7.6.1
