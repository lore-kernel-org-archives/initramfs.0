From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/18] Update dracut-catimages to make it much more robust.
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <2790d5b2ed6993c01158e96aea24404cd40eb0c0.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

dracut-catimages will now handle image filenames with spaces, carriage returns,
and other such nasty characters in them.  Bash arrays are very useful for 
these sorts of things.

---
 dracut-catimages |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/dracut-catimages b/dracut-catimages
index 66b03fe..b19f20a 100755
--- a/dracut-catimages
+++ b/dracut-catimages
@@ -70,7 +70,7 @@ done
 
 outfile=$1; shift
 
-if [ -z "$outfile" ]; then
+if [[ -z $outfile ]]; then
     derror "No output file specified."
     usage
     exit 1
@@ -78,45 +78,47 @@ fi
 
 baseimage=$1; shift
 
-if [ -z "$baseimage" ]; then
+if [[ -z $baseimage ]]; then
     derror "No base image specified."
     usage
     exit 1
 fi
 
-if [ -f $outfile -a -z "$force" ]; then
+if [[ -f $outfile && ! $force ]]; then
     derror "Will not override existing initramfs ($outfile) without --force"
     exit 1
 fi
 
-if [ -z "$no_imagedir" -a ! -d "$imagedir" ]; then
+if [[ ! $no_imagedir && ! -d $imagedir ]]; then
     derror "Image directory $overlay is not a directory"
     exit 1
 fi
 
-if [ -z "$no_overlay" -a ! -d "$overlay" ]; then
+if [[ ! $no_overlay && ! -d $overlay ]]; then
     derror "Overlay $overlay is not a directory"
     exit 1
 fi
 
-if [ -z "$no_overlay" ]; then
+if [[ ! $no_overlay ]]; then
     ofile="$imagedir/90-overlay.img"
     dinfo "Creating image $ofile from directory $overlay"
     ( cd "$overlay"; find . |cpio --quiet -H newc -o  |gzip -9 > "$ofile"; )
 fi
 
-if [ -z "$no_imagedir" ]; then
-    images=$(for i in $imagedir/*.img;do [ -f $i ] || continue; echo $i; done)
+if [[ ! $no_imagedir ]]; then
+    for i in "$imagedir/"*.img; do
+	[[ -f $i ]] && images+=("$i")
+    done
 fi
 
-images="$images $@"
+images+=($@)
 
 dinfo "Using base image $baseimage"
-cat $baseimage > $outfile
+cat "$baseimage" > "$outfile"
 
-for i in $images; do 
+for i in "${images[@]}"; do 
     dinfo "Appending $i"
-    cat $i >> $outfile
+    cat "$i" >> "$outfile"
 done
 
 dinfo "Created $outfile"
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
