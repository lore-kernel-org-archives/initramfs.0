From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 8/9] add img-lib: a library for handling filesystem images
Date: Tue, 14 Feb 2012 12:38:09 -0500
Message-ID: <1329241090-26908-9-git-send-email-wwoods@redhat.com>
References: <1329241090-26908-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329241090-26908-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

img-lib handles identifying and unpacking archives (uncompressed or
compressed) and filesystem images.

Currently tar and gzip are required; cpio and xz are optional, and bzip2
is supported but unused.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99img-lib/img-lib.sh      |   72 +++++++++++++++++++++++++++++++++++
 modules.d/99img-lib/module-setup.sh |   23 +++++++++++
 2 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/99img-lib/img-lib.sh
 create mode 100755 modules.d/99img-lib/module-setup.sh

diff --git a/modules.d/99img-lib/img-lib.sh b/modules.d/99img-lib/img-lib.sh
new file mode 100755
index 0000000..582b416
--- /dev/null
+++ b/modules.d/99img-lib/img-lib.sh
@@ -0,0 +1,72 @@
+#!/bin/bash
+# img-lib.sh: utilities for dealing with archives and filesystem images.
+#
+# TODO: identify/unpack rpm, deb?
+
+
+# super-simple "file" that only identifies archives.
+# works with stdin if $1 is not set.
+det_archive() {
+    local bz="BZh" xz="$(echo -e '\xfd7zXZ')" gz="$(echo -e '\x1f\x8b')"
+    local headerblock="$(dd ${1:+if=$1} bs=262 count=1 2>/dev/null)"
+    case "$headerblock" in
+        $xz*) echo "xz" ;;
+        $gz*) echo "gzip" ;;
+        $bz*) echo "bzip2" ;;
+        07070*) echo "cpio" ;;
+        *ustar) echo "tar" ;;
+    esac
+}
+
+# determine filesystem type for a filesystem image
+det_fs_img() {
+    local dev=$(losetup --find --show "$1") rv=""
+    det_fs $dev; rv=$?
+    losetup -d $dev
+    return $rv
+}
+
+# unpack_archive ARCHIVE OUTDIR
+# unpack a (possibly compressed) cpio/tar archive
+unpack_archive() {
+    local img="$1" outdir="$2" archiver="" decompr=""
+    local ft="$(det_archive $img)"
+    case "$ft" in
+        xz|gzip|bzip2) decompr="$decompr -dc" ;;
+        cpio|tar) decompr="cat";;
+        *) return 1 ;;
+    esac
+    ft="$($decompr $img | det_archive)"
+    case "$ft" in
+        cpio) archiver="cpio -iumd" ;;
+        tar) archiver="tar -xf -" ;;
+        *) return 2 ;;
+    esac
+    mkdir -p $outdir
+    ( cd $outdir; $decompr | $archiver 2>/dev/null ) < $img
+}
+
+# unpack_fs FSIMAGE OUTDIR
+# unpack a filesystem image
+unpack_fs() {
+    local img="$1" outdir="$2" mnt="$(mkuniqdir /tmp unpack_fs.)"
+    mount -o loop $img $mnt || { rmdir $mnt; return 1; }
+    mkdir -p $outdir; outdir="$(cd $outdir; pwd)"
+    ( cd $mnt; cp -a -t $outdir . )
+    umount $mnt
+    rmdir $mnt
+}
+
+# unpack an image file - compressed/uncompressed cpio/tar, filesystem, whatever
+# unpack_img IMAGEFILE OUTDIR
+unpack_img() {
+    local img="$1" outdir="$2"
+    [ -r "$img" ] || { warn "can't read img!"; return 1; }
+    [ -n "$outdir" ] || { warn "unpack_img: no output dir given"; return 1; }
+
+    if [ "$(det_img $img)" ]; then
+        unpack_archive "$@" || { warn "can't unpack archive file!"; return 1; }
+    else
+        unpack_fs "$@" || { warn "can't unpack filesystem image!"; return 1; }
+    fi
+}
diff --git a/modules.d/99img-lib/module-setup.sh b/modules.d/99img-lib/module-setup.sh
new file mode 100755
index 0000000..eead2ab
--- /dev/null
+++ b/modules.d/99img-lib/module-setup.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+# module-setup for img-lib
+
+check() {
+    for cmd in tar gzip dd; do
+        command -v $cmd >/dev/null || return 1
+    done
+    return 255
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    # NOTE/TODO: we require bash, but I don't know how to specify that..
+    dracut_install tar gzip dd
+    dracut_install -o cpio xz
+    # TODO: make this conditional on a cmdline flag / config option
+    # dracut_install -o bzip2
+    inst "$moddir/img-lib.sh" "/lib/img-lib.sh"
+}
+
-- 
1.7.7.6
