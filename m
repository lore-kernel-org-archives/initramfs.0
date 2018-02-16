From: Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 14/14] selinux: delay sid population for rootfs till init is complete
Date: Fri, 16 Feb 2018 20:33:53 +0000
Message-ID: <1518813234-5874-18-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2865; q=dns/txt; s=iport;
  t=1518813251; x=1520022851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=h+x182m25pAUhcejAUrzU53jlgUVrI0n67CYLEcHg4c=;
  b=cOLZsB9Nzw8q1/StuKYf0pbeaeCA2urCwUkBI0bmQwiqz/hi1LCQuP//
   1S8uT9eWWL7JxhxiFsW1vABwSEOU7gefPIGE9KZzNROAxNTHY0pxBlQ16
   jgxD0Ib718nbLqSjENqeNyQ7odDOfXJEl7q7ZMUdCKHpJXGbr8NxwBOGy
   k=;
In-Reply-To: <1518813234-5874-1-git-send-email-takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, James McMechan <james.w.mcmechan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xe-linux-external-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org

From: Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>

With initramfs cpio format that supports extended attributes
we need to skip sid population on sys_lsetxattr call from
initramfs for rootfs if security server is not initialized yet.

Otherwise callback in selinux_inode_post_setxattr will try to
translate give security.selinux label into sid context and since
security server is not available yet inode will receive default
sid (typically kernel_t). Note that in the same time proper
label will be stored in inode xattrs. Later, since inode sid
would be already populated system will never look back at
actual xattrs. But if we skip sid population for rootfs and
we have policy that direct use of xattrs for rootfs, proper
sid will be filled in from extended attributes one node is
accessed and server is initialized.

Note new DELAYAFTERINIT_MNT super block flag is introduced
to only mark rootfs for such behavior. For other types of
tmpfs original logic is still used.

Signed-off-by: Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
---
 security/selinux/hooks.c            | 9 ++++++++-
 security/selinux/include/security.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f3fe65589f02..bb25268f734e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -716,7 +716,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			 */
 			if (!strncmp(sb->s_type->name, "rootfs",
 				     sizeof("rootfs")))
-				sbsec->flags |= SBLABEL_MNT;
+				sbsec->flags |= SBLABEL_MNT|DELAYAFTERINIT_MNT;
 
 			/* Defer initialization until selinux_complete_init,
 			   after the initial policy is loaded and the security
@@ -3253,6 +3253,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct inode_security_struct *isec;
+	struct superblock_security_struct *sbsec;
 	u32 newsid;
 	int rc;
 
@@ -3261,6 +3262,12 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 		return;
 	}
 
+	if (!ss_initialized) {
+		sbsec = inode->i_sb->s_security;
+		if (sbsec->flags & DELAYAFTERINIT_MNT)
+			return;
+	}
+
 	rc = security_context_to_sid_force(value, size, &newsid);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to map context to SID"
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 02f0412d42f2..585acfd6cbcf 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -52,6 +52,7 @@
 #define ROOTCONTEXT_MNT	0x04
 #define DEFCONTEXT_MNT	0x08
 #define SBLABEL_MNT	0x10
+#define DELAYAFTERINIT_MNT 0x20
 /* Non-mount related flags */
 #define SE_SBINITIALIZED	0x0100
 #define SE_SBPROC		0x0200
-- 
2.10.3.dirty
