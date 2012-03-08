From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] img-lib: fix unpack_img()
Date: Thu,  8 Mar 2012 18:02:29 -0500
Message-ID: <1331247749-11928-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

- det_img should have been det_archive
- for ft=xz|gzip|bzip2, decompr should be "$ft -dc"
---
 modules.d/99img-lib/img-lib.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/modules.d/99img-lib/img-lib.sh b/modules.d/99img-lib/img-lib.sh
index f6be26d..22507aa 100755
--- a/modules.d/99img-lib/img-lib.sh
+++ b/modules.d/99img-lib/img-lib.sh
@@ -1,12 +1,13 @@
 #!/bin/sh
 # img-lib.sh: utilities for dealing with archives and filesystem images.
 #
-# TODO: identify/unpack rpm, deb?
+# TODO: identify/unpack rpm, deb, maybe others?
 
 
 # super-simple "file" that only identifies archives.
 # works with stdin if $1 is not set.
 det_archive() {
+    # NOTE: echo -e works in ash and bash, but not dash
     local bz="BZh" xz="$(echo -e '\xfd7zXZ')" gz="$(echo -e '\x1f\x8b')"
     local headerblock="$(dd ${1:+if=$1} bs=262 count=1 2>/dev/null)"
     case "$headerblock" in
@@ -32,7 +33,7 @@ unpack_archive() {
     local img="$1" outdir="$2" archiver="" decompr=""
     local ft="$(det_archive $img)"
     case "$ft" in
-        xz|gzip|bzip2) decompr="$decompr -dc" ;;
+        xz|gzip|bzip2) decompr="$ft -dc" ;;
         cpio|tar) decompr="cat";;
         *) return 1 ;;
     esac
@@ -64,7 +65,7 @@ unpack_img() {
     [ -r "$img" ] || { warn "can't read img!"; return 1; }
     [ -n "$outdir" ] || { warn "unpack_img: no output dir given"; return 1; }
 
-    if [ "$(det_img $img)" ]; then
+    if [ "$(det_archive $img)" ]; then
         unpack_archive "$@" || { warn "can't unpack archive file!"; return 1; }
     else
         unpack_fs "$@" || { warn "can't unpack filesystem image!"; return 1; }
-- 
1.7.7.6
