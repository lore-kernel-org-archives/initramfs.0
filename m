From: Kamil Rytarowski <n54-KK0ffGbhmjU@public.gmane.org>
Subject: Patches against the dracut git version
Date: Sat, 11 May 2013 15:09:33 +0200
Message-ID: <518E430D.4020600@gmx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090404050108070601080002"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------090404050108070601080002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm attaching the following patches against the current development 
version of dracut:
0001-Fix-parsing-command-line-arguments.patch
0002-Use-consistiently-termination-code-macros.patch
0003-Always-check-the-return-number-of-asprintf.patch
0004-Fix-memory-leak.patch

Please double check and apply them.

Regards,

--------------090404050108070601080002
Content-Type: text/x-patch;
 name="0001-Fix-parsing-command-line-arguments.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-parsing-command-line-arguments.patch"

From f9a63777f744e14dc9244ada09190e84a741bfb4 Mon Sep 17 00:00:00 2001
From: Kamil Rytarowski <n54-KK0ffGbhmjU@public.gmane.org>
Date: Sat, 11 May 2013 11:39:46 +0200
Subject: [PATCH 1/4] Fix parsing command line arguments

Adjust correctly the *optstring argument of getopt_long. Add support
for a missing option -v|--verbose and drop unknown options -D, -I and -L.
---
 install/dracut-install.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/install/dracut-install.c b/install/dracut-install.c
index b4bf681..be8472f 100644
--- a/install/dracut-install.c
+++ b/install/dracut-install.c
@@ -619,8 +619,7 @@ static int parse_argv(int argc, char *argv[])
                 {NULL, 0, NULL, 0}
         };
 
