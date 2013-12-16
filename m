From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Does dracut need start watchdog?
Date: Mon, 16 Dec 2013 10:53:08 +0800
Message-ID: <20131216025308.GB1459@dhcp-16-105.nay.redhat.com>
References: <20130805101929.GA26184@dhcp-16-252.nay.redhat.com>
 <52049855.6050308@redhat.com>
 <52A6CF1C.50206@redhat.com>
 <52A6FE79.3050000@redhat.com>
 <20131211075800.GD8495@dhcp-16-105.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131211075800.GD8495-je1gSBvt1TeLcxizHhUEZR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/11/13 at 03:58pm, Baoquan He wrote:

> > Why can't systemd help?
> > 
> > dracut also uses the hardware watchdog. There is even a software watchdog device
> > driver (softdog).
> 
> Hi Harald,
> 
> Before we encoutered a NMI watchdog problem, that hardware is iTCO_wdt
> residing in lpc_ich mtd device. Then Don (dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) found the
> iTCO_wdt driver has code that tells it to turn off the watchdog until
> userspace turns it on. So for kdump, the device will get turned off
> (which is what we want).
> 
> Not all devices may behave this way, but iTCO_wdt should cover the
> majority of the problems we are seeing.
> 
> Now when the watchdog ko is added into kernel, with the help of udevd,
> module loading happens automatically, that's great. So the thing is
> where to put the code that add watchdog ko into initramfs, 04watchdog
> seems like the suitable place.
> 
> Baoquan
> Thanks

Hi Harald,

Do you think it's OK to put watchdog driver module adding into
04watchdog? If it's fine to you, I can post a patch. 

Baoquan
Thanks

> 
> > 
> > Just load the module and systemd should start to make use of "/dev/watchdog".
> > With udevd in the initramfs, module loading should happen automatically, you
> > just have to add the watchdog modules to the initramfs.
> > 
> > $ echo; echo -n "instmods"; modinfo char-major-10-130 | while read a b; do [[ $a
> > == filename: ]] && (b=${b##*/}; echo -n " ${b%.ko}");done;echo
> > 
> > instmods pcwd_pci wdt_pci pcwd_usb alim1535_wdt alim7101_wdt sp5100_tco
> > sbc_fitpc2_wdt ib700wdt ibmasr i6300esb ie6xx_wdt iTCO_wdt it8712f_wdt it87_wdt
> > hpwdt nv_tco sch311x_wdt w83627hf_wdt w83697hf_wdt w83697ug_wdt w83877f_wdt
> > w83977f_wdt machzwd xen_wdt softdog
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
