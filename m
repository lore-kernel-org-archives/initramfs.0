From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] apply-live-updates.sh: copy without glob
Date: Fri, 21 Oct 2011 13:18:50 +0200
Message-ID: <4EA1551A.8070308@redhat.com>
References: <1319133444-27980-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1319133444-27980-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 20.10.2011 19:57, Will Woods wrote:
> cp $SRC/* $DEST will skip dotfiles in $SRC.
> ( cd $SRC; cp -a -t $DEST . ) will copy everything.
> ---
>  modules.d/90dmsquash-live/apply-live-updates.sh |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/modules.d/90dmsquash-live/apply-live-updates.sh b/modules.d/90dmsquash-live/apply-live-updates.sh
> index dfdb404..8dce5d4 100755
> --- a/modules.d/90dmsquash-live/apply-live-updates.sh
> +++ b/modules.d/90dmsquash-live/apply-live-updates.sh
> @@ -1,7 +1,8 @@
>  #!/bin/sh
>  if [ -b /dev/mapper/live-rw ]; then
> -    if [ "`echo /updates/*`" != "/updates/*" ]; then
> +    if pushd /updates &>/dev/null; then
>          echo "Applying updates to live image..."
> -        /bin/cp -a /updates/* $NEWROOT
> +        /bin/cp -a -t $NEWROOT .
> +        popd &>/dev/null
>      fi
>  fi

pushed, thanks