-        while ((c = getopt_long(argc, argv, "adhloD:DHILR", options, NULL)) != -1) {
+        while ((c = getopt_long(argc, argv, "adhlovD:HR", options, NULL)) != -1) {
                 switch (c) {
                 case ARG_VERSION:
                         puts(PROGRAM_VERSION_STRING);
-- 
1.8.1.5


--------------090404050108070601080002
Content-Type: text/x-patch;
 name="0002-Use-consistiently-termination-code-macros.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-Use-consistiently-termination-code-macros.patch"

From a874eacf340e62e5a5d2ed3fe9f2ec2cae256f87 Mon Sep 17 00:00:00 2001
From: Kamil Rytarowski <n54-KK0ffGbhmjU@public.gmane.org>
Date: Sat, 11 May 2013 13:49:00 +0200
Subject: [PATCH 2/4] Use consistiently termination code macros

Operate in install_all and install_one consequently on EXIT_SUCCESS
and EXIT_FAILURE termination code macros as they are meant to be
returned from these functions.
---
 install/dracut-install.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/install/dracut-install.c b/install/dracut-install.c
index be8472f..3c841b6 100644
--- a/install/dracut-install.c
+++ b/install/dracut-install.c
@@ -757,7 +757,7 @@ static char *find_binary(const char *src)
 
 static int install_one(const char *src, const char *dst)
 {
-        int r = 0;
+        int r = EXIT_SUCCESS;
         int ret;
 
         if (strchr(src, '/') == NULL) {
@@ -786,7 +786,7 @@ static int install_one(const char *src, const char *dst)
 
 static int install_all(int argc, char **argv)
 {
-        int r = 0;
+        int r = EXIT_SUCCESS;
         int i;
         for (i = 0; i < argc; i++) {
                 int ret;
-- 
1.8.1.5


--------------090404050108070601080002
Content-Type: text/x-patch;
 name="0003-Always-check-the-return-number-of-asprintf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-Always-check-the-return-number-of-asprintf.patch"

From 7bc69fb081e129f2583b1ac8b45f290f6caa99c5 Mon Sep 17 00:00:00 2001
From: Kamil Rytarowski <n54-KK0ffGbhmjU@public.gmane.org>
Date: Sat, 11 May 2013 14:40:19 +0200
Subject: [PATCH 3/4] Always check the return number of asprintf

asprintf prints to an allocated string. When  successful,  the
functions return the number of bytes printed. If memory allocation
wasn't possible, or some other error occurs, the function will return
-1.

Don't check strp as a result of asprintf, it's content may be undefined.

man 3 asprintf
---
 install/dracut-install.c | 59 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/install/dracut-install.c b/install/dracut-install.c
index 3c841b6..0f04023 100644
--- a/install/dracut-install.c
+++ b/install/dracut-install.c
@@ -83,6 +83,7 @@ static char *convert_abs_rel(const char *from, const char *target)
         int level = 0, fromlevel = 0, targetlevel = 0;
         int l, i, rl;
         int dirlen;
+        int ret;
 
         target_dir_p = strdup(target);
         if (!target_dir_p)
@@ -103,7 +104,11 @@ static char *convert_abs_rel(const char *from, const char *target)
         for (i = dirlen+1; i < rl; ++i)
             if (target_dir_p[i] != '/')
                 break;
-        asprintf(&realtarget, "%s/%s", realpath_p, &target_dir_p[i]);
+        ret = asprintf(&realtarget, "%s/%s", realpath_p, &target_dir_p[i]);
+        if (ret < 0) {
+                log_error("Out of memory!");
+                exit(EXIT_FAILURE);
+        }
 
         /* now calculate the relative path from <from> to <target> and
            store it in <relative_from>
@@ -282,8 +287,11 @@ static int resolve_deps(const char *src)
 
         /* run ldd */
         ret = asprintf(&cmd, "ldd %s 2>&1", src);
-        if (ret < 0)
-                return ret;
+        if (ret < 0) {
+                log_error("Out of memory!");
+                exit(EXIT_FAILURE);
+        }
+
         ret = 0;
 
         fptr = popen(cmd, "r");
@@ -352,6 +360,7 @@ static int hmac_install(const char *src, const char *dst, const char *hmacpath)
         _cleanup_free_ char *dstpath = strdup(dst);
         _cleanup_free_ char *srchmacname = NULL;
         _cleanup_free_ char *dsthmacname = NULL;
+        int ret;
 
         if (!(srcpath && dstpath))
                 return -ENOMEM;
@@ -371,11 +380,29 @@ static int hmac_install(const char *src, const char *dst, const char *hmacpath)
         srcpath[dlen] = '\0';
         dstpath[dir_len(dst)] = '\0';
         if (hmacpath) {
-                asprintf(&srchmacname, "%s/%s.hmac", hmacpath, &src[dlen + 1]);
-                asprintf(&dsthmacname, "%s/%s.hmac", hmacpath, &src[dlen + 1]);
+                ret = asprintf(&srchmacname, "%s/%s.hmac", hmacpath, &src[dlen + 1]);
+                if (ret < 0) {
+                        log_error("Out of memory!");
+                        exit(EXIT_FAILURE);
+                }
+
+                ret = asprintf(&dsthmacname, "%s/%s.hmac", hmacpath, &src[dlen + 1]);
+                if (ret < 0) {
+                        log_error("Out of memory!");
+                        exit(EXIT_FAILURE);
+                }
         } else {
-                asprintf(&srchmacname, "%s/.%s.hmac", srcpath, &src[dlen + 1]);
-                asprintf(&dsthmacname, "%s/.%s.hmac", dstpath, &src[dlen + 1]);
+                ret = asprintf(&srchmacname, "%s/.%s.hmac", srcpath, &src[dlen + 1]);
+                if (ret < 0) {
+                        log_error("Out of memory!");
+                        exit(EXIT_FAILURE);
+                }
+
+                ret = asprintf(&dsthmacname, "%s/.%s.hmac", dstpath, &src[dlen + 1]);
+                if (ret < 0) {
+                        log_error("Out of memory!");
+                        exit(EXIT_FAILURE);
+                }
         }
         log_debug("hmac cp '%s' '%s')", srchmacname, dsthmacname);
         dracut_install(srchmacname, dsthmacname, false, false, true);
@@ -428,7 +455,11 @@ static int dracut_install(const char *src, const char *dst, bool isdir, bool res
 
         hashmap_put(items, i, i);
 
-        asprintf(&fulldstpath, "%s%s", destrootdir, dst);
+        ret = asprintf(&fulldstpath, "%s%s", destrootdir, dst);
+        if (ret < 0) {
+                log_error("Out of memory!");
+                exit(EXIT_FAILURE);
+        }
 
         ret = stat(fulldstpath, &sb);
 
@@ -511,7 +542,11 @@ static int dracut_install(const char *src, const char *dst, bool isdir, bool res
                 if (lstat(fulldstpath, &sb) != 0) {
                         _cleanup_free_ char *absdestpath = NULL;
 
-                        asprintf(&absdestpath, "%s%s", destrootdir, abspath);
+                        ret = asprintf(&absdestpath, "%s%s", destrootdir, abspath);
+                        if (ret < 0) {
+                                log_error("Out of memory!");
+                                exit(EXIT_FAILURE);
+                        }
 
                         ln_r(absdestpath, fulldstpath);
                 }
@@ -704,6 +739,8 @@ static char *find_binary(const char *src)
         char *p, *q;
         bool end = false;
         char *newsrc = NULL;
+        int ret;
+
         path = getenv("PATH");
 
         if (path == NULL) {
@@ -730,8 +767,8 @@ static char *find_binary(const char *src)
                 else
                         *q = '\0';
 
-                asprintf(&newsrc, "%s/%s", p, src);
-                if (newsrc == NULL) {
+                ret = asprintf(&newsrc, "%s/%s", p, src);
+                if (ret < 0) {
                         log_error("Out of memory!");
                         exit(EXIT_FAILURE);
                 }
-- 
1.8.1.5


--------------090404050108070601080002
Content-Type: text/x-patch;
 name="0004-Fix-memory-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0004-Fix-memory-leak.patch"

From e1b55aad7d4de95b7ff502e878bb225bfebb800a Mon Sep 17 00:00:00 2001
From: Kamil Rytarowski <n54-KK0ffGbhmjU@public.gmane.org>
Date: Sat, 11 May 2013 14:54:38 +0200
Subject: [PATCH 4/4] Fix memory leak

---
 install/dracut-install.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/install/dracut-install.c b/install/dracut-install.c
index 0f04023..3b86256 100644
--- a/install/dracut-install.c
+++ b/install/dracut-install.c
@@ -258,7 +258,7 @@ static int resolve_deps(const char *src)
 {
         int ret = 0;
 
-        char *buf = malloc(LINE_MAX);
+        _cleanup_free_ char *buf = malloc(LINE_MAX);
         size_t linesize = LINE_MAX;
         _cleanup_pclose_ FILE *fptr = NULL;
         _cleanup_free_ char *cmd = NULL;
-- 
1.8.1.5


--------------090404050108070601080002--
