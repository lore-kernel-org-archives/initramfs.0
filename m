From: Kamil Rytarowski <n54-KK0ffGbhmjU@public.gmane.org>
Subject: [PATCH] Introduce stricter type-correctness
Date: Sat, 11 May 2013 17:14:32 +0200
Message-ID: <518E6058.8070300@gmx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040804070501090504090406"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------040804070501090504090406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm attaching a patch introducing stricter type-correctness.
Most of the changes are fixing issues with operating over signed with 
unsigned types. One of the changes aims to fix an insecure passing of a 
character* buffer through a parameter.

Regards,

--------------040804070501090504090406
Content-Type: text/x-patch;
 name="0001-Introduce-stricter-type-correctness.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Introduce-stricter-type-correctness.patch"

From 66ba27f0dc3cdb3edf4fe4e04d2e23c348294bc5 Mon Sep 17 00:00:00 2001
From: Kamil Rytarowski <n54-KK0ffGbhmjU@public.gmane.org>
Date: Sat, 11 May 2013 17:06:45 +0200
Subject: [PATCH] Introduce stricter type correctness

---
 install/dracut-install.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/install/dracut-install.c b/install/dracut-install.c
index 3b86256..84703ad 100644
--- a/install/dracut-install.c
+++ b/install/dracut-install.c
@@ -80,9 +80,9 @@ static char *convert_abs_rel(const char *from, const char *target)
         _cleanup_free_ char *realtarget = NULL;
         _cleanup_free_ char *target_dir_p = NULL, *realpath_p = NULL;
         const char *realfrom = from;
-        int level = 0, fromlevel = 0, targetlevel = 0;
-        int l, i, rl;
-        int dirlen;
+        size_t level = 0, fromlevel = 0, targetlevel = 0;
+        int l;
+        size_t i, rl, dirlen;
         int ret;
 
         target_dir_p = strdup(target);
@@ -220,7 +220,7 @@ static int cp(const char *src, const char *dst)
                 if (ret == 0) {
                         struct timeval tv[2];
                         if (fchown(dest_desc, sb.st_uid, sb.st_gid) != 0)
-                                fchown(dest_desc, -1, sb.st_gid);
+                                fchown(dest_desc, (__uid_t)-1, sb.st_gid);
                         tv[0].tv_sec = sb.st_atime;
                         tv[0].tv_usec = 0;
                         tv[1].tv_sec = sb.st_mtime;
@@ -305,7 +305,7 @@ static int resolve_deps(const char *src)
                 log_debug("ldd: '%s'", buf);
 
                 if (strstr(buf, "you do not have execution permission")) {
-                        log_error(buf);
+                        log_error("%s", buf);
                         ret+=1;
                         break;
                 }
@@ -705,7 +705,7 @@ static int parse_argv(int argc, char *argv[])
 static int resolve_lazy(int argc, char **argv)
 {
         int i;
-        int destrootdirlen = strlen(destrootdir);
+        size_t destrootdirlen = strlen(destrootdir);
         int ret = 0;
         char *item;
         for (i = 0; i < argc; i++) {
-- 
1.8.1.5


--------------040804070501090504090406--
