From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PATCH: Fix / on lvm
Date: Sun, 12 Jul 2009 23:09:08 -0400
Message-ID: <4A5AA554.3000304@redhat.com>
References: <4A577113.2040804@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A577113.2040804-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/10/2009 12:49 PM, Hans de Goede wrote:
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

Could you please describe in detail the type of setup needed to 
reproduce this failure?  I have / on lvm here and dracut is working just 
fine.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
