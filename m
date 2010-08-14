From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/16] Add support for bzip2 and xz compressed initramfs images.
Date: Sat, 14 Aug 2010 14:23:25 -0500 (CDT)
Message-ID: <d23e6d8e5281904090c6a05cecf1576ee7f098f6.1281812506.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=59ziAU7NmwY9hqTb+b/l+45IdaUcmQu1DjCTw8EqT2Y=;
        b=tHlNhhUb9xQlNo8iIHj+579HXYLrwDGgZ6cJqYddNcabaFE9cQQC9xWjlk4qeU+GlV
         JNDzDqq4oxYZ79orDpzZGNbsUDhAdzu5qoQOl7/xDtgoGE9RqCqkiyQ0sULqZCvTrhoJ
         Qqr77md33Vj+aBfHrK/WMwmgE1v+aN+nIiVU0=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Current kernels know how to uncompress bzip2 and xz, so use them for compressing
the initramfs if asked.  The more compression the merrier.

Also add support for generating uncompressed images, although they
are usually not what you want.

---
 dracut             |   21 ++++++++++++++++++---
 mkinitrd-dracut.sh |    2 +-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/dracut b/dracut
index a2bc312..5c1c4b4 100755
--- a/dracut
+++ b/dracut
@@ -75,6 +75,17 @@ Creates initial ramdisk images for preloading modules
                          Target directory in the final initramfs.
   -I, --install [LIST]  Install the space separated list of files into the
                          initramfs.
+  --gzip                Compress the generated initramfs using gzip.
+                        This will be done by default, unless another
+                        compression option or --no-compress is passed.
+  --bzip2               Compress the generated initramfs using bzip2.
+                        Make sure your kernel has bzip2 decompression support
+                        compiled in, otherwise you will not be able to boot.
+  --xz                  Compress the generated initramfs using xz.
+                        Make sure your kernel has xz support compiled in, 
+                        otherwise you will not be able to boot.
+  --no-compress         Do not compress the generated initramfs.  This will
+                        override any other compression options.
 "
 }
 
@@ -111,6 +122,10 @@ while (($# > 0)); do
 	--fstab) use_fstab_l="yes" ;;
 	-i|--include) include_src="$2"; include_target="$3"; shift 2;;
 	-I|--install) install_items="$2"; shift;;
+        --gzip) [[ $compress != cat ]] && compress="gzip -9";;
+        --bzip2) [[$compress != cat ]] && compress="bzip2 -9";;
+        --xz) [[ $compress != cat ]] && compress="xz -9";;
+        --no-compress) compress="cat";;
 	-*) printf "\nUnknown option: %s\n\n" "$1" >&2; usage; exit 1;;
 	*) break ;;
     esac
@@ -174,6 +189,7 @@ fw_dir=${fw_dir//:/ }
 
 [[ $hostonly = yes ]] && hostonly="-h"
 [[ $hostonly != "-h" ]] && unset hostonly
+[[ $compress ]] || compress="gzip -9"
 
 if [[ -f $dracutbasedir/dracut-functions ]]; then
    . $dracutbasedir/dracut-functions
@@ -323,8 +339,8 @@ type hardlink &>/dev/null && {
 	hardlink "$initdir" 2>&1
 }
 
-type pigz &>/dev/null && gzip=pigz || gzip=gzip
-( cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet |$gzip -9 > "$outfile"; ) 
+[[ $compress = gzip* ]] && type pigz > /dev/null 2>&1 && compress="pigz -9"
+( cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet |$compress > "$outfile"; ) 
 if [ $? -ne 0 ]; then
     derror "dracut: creation of $outfile failed"
     exit 1
@@ -333,4 +349,3 @@ fi
 [[ $beverbose = yes ]] && ls -lh "$outfile"
 
 exit 0
-
diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
index 64b3069..59333a7 100644
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -96,7 +96,7 @@ while [ $# -gt 0 ]; do
         --without*) ;;
         --without-usb) ;;
         --fstab*) ;;
-        --nocompress) ;;
+        --nocompress) dracut_args="$dracut_args --no-compress";;
         --ifneeded) ;;
         --omit-scsi-modules) ;;
         --omit-ide-modules) ;;
-- 
1.7.2.1
