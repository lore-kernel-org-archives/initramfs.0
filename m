From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 10/50] Clean up initialization in dracut.
Date: Mon, 16 Feb 2009 14:06:06 -0500
Message-ID: <200902161906.n1GJ66mu027689@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=c8937ec4a722e4816a526b68c90d17907a9b93da
Commit:     c8937ec4a722e4816a526b68c90d17907a9b93da
Parent:     b368a5f3bb58a795210f4caf3ad43a2757e3d651
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:41:54 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:40 2009 -0500

    [PATCH 10/50] Clean up initialization in dracut.
    
    The source keyword is deprecated, and kernel / outfile are more legible as
    conditional lists.
---
 dracut |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/dracut b/dracut
index 82cf9e5..bd592d0 100755
--- a/dracut
+++ b/dracut
@@ -23,29 +23,22 @@ while (($# > 0)); do
     shift
 done
 
-if [ -n "$2" ]; then
-    kernel=$2
-else
-    kernel=$(uname -r)
-fi
-if [ -n "$1" ]; then
-    outfile=$(readlink -f $1)
-else
+[[ $2 ]] && kernel=$2 || kernel=$(uname -r)
+[[ $1 ]] && outfile=$(readlink -f $1) || \
     outfile="/boot/initrd-$kernel.img"
-fi
 
-if [ -f "$outfile" -a  -z "$force" ]; then
+if [[ -f $outfile && ! $force ]]; then
     echo "Will not override existing initramfs ($outfile) without --force"
     exit 1
 fi
 
-if [ -n "$allowlocal" -a -f ./init ]; then
-    source ./dracut-functions
+if [[ $allowlocal && -f ./init ]]; then
+    . ./dracut-functions
     initfile=./init
     switchroot=./switch_root
     rulesdir=./rules.d
 else
-    source /usr/libexec/dracut/functions
+    . /usr/libexec/dracut/functions
     initfile=/usr/libexec/dracut/init
     switchroot=/usr/libexec/dracut/switch_root
     rulesdir=/usr/libexec/dracut/rules.d
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
