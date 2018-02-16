From: Taras Kondratiuk <takondra@cisco.com>
Subject: [PATCH v3 03/15] initramfs: store file name in name_buf
Date: Fri, 16 Feb 2018 20:33:39 +0000
Message-ID: <1518813234-5874-4-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1686; q=dns/txt; s=iport;
  t=1518813239; x=1520022839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7ti1CmKalB2rOy6NHEJ+DZLJMKGu7wCBQHH/kiDtVEo=;
  b=kmG/0WdO4oZV60wz9NqXUEO2MfEC3TfHa1RjegV/Ek8OE+JfOVx1XnWU
   uXwEilHbrdhvMWadTcT02qesuLYZc6gpcWZnX4VHG9XuWImdXH5QSUCXl
   k07K/1VwFno75wuJ3Pm9MP6n7C7oXICM46RCAfgboHDKANXcQgvhMMMcC
   U=;
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
Sender: owner-linux-security-module@vger.kernel.org
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

