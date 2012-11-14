From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch RFC 0/6] network fixes for link waiting
Date: Wed, 14 Nov 2012 16:49:50 +0800
Message-ID: <50A35B2E.9050206@redhat.com>
References: <20121108034018.789330224@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121108034018.789330224-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Even with this series we still need add rd.retry=90 to make it work.
How about increase the default rd.retry value in dracut?

On 11/08/2012 11:40 AM, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:

> Here is a patch set for some network cleanup and fixes:
> 01-network-move-wait-for-if-function-to-net-lib.patch
> 02-network-add-function-linkup.patch
> 03-network-use-linkup-function.patch
> 04-network-wait-for-link-ready-before-use.patch
> 05-network-get-ifaces-for-udev-rule-use.patch
> 06-network-wait-interface-up-at-early-stage.patch
> 
> Tested kdump with a nic which delay abouth 60s while initializing.
> 
> Please help to review especially for the patch 3/6 which replace some ip link
> up with a function linkup.
> 
> --
> Thanks a lot
> Dave
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
