From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Boot a Live USB device as read-only after persisting
 some changes.
Date: Fri, 16 Aug 2013 10:20:28 +0200
Message-ID: <520DE0CC.9050008@gmail.com>
References: <520B4BE5.6030003@redhat.com> <1376512685-4713-1-git-send-email-fgrose@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yS0Y2/5rvDclXQtb7OQWDaD/kUFqS+edqGmCoiP82SU=;
        b=ofgAhCv/89QO9hOEdnNqgCIqHnxYhZvDjeDa5eCuVeLaw6jAE0CIoiVYPg4s9or1Ir
         1Dq9ExZbeF25iz2/WJWLtuo9hUR7rVeZMHRSbW9qIGwT5hpktLCWjouTeUyQ1PJQKynl
         SlwHG/pjyQXy6QiJP7qN810wJQ6VxEPlxfl4IUIrKy1yhA/BwopLECYga8IapvTwMvm6
         m+h7V0fYy0Yo6uu5tGLZu4c9euO1NH2vD/on+cWtb0qI9umxPvNN5HBglBGjsoaOR1Nt
         vYF1Vt5rzmQivvj7GYCu2qaRdr53zXcRKNOOMwcqyVIbTIRCDf9PArV+Ug0l+g1QEq5r
         A9mw==
In-Reply-To: <1376512685-4713-1-git-send-email-fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, livecd-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org, spins-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org, Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>

On 08/14/2013 10:38 PM, fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>
> 
> commit 96ff19a87c0be1eca27860aeef5434513b0e8c61
> Author: Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>
> 
>     Allow read-only mounting of the base device filesystem, livedev.
>     Use read-only loop devices and non-persistent overlay targets.
> 
> ---
>  modules.d/90dmsquash-live/dmsquash-live-root.sh | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> index 14e84e1..af0022f 100755
> --- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
> +++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> @@ -24,7 +24,7 @@ squash_image=$(getarg rd.live.squashimg)
>  
>  getargbool 0 rd.live.ram -d -y live_ram && live_ram="yes"
>  getargbool 0 rd.live.overlay.reset -d -y reset_overlay && reset_overlay="yes"
> -getargbool 0 rd.live.overlay.readonly -d -y readonly_overlay && readonly_overlay="--readonly" || readonly_overlay=""
> +getargbool 0 rd.live.overlay.readonly -d -y readonly_overlay && readonly_overlay="-r" || readonly_overlay=""
>  overlay=$(getarg rd.live.overlay -d overlay)
>  
>  # CD/DVD media check
> @@ -105,17 +105,23 @@ do_live_overlay() {
>      setup=""
>      if [ -n "$devspec" -a -n "$pathspec" -a -n "$overlay" ]; then
>          mkdir -m 0755 /run/initramfs/overlayfs
> -        mount -n -t auto $devspec /run/initramfs/overlayfs || :
> -        if [ -f /run/initramfs/overlayfs$pathspec -a -w /run/initramfs/overlayfs$pathspec ]; then
> -            losetup $OVERLAY_LOOPDEV /run/initramfs/overlayfs$pathspec
> -            if [ -n "$reset_overlay" ]; then
> -                dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k count=1 conv=fsync 2>/dev/null
> +        mount -n -t auto -o $liverw $devspec /run/initramfs/overlayfs || :
> +        if [ -f /run/initramfs/overlayfs$pathspec ]; then
> +            if [ "$liverw" = ro ]; then
> +                readonly_overlay='-r'
> +            fi
> +            losetup $readonly_overlay $OVERLAY_LOOPDEV /run/initramfs/overlayfs$pathspec
> +            if [ -w /run/initramfs/overlayfs$pathspec ]; then
> +                if [ -n "$reset_overlay" ]; then
> +                    dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k count=1 conv=fsync 2>/dev/null
> +                fi
>              fi
>              setup="yes"
>          fi
>          umount -l /run/initramfs/overlayfs || :
>      fi
>  
> +    persistent='P'
>      if [ -z "$setup" -o -n "$readonly_overlay" ]; then
>          if [ -n "$setup" ]; then
>              warn "Using temporary overlay."
> @@ -123,6 +129,7 @@ do_live_overlay() {
>              warn "Unable to find persistent overlay; using temporary"
>              sleep 5
>          fi
> +        persistent='N'
>  
>          dd if=/dev/null of=/overlay bs=1024 count=1 seek=$((512*1024)) 2> /dev/null
>          if [ -n "$setup" -a -n "$readonly_overlay" ]; then
> @@ -136,14 +143,14 @@ do_live_overlay() {
>      # set up the snapshot
>      sz=$(blockdev --getsz $BASE_LOOPDEV)
>      if [ -n "$readonly_overlay" ]; then
> -        echo 0 $sz snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV p 8 | dmsetup create $readonly_overlay live-ro
> +        echo 0 $sz snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV N 8 | dmsetup create $readonly_overlay live-ro
>          base="/dev/mapper/live-ro"
>          over=$RO_OVERLAY_LOOPDEV
>      else
>          base=$BASE_LOOPDEV
>          over=$OVERLAY_LOOPDEV
>      fi
> -    echo 0 $sz snapshot $base $over p 8 | dmsetup create live-rw
> +    echo 0 $sz snapshot $base $over $persistent 8 | dmsetup create live-rw
>  }
>  
>  # live cd helper function
> @@ -217,7 +224,7 @@ fi
>  if [ -b "$OSMIN_LOOPDEV" ]; then
>      # set up the devicemapper snapshot device, which will merge
>      # the normal live fs image, and the delta, into a minimzied fs image
> -    echo "0 $( blockdev --getsz $BASE_LOOPDEV ) snapshot $BASE_LOOPDEV $OSMIN_LOOPDEV p 8" | dmsetup create --readonly live-osimg-min
> +    echo "0 $( blockdev --getsz $BASE_LOOPDEV ) snapshot $BASE_LOOPDEV $OSMIN_LOOPDEV N 8" | dmsetup create --readonly live-osimg-min
>  fi
>  
>  ROOTFLAGS="$(getarg rootflags)"
> 

thanks! pushed
