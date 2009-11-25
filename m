From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Wildcards need dracut_install
Date: Wed, 25 Nov 2009 16:17:00 +0100
Message-ID: <4B0D4A6C.5060408@redhat.com>
References: <1259099416.15712.2.camel@d2>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259099416.15712.2.camel@d2>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Yanko Kaneti <yaneti-jUE9FD3ILm5BDgjK7y7TUQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/24/2009 10:50 PM, Yanko Kaneti wrote:
> ---
>   modules.d/90dmraid/install |    2 +-
>   modules.d/90lvm/install    |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/modules.d/90dmraid/install b/modules.d/90dmraid/install
> index ac88212..46e912d 100755
> --- a/modules.d/90dmraid/install
> +++ b/modules.d/90dmraid/install
> @@ -2,7 +2,7 @@
>   dracut_install dmraid partx kpartx
>
>   inst  dmeventd
> -inst  /usr/lib*/libdmraid-events*.so
> +dracut_install  /usr/lib*/libdmraid-events*.so
>   inst_rules 10-dm.rules 13-dm-disk.rules 95-dm-notify.rules
>
>   inst "$moddir/dmraid.sh" /sbin/dmraid_scan
> diff --git a/modules.d/90lvm/install b/modules.d/90lvm/install
> index 825d1fc..524258f 100755
> --- a/modules.d/90lvm/install
> +++ b/modules.d/90lvm/install
> @@ -8,7 +8,7 @@ if [[ $hostonly ]] || [[ $lvmconf = "yes" ]]; then
>       [ -f /etc/lvm/lvm.conf ]&&  inst /etc/lvm/lvm.conf
>   fi
>
> -inst /lib*/libdevmapper-event*.so
> +dracut_install /lib*/libdevmapper-event*.so
>   inst_rules 10-dm.rules 13-dm-disk.rules 95-dm-notify.rules
> 11-dm-lvm.rules
>
>   inst "$moddir/lvm_scan.sh" /sbin/lvm_scan

nice find! thank you!
