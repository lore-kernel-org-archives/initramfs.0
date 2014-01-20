From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] add a new option "testonly"
Date: Mon, 20 Jan 2014 13:51:08 -0500
Message-ID: <20140120185108.GD11319@redhat.com>
References: <1389790430-17808-1-git-send-email-bhe@redhat.com>
 <20140115201608.GA13541@redhat.com>
 <20140120022848.GA18942@dhcp-16-105.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140120022848.GA18942-je1gSBvt1TeLcxizHhUEZR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Mon, Jan 20, 2014 at 10:28:48AM +0800, Baoquan He wrote:

[..]

> > I personally feel it should be watchdog module but if harald does not
> > like it, we can atleast for the time being keep that logic in kdump
> > module. But trying to create this testonly mode feels odd to me.
> 
> Yeah, agree. For the time being, only iTCO_wdt need load module and
> satisfacory. However, there are many kinds of watchdog with different
> implementation. Finally, a independent dracut module may be needed, it
> can be put into dracut as a independent folder, e.g 06wdt which is
> different then 04watchdog. 

I think creating another watchdog module 06wdt does not make much sense.
Eiter this logic needs to be merged into existing watchdog module 04wdt
or we modify kdump module to load watchdog drivers in kdump initramfs
as a short term approach till we can convince harald that keeping this
logic in 04watchdog is a good idea.

Thanks
Vivek
