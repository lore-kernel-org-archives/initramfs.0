From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 37/50] Try to install file as scripts before installing them as binaries
Date: Mon, 16 Feb 2009 14:06:59 -0500
Message-ID: <200902161906.n1GJ6xRS028528@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=8c1faa35c4e6d449f4744c12a827e3a87c464696
Commit:     8c1faa35c4e6d449f4744c12a827e3a87c464696
Parent:     75ec5873afdbf6a304fa2eddb9a789068e0476b6
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:59 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 37/50] Try to install file as scripts before installing them as binaries
    
    This ensures that scripts will ahve their interpreter isntalled before
    they get installed.
    
    Also included a minor fixup that skips library checking if the binary
    we are testing is already installed.
---
 dracut-functions |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 1ded3d8..97ac626 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -59,6 +59,7 @@ inst_library() {
 inst_binary() {
     local bin="$1" target="${2:-$1}"
     local LDSO NAME IO FILE ADDR I1 n f TLIBDIR
+    [[ -f $initdir$target ]] && return 0
 
     LDSO=$(LANG=C eu-readelf -l $bin 2>/dev/null | \
 	awk '/interpreter/ {print $4}' |sed -e 's/]$//')
@@ -122,7 +123,7 @@ inst() {
         return 1
     fi
     local src=$1 dest=${2:-$1}
-    for x in inst_symlink inst_binary inst_script inst_simple; do
+    for x in inst_symlink inst_script inst_binary inst_simple; do
 	$x "$src" "$dest" && return 0
     done
     return 1
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
