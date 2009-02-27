From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Canonicalize symlinks
Date: Fri, 27 Feb 2009 15:37:47 +0100
Message-ID: <49A7FABB.9060007@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

When handling links sometimes one readlink isn't enough. Dracut doesn't 
need to clone a whole link series, so just use readlink -f

--
  dracut-functions |    8 +++-----
  1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 2f63e31..0fcfe53 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -42,11 +42,9 @@ inst_library() {
      local src=$1 dest=${2:-$1}
      [[ -f $initdir$dest ]] && return 0
      if [[ -L $src ]]; then
-	reallib="$(readlink "$src")"
+	reallib="$(readlink -f "$src")"
  	lib=${src##*/}
-	realsrc="${src%/*}/$reallib"
-	realdest="${dest%/*}/$reallib"
-	inst_simple "$realsrc" "$realdest"
+	inst_simple "$reallib" "$reallib"
  	(cd "${initdir}${dest%/*}" && ln -s "$reallib" "$lib")
      else
  	inst_simple "$src" "$dest"
@@ -124,7 +122,7 @@ inst_symlink() {
      local src=$1 target=$initdir${2:-$1} realsrc
      [[ -L $1 ]] || return 1
      [[ -L $target ]] && return 0
-    realsrc=$(readlink "$src")
+    realsrc=$(readlink -f "$src")
      [[ $realsrc = ${realsrc##*/} ]] && realsrc="${src%/*}/$realsrc"
      inst "$realsrc" && ln -s "$realsrc" "$target"
  }
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
