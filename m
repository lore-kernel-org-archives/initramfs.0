From: lars-3XmpO8hA3EAAvxtiuMwx3w@public.gmane.org
Subject: [PATCH] dracut: write initramfs to temp file then move into place
Date: Thu, 21 Feb 2013 13:40:23 -0800
Message-ID: <1361482823-30898-1-git-send-email-lars@pixar.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Lars R. Damerow" <lars-3XmpO8hA3EAAvxtiuMwx3w@public.gmane.org>

From: "Lars R. Damerow" <lars-3XmpO8hA3EAAvxtiuMwx3w@public.gmane.org>

We've been finding cases where multiple instances of dracut can be launched
simultaneously, resulting in a corrupted initramfs file. This patch makes
dracut write the initramfs to a new file, then move it into place atomically.
---
 dracut.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 31cf2a5..da96aaa 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1103,10 +1103,11 @@ fi
 rm -f "$outfile"
 dinfo "*** Creating image file ***"
 if ! ( umask 077; cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet| \
-    $compress > "$outfile"; ); then
-    dfatal "dracut: creation of $outfile failed"
+    $compress > "$outfile.$$"; ); then
+    dfatal "dracut: creation of $outfile.$$ failed"
     exit 1
 fi
+mv $outfile.$$ $outfile
 dinfo "*** Creating image file done ***"
 
 dinfo "Wrote $outfile:"
-- 
1.8.0
