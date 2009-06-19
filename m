From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 10/13] updated switch_root.c
Date: Fri, 19 Jun 2009 13:05:48 +0200
Message-ID: <1245409551-30493-11-git-send-email-harald@redhat.com>
References: <1245409551-30493-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245409551-30493-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

matches the version, which will go to util-linux-ng
---
 Makefile      |    2 +-
 switch_root.c |  232 ++++++++++++++++++++++++++++-----------------------------
 2 files changed, 115 insertions(+), 119 deletions(-)

diff --git a/Makefile b/Makefile
index 3ec288a..f693ace 100644
--- a/Makefile
+++ b/Makefile
@@ -9,7 +9,7 @@ sbindir = ${prefix}/sbin
 mandir = ${prefix}/share/man
 
 modules.d/99base/switch_root: switch_root.c
-	gcc -o modules.d/99base/switch_root switch_root.c	
+	gcc -D _GNU_SOURCE -D 'PACKAGE_STRING="dracut"' -std=gnu99 -fsigned-char -g -O2 -o modules.d/99base/switch_root switch_root.c	
 
 all: modules.d/99base/switch_root
 
diff --git a/switch_root.c b/switch_root.c
index ef7a0fb..8daacb1 100644
--- a/switch_root.c
+++ b/switch_root.c
@@ -1,7 +1,7 @@
 /*
  * switchroot.c - switch to new root directory and start init.
  *
- * Copyright 2002-2008 Red Hat, Inc.  All rights reserved.
+ * Copyright 2002-2009 Red Hat, Inc.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -17,12 +17,9 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
  * Authors:
- * 	Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *	Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
  *	Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
  */
-
-#define _GNU_SOURCE 1
-
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -35,164 +32,163 @@
 #include <errno.h>
 #include <ctype.h>
 #include <dirent.h>
+#include <err.h>
 
 #ifndef MS_MOVE
 #define MS_MOVE 8192
 #endif
 
