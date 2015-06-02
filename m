From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] Portability fixes
Date: Tue,  2 Jun 2015 11:18:32 +0200
Message-ID: <1433236712-31133-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: xtraeme <xtraeme-Dz/b8W81T9G0sumixwIyNQ@public.gmane.org>

From: xtraeme <xtraeme-Dz/b8W81T9G0sumixwIyNQ@public.gmane.org>

- Use uid_t not __uid_t.
- Define _GNU_SOURCE for cpu_set_t and others.
- Include string.h for strncmp().
- Detect musl's ldd error message.
---
 install/dracut-install.c | 7 ++++++-
 install/util.h           | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/install/dracut-install.c b/install/dracut-install.c
index 201f181..0ff5c49 100644
--- a/install/dracut-install.c
+++ b/install/dracut-install.c
@@ -222,7 +222,7 @@ static int cp(const char *src, const char *dst)
                 if (ret == 0) {
                         struct timeval tv[2];
                         if (fchown(dest_desc, sb.st_uid, sb.st_gid) != 0)
-                                if(fchown(dest_desc, (__uid_t) - 1, sb.st_gid) != 0)
+                                if(fchown(dest_desc, (uid_t) - 1, sb.st_gid) != 0)
                                     log_error("Failed to chown %s: %m", dst);
                         tv[0].tv_sec = sb.st_atime;
                         tv[0].tv_usec = 0;
@@ -388,6 +388,11 @@ static int resolve_deps(const char *src)
                         break;
                 }
 
+		/* musl ldd */
+		if (strstr(buf, "Not a valid dynamic program"))
+			break;
+
+		/* glibc */
                 if (strstr(buf, "not a dynamic executable"))
                         break;
 
diff --git a/install/util.h b/install/util.h
index cc7b988..2ad3254 100644
--- a/install/util.h
+++ b/install/util.h
@@ -20,6 +20,8 @@
   along with systemd; If not, see <http://www.gnu.org/licenses/>.
 ***/
 
+#define _GNU_SOURCE
+
 #include <inttypes.h>
 #include <time.h>
 #include <sys/time.h>
@@ -27,6 +29,7 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
 #include <signal.h>
 #include <sched.h>
 #include <limits.h>
-- 
2.4.1
