From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] switch_root: add subroot support
Date: Sun, 12 Jul 2009 12:02:43 +0100 (BST)
Message-ID: <20090712110243.F3E7E9D405C@zog.reactivated.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The current switch_root can only switch to a new root that is the root
of a mount point.

This patch adds support for "subroots", where the new root is somewhere
below a mount point. It does this by adding in a few extra steps to
chroot into the subroot after the enclosing partition has been moved
and entered.

This will be used by OLPC, who sort-of have 2 copies of Fedora stored
on a single partition under different directory trees, where the
initramfs decides which one to boot into.
---
 switch_root.c |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/switch_root.c b/switch_root.c
index 8daacb1..8ce4aaf 100644
--- a/switch_root.c
+++ b/switch_root.c
@@ -33,11 +33,63 @@
 #include <ctype.h>
 #include <dirent.h>
 #include <err.h>
+#include <libgen.h>
 
 #ifndef MS_MOVE
 #define MS_MOVE 8192
 #endif
 
+/* find the enclosing mount point of a path, by examining the backing device
+ * of parent directories until we reach / or find a parent with a differing
+ * device.
+ * result must be freed.
+ */
+static char *get_parent_mount(const char *path)
+{
+	struct stat sb;
+	char dir[PATH_MAX];
+	char tmp[PATH_MAX];
+	dev_t inner_dev;
+	int r;
+
+	r = stat(path, &sb);
+	if (r != 0) {
+		warn("failed to stat %s", path);
+		return NULL;
+	}
+	inner_dev = sb.st_dev;
+
+	/* dirname has some annoying properties of modifying the input... */
+	strncpy(dir, path, PATH_MAX);
+	dir[PATH_MAX - 1] = 0; /* for safety */
+
+	while (1) {
+		char *parent;
+
+		strncpy(tmp, dir, PATH_MAX);
+		tmp[PATH_MAX - 1] = 0;
+		parent = dirname(tmp);
+
+		r = stat(parent, &sb);
+		if (r != 0) {
+			warn("failed to stat %s", parent);
+			return NULL;
+		}
+
+		/* if the parent directory's device differs then we have found a mount
+		 * point */
+		if (sb.st_dev != inner_dev)
+			return strdup(dir);
+
+		strncpy(dir, parent, PATH_MAX);
+		dir[PATH_MAX - 1] = 0;
+
+		/* maybe we've reached / */
+		if (strlen(dir) == 1)
+			return strdup(dir);
+	}
+}
+
 /* remove all files/directories below dirName -- don't cross mountpoints */
 static int recursiveRemove(char *dirName)
 {
@@ -109,7 +161,10 @@ static int switchroot(const char *newroot)
 {
 	/*  Don't try to unmount the old "/", there's no way to do it. */
 	const char *umounts[] = { "/dev", "/proc", "/sys", NULL };
+	char *newroot_mnt;
+	const char *chroot_path = NULL;
 	int i;
+	int r = -1;
 
 	for (i = 0; umounts[i] != NULL; i++) {
 		char newmount[PATH_MAX];
@@ -131,16 +186,46 @@ static int switchroot(const char *newroot)
 
 	recursiveRemove("/");
 
+	newroot_mnt = get_parent_mount(newroot);
+	if (newroot_mnt && strcmp(newroot, newroot_mnt)) {
+		/* newroot is not a mount point, so we have to MS_MOVE the parent
+		 * mount point and then chroot in to the "subroot" */
+		chroot_path = newroot + strlen(newroot_mnt);
+		newroot = newroot_mnt;
+
+		if (chdir(newroot)) {
+			warn("failed to chdir to newroot mount %s", newroot);
+			goto err;
+		}
+	}
+
 	if (mount(newroot, "/", NULL, MS_MOVE, NULL) < 0) {
 		warn("failed to mount moving %s to /", newroot);
-		return -1;
+		goto err;
 	}
 
 	if (chroot(".")) {
 		warn("failed to change root");
-		return -1;
+		goto err;
 	}
-	return 0;
+
+	if (chroot_path) {
+		if (chdir(chroot_path)) {
+			warn("failed to chdir to subroot %s", chroot_path);
+			goto err;
+		}
+
+		if (chroot(".")) {
+			warn("failed to change root to subroot");
+			goto err;
+		}
+	}
+
+	r = 0;
+err:
+	if (newroot_mnt)
+		free(newroot_mnt);
+	return r;
 }
 
 static void usage(FILE *output)
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