-#ifndef MNT_DETACH
-#define MNT_DETACH 0x2
-#endif
+/* remove all files/directories below dirName -- don't cross mountpoints */
+static int recursiveRemove(char *dirName)
+{
+	struct stat rb;
+	DIR *dir;
+	int rc = -1;
+	int dfd;
+
+	if (!(dir = opendir(dirName))) {
+		warn("failed to open %s", dirName);
+		goto done;
+	}
 
-enum {
-	ok,
-	err_no_directory,
-	err_usage,
-};
+	dfd = dirfd(dir);
 
-/* remove all files/directories below dirName -- don't cross mountpoints */
-static int
-recursiveRemove(char * dirName)
- {
-    struct stat sb,rb;
-    DIR * dir;
-    struct dirent * d;
-    char * strBuf = alloca(strlen(dirName) + 1024);
-
-    if (!(dir = opendir(dirName))) {
-        printf("error opening %s: %m\n", dirName);
-        return 0;
-    }
-
-    if (fstat(dirfd(dir),&rb)) {
-        printf("unable to stat %s: %m\n", dirName);
-        closedir(dir);
-        return 0;
-    }
-
-    errno = 0;
-    while ((d = readdir(dir))) {
-        errno = 0;
-
-        if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, "..")) {
-            errno = 0;
-            continue;
-        }
-
-        strcpy(strBuf, dirName);
-        strcat(strBuf, "/");
-        strcat(strBuf, d->d_name);
-
-        if (lstat(strBuf, &sb)) {
-            printf("failed to stat %s: %m\n", strBuf);
-            errno = 0;
-            continue;
-        }
-
-        /* only descend into subdirectories if device is same as dir */
-        if (S_ISDIR(sb.st_mode)) {
-            if (sb.st_dev == rb.st_dev) {
-	        recursiveRemove(strBuf);
-                if (rmdir(strBuf))
-                    printf("failed to rmdir %s: %m\n", strBuf);
-            }
-            errno = 0;
-            continue;
-        }
-        if (unlink(strBuf)) {
-            printf("failed to remove %s: %m\n", strBuf);
-            errno = 0;
-            continue;
-        }
-    }
-
-    if (errno) {
-        closedir(dir);
-        printf("error reading from %s: %m\n", dirName);
-        return 1;
-    }
-
-    closedir(dir);
-
-    return 0;
- }
+	if (fstat(dfd, &rb)) {
+		warn("failed to stat %s", dirName);
+		goto done;
+	}
+
+	while(1) {
+		struct dirent *d;
+
+		errno = 0;
+		if (!(d = readdir(dir))) {
+			if (errno) {
+				warn("failed to read %s", dirName);
+				goto done;
+			}
+			break;	/* end of directory */
+		}
+
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+
+		if (d->d_type == DT_DIR) {
+			struct stat sb;
+
+			if (fstatat(dfd, d->d_name, &sb, AT_SYMLINK_NOFOLLOW)) {
+				warn("failed to stat %s/%s", dirName, d->d_name);
+				continue;
+			}
+
+			/* remove subdirectories if device is same as dir */
+			if (sb.st_dev == rb.st_dev) {
+				char subdir[ strlen(dirName) +
+					     strlen(d->d_name) + 2 ];
+
+				sprintf(subdir, "%s/%s", dirName, d->d_name);
+				recursiveRemove(subdir);
+			} else
+				continue;
+		}
+
+		if (unlinkat(dfd, d->d_name,
+			     d->d_type == DT_DIR ? AT_REMOVEDIR : 0))
+			warn("failed to unlink %s/%s", dirName, d->d_name);
+	}
+
+	rc = 0;	/* success */
+
+done:
+	if (dir)
+		closedir(dir);
+	return rc;
+}
 
 static int switchroot(const char *newroot)
 {
 	/*  Don't try to unmount the old "/", there's no way to do it. */
 	const char *umounts[] = { "/dev", "/proc", "/sys", NULL };
-	int errnum;
 	int i;
 
 	for (i = 0; umounts[i] != NULL; i++) {
 		char newmount[PATH_MAX];
-		strcpy(newmount, newroot);
-		strcat(newmount, umounts[i]);
+
+		snprintf(newmount, sizeof(newmount), "%s%s", newroot, umounts[i]);
+
 		if (mount(umounts[i], newmount, NULL, MS_MOVE, NULL) < 0) {
-			fprintf(stderr, "Error mount moving old %s %s %m\n",
+			warn("failed to mount moving %s to %s",
 				umounts[i], newmount);
-			fprintf(stderr, "Forcing unmount of %s\n", umounts[i]);
+			warnx("forcing unmount of %s", umounts[i]);
 			umount2(umounts[i], MNT_FORCE);
 		}
 	}
 
-	if (chdir(newroot) < 0) {
-	  errnum=errno;
-	  fprintf(stderr, "switchroot: chdir failed: %m\n");
-	  errno=errnum;
-	  return -1;
+	if (chdir(newroot)) {
+		warn("failed to change directory to %s", newroot);
+		return -1;
 	}
+
 	recursiveRemove("/");
+
 	if (mount(newroot, "/", NULL, MS_MOVE, NULL) < 0) {
-		errnum = errno;
-		fprintf(stderr, "switchroot: mount failed: %m\n");
-		errno = errnum;
+		warn("failed to mount moving %s to /", newroot);
 		return -1;
 	}
 
 	if (chroot(".")) {
-		errnum = errno;
-		fprintf(stderr, "switchroot: chroot failed: %m\n");
-		errno = errnum;
-		return -2;
+		warn("failed to change root");
+		return -1;
 	}
-	return 1;
+	return 0;
 }
 
 static void usage(FILE *output)
 {
-	fprintf(output, "usage: switchroot <newrootdir> <init> <args to init>\n");
-	if (output == stderr)
-		exit(err_usage);
-	exit(ok);
+	fprintf(output, "usage: %s <newrootdir> <init> <args to init>\n",
+			program_invocation_short_name);
+	exit(output == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+static void version(void)
+{
+	fprintf(stdout,  "%s from %s\n", program_invocation_short_name,
+			PACKAGE_STRING);
+	exit(EXIT_SUCCESS);
 }
 
 int main(int argc, char *argv[])
 {
-	char *newroot = argv[1];
-	char *init = argv[2];
-	char **initargs = &argv[2];
+	char *newroot, *init, **initargs;
 
-	if (newroot == NULL || newroot[0] == '\0' ||
-	    init == NULL || init[0] == '\0' ) {
+	if (argv[1] && (!strcmp(argv[1], "--help") || !strcmp(argv[1], "-h")))
+		usage(stdout);
+	if (argv[1] && (!strcmp(argv[1], "--version") || !strcmp(argv[1], "-V")))
+		version();
+	if (argc < 3)
 		usage(stderr);
-	}
 
-	if (switchroot(newroot) < 0) {
-	  fprintf(stderr, "switchroot has failed.  Sorry.\n");
-	  return 1;
-	}
-	if (access(initargs[0], X_OK))
-	  fprintf(stderr, "WARNING: can't access %s\n", initargs[0]);
+	newroot = argv[1];
+	init = argv[2];
+	initargs = &argv[2];
+
+	if (!*newroot || !*init)
+		usage(stderr);
+
+	if (switchroot(newroot))
+		errx(EXIT_FAILURE, "failed. Sorry.");
+
+	if (access(init, X_OK))
+		warn("cannot access %s", init);
 
 	/* get session leader */
 	setsid();
+
 	/* set controlling terminal */
-	ioctl (0, TIOCSCTTY, 1);
+	if (ioctl (0, TIOCSCTTY, 1))
+		warn("failed to TIOCSCTTY");
 
-	execv(initargs[0], initargs);
+	execv(init, initargs);
+	err(EXIT_FAILURE, "failed to execute %s", init);
 }
 
-/*
- * vim:noet:ts=8:sw=8:sts=8
- */
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
