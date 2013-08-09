From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Does dracut need start watchdog?
Date: Fri, 09 Aug 2013 09:20:53 +0200
Message-ID: <52049855.6050308@redhat.com>
References: <20130805101929.GA26184@dhcp-16-252.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130805101929.GA26184-je1gSBvt1Td8jiCoVU1BWR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/05/2013 12:19 PM, Baoquan He wrote:
> Hi Harald,
> 
> Since some drivers do the soft kicking. That is if BIOS has enabled
> watchdog, then kernel driver kicks the hardware till user space watchdog
> daemon comes along. This can help sove the problem in kdump which kdump
> kernel reboot before vmcore saving is finished. That problem is
> triggered because watchdog started in 1st kernel and timeout because of
> stopping being kicked.
> 
> I noticed in 04watchdog the watchdog.sh will start watchdog if
> /dev/watchdog exists. I am just wondering if it's needed to start
> watchdog by accessing /dev/watchdog. If starting watchdog is not needed,
> I want to make some code change of watchdog.sh.
> 
> What's your suggestion?
> 
> Baoquan
> Thanks a lot

Basically the 04watchdog module was used only in the testsuite. You might
consider to use the systemd watchdog feature instead.

http://0pointer.de/blog/projects/watchdog.html

or, if 0pointer is down again:

http://webcache.googleusercontent.com/search?q=cache:jYfJU_fFZy8J:0pointer.de/blog/projects/watchdog.html
