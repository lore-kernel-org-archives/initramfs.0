From: Taras Kondratiuk <takondra@cisco.com>
Subject: [PATCH v2 14/15] selinux: allow setxattr on rootfs so initramfs code can set them
Date: Thu, 25 Jan 2018 03:27:54 +0000
Message-ID: <1516850875-25066-15-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1404; q=dns/txt; s=iport;
  t=1516851451; x=1518061051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GVG8yZSIqBpAYoYeLbJ4sv4eV9fL21UfOz/cszDkk3s=;
  b=Go/LZac3ldSxvJghPk7P5ae/hOR+V0KOx1J5IdLhT6GzgIH5YOk63ca0
   WuErMK5FU91UWW3xCzIcMSGHfOXhP3Pi81CFjgKW7vBHJEuOQQ+/PAPw6
   oq+vCau449kqWhgmZ7ACs+S43Sb/69ym050OWNUCZjVUP6DKcbKabA9be
   8=;
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, xe-linux-external@cisco.com

From: Victor Kamensky <kamensky@cisco.com>

initramfs code supporting extended cpio format have ability to
fill extended attributes from cpio archive, but if SELinux enabled
and security server is not initialized yet, selinux callback would
refuse setxattr made by initramfs code.

Solution enable SBLABEL_MNT on rootfs even if secrurity server is
not initialized yet.

Signed-off-by: Victor Kamensky <kamensky@cisco.com>
---
 security/selinux/hooks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8644d864e3c1..f3fe65589f02 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -706,6 +706,18 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 
 	if (!ss_initialized) {
 		if (!num_opts) {
+			/*
+			 * Special handling for rootfs. Is genfs but supports
+			 * setting SELinux context on in-core inodes.
+			 *
+			 * Chicken and egg problem: policy may reside in rootfs
+			 * but for initramfs code to fill in attributes, it
+			 * needs selinux to allow that.
+			 */
+			if (!strncmp(sb->s_type->name, "rootfs",
+				     sizeof("rootfs")))
+				sbsec->flags |= SBLABEL_MNT;
+
 			/* Defer initialization until selinux_complete_init,
 			   after the initial policy is loaded and the security
 			   server is ready to handle calls. */
-- 
2.10.3.dirty

