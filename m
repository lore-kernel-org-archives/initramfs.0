From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v1 05/11] gen_init_cpio: replace inline format string with common variable
Date: Tue, 20 Jan 2015 14:12:54 -0500
Message-ID: <1421781180-24425-6-git-send-email-zohar@linux.vnet.ibm.com>
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

The same printf format string is used in a number of places.  This
patch replaces the inline format string with a single common variable
called newcfmt.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 usr/gen_init_cpio.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 225ad24..ee35361 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -20,6 +20,9 @@
 #define xstr(s) #s
 #define str(s) xstr(s)
 
+static char *newcfmt = "%s%08X%08X%08lX%08lX%08X%08lX"
+			"%08X%08X%08X%08X%08X%08X%08X";
+
 static unsigned int offset;
 static unsigned int ino = 721;
 static time_t default_mtime;
@@ -74,8 +77,7 @@ static void cpio_trailer(void)
 	char s[256];
 	const char name[] = "TRAILER!!!";
 
-	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
+	sprintf(s, newcfmt,
 		"070701",		/* magic */
 		0,			/* ino */
 		0,			/* mode */
@@ -106,8 +108,7 @@ static int cpio_mkslink(const char *name, const char *target,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
+	sprintf(s, newcfmt,
 		"070701",		/* magic */
 		ino++,			/* ino */
 		S_IFLNK | mode,		/* mode */
@@ -155,8 +156,7 @@ static int cpio_mkgeneric(const char *name, unsigned int mode,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
+	sprintf(s, newcfmt,
 		"070701",		/* magic */
 		ino++,			/* ino */
 		mode,			/* mode */
@@ -249,8 +249,7 @@ static int cpio_mknod(const char *name, unsigned int mode,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
+	sprintf(s, newcfmt,
 		"070701",		/* magic */
 		ino++,			/* ino */
 		mode,			/* mode */
@@ -339,8 +338,7 @@ static int cpio_mkfile(const char *name, const char *location,
 		if (name[0] == '/')
 			name++;
 		namesize = strlen(name) + 1;
-		sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-		       "%08lX%08X%08X%08X%08X%08X%08X",
+		sprintf(s, newcfmt,
 			"070701",		/* magic */
 			ino,			/* ino */
 			mode,			/* mode */
-- 
1.8.1.4
