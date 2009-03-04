From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] Fix several inst functions.
Date: Tue, 03 Mar 2009 16:21:19 -0800 (PST)
Message-ID: <446f41c9fdf5c8a4a460ae922527577de9e39d4c.1236124962.git.victor.lowther@gmail.com>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=IHP2nZxHM9+FZyLLLrwman/ZxLqcPvM0dcpIbxjN3h8=;
        b=SvPdriD8HguzwEwyF4w6sEAyuBAlsNd+ONmq6BS7SoRwjSshn0MffRKOsWilGT/h24
         mZ0c4jRrcbGeJ9v5SpLZtVODEaCYvwy8vYtNshbLaOkvEOLkPFqH0ytPaxb8TtgfG75v
         hzKKb4zkLQctNbEg1wmjtscXe8vt+DDzfLA2g=
In-Reply-To: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Move file existence checking into the individual inst functions. This makes
things a bit easier to understand and maintain.

---
 dracut-functions |   29 ++++++++++++++---------------
 1 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index fbcf315..0c2437a 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -31,7 +31,9 @@ strstr() { [[ ! ${1#*$2*} = $1 ]]; }
 # $2 (optional) Name for the file on the ramdisk
 # Location of the image dir is assumed to be $initdir
 inst_simple() {
-    local src=$1 target="${initdir}${2:-$1}"
+    local src target
+    [[ -f $1 ]] || return 1
+    src=$1 target="${initdir}${2:-$1}"
     [[ -f $target ]] && return 0
     mkdir -p "${target%/*}"
     echo "Installing $src" >&2
@@ -66,7 +68,9 @@ find_binary() {
 # If the file is a binary executable, install all its
 # shared library dependencies, if any.
 inst_binary() {
-    local bin="$1" target="${2:-$1}"
+    local bin target
+    bin=$(find_binary "$1") || return 1
+    shift
     local LDSO NAME IO FILE ADDR I1 n f TLIBDIR
     [[ -f $initdir$target ]] && return 0
     # I love bash!
@@ -97,12 +101,13 @@ inst_binary() {
 	}
         inst_library "$FILE" 
     done < <(ldd $bin 2>/dev/null)
-    inst_simple "$bin" "$target"
+    inst_simple "$bin" "$@"
 }
 
 # same as above, except for shell scripts.
 # If your shell script does not start with shebang, it is not a shell script.
 inst_script() {
+    [[ -f $1 ]] || return 1
     local src=$1 target=${2:-$1} line
     read -r -n 80 line <"$src"
     [[ $line =~ '(#! *)(/[^ ]+).*' ]] || return 1
@@ -142,15 +147,8 @@ inst() {
         echo "usage: inst <file> <root> [<destination file>]"
         return 1
     fi
-    local src dest
-    src=$(find_binary "$1") || {
-	echo "Cannot find requested file $1. Exiting."
-	exit 1
-    }
-    local dest=${2:-$src}
     for x in inst_symlink inst_script inst_binary inst_simple; do
-	$x "$src" "$dest" && return 0
+	$x "$@" && return 0
     done
     return 1
 }
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
