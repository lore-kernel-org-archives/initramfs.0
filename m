From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] replace switch_root shell script with binary
Date: Wed, 04 Mar 2009 13:54:55 +0100
Message-ID: <49AE7A1F.3040508@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050907090207000404030209"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------050907090207000404030209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The switch_root shell script did not work with bash-4.0-2, because
"exec" gets the real path of the executable which is then
"/sysroot/lib/ld-linux.so.2" instread of "./lib/ld-linux.so.2".

Also the required chroot binary might live in /usr/bin, which can
be mounted later.

Here is the switch_root code from nash, which can be stripped down
further, but which works.

--------------050907090207000404030209
Content-Type: text/plain;
 name="0002-replace-switch_root-shell-script-with-binary.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-replace-switch_root-shell-script-with-binary.patch"

From f1b1e4f8694104f007e4483c36b0bf40a5760167 Mon Sep 17 00:00:00 2001
From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Wed, 4 Mar 2009 13:41:07 +0100
Subject: [PATCH] replace switch_root shell script with binary

The switch_root shell script did not work with bash-4.0-2, because
"exec" gets the real path of the executable which is then
"/sysroot/lib/ld-linux.so.2" instead of "./lib/ld-linux.so.2".
Also the required chroot binary might live in /usr/bin, which can
be mounted later.

Here is the switch_root code from nash, which can be stripped down
further, but which works.
---
 Makefile      |   11 +-
 init          |    3 +
 switch_root   |  111 ------------
 switch_root.c |  556 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 566 insertions(+), 115 deletions(-)
 delete mode 100755 switch_root
 create mode 100644 switch_root.c

diff --git a/Makefile b/Makefile
index dbc2a7d..9441bbe 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,9 @@
-all:
-	@echo "Nothing to do"
+switch_root: switch_root.c
+	gcc -o switch_root switch_root.c	
 
-install:
+all: switch_root
+
+install: all
 	mkdir -p $(DESTDIR)/usr/libexec/dracut
 	mkdir -p $(DESTDIR)/sbin
 	mkdir -p $(DESTDIR)/usr/libexec/dracut/hooks
