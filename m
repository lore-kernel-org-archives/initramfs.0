From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] ACPI: Only allow users with CAP_SYS_RAWIO rights to overwrite ACPI funcs at runtime
Date: Tue, 25 Sep 2012 17:25:11 +0200
Message-ID: <201209251725.13085.trenn@suse.de>
References: <1348234085-39220-1-git-send-email-trenn@suse.de> <201209240840.29342.trenn@suse.de> <20120924102159.346d0735@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120924102159.346d0735@pyramind.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Len Brown <lenb@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, hpa@zytor.com, initramfs@vger.kernel.org, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, yinghai@kernel.org, eric.piel@tremplin-utc.net, vojcek@tlen.pl

ACPI: Only allow users with CAP_SYS_RAWIO rights to overwrite ACPI funcs at runtime

and tab align file_operations callbacks.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/custom_method.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 5d42c24..9a0294d 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -72,9 +72,15 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	return count;
 }
 
+static int open_check_acc(struct inode *inode, struct file *filp)
+{
+	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
+}
+
 static const struct file_operations cm_fops = {
-	.write = cm_write,
-	.llseek = default_llseek,
+	.write	= cm_write,
+	.llseek	= default_llseek,
+	.open	= open_check_acc,
 };
 
 static int __init acpi_custom_method_init(void)
