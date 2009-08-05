From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Fix full pathname condition in find_library
Date: Wed, 05 Aug 2009 16:22:55 +0200
Message-ID: <4A7995BF.10801@redhat.com>
References: <op.uxy35cntfzkdih@etgc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <op.uxy35cntfzkdih@etgc>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Sergey Fionov <fionov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/01/2009 09:52 AM, Sergey Fionov wrote:
> Hello,
>
> Now a fact that the path is full is checked by
> [[ -x $1 ]]
>
> But if the working directory is /bin or a directory with a file named
> "mount",
> this condition will be met for "inst mount", and "mount" will not be copied
> into initrd at all.
>
> diff --git a/dracut-functions b/dracut-functions
> index d4caacf..1078bfd 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -83,7 +83,7 @@ inst_library() {
> # search in the usual places to find the binary.
> find_binary() {
> local binpath="/bin /sbin /usr/bin /usr/sbin" p
> - [[ -x $1 ]] && { echo $1; return 0; }
> + [[ -z ${1##/*} && -x $1 ]] && { echo $1; return 0; }
> for p in $binpath; do
> [[ -x $p/$1 ]] && { echo "$p/$1"; return 0; }
> done

merged in git
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
