From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v1 11/11] ima: include rootfs (tmpfs) in ima_appraise_tcb policy
Date: Tue, 20 Jan 2015 14:13:00 -0500
Message-ID: <1421781180-24425-12-git-send-email-zohar@linux.vnet.ibm.com>
References: <1421781180-24425-1-git-send-email-zohar@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421781180-24425-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>, linux-ima-devel@lists.sourceforge.net, linux-security-module <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

When rootfs supports extended attributes and CONFIG_IMA_APPRAISE_ROOTFS
is enabled, appraise the xattrs.

Changelog v1:
- limit appraising tmpfs to rootfs
- define new IMA_APPRAISE_ROOTFS Kconfig option (based on Josh Boyer's
comment).

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig      | 12 ++++++++++++
 security/integrity/ima/ima_policy.c |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 57515bc..fe2fd5f 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -156,3 +156,15 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_APPRAISE_ROOTFS
+	bool "Require labeled rootfs"
+	depends on IMA_LOAD_X509
+	default n
+	help
+	   This option is dependent on the initramfs including
+	   extended attributes(xattrs) in the CPIO file and the
+	   rootfs file system for supporting them.
+
+	   The new CPIO format (070703) includes xattrs in the
+	   initramfs.  Use tmpfs as the rootfs.
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d1eefb9..7748332 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -27,6 +27,7 @@
 #define IMA_UID		0x0008
 #define IMA_FOWNER	0x0010
 #define IMA_FSUUID	0x0020
+#define IMA_SBID	0x0040
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -49,6 +50,7 @@ struct ima_rule_entry {
 	enum ima_hooks func;
 	int mask;
 	unsigned long fsmagic;
+	char sbid[32];
 	u8 fsuuid[16];
 	kuid_t uid;
 	kuid_t fowner;
@@ -93,6 +95,10 @@ static struct ima_rule_entry default_appraise_rules[] = {
 	{.action = DONT_APPRAISE, .fsmagic = PROC_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = SYSFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = DEBUGFS_MAGIC, .flags = IMA_FSMAGIC},
+#ifdef CONFIG_IMA_APPRAISE_ROOTFS
+	{.action = APPRAISE, .fsmagic = TMPFS_MAGIC, .sbid="rootfs", 
+	 .flags = IMA_FSMAGIC | IMA_SBID},
+#endif
 	{.action = DONT_APPRAISE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = RAMFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = DEVPTS_SUPER_MAGIC, .flags = IMA_FSMAGIC},
@@ -188,6 +194,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	if ((rule->flags & IMA_FSUUID) &&
 	    memcmp(rule->fsuuid, inode->i_sb->s_uuid, sizeof(rule->fsuuid)))
 		return false;
+	if ((rule->flags & IMA_SBID) && strcmp(rule->sbid, inode->i_sb->s_id))
+		return false;
 	if ((rule->flags & IMA_UID) && !uid_eq(rule->uid, cred->uid))
 		return false;
 	if ((rule->flags & IMA_FOWNER) && !uid_eq(rule->fowner, inode->i_uid))
-- 
1.8.1.4
