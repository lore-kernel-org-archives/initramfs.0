From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-initramfs-restore: make mount error nonfatal
Date: Wed, 2 Sep 2015 12:55:21 +0200
Message-ID: <55E6D599.9000901@redhat.com>
References: <E1ZK3hi-0000SN-Lt@puleglot.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1ZK3hi-0000SN-Lt-C3g8GgeTu50ox3rIn2DAYQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 28.07.2015 13:55, Alexander Tsoy wrote:
> Script enables errexit option (set -e). So if /boot is not a mount point
> or is already mounted, then script dies after unsuccessful mount
> command. Fix this by always returning successful result.
> ---
>  dracut-initramfs-restore.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dracut-initramfs-restore.sh b/dracut-initramfs-restore.sh
> index 0e6a1a8..0c41a59 100644
> --- a/dracut-initramfs-restore.sh
> +++ b/dracut-initramfs-restore.sh
> @@ -14,7 +14,7 @@ SKIP="$dracutbasedir/skipcpio"
>  
>  [[ -f /etc/machine-id ]] && read MACHINE_ID < /etc/machine-id
>  
> -mount -o ro /boot &>/dev/null
> +mount -o ro /boot &>/dev/null || true
>  
>  if [[ $MACHINE_ID ]] && [[ -d /boot/${MACHINE_ID} || -L /boot/${MACHINE_ID} ]] ; then
>      IMG="/boot/${MACHINE_ID}/${KERNEL_VERSION}/initrd"
> 

Thanks! Merged
