From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Does dracut need start watchdog?
Date: Wed, 11 Dec 2013 15:58:00 +0800
Message-ID: <20131211075800.GD8495@dhcp-16-105.nay.redhat.com>
References: <20130805101929.GA26184@dhcp-16-252.nay.redhat.com>
 <52049855.6050308@redhat.com>
 <52A6CF1C.50206@redhat.com>
 <52A6FE79.3050000@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52A6FE79.3050000-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/10/13 at 12:43pm, Harald Hoyer wrote:
> On 12/10/2013 09:21 AM, Baoquan He wrote:
> > On 08/09/2013 03:20 PM, Harald Hoyer wrote:
> >> On 08/05/2013 12:19 PM, Baoquan He wrote:
> >>> Hi Harald,
> >>>
> >>> Since some drivers do the soft kicking. That is if BIOS has enabled
> >>> watchdog, then kernel driver kicks the hardware till user space watchdog
> >>> daemon comes along. This can help sove the problem in kdump which kdump
> >>> kernel reboot before vmcore saving is finished. That problem is
> >>> triggered because watchdog started in 1st kernel and timeout because of
> >>> stopping being kicked.
> >>>
> >>> I noticed in 04watchdog the watchdog.sh will start watchdog if
> >>> /dev/watchdog exists. I am just wondering if it's needed to start
> >>> watchdog by accessing /dev/watchdog. If starting watchdog is not needed,
> >>> I want to make some code change of watchdog.sh.
> >>>
> >>> What's your suggestion?
> >>>
> >>> Baoquan
> >>> Thanks a lot
> >>
> >> Basically the 04watchdog module was used only in the testsuite. You might
> >> consider to use the systemd watchdog feature instead.
> >>
> >> http://0pointer.de/blog/projects/watchdog.html
> >>
> >> or, if 0pointer is down again:
> >>
> >> http://webcache.googleusercontent.com/search?q=cache:jYfJU_fFZy8J:0pointer.de/blog/projects/watchdog.html
> > 
> > Hi,
> > 
> > I tried your suggestion, systemd can't help.
> > 
> > In /etc/systemd/system.conf, there are 2 options to control watchdog,
> > however it need watchdog hardware to be present. That means watchdog
> > driver need be loaded during startup.
> > 
> > Baoquan
> > Thanks
> 
> Why can't systemd help?
> 
> dracut also uses the hardware watchdog. There is even a software watchdog device
> driver (softdog).

Hi Harald,

Before we encoutered a NMI watchdog problem, that hardware is iTCO_wdt
residing in lpc_ich mtd device. Then Don (dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) found the
iTCO_wdt driver has code that tells it to turn off the watchdog until
userspace turns it on. So for kdump, the device will get turned off
(which is what we want).

Not all devices may behave this way, but iTCO_wdt should cover the
majority of the problems we are seeing.

Now when the watchdog ko is added into kernel, with the help of udevd,
module loading happens automatically, that's great. So the thing is
where to put the code that add watchdog ko into initramfs, 04watchdog
seems like the suitable place.

Baoquan
Thanks

> 
> Just load the module and systemd should start to make use of "/dev/watchdog".
> With udevd in the initramfs, module loading should happen automatically, you
> just have to add the watchdog modules to the initramfs.
> 
> $ echo; echo -n "instmods"; modinfo char-major-10-130 | while read a b; do [[ $a
> == filename: ]] && (b=${b##*/}; echo -n " ${b%.ko}");done;echo
> 
> instmods pcwd_pci wdt_pci pcwd_usb alim1535_wdt alim7101_wdt sp5100_tco
> sbc_fitpc2_wdt ib700wdt ibmasr i6300esb ie6xx_wdt iTCO_wdt it8712f_wdt it87_wdt
> hpwdt nv_tco sch311x_wdt w83627hf_wdt w83697hf_wdt w83697ug_wdt w83877f_wdt
> w83977f_wdt machzwd xen_wdt softdog
> 
