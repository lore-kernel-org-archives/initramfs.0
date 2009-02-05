From: Thiago Galesi <ro-ubUvw2JwXcZg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] add support for -o option
Date: Thu,  5 Feb 2009 15:52:44 -0200
Message-ID: <1233856364-6692-1-git-send-email-ro@duskblue.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Here's a patch to add -o suport to dracut, like in other mkinitrds 


Signed-off-by: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 dracut |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/dracut b/dracut
index ef2ca42..b6bf198 100755
--- a/dracut
+++ b/dracut
@@ -27,6 +27,10 @@ while [ $# -gt 0 ]; do
 	    allowlocal="yes"
 	    shift
 	    ;;
+	-o|--output)
+	    outfile=$(readlink -f "$2")
+	    shift 2
+	    ;;
 	--allow-missing)
 	    shift
 	    ;;
@@ -40,10 +44,12 @@ if [ -n "$2" ]; then
 else
     kernel=$(uname -r)
 fi
-if [ -n "$1" ]; then
-    outfile=$(readlink -f $1)
-else
-    outfile="/boot/initrd-$kernel.img"
+if [ -z "$outfile" ]; then 
+	if [ -n "$1" ]; then
+	    outfile=$(readlink -f $1)
+	else
+	    outfile="/boot/initrd-$kernel.img"
+	fi
 fi
 
 if [ -f "$outfile" -a  -z "$force" ]; then
-- 
1.5.4.3

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
