From: Taras Kondratiuk <takondra@cisco.com>
Subject: [PATCH v3 14/15] selinux: allow setxattr on rootfs so initramfs code can set them
Date: Fri, 16 Feb 2018 20:33:52 +0000
Message-ID: <1518813234-5874-17-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1404; q=dns/txt; s=iport;
  t=1518813249; x=1520022849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GVG8yZSIqBpAYoYeLbJ4sv4eV9fL21UfOz/cszDkk3s=;
  b=iGG+2L+e0Zb04v5nVWdGBjxAAMc/qwq/7Rdwldv5H43WS8Q7MEmmdznQ
   MECm7Jy8iLikh+JJp2Qgm/mRFfr42SGN1j9ZZYlPXmS0aTKco7GeWKtKs
   R1SBsMamqKd3VSyFE9PdkeR0dUByf4uUCbSw/JwOZycFOYcvO55lMBNWr
   s=;
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
Sender: linux-doc-owner@vger.kernel.org
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

