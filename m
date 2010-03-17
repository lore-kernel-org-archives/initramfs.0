From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [DRACUT PATCH] lvm_scan: use '--ignoremonitoring' rather than
 '--monitor n'
Date: Wed, 17 Mar 2010 11:59:50 +0100
Message-ID: <4BA0B626.9080201@redhat.com>
References: <1268249058-23510-1-git-send-email-snitzer@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1268249058-23510-1-git-send-email-snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mike Snitzer <snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lvm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 03/10/2010 08:24 PM, Mike Snitzer wrote:
> lvchange and vgchange '--monitor n' will not prevent lvm from
> attempting to dlopen the libdevmapper-event library.
>
> dracut git commit 47ab3b6c5e introduced the use of '--monitor n' but
> '--ignoremonitoring' is needed now that the libdevmapper-event library
> isn't copied into the initramfs (ever since 0fae59d6eb3)
>
> Signed-off-by: Mike Snitzer<snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   modules.d/90lvm/lvm_scan.sh |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/modules.d/90lvm/lvm_scan.sh b/modules.d/90lvm/lvm_scan.sh
> index 85cd78e..f4f7b4a 100755
> --- a/modules.d/90lvm/lvm_scan.sh
> +++ b/modules.d/90lvm/lvm_scan.sh
> @@ -60,13 +60,13 @@ nopoll=$(
>   if [ -n "$LVS" ] ; then
>       info "Scanning devices $lvmdevs for LVM logical volumes $LVS"
>       lvm lvscan --ignorelockingfailure 2>&1 | vinfo
> -    lvm lvchange -ay --ignorelockingfailure $nopoll --monitor n $LVS 2>&1 | vinfo
> +    lvm lvchange -ay --ignorelockingfailure $nopoll --ignoremonitoring $LVS 2>&1 | vinfo
>   fi
>
>   if [ -z "$LVS" -o -n "$VGS" ]; then
>       info "Scanning devices $lvmdevs for LVM volume groups $VGS"
>       lvm vgscan --ignorelockingfailure 2>&1 | vinfo
> -    lvm vgchange -ay --ignorelockingfailure $nopoll --monitor n $VGS 2>&1 | vinfo
> +    lvm vgchange -ay --ignorelockingfailure $nopoll --ignoremonitoring $VGS 2>&1 | vinfo
>   fi
>
>   if [ "$lvmwritten" ]; then
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

pushed
