From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] Fix several inst functions broken by previous find_binary hackery
Date: Wed, 04 Mar 2009 18:51:42 -0800 (PST)
Message-ID: <36d547d5657b783aeff0b43b9f25f3c5792e47cb.1236220864.git.victor.lowther@gmail.com>
References: <c79c304ad7c2ef19b138c43f89f9b7244b57a6f4.1236220864.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=Vtw5IPvl0VCGDZyBnXebXk2jdZADxj00f5CTRgNgUo8=;
        b=jcIAy/OtNfNfV/0MQns81BgwfKwZWlNnHxx9w8BtrrGItZc6J0MoCuANoaUsC9Z8F/
         dXvIKHF7JYo35em5skziAlQlCYNYu4TGP4LL/Co+K/u+s8h3zoUmAQn7D5B95JcIACSW
         V9oUk6A5iawZbVBQF3uat2k73+vZRi5tlMybY=
In-Reply-To: <c79c304ad7c2ef19b138c43f89f9b7244b57a6f4.1236220864.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This also makes the individual inst functions more robust and easily callable 
as seperate functions.

---
 dracut-functions |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index bb6e972..fe86a10 100755
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
@@ -142,14 +147,8 @@ inst() {
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
@@ -176,7 +175,7 @@ dracut_install() {
     done
 }
 
-srcmods="/lib/modules/$kernel/"
+srcmods="/lib/modules/$kernel"
 instmods() {
     local mod mpargs modpath modname cmd
     while (($# > 0)); do
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
