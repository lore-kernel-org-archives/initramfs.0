From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [RFC][PATCH 1/9] initramfs: separate reading cpio method from header
Date: Wed,  7 Jan 2015 15:52:52 -0500
Message-ID: <1420663980-20842-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1420663980-20842-1-git-send-email-zohar@linux.vnet.ibm.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420663980-20842-1-git-send-email-zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-ima-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

In preparation for adding xattr support, read the CPIO method separately
from the rest of the header.

Signed-off-by: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 init/initramfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index bece48c..527703e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -187,6 +187,7 @@ static void __init parse_header(char *s)
 
 static __initdata enum state {
 	Start,
+	GotFormat,
 	Collect,
 	GotHeader,
 	SkipIt,
@@ -230,7 +231,7 @@ static __initdata char *header_buf, *symlink_buf, *name_buf;
 
 static int __init do_start(void)
 {
-	read_into(header_buf, 110, GotHeader);
+	read_into(header_buf, 6, GotFormat);
 	return 0;
 }
 
@@ -248,7 +249,7 @@ static int __init do_collect(void)
 	return 0;
 }
 
-static int __init do_header(void)
+static int __init do_format(void)
 {
 	if (memcmp(collected, "070707", 6)==0) {
 		error("incorrect cpio method used: use -H newc option");
@@ -258,6 +259,12 @@ static int __init do_header(void)
 		error("no cpio magic");
 		return 1;
 	}
+	read_into(header_buf, 104, GotHeader);
+	return 0;
+}
+
+static int __init do_header(void)
+{
 	parse_header(collected);
 	next_header = this_header + N_ALIGN(name_len) + body_len;
 	next_header = (next_header + 3) & ~3;
@@ -400,6 +407,7 @@ static int __init do_symlink(void)
 
 static __initdata int (*actions[])(void) = {
 	[Start]		= do_start,
+	[GotFormat]	= do_format,
 	[Collect]	= do_collect,
 	[GotHeader]	= do_header,
 	[SkipIt]	= do_skip,
-- 
1.8.1.4
