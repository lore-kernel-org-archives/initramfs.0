From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PATCH: Fix / on lvm
Date: Mon, 13 Jul 2009 14:56:48 +0200
Message-ID: <4A5B2F10.5040603@redhat.com>
References: <4A577113.2040804@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A577113.2040804-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/10/2009 06:49 PM, Hans de Goede wrote:
> Hi,
>
> Currently / on lvm is not working because the udev rules test for
> KERNEL="dm-*" which of course
> will not be true for PV's, so PV's are not recognized and thus lvm does
> not work.
>
> The attached patch fixes this.
>
> Regards,
>
> Hans

fixed
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
