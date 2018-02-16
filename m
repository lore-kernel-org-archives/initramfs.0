From: Taras Kondratiuk <takondra@cisco.com>
Subject: [PATCH v3 04/15] initramfs: remove unnecessary symlinks processing shortcut
Date: Fri, 16 Feb 2018 20:33:40 +0000
Message-ID: <1518813234-5874-5-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2499; q=dns/txt; s=iport;
  t=1518813240; x=1520022840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=nvpl0b5eWYplhP1sX/h4M5FhyqcWUI82Pb+U0GTb0WU=;
  b=BchP61rTYB6VhmWCnCTwakG/h5Xx6+BtifmPo5d9xn4tzgrSGh+l1ebl
   wEC2Xd/dVPZIJaD9UqeuMdswzTQlTKIhmHol+T4sXZQP7/yqnsej7jClz
   eDTtzaoJTFxt3Q+tPlwL8MflfcQNSSIRKlxTe6ROmtCmfTC+V+kLllg+c
   0=;
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, xe-linux-external@cisco.com

Special handling of symlinks in do_header() assumes that name and body
entries are sequential and reads them together. This shortcut has no
real performance benefits, but it complicates changes to the state
machine.

Make handling of symlinks more similar to a regular files. Store name
in name_buf and destination in symlink_buf.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index b6ee675e5cdb..d0ab7ad6ac05 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -266,16 +266,7 @@ static int __init do_header(void)
 	state = do_skip;
 	if (name_len <= 0 || name_len > PATH_MAX)
 		return 0;
-	if (S_ISLNK(mode)) {
-		if (body_len > PATH_MAX)
-			return 0;
-		collect = collected = symlink_buf;
-		remains = N_ALIGN(name_len) + body_len;
-		next_state = do_symlink;
-		state = do_collect;
-		return 0;
-	}
-	if (S_ISREG(mode) || !body_len)
+	if (S_ISREG(mode) || S_ISLNK(mode) || !body_len)
 		read_into(name_buf, N_ALIGN(name_len), do_name);
 	return 0;
 }
@@ -372,6 +363,11 @@ static int __init do_name(void)
 			sys_chmod(collected, mode);
 			do_utime(collected, mtime);
 		}
+	} else if (S_ISLNK(mode)) {
+		if (body_len > PATH_MAX)
+			return 0;
+		memcpy_optional(name_buf, collected, N_ALIGN(name_len));
+		read_into(symlink_buf, body_len, do_symlink);
 	}
 	return 0;
 }
@@ -397,11 +393,12 @@ static int __init do_copy(void)
 
 static int __init do_symlink(void)
 {
-	collected[N_ALIGN(name_len) + body_len] = '\0';
-	clean_path(collected, 0);
-	sys_symlink(collected + N_ALIGN(name_len), collected);
-	sys_lchown(collected, uid, gid);
-	do_utime(collected, mtime);
+	memcpy_optional(symlink_buf, collected, body_len);
+	symlink_buf[body_len] = '\0';
+	clean_path(name_buf, 0);
+	sys_symlink(symlink_buf, name_buf);
+	sys_lchown(name_buf, uid, gid);
+	do_utime(name_buf, mtime);
 	state = do_skip;
 	next_state = do_reset;
 	return 0;
@@ -453,7 +450,7 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	static __initdata char msg_buf[64];
 
 	header_buf = kmalloc(110, GFP_KERNEL);
-	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
+	symlink_buf = kmalloc(PATH_MAX + 1, GFP_KERNEL);
 	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
 
 	if (!header_buf || !symlink_buf || !name_buf)
-- 
2.10.3.dirty

