From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: use TMPDIR defintion
Date: Mon, 16 May 2011 18:08:32 +0200
Message-ID: <4DD14C00.6070708@redhat.com>
References: <1305560806-27836-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305560806-27836-1-git-send-email-max-U9r9yeDMy7A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 16.05.2011 17:46, schrieb maximilian attems:
> mktemp has marked the "-t" as deprecated.
> TMPDIR is anyway write guarded just a line above since dracut 003.
> 
> Signed-off-by: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
> ---
>  dracut |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/dracut b/dracut
> index d19c162..e018061 100755
> --- a/dracut
> +++ b/dracut
> @@ -452,7 +452,7 @@ elif [[ -f "$outfile" && ! -w "$outfile" ]]; then
>  fi
>  
>  [[ $TMPDIR && ! -w $TMPDIR ]] && unset TMPDIR

We should even remove the above line, because we really want /var/tmp here.
/tmp might be to small and we want to prevent accidents (like as we do, when we
set $PATH)

> -readonly initdir=$(mktemp --tmpdir=/var/tmp/ -d -t initramfs.XXXXXX)
> +readonly initdir=$(mktemp --tmpdir=${TMPDIR:-/var/tmp/} -d initramfs.XXXXXX)
>  
>  # clean up after ourselves no matter how we die.
>  trap 'ret=$?;rm -rf "$initdir";exit $ret;' EXIT
