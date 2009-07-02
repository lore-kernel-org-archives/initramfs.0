From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add firmware loading support
Date: Thu, 02 Jul 2009 18:48:17 +0200
Message-ID: <4A4CE4D1.4030404@redhat.com>
References: <20090702141547.05B9B9D405C@zog.reactivated.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090702141547.05B9B9D405C-k/4jFdqg8LLlyo9zxV8I99HuzzzSOjJt@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/02/2009 04:15 PM, Daniel Drake wrote:
> ---
>   modules.d/95udev-rules/install |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/install
> index 8a3d8e9..f8ea69a 100755
> --- a/modules.d/95udev-rules/install
> +++ b/modules.d/95udev-rules/install
> @@ -12,6 +12,11 @@ inst_rules 50-udev.rules 95-late.rules
>   # ignore some devices in the initrd
>   inst_rules "$moddir/01-ignore.rules"
>
> +# for firmware loading
> +inst_rules 50-firmware.rules
> +dracut_install /lib/udev/firmware.sh
> +dracut_install cat uname
> +
>   if [ ! -x /lib/udev/vol_id ]; then
>       dracut_install blkid
>   fi

pushed
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
