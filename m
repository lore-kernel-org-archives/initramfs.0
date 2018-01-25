From: Taras Kondratiuk <takondra@cisco.com>
Subject: [PATCH v2 06/15] initramfs: separate reading cpio method from header
Date: Thu, 25 Jan 2018 03:27:46 +0000
Message-ID: <1516850875-25066-7-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2224; q=dns/txt; s=iport;
  t=1516851451; x=1518061051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=a+seLTc7b5r96aHoOplgXaf9fRRhQmOfR4/lqCZPL2Q=;
  b=Dmo5Y3D2Fh9HiPyPDt9xM68Yc1urp096T9wM896RUr6ghl5LYT1fMTA7
   PJWZZukZHjaBErB5uAxi/yhrnVtTw2UkqpjfXts1IMOBuLZz7eXH9k9oM
   1aVBxyh1siOu6NnOWeyVuD1r61YD05foXA9Rb0aqosoTwVibadHith1Nc
   Q=;
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, xe-linux-external@cisco.com

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

In preparation for adding xattr support, read the CPIO method
separately from the rest of the header.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 2d5920c094e0..b3d39c8793be 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -168,7 +168,7 @@ static void __init parse_header(char *s)
 	int i;
 
 	buf[8] = '\0';
-	for (i = 0, s += 6; i < 12; i++, s += 8) {
+	for (i = 0; i < 12; i++, s += 8) {
 		memcpy(buf, s, 8);
 		parsed[i] = simple_strtoul(buf, NULL, 16);
 	}
@@ -189,6 +189,7 @@ static void __init parse_header(char *s)
 
 static int __init do_start(void);
 static int __init do_collect(void);
+static int __init do_format(void);
 static int __init do_header(void);
 static int __init do_skip(void);
 static int __init do_name(void);
@@ -233,7 +234,7 @@ static __initdata char *header_buf, *symlink_buf, *name_buf;
 
 static int __init do_start(void)
 {
-	read_into(header_buf, 110, do_header);
+	read_into(header_buf, 6, do_format);
 	return 0;
 }
 
@@ -251,7 +252,7 @@ static int __init do_collect(void)
 	return 0;
 }
 
-static int __init do_header(void)
+static int __init do_format(void)
 {
 	if (memcmp(collected, "070707", 6)==0) {
 		error("incorrect cpio method used: use -H newc option");
@@ -261,6 +262,12 @@ static int __init do_header(void)
 		error("no cpio magic");
 		return 1;
 	}
+	read_into(header_buf, 104, do_header);
+	return 0;
+}
+
+static int __init do_header(void)
+{
 	parse_header(collected);
 	next_header = this_header + N_ALIGN(name_len) + body_len;
 	next_header = (next_header + 3) & ~3;
@@ -457,7 +464,7 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	const char *compress_name;
 	static __initdata char msg_buf[64];
 
-	header_buf = kmalloc(110, GFP_KERNEL);
+	header_buf = kmalloc(104, GFP_KERNEL);
 	symlink_buf = kmalloc(PATH_MAX + 1, GFP_KERNEL);
 	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
 
-- 
2.10.3.dirty

