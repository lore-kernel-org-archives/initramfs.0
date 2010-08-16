From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/16] Clean up some conditional checking when trying
 to find our config files.
Date: Mon, 16 Aug 2010 10:47:14 +0200
Message-ID: <4C68FB12.8010504@redhat.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com> <ef5afb56d5b0073885e92a7fbe0bd79dfe84fb77.1281812505.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ef5afb56d5b0073885e92a7fbe0bd79dfe84fb77.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/14/2010 09:23 PM, Victor Lowther wrote:
> No point in checking the same condition twice when compound commands will do.
>
> ---
>   dracut |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/dracut b/dracut
> index 541bfc0..a653981 100755
> --- a/dracut
> +++ b/dracut
> @@ -131,13 +131,13 @@ export PATH
>
>   # if we were not passed a config file, try the default one
>   if [[ ! -f $conffile ]]; then
> -    [[ $allowlocal ]] || conffile="/etc/dracut.conf"
> -    [[ $allowlocal ]]&&  conffile="$dracutbasedir/dracut.conf"
> +    [[ $allowlocal ]]&&  conffile="$dracutbasedir/dracut.conf" || \
> +        conffile="/etc/dracut.conf"
>   fi
>
>   if [[ ! -d $confdir ]]; then
> -    [[ $allowlocal ]] || confdir="/etc/dracut.conf.d"
> -    [[ $allowlocal ]]&&  confdir="$dracutbasedir/dracut.conf.d"
> +    [[ $allowlocal ]]&&  confdir="$dracutbasedir/dracut.conf.d" \
> +        confdir="/etc/dracut.conf.d"
>   fi
>
>   # source our config file


missing "||" in the second block???
