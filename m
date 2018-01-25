From: Taras Kondratiuk <takondra@cisco.com>
Subject: [PATCH v2 03/15] initramfs: store file name in name_buf
Date: Thu, 25 Jan 2018 03:27:43 +0000
Message-ID: <1516850875-25066-4-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1686; q=dns/txt; s=iport;
  t=1516851450; x=1518061050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7ti1CmKalB2rOy6NHEJ+DZLJMKGu7wCBQHH/kiDtVEo=;
  b=RW6UqDFNg6js/uUWmxlUgtO4eWJT0r+HgENdSQaOGoHQ3GZLunOxdR24
   axqVWD0LWWFuCfb6jrG2tQEaQXn2teEZN6yXU8QCJanTSX/qljsH/QUeH
   Fp+3yxF4MrZTUKrDz6wc/KTipADmAB/5xaBxLnDlYeMQqhyqOqvqsXF8w
   o=;
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, xe-linux-external@cisco.com

There is already name_buf buffer pre-allocated for a file name. No need
to allocate vcollected for every file. More over a name can be already
stored in name_buf by read_info() function.

Add memcpy_optional() function to handle such case.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 49cd2681a26f..b6ee675e5cdb 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -210,7 +210,6 @@ static inline void __init eat(unsigned n)
 	byte_count -= n;
 }
 
-static __initdata char *vcollected;
 static __initdata char *collected;
 static long remains __initdata;
 static __initdata char *collect;
@@ -324,6 +323,13 @@ static void __init clean_path(char *path, umode_t fmode)
 	}
 }
 
+static void *memcpy_optional(void *dest, const void *src, size_t n)
+{
+	if (dest != src)
+		return memcpy(dest, src, n);
+	return dest;
+}
+
 static __initdata int wfd;
 
 static int __init do_name(void)
@@ -348,7 +354,8 @@ static int __init do_name(void)
 				sys_fchmod(wfd, mode);
 				if (body_len)
 					sys_ftruncate(wfd, body_len);
-				vcollected = kstrdup(collected, GFP_KERNEL);
+				memcpy_optional(name_buf, collected,
+						N_ALIGN(name_len));
 				state = do_copy;
 			}
 		}
@@ -375,8 +382,7 @@ static int __init do_copy(void)
 		if (xwrite(wfd, victim, body_len) != body_len)
 			error("write error");
 		sys_close(wfd);
-		do_utime(vcollected, mtime);
-		kfree(vcollected);
+		do_utime(name_buf, mtime);
 		eat(body_len);
 		state = do_skip;
 		return 0;
-- 
2.10.3.dirty