@@ -16,6 +18,7 @@ install:
 	for module in modules/*.sh; do install -m 0755 $$module $(DESTDIR)/usr/libexec/dracut ; done
 clean:
 	rm -f *~
+	rm -f switch_root
 
-archive:
+archive: 
 	git archive --format=tar HEAD --prefix=dracut/ |bzip2 > dracut-$(shell git rev-list  --abbrev-commit  -n 1 HEAD  |cut -b 1-8).tar.bz2
diff --git a/init b/init
index 9605141..a0e83a7 100755
--- a/init
+++ b/init
@@ -103,6 +103,9 @@ INIT=$(getarg init); INIT=${INIT#init=}
 }
 	    
 source_all pre-pivot
+
+kill $(pidof udevd)
+
 echo "Switching to real root filesystem $root"
 exec switch_root "$NEWROOT" "$INIT"  $CMDLINE || {
     # davej doesn't like initrd bugs
diff --git a/switch_root b/switch_root
deleted file mode 100755
index d142e97..0000000
--- a/switch_root
+++ /dev/null
@@ -1,111 +0,0 @@
-#!/bin/sh
-# Copyright (c) Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
-# Licensed under the terms of the GNU GPL v2 or later.
-
-# some utility functions first
-# this is so we can scroll back.
-
-die() { echo "${1}, dying horribly."; while :;do read line; done }
-
-# jsut enough to get the job done
-simple_find() {
-    # $1 = file to look for
-    # $rest = places to look for it
-    local file=$1
-    shift
-    for loc in "$@"; do
-	[ -f "$NEWROOT$loc/$file" ] && { echo "$loc/$file"; return 0; }
-    done
-    return 1
-}
-
-# We really should not be doing this from here, but...
-find_interp() {
-    local ldso=$("$NEWROOT$CHROOT" "$NEWROOT" "$LDD" "$1" |
-	while read interp rest; do
-	    [ -f "${NEWROOT}$interp" ] || continue
-	    echo "$interp"
-	    break
-	done);
-    [ "$ldso" ] && echo $ldso
-}
-
-# this makes it easier to run a command entirely from newroot
-# $1 = elf interpreter (must pass empty string if none)
-# $2 = command or "exec"
-# $3 = command if exec was passed
-run_from_newroot() {
-    local ldso="$1" cmd="$2"; shift; shift
-    if [ "$cmd" = "exec" ]; then
-	cmd="$1"; shift
-	if [ "$ldso" ]; then
-	    exec "$NEWROOT$ldso" --library-path "$LIBPATH" "$NEWROOT$cmd" "$@"
-	else
-	    exec "$NEWROOT$cmd" "$@"
-	fi
-    else
-	if [ "$ldso" ]; then
-	    "$NEWROOT$ldso" --library-path "$LIBPATH" "$NEWROOT$cmd" "$@"
-	else
-	    "$NEWROOT$cmd" "$@"
-	fi
-    fi
-}
-# update the path to find our dynamic libraries on newroot
-update_newroot_libpath() {
-    local x
-    LIBPATH=":"
-    LIBDIRS="$(echo $NEWROOT/lib* $NEWROOT/usr/lib*)"
-    for x in $LIBDIRS; do
-	[ -d "$x" ] && LIBPATH="${LIBPATH}${x}:"
-    done
-    LIBPATH="${LIBPATH%:}"; LIBPATH="${LIBPATH#:}"
-    [ "$LIBPATH" ] || die "Cannot find shared library diectories on $NEWROOT"
-}
-NEWROOT="$1"
-INIT="$2"
-[ -d "$NEWROOT" ] || die "$NEWROOT is not a directory"
-[ -x "$NEWROOT$INIT" ] || die "$NEWROOT/$INIT is not executable."
-shift; shift
-
-update_newroot_libpath
-
-# start looking for required binaries and bits of infrastructure
-BINDIRS="/bin /sbin /usr/bin /usr/sbin"
-RM=$(simple_find rm $BINDIRS) || die "Cannnot find rm on $NEWROOT"
-CHROOT=$(simple_find chroot $BINDIRS) || die "Cannot find chroot on $NEWROOT"
-LDD=$(simple_find ldd $BINDIRS) || die "Cannot find ldd on $NEWROOT"
-MOUNT=$(simple_find mount $BINDIRS) || die "Cannot find mount on $NEWROOT"
-
-# now, start the real process of switching the root
-cd /
-
-# kill udevd, move all our mounts over to the new root
-kill $(pidof udevd)
-mount --move /proc $NEWROOT/proc
-mount --move /sys $NEWROOT/sys
-mount --move /dev $NEWROOT/dev
-
-# Find the binary interpreter for our three required binaries.
-# We do it here so that ldd does not complain about a missing /dev/null.
-CHROOT_LDSO=$(find_interp "$CHROOT")
-RM_LDSO=$(find_interp "$RM")
-MOUNT_LDSO=$(find_interp "$MOUNT")
-
-# redirect to new console. Our old initramfs will not be freed otherwise
-CONSOLE=$NEWROOT/dev/console
-[ -c $CONSOLE ] && exec >$CONSOLE 2>&1 <$CONSOLE
-for x in *; do
-    [ "/$x" = "$NEWROOT" ] || run_from_newroot "$RM_LDSO" "$RM" -rf -- "$x"
-done
-# switch to our new root dir
-cd "$NEWROOT"
-# this moves rootfs to the actual root...
-run_from_newroot "$MOUNT_LDSO" "$MOUNT" -n --move . /
-# but does not update where / is in directory lookups.
-# Therefore, newroot is now ".".  Update things accordingly, then chroot and
-# exec init.
-NEWROOT="."
-update_newroot_libpath
-run_from_newroot "$CHROOT_LDSO" exec "$CHROOT" "$NEWROOT" "$INIT" "$@" || \
-    die "The chroot did not take for some reason"
diff --git a/switch_root.c b/switch_root.c
new file mode 100644
index 0000000..5e2f54f
--- /dev/null
+++ b/switch_root.c
@@ -0,0 +1,556 @@
+/*
+ * switch_root.c
+ *
+ * Code to switch from initramfs to system root.
+ * Based on nash.c from mkinitrd
+ *
+ * Copyright 2002-2009 Red Hat, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author(s): Erik Troan <ewt-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *            Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *            Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *            Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ */
+
+#define _GNU_SOURCE 1
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <dirent.h>
+#include <alloca.h>
+#include <string.h>
+#include <errno.h>
+#include <mntent.h>
+#include <stdlib.h>
+#include <ctype.h>
+#include <sys/mount.h>
+#include <fcntl.h>
+#include <linux/fs.h>
+
+#ifndef MNT_FORCE
+#define MNT_FORCE 0x1
+#endif
+
+#ifndef MNT_DETACH
+#define MNT_DETACH 0x2
+#endif
+
+
+#define asprintfa(str, fmt, ...) ({                 \
+        char *_tmp = NULL;                          \
+        int _rc;                                    \
+        _rc = asprintf((str), (fmt), __VA_ARGS__);  \
+        if (_rc != -1) {                            \
+            _tmp = strdupa(*(str));                 \
+            if (!_tmp) {                            \
+                _rc = -1;                           \
+            } else {                                \
+                free(*(str));                       \
+                *(str) = _tmp;                      \
+            }                                       \
+        }                                           \
+        _rc;                                        \
+    })
+
+
+
+static inline int
+setFdCoe(int fd, int enable)
+{
+    int rc;
+    long flags = 0;
+
+    rc = fcntl(fd, F_GETFD, &flags);
+    if (rc < 0)
+        return rc;
+
+    if (enable)
+        flags |= FD_CLOEXEC;
+    else
+        flags &= ~FD_CLOEXEC;
+
+    rc = fcntl(fd, F_SETFD, flags);
+    return rc;
+}
+
+static char *
+getArg(char * cmd, char * end, char ** arg)
+{
+    char quote = '\0';
+
+    if (!cmd || cmd >= end)
+        return NULL;
+
+    while (isspace(*cmd) && cmd < end)
+        cmd++;
+    if (cmd >= end)
+        return NULL;
+
+    if (*cmd == '"')
+        cmd++, quote = '"';
+    else if (*cmd == '\'')
+        cmd++, quote = '\'';
+
+    if (quote) {
+        *arg = cmd;
+
+        /* This doesn't support \ escapes */
+        while (cmd < end && *cmd != quote)
+            cmd++;
+
+        if (cmd == end) {
+            printf("error: quote mismatch for %s\n", *arg);
+            return NULL;
+        }
+
+        *cmd = '\0';
+        cmd++;
+    } else {
+        *arg = cmd;
+        while (!isspace(*cmd) && cmd < end)
+            cmd++;
+        *cmd = '\0';
+        if (**arg == '$')
+            *arg = getenv(*arg+1);
+        if (*arg == NULL)
+            *arg = "";
+    }
+
+    cmd++;
+
+    while (isspace(*cmd))
+        cmd++;
+
+    return cmd;
+}
+
+static int
+mountCommand(char * cmd, char * end)
+{
+    char * fsType = NULL;
+    char * device, *spec;
+    char * mntPoint;
+    char * opts = NULL;
+    int rc = 0;
+    int flags = MS_MGC_VAL;
+    char * newOpts;
+
+    if (!(cmd = getArg(cmd, end, &spec))) {
+        printf(
+            "usage: mount [--ro] [-o <opts>] -t <type> <device> <mntpoint>\n");
+        return 1;
+    }
+
+    while (cmd && *spec == '-') {
+        if (!strcmp(spec, "--ro")) {
+            flags |= MS_RDONLY;
+        } else if (!strcmp(spec, "--bind")) {
+            flags = MS_BIND;
+            fsType = "none";
+        } else if (!strcmp(spec, "--move")) {
+            flags = MS_MOVE;
+            fsType = "none";
+        } else if (!strcmp(spec, "-o")) {
+            cmd = getArg(cmd, end, &opts);
+            if (!cmd) {
+                printf("mount: -o requires arguments\n");
+                return 1;
+            }
+        } else if (!strcmp(spec, "-t")) {
+            if (!(cmd = getArg(cmd, end, &fsType))) {
+                printf("mount: missing filesystem type\n");
+                return 1;
+            }
+        }
+
+        cmd = getArg(cmd, end, &spec);
+    }
+
+    if (!cmd) {
+        printf("mount: missing device or mountpoint\n");
+        return 1;
+    }
+
+    if (!(cmd = getArg(cmd, end, &mntPoint))) {
+        struct mntent *mnt;
+        FILE *fstab;
+
+        fstab = fopen("/etc/fstab", "r");
+        if (!fstab) {
+            printf("mount: missing mount point\n");
+            return 1;
+        }
+        do {
+            if (!(mnt = getmntent(fstab))) {
+                printf("mount: missing mount point\n");
+                fclose(fstab);
+                return 1;
+            }
+            if (!strcmp(mnt->mnt_dir, spec)) {
+                spec = mnt->mnt_fsname;
+                mntPoint = mnt->mnt_dir;
+
+                if (!strcmp(mnt->mnt_type, "bind")) {
+                    flags |= MS_BIND;
+                    fsType = "none";
+                } else
+                    fsType = mnt->mnt_type;
+
+                opts = mnt->mnt_opts;
+                break;
+            }
+        } while(1);
+
+        fclose(fstab);
+    }
+
+    if (!fsType) {
+        printf("mount: filesystem type expected\n");
+        return 1;
+    }
+
+    if (cmd && cmd < end) {
+        printf("mount: unexpected arguments\n");
+        return 1;
+    }
+
+    /* need to deal with options */
+    if (opts) {
+        char * end;
+        char * start = opts;
+
+        newOpts = alloca(strlen(opts) + 1);
+        *newOpts = '\0';
+
+        while (*start) {
+            end = strchr(start, ',');
+            if (!end) {
+                end = start + strlen(start);
+            } else {
+                *end = '\0';
+                end++;
+            }
+
+            if (!strcmp(start, "ro"))
+                flags |= MS_RDONLY;
+            else if (!strcmp(start, "rw"))
+                flags &= ~MS_RDONLY;
+            else if (!strcmp(start, "nosuid"))
+                flags |= MS_NOSUID;
+            else if (!strcmp(start, "suid"))
+                flags &= ~MS_NOSUID;
+            else if (!strcmp(start, "nodev"))
+                flags |= MS_NODEV;
+            else if (!strcmp(start, "dev"))
+                flags &= ~MS_NODEV;
+            else if (!strcmp(start, "noexec"))
+                flags |= MS_NOEXEC;
+            else if (!strcmp(start, "exec"))
+                flags &= ~MS_NOEXEC;
+            else if (!strcmp(start, "sync"))
+                flags |= MS_SYNCHRONOUS;
+            else if (!strcmp(start, "async"))
+                flags &= ~MS_SYNCHRONOUS;
+            else if (!strcmp(start, "nodiratime"))
+                flags |= MS_NODIRATIME;
+            else if (!strcmp(start, "diratime"))
+                flags &= ~MS_NODIRATIME;
+            else if (!strcmp(start, "noatime"))
+                flags |= MS_NOATIME;
+            else if (!strcmp(start, "atime"))
+                flags &= ~MS_NOATIME;
+            else if (!strcmp(start, "relatime"))
+                flags |= MS_RELATIME;
+            else if (!strcmp(start, "norelatime"))
+                flags &= ~MS_RELATIME;
+            else if (!strcmp(start, "remount"))
+                flags |= MS_REMOUNT;
+            else if (!strcmp(start, "bind"))
+                flags |= MS_BIND;
+            else if (!strcmp(start, "defaults"))
+                ;
+            else {
+                if (*newOpts)
+                    strcat(newOpts, ",");
+                strcat(newOpts, start);
+            }
+
+            start = end;
+        }
+
+        opts = newOpts;
+    }
+
+    device = strdupa(spec);
+
+    if (!device) {
+        printf("mount: could not find filesystem '%s'\n", spec);
+        return 1;
+    }
+
+    {
+        char *mount_opts = NULL;
+	mount_opts = opts;
+        if (mount(device, mntPoint, fsType, flags, mount_opts) < 0) {
+            printf("mount: error mounting %s on %s as %s: %m\n",
+                    device, mntPoint, fsType);
+            rc = 1;
+        }
+    }
+
+    return rc;
+}
+
+/* remove all files/directories below dirName -- don't cross mountpoints */
+static int
+recursiveRemove(char * dirName)
+{
+    struct stat sb,rb;
+    DIR * dir;
+    struct dirent * d;
+    char * strBuf = alloca(strlen(dirName) + 1024);
+
+    if (!(dir = opendir(dirName))) {
+        printf("error opening %s: %m\n", dirName);
+        return 0;
+    }
+
+    if (fstat(dirfd(dir),&rb)) {
+        printf("unable to stat %s: %m\n", dirName);
+        closedir(dir);
+        return 0;
+    }
+
+    errno = 0;
+    while ((d = readdir(dir))) {
+        errno = 0;
+
+        if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, "..")) {
+            errno = 0;
+            continue;
+        }
+
+        strcpy(strBuf, dirName);
+        strcat(strBuf, "/");
+        strcat(strBuf, d->d_name);
+
+        if (lstat(strBuf, &sb)) {
+            printf("failed to stat %s: %m\n", strBuf);
+            errno = 0;
+            continue;
+        }
+
+        /* only descend into subdirectories if device is same as dir */
+        if (S_ISDIR(sb.st_mode)) {
+            if (sb.st_dev == rb.st_dev) {
+	        recursiveRemove(strBuf);
+                if (rmdir(strBuf))
+                    printf("failed to rmdir %s: %m\n", strBuf);
+            }
+            errno = 0;
+            continue;
+        }
+
+        if (unlink(strBuf)) {
+            printf("failed to remove %s: %m\n", strBuf);
+            errno = 0;
+            continue;
+        }
+    }
+
+    if (errno) {
+        closedir(dir);
+        printf("error reading from %s: %m\n", dirName);
+        return 1;
+    }
+
+    closedir(dir);
+
+    return 0;
+}
+
+static void
+mountMntEnt(const struct mntent *mnt)
+{
+    char *start = NULL, *end;
+    char *target = NULL;
+    struct stat sb;
+    
+    printf("mounting %s\n", mnt->mnt_dir);
+    if (asprintfa(&target, ".%s", mnt->mnt_dir) < 0) {
+        printf("setuproot: out of memory while mounting %s\n",
+                mnt->mnt_dir);
+        return;
+    }
+    
+    if (stat(target, &sb) < 0)
+        return;
+    
+    if (asprintf(&start, "-o %s -t %s %s .%s\n",
+            mnt->mnt_opts, mnt->mnt_type, mnt->mnt_fsname,
+            mnt->mnt_dir) < 0) {
+        printf("setuproot: out of memory while mounting %s\n",
+                mnt->mnt_dir);
+        return;
+    }
+    
+    end = start + 1;
+    while (*end && (*end != '\n'))
+        end++;
+    /* end points to the \n at the end of the command */
+    
+    if (mountCommand(start, end) != 0)
+        printf("setuproot: mount returned error\n");
+}
+
+static int
+setuprootCommand(char *new)
+{
+    FILE *fp;
+
+    printf("Setting up new root fs\n");
+
+    if (chdir(new)) {
+        printf("setuproot: chdir(%s) failed: %m\n", new);
+        return 1;
+    }
+
+    if (mount("/dev", "./dev", NULL, MS_BIND, NULL) < 0)
+        printf("setuproot: moving /dev failed: %m\n");
+
+        fp = setmntent("./etc/fstab.sys", "r");
+        if (fp)
+            printf("using fstab.sys from mounted FS\n");
+        else {
+            fp = setmntent("/etc/fstab.sys", "r");
+            if (fp)
+                printf("using fstab.sys from initrd\n");
+        }
+        if (fp) {
+            struct mntent *mnt;
+
+            while((mnt = getmntent(fp)))
+                mountMntEnt(mnt);
+            endmntent(fp);
+        } else {
+            struct {
+                char *source;
+                char *target;
+                char *type;
+                int flags;
+                void *data;
+                int raise;
+            } fstab[] = {
+                { "/proc", "./proc", "proc", 0, NULL },
+                { "/sys", "./sys", "sysfs", 0, NULL },
+#if 0
+                { "/dev/pts", "./dev/pts", "devpts", 0, "gid=5,mode=620" },
+                { "/dev/shm", "./dev/shm", "tmpfs", 0, NULL },
+                { "/selinux", "/selinux", "selinuxfs", 0, NULL },
+#endif
+                { NULL, }
+            };
+            int i = 0;
+
+            printf("no fstab.sys, mounting internal defaults\n");
+            for (; fstab[i].source != NULL; i++) {
+                if (mount(fstab[i].source, fstab[i].target, fstab[i].type,
+                            fstab[i].flags, fstab[i].data) < 0)
+                    printf("setuproot: error mounting %s: %m\n",
+                            fstab[i].source);
+            }
+        }
+
+    chdir("/");
+    return 0;
+}
+
+int main(int argc, char **argv) 
+{
+    /*  Don't try to unmount the old "/", there's no way to do it. */
+    const char *umounts[] = { "/dev", "/proc", "/sys", NULL };
+    char *new = NULL;
+    int fd, i = 0;
+
+    argv++;
+    new = argv[0];
+    argv++;
+    printf("Switching to root: %s", new);
+
+    setuprootCommand(new);
+
+    fd = open("/", O_RDONLY);
+    for (; umounts[i] != NULL; i++) {
+        printf("unmounting old %s\n", umounts[i]);
+        if (umount2(umounts[i], MNT_DETACH) < 0) {
+            printf("ERROR unmounting old %s: %m\n",umounts[i]);
+            printf("forcing unmount of %s\n", umounts[i]);
+            umount2(umounts[i], MNT_FORCE);
+        }
+    }
+    i=0;
+
+    chdir(new);
+
+    recursiveRemove("/");
+
+    if (mount(new, "/", NULL, MS_MOVE, NULL) < 0) {
+        printf("switchroot: mount failed: %m\n");
+        close(fd);
+        return 1;
+    }
+
+    if (chroot(".")) {
+        printf("switchroot: chroot() failed: %m\n");
+        close(fd);
+        return 1;
+    }
+
+    /* release the old "/" */
+    close(fd);
+
+    close(3);
+    if ((fd = open("/dev/console", O_RDWR)) < 0) {
+        printf("ERROR opening /dev/console: %m\n");
+        printf("Trying to use fd 0 instead.\n");
+        fd = dup2(0, 3);
+    } else {
+        setFdCoe(fd, 0);
+        if (fd != 3) {
+            dup2(fd, 3);
+            close(fd);
+            fd = 3;
+        }
+    }
+    close(0);
+    dup2(fd, 0);
+    close(1);
+    dup2(fd, 1);
+    close(2);
+    dup2(fd, 2);
+    close(fd);
+
+    if (access(argv[0], X_OK)) {
+        printf("WARNING: can't access %s\n", argv[0]);
+    }
+
+    execv(argv[0], argv);
+
+    printf("exec of init (%s) failed!!!: %m\n", argv[0]);
+    return 1;
+}
-- 
1.6.0.6


--------------050907090207000404030209--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
