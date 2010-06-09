From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/4] Just look for cryptroot instead of /sbin/cryptroot
Date: Wed, 09 Jun 2010 17:36:37 +0200
Message-ID: <4C0FB505.3050500@redhat.com>
References: <4b22ffbe9ef3f55ac4fad54bd58f9cf9fc345b22.1275480426.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4b22ffbe9ef3f55ac4fad54bd58f9cf9fc345b22.1275480426.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/02/2010 02:07 PM, Victor Lowther wrote:
> We know what the path is and what it contains in the initrd, and
> not everyone puts cryptroot in /sbin
> ---
>   modules.d/90crypt/cryptroot-ask.sh |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
> index 13487c8..2f39667 100755
> --- a/modules.d/90crypt/cryptroot-ask.sh
> +++ b/modules.d/90crypt/cryptroot-ask.sh
> @@ -68,7 +68,7 @@ if [ $ask -gt 0 ]; then
>       # flock against other interactive activities
>       { flock -s 9;
>   	echo -n "$device ($luksname) is password protected"
> -	/sbin/cryptsetup luksOpen -T1 $1 $luksname
> +	cryptsetup luksOpen -T1 $1 $luksname
>       } 9>/.console.lock
>   fi
>

pushed
