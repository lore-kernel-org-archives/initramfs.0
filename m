From: Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 02/15] initramfs: replace states with function pointers
Date: Thu, 25 Jan 2018 03:27:42 +0000
Message-ID: <1516850875-25066-3-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5648; q=dns/txt; s=iport;
  t=1516851450; x=1518061050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kPtfKRZKS/cOHG4AIpt4bEc+kdJD6gX/yiPBjFXhWw4=;
  b=Mio1CcepFKBICFnIaM0a0JIUZi1tG9KGnvU71v8x4X1YkAzTwE/vee0Z
   qZvvxhsZGAjYzOgAS2jOdhKEkL45LLzDWGkbX585OqJF+fYgVTYrGad57
   JabVNOJJvYZycRYhMce15y4hHbuW2v4wqqfuTlCsS7F06N6yflVD08/gH
   Y=;
In-Reply-To: <1516850875-25066-1-git-send-email-takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, James McMechan <james.w.mcmechan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Victor Kamensky <kamensky-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xe-linux-external-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org

Currently the FSM states are mapped directly to function pointers. Extra
level of intirection is not needed and makes navigation over the code
harder. One can't jump between states directly when browsing code (e.g.
with cscope). Need to go through actions[] array each time.

Replace states with their action function pointers. No behaviour change.

Signed-off-by: Taras Kondratiuk <takondra-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
---
 init/initramfs.c | 73 +++++++++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7e99a0038942..49cd2681a26f 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -187,16 +187,17 @@ static void __init parse_header(char *s)
 
 /* FSM */
 
-static __initdata enum state {
-	Start,
-	Collect,
-	GotHeader,
-	SkipIt,
-	GotName,
-	CopyFile,
-	GotSymlink,
-	Reset
-} state, next_state;
+static int __init do_start(void);
+static int __init do_collect(void);
+static int __init do_header(void);
+static int __init do_skip(void);
+static int __init do_name(void);
+static int __init do_copy(void);
+static int __init do_symlink(void);
+static int __init do_reset(void);
+
+typedef int (*fsm_state_t)(void);
+static __initdata fsm_state_t state, next_state;
 
 static __initdata char *victim;
 static unsigned long byte_count __initdata;
@@ -214,7 +215,7 @@ static __initdata char *collected;
 static long remains __initdata;
 static __initdata char *collect;
 
-static void __init read_into(char *buf, unsigned size, enum state next)
+static void __init read_into(char *buf, unsigned size, fsm_state_t next)
 {
 	if (byte_count >= size) {
 		collected = victim;
@@ -224,7 +225,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 		collect = collected = buf;
 		remains = size;
 		next_state = next;
-		state = Collect;
+		state = do_collect;
 	}
 }
 
@@ -232,7 +233,7 @@ static __initdata char *header_buf, *symlink_buf, *name_buf;
 
 static int __init do_start(void)
 {
-	read_into(header_buf, 110, GotHeader);
+	read_into(header_buf, 110, do_header);
 	return 0;
 }
 
@@ -263,7 +264,7 @@ static int __init do_header(void)
 	parse_header(collected);
 	next_header = this_header + N_ALIGN(name_len) + body_len;
 	next_header = (next_header + 3) & ~3;
-	state = SkipIt;
+	state = do_skip;
 	if (name_len <= 0 || name_len > PATH_MAX)
 		return 0;
 	if (S_ISLNK(mode)) {
@@ -271,12 +272,12 @@ static int __init do_header(void)
 			return 0;
 		collect = collected = symlink_buf;
 		remains = N_ALIGN(name_len) + body_len;
-		next_state = GotSymlink;
-		state = Collect;
+		next_state = do_symlink;
+		state = do_collect;
 		return 0;
 	}
 	if (S_ISREG(mode) || !body_len)
-		read_into(name_buf, N_ALIGN(name_len), GotName);
+		read_into(name_buf, N_ALIGN(name_len), do_name);
 	return 0;
 }
 
@@ -327,8 +328,8 @@ static __initdata int wfd;
 
 static int __init do_name(void)
 {
-	state = SkipIt;
-	next_state = Reset;
+	state = do_skip;
+	next_state = do_reset;
 	if (strcmp(collected, "TRAILER!!!") == 0) {
 		free_hash();
 		return 0;
@@ -348,7 +349,7 @@ static int __init do_name(void)
 				if (body_len)
 					sys_ftruncate(wfd, body_len);
 				vcollected = kstrdup(collected, GFP_KERNEL);
-				state = CopyFile;
+				state = do_copy;
 			}
 		}
 	} else if (S_ISDIR(mode)) {
@@ -377,7 +378,7 @@ static int __init do_copy(void)
 		do_utime(vcollected, mtime);
 		kfree(vcollected);
 		eat(body_len);
-		state = SkipIt;
+		state = do_skip;
 		return 0;
 	} else {
 		if (xwrite(wfd, victim, byte_count) != byte_count)
@@ -395,29 +396,19 @@ static int __init do_symlink(void)
 	sys_symlink(collected + N_ALIGN(name_len), collected);
 	sys_lchown(collected, uid, gid);
 	do_utime(collected, mtime);
-	state = SkipIt;
-	next_state = Reset;
+	state = do_skip;
+	next_state = do_reset;
 	return 0;
 }
 
-static __initdata int (*actions[])(void) = {
-	[Start]		= do_start,
-	[Collect]	= do_collect,
-	[GotHeader]	= do_header,
-	[SkipIt]	= do_skip,
-	[GotName]	= do_name,
-	[CopyFile]	= do_copy,
-	[GotSymlink]	= do_symlink,
-	[Reset]		= do_reset,
-};
-
 static long __init write_buffer(char *buf, unsigned long len)
 {
 	byte_count = len;
 	victim = buf;
 
-	while (!actions[state]())
-		;
+	do
+		pr_debug("state: %pf\n", state);
+	while (!state());
 	return len - byte_count;
 }
 
@@ -433,11 +424,11 @@ static long __init flush_buffer(void *bufv, unsigned long len)
 		if (c == '0') {
 			buf += written;
 			len -= written;
-			state = Start;
+			state = do_start;
 		} else if (c == 0) {
 			buf += written;
 			len -= written;
-			state = Reset;
+			state = do_reset;
 		} else
 			error("junk in compressed archive");
 	}
@@ -462,13 +453,13 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	if (!header_buf || !symlink_buf || !name_buf)
 		panic("can't allocate buffers");
 
-	state = Start;
+	state = do_start;
 	this_header = 0;
 	message = NULL;
 	while (!message && len) {
 		loff_t saved_offset = this_header;
 		if (*buf == '0' && !(this_header & 3)) {
-			state = Start;
+			state = do_start;
 			written = write_buffer(buf, len);
 			buf += written;
 			len -= written;
@@ -497,7 +488,7 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 			}
 		} else
 			error("junk in compressed archive");
-		if (state != Reset)
+		if (state != do_reset)
 			error("junk in compressed archive");
 		this_header = saved_offset + my_inptr;
 		buf += my_inptr;
-- 
2.10.3.dirty
