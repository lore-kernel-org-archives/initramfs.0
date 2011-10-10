From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: check mktemp return value
Date: Mon, 10 Oct 2011 11:44:47 +0200
Message-ID: <4E92BE8F.20001@redhat.com>
References: <4E92BC6F.3070805@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E92BC6F.3070805-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10.10.2011 11:35, Dave Young wrote:
> 
> in slackware the default mktemp is not from coreutils.
> A simply make in test directory mangled my rootfs due
> to initdir is blank
> 
> Also mktemp could failed with other reason like ENOSPC or EPERM
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/dracut b/dracut
> index c9329bd..8237f7a 100755
> --- a/dracut
> +++ b/dracut
> @@ -472,6 +472,10 @@ fi
> 
>  readonly TMPDIR=/var/tmp
>  readonly initdir=$(mktemp --tmpdir=/var/tmp/ -d -t initramfs.XXXXXX)
> +[ -z $initdir ] && {
> +    dfatal "mktemp failed."
> +    exit 1
> +}
> 
>  # clean up after ourselves no matter how we die.
>  trap 'ret=$?;[[ $keep ]] && echo "Not removing $initdir." >&2 || rm -rf
> "$initdir";exit $ret;' EXIT

pushed...

had to hand edit, because your mailer automatically broke the line.
