From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] fstab: do not mount and fsck from fstab if using systemd
Date: Wed, 02 Apr 2014 09:59:37 +0200
Message-ID: <533BC369.4000909@redhat.com>
References: <20140401072049.GA23588@dhcp-17-89.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140401072049.GA23588-2coKmSd1Zb6BYdNaKHuJJRcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 01.04.2014 09:20, schrieb WANG Chao:
> If using systemd in initramfs, we could run into a race condition when
> dracut and systemd both are trying to mount and run fsck for the same
> filesystem, and mount or fsck could be a failure.
> 
> To fix such failure, we should use systemd to mount/fsck from /etc/fstab
> only.
> 
> v2: check $DRACUT_SYSTEMD suggested by Alexander Tsoy
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/95fstab-sys/mount-sys.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/modules.d/95fstab-sys/mount-sys.sh b/modules.d/95fstab-sys/mount-sys.sh
> index 12711a0..a237810 100755
> --- a/modules.d/95fstab-sys/mount-sys.sh
> +++ b/modules.d/95fstab-sys/mount-sys.sh
> @@ -27,7 +27,11 @@ fstab_mount() {
>      return 0
>  }
>  
> -[ -f /etc/fstab ] && fstab_mount /etc/fstab
> +# systemd will mount and run fsck from /etc/fstab and we don't want to
> +# run into a race condition.
> +if [ -z "$DRACUT_SYSTEMD" ]; then
> +    [ -f /etc/fstab ] && fstab_mount /etc/fstab
> +fi
>  
>  # prefer $NEWROOT/etc/fstab.sys over local /etc/fstab.sys
>  if [ -f $NEWROOT/etc/fstab.sys ]; then
> 

Thanks. pushed
