From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 5/6] ACPI: Create acpi_table_taint() function to avoid code duplication
Date: Tue, 25 Sep 2012 16:56:00 +0200
Message-ID: <1348584961-1476-6-git-send-email-trenn@suse.de>
References: <1348584961-1476-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1348584961-1476-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hpa@zytor.com
Cc: lenb@kernel.org, initramfs@vger.kernel.org, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, yinghai@kernel.org, Thomas Renninger <trenn@suse.de>

There are two ways of overriding ACPI tables now, both need to taint the
the kernel.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/osl.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 007224b..a2845ff 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -656,6 +656,15 @@ void __init acpi_initrd_override(void *data, size_t size)
 }
 #endif /* CONFIG_ACPI_INITRD_TABLE_OVERRIDE */
 
+static void acpi_table_taint(struct acpi_table_header *table)
+{
+	pr_warn(PREFIX
+		"Override [%4.4s-%8.8s], this is unsafe: tainting kernel\n",
+		table->signature, table->oem_table_id);
+	add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
+}
+
+
 acpi_status
 acpi_os_table_override(struct acpi_table_header * existing_table,
 		       struct acpi_table_header ** new_table)
@@ -669,13 +678,8 @@ acpi_os_table_override(struct acpi_table_header * existing_table,
 	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
 		*new_table = (struct acpi_table_header *)AmlCode;
 #endif
-	if (*new_table != NULL) {
-		printk(KERN_WARNING PREFIX "Override [%4.4s-%8.8s], "
-			   "this is unsafe: tainting kernel\n",
-		       existing_table->signature,
-		       existing_table->oem_table_id);
-		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
-	}
+	if (*new_table != NULL)
+		acpi_table_taint(existing_table);
 	return AE_OK;
 }
 
@@ -736,6 +740,8 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 		break;
 	} while (table_offset + ACPI_HEADER_SIZE < all_tables_size);
 
+	if (*address != 0)
+		acpi_table_taint(existing_table);
 	return AE_OK;
 #endif
 }
-- 
1.7.6.1

