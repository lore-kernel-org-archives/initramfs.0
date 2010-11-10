From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] 95rootfs-block: fix missing root when label contains
 slash
Date: Wed, 10 Nov 2010 16:03:34 +0100
Message-ID: <4CDAB446.7000409@redhat.com>
References: <1288963916-3609-1-git-send-email-arvidjaar@gmail.com> <1289080013-3525-1-git-send-email-arvidjaar@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289080013-3525-1-git-send-email-arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/06/2010 10:46 PM, Andrey Borzenkov wrote:
> It is not clearly documented, but apparently fsck
> (or, probably, getmntent) is using backslash as
> escape character.
>
> Label containing slash is converted to \x2f but '\'
> is eaten by fsck later. Escape '\' before writing
> into fstab.
>
> v2:
> - fix sed expression
> - use printf instead of echo because echo eats '\' as well
>
> Signed-off-by: Andrey Borzenkov<arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> ---
>   modules.d/95rootfs-block/mount-root.sh |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
> index ff64209..9065bed 100755
> --- a/modules.d/95rootfs-block/mount-root.sh
> +++ b/modules.d/95rootfs-block/mount-root.sh
> @@ -106,7 +106,9 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
>               done
>       fi
>
> -    echo ${root#block:} "$NEWROOT" "$rootfs" ${rflags},${rootopts} 1 1>  /etc/fstab
> +    # backslashes are treated as escape character in fstab
> +    esc_root=$(echo ${root#block:} | sed 's,\\,\\\\,g')
> +    printf "%s $NEWROOT $rootfs ${rflags},${rootopts} 1 1\n" "$esc_root">  /etc/fstab
>
>       if [ -z "$fastboot" -a "$READONLY" != "yes" ]; then
>           info "Checking filesystems"

pushed
