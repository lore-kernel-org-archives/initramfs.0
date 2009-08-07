From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Race condition? /tmp/net.ifaces and pre-pivot
Date: Fri, 7 Aug 2009 09:35:10 +0200
Message-ID: <4A7BD92E.5010004@bfh.ch>
References: <4A68D828.40506@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A68D828.40506-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Warren Togami wrote:
> I am running into an odd issue that is supposedto be impossible.
> 
> pre-pivot/20write-ifcfg.sh is often being run but fails to write 
> net.*.ifcfg files because /tmp/net.ifaces does not exist at that moment. 
>  The mount was otherwise successful, and rdbreak before switch_root sees 
> that /tmp/net.ifaces exists.
> 
> With plain "root=dhcp" with a NFS rootfs, it seems to never happen. 
> However with "root=dhcp bridge", perhaps 25-75% of the time it is 
> failing to write ifcfg files.
> 
> Some kind of race going on?  An inspection of the code seems to me that 
> /tmp/net.ifaces should have already been created prior to pre-pivot?

This is not entirely unexpected due to the asynchronousness of 
udev-events and the new initqueue/mount-loop.

The correct solution would be to move the whole call of netroot to the 
initqueue, which we'll have to do anyway when we start handling 
interface timeouts with arp.

> 
> Warren Togami
> wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> -- 
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
