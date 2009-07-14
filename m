From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] switch_root: add subroot support
Date: Tue, 14 Jul 2009 15:06:29 +0200
Message-ID: <20090714130629.GA2768@nb.net.home>
References: <20090712110243.F3E7E9D405C@zog.reactivated.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090712110243.F3E7E9D405C-k/4jFdqg8LLlyo9zxV8I99HuzzzSOjJt@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Sun, Jul 12, 2009 at 12:02:43PM +0100, Daniel Drake wrote:
> The current switch_root can only switch to a new root that is the root
> of a mount point.
> 
> This patch adds support for "subroots", where the new root is somewhere
> below a mount point. It does this by adding in a few extra steps to
> chroot into the subroot after the enclosing partition has been moved
> and entered.
> 
> This will be used by OLPC, who sort-of have 2 copies of Fedora stored
> on a single partition under different directory trees, where the
> initramfs decides which one to boot into.

 Sounds crazy :-) 
 
 Applied with some minor changes. Please, review the patch below or
  
   git://git.kernel.org/pub/scm/utils/util-linux-ng/util-linux-ng.git

 Thanks.

    Karel


From a692a8745941a192528c5e2a05de97155ba586f9 Mon Sep 17 00:00:00 2001
From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Date: Tue, 14 Jul 2009 14:41:33 +0200
Subject: [PATCH] switch_root: add subroot support

The current switch_root can only switch to a new root that is the root
of a mount point.

This patch adds support for "subroots", where the new root is
somewhere below a mount point. It does this by adding in a few extra
steps to chroot into the subroot after the enclosing partition has
been moved and entered.

This will be used by OLPC, who sort-of have 2 copies of Fedora stored
on a single partition under different directory trees, where the
initramfs decides which one to boot into

[kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org:
    - port to the current u-l-ng switch_root code
    - don't use static buffer for "dir" in get_parent_mount()]

CC: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Signed-off-by: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 sys-utils/switch_root.c |   81 ++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
index b947f54..b192a08 100644
--- a/sys-utils/switch_root.c
+++ b/sys-utils/switch_root.c
@@ -33,6 +33,7 @@
 #include <ctype.h>
 #include <dirent.h>
 #include <err.h>
+#include <libgen.h>
 
 #ifndef MS_MOVE
 #define MS_MOVE 8192
@@ -108,13 +109,58 @@ done:
 	return rc;
 }
 
+/* find the enclosing mount point of a path, by examining the backing device
+ * of parent directories until we reach / or find a parent with a differing
+ * device. Result must be freed.
+ */
+static char *get_parent_mount(const char *path)
+{
+	struct stat sb;
+	char *dir;
+	char tmp[PATH_MAX];
+	dev_t inner_dev;
+
+	if (stat(path, &sb) != 0) {
+		warn("failed to stat %s", path);
+		return NULL;
+	}
+
+	inner_dev = sb.st_dev;
+	dir = strdup(path);
+
+	while (dir) {
+		char *parent;
+
+		strncpy(tmp, dir, PATH_MAX);
+		tmp[PATH_MAX - 1] = '\0';
+		parent = dirname(tmp);
+
+		if (stat(parent, &sb) != 0) {
+			warn("failed to stat %s", parent);
+			return NULL;
+		}
+		if (sb.st_dev != inner_dev)
+			return dir;
+
+		strncpy(dir, parent, PATH_MAX);
+		dir[PATH_MAX - 1] = '\0';
+
+		/* maybe we've reached / */
+		if (*dir == '/' && !*(dir + 1))
+			return dir;
+	}
+	return NULL;
+}
+
 static int switchroot(const char *newroot)
 {
 	/*  Don't try to unmount the old "/", there's no way to do it. */
 	const char *umounts[] = { "/dev", "/proc", "/sys", NULL };
 	int i;
-	int cfd;
+	int cfd, rc = -1;
 	pid_t pid;
+	const char *chroot_path = NULL;
+	char *newroot_mnt;
 
 	for (i = 0; umounts[i] != NULL; i++) {
 		char newmount[PATH_MAX];
@@ -129,21 +175,43 @@ static int switchroot(const char *newroot)
 		}
 	}
 
+	newroot_mnt = get_parent_mount(newroot);
+	if (newroot_mnt && strcmp(newroot, newroot_mnt)) {
+		/* newroot is not a mount point, so we have to MS_MOVE the
+		 * parent mount point and then chroot in to the "subroot"
+		 */
+		chroot_path = newroot + strlen(newroot_mnt);
+		newroot = newroot_mnt;
+	}
+
 	if (chdir(newroot)) {
 		warn("failed to change directory to %s", newroot);
-		return -1;
+		goto done;
 	}
 
 	cfd = open("/", O_RDONLY);
 
 	if (mount(newroot, "/", NULL, MS_MOVE, NULL) < 0) {
 		warn("failed to mount moving %s to /", newroot);
-		return -1;
+		goto done;
 	}
 
+	/* move to the real root of the device */
 	if (chroot(".")) {
 		warn("failed to change root");
-		return -1;
+		goto done;
+	}
+
+	/* move to the subdirectory on the root device (subroot) */
+	if (chroot_path) {
+		if (chdir(chroot_path)) {
+			warn("failed to chdir to subroot %s", chroot_path);
+			goto done;
+		}
+		if (chroot(".")) {
+			warn("failed to change root to subroot %s", chroot_path);
+			goto done;
+		}
 	}
 
 	if (cfd >= 0) {
@@ -155,7 +223,10 @@ static int switchroot(const char *newroot)
 		}
 		close(cfd);
 	}
-	return 0;
+	rc = 0;
+done:
+	free(newroot_mnt);
+	return rc;
 }
 
 static void usage(FILE *output)
-- 
1.6.2.2
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
