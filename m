From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH liveupdates] apply-live-updates.sh: handle updates for
 /run
Date: Thu, 06 Sep 2012 12:17:45 +0200
Message-ID: <50487849.5010803@redhat.com>
References: <1346281095-16549-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346281095-16549-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 30.08.2012 00:58, schrieb Will Woods:
> /run will get mounted at $NEWROOT/run after switch_root, but it's not
> there yet. bind-mount it in place so updates for /run actually land in
> /run.
> 
> (also: remove a redundant check for existing directories. mkdir -p
> doesn't do anything if the directory already exists.)
> ---
>  modules.d/90dmsquash-live/apply-live-updates.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/modules.d/90dmsquash-live/apply-live-updates.sh b/modules.d/90dmsquash-live/apply-live-updates.sh
> index 61da4bf..d620f2c 100755
> --- a/modules.d/90dmsquash-live/apply-live-updates.sh
> +++ b/modules.d/90dmsquash-live/apply-live-updates.sh
> @@ -2,14 +2,16 @@
>  
>  if [ -b /dev/mapper/live-rw ] && [ -d /updates ]; then
>      info "Applying updates to live image..."
> +    mount -o bind /run $NEWROOT/run
>      # avoid overwriting symlinks (e.g. /lib -> /usr/lib) with directories
>      (
>          cd /updates
>          find . -depth -type d | while read dir; do
> -            [ -d "$NEWROOT/$dir" ] || mkdir -p "$NEWROOT/$dir"
> +            mkdir -p "$NEWROOT/$dir"
>          done
>          find . -depth \! -type d | while read file; do
>              cp -a "$file" "$NEWROOT/$file"
>          done
>      )
> +    umount $NEWROOT/run
>  fi
> 

Huh? Why do you want updates in /run ?????
