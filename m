From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/7] inst_dir: fix handling of relative symlinks outside the current dir
Date: Tue,  8 Mar 2011 18:35:12 -0500
Message-ID: <1299627317-11145-3-git-send-email-wwoods@redhat.com>
References: <1299627317-11145-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1299627317-11145-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

inst_dir used the following to try to resolve a relative path:
  [[ $target = ${target##*/} ]] && target="${file%/*}/$target"
  inst_dir $target

This will only match if $target has no slashes, so something like
/usr/bin -> ../sbin would result in: inst_dir ../sbin, or
/usr/share -> local/share would result in: inst_dir local/share
which is not going to do the right thing.

Instead, we resolve any non-absolute link, like so:
  [[ $target == ${target#/} ]] && target=$(dirname "$file")/$target
Thus /usr/bin -> ../sbin results in: inst_dir /usr/../sbin, and
/usr/share -> local/share results in: inst_dir /usr/local/share
which is what you would expect.
---
 dracut-functions |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index cc16760..c70e29a 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -240,8 +240,8 @@ inst_dir() {
             # create link as the original
             local target=$(readlink "$file")
             ln -sfn "$target" "${initdir}$file" || return 1
-            # resolve relative path and recursively install destionation
-            [[ $target = ${target##*/} ]] && target="${file%/*}/$target"
+            # resolve relative path and recursively install destination
+            [[ $target == ${target#/} ]] && target=$(dirname "$file")/$target
             inst_dir "$target"
         else
             # create directory
-- 
1.7.4
