From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 13/16] Trivial bashification and minor code rearrangement for initramfs compression.
Date: Sat, 14 Aug 2010 14:23:26 -0500 (CDT)
Message-ID: <fe4242a37082fcee1cd5520941b80ecf7afd97d0.1281812506.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=ad5+vP35qKowgZIS9BsfFTt7jBZ0ip0pNwz2w7smX0A=;
        b=ndWn9KywIh/ZDbU49iH0+BYM8fyT1XrYOmaNX/VQ7S5QkItm1g68flCyHl81Bfj/79
         Oz54AVbzCY47sfOrEM+gbpLTaafKdf9RLBJcl09gjNiYIe2DQytodM9i37lA4L5Ur4Jy
         VOYum40con18yq0D8emWNM5RxxEYQvTqI3R4I=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 dracut |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/dracut b/dracut
index fcd32c1..f70aa50 100755
--- a/dracut
+++ b/dracut
@@ -136,10 +136,13 @@ while (($# > 0)); do
 	--fstab)       use_fstab_l="yes" ;;
 	-h|--help)     usage; exit 1 ;;
 	-i|--include)  include_src="$2"; include_target="$3"; shift 2;;
-        --gzip)        [[ $compress != cat ]] && compress="gzip -9";;
         --bzip2)       [[ $compress != cat ]] && compress="bzip2 -9";;
         --xz)          [[ $compress != cat ]] && compress="xz -9";;
         --no-compress) compress="cat";;
+        --gzip)        if [[ $compress != cat ]]; then
+            type pigz > /dev/null 2>&1 && compress="pigz -9" || \
+                compress="gzip -9"
+            fi;;
         --ignore-kernel-modules) kernel_only="no"; no_kernel="yes"
             ignore_kmodules="yes"
             omit_dracutmodules_l+=\ kernel-modules
@@ -258,7 +261,7 @@ fi
 
 hookdirs="cmdline pre-udev pre-trigger netroot pre-mount pre-pivot mount emergency"
 
-[[ -n "$TMPDIR" ]] && ! [[ -w "$TMPDIR" ]] && unset TMPDIR
+[[ $TMPDIR && ! -w $TMPDIR ]] && unset TMPDIR
 readonly initdir=$(mktemp -d -t initramfs.XXXXXX)
 
 trap 'ret=$?;rm -rf "$initdir";exit $ret;' EXIT # clean up after ourselves no matter how we die.
@@ -357,7 +360,6 @@ type hardlink &>/dev/null && {
 	hardlink "$initdir" 2>&1
 }
 
-[[ $compress = gzip* ]] && type pigz > /dev/null 2>&1 && compress="pigz -9"
 if ! ( cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet | \
     $compress > "$outfile"; ); then 
     derror "dracut: creation of $outfile failed"
-- 
1.7.2.1
