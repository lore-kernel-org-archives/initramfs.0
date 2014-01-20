From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] add a new option "testonly"
Date: Mon, 20 Jan 2014 10:28:48 +0800
Message-ID: <20140120022848.GA18942@dhcp-16-105.nay.redhat.com>
References: <1389790430-17808-1-git-send-email-bhe@redhat.com>
 <20140115201608.GA13541@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140115201608.GA13541-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 01/15/14 at 03:16pm, Vivek Goyal wrote:
> Bao,
> 
> This is harald's call but personally to me this testonly options look
> little odd.

Yeah, it does look odd. But I don't want this to affect the existed test
cases. 

> 
> I am looking at old discussion here.
> 
> http://thread.gmane.org/gmane.linux.kernel.initramfs/3370
> 
> So harald's suggestion of using systemd looks fine. It is just a matter of
> figuring out who should load watchdog modules in initramfs.
> 
> I personally feel it should be watchdog module but if harald does not
> like it, we can atleast for the time being keep that logic in kdump
> module. But trying to create this testonly mode feels odd to me.

Yeah, agree. For the time being, only iTCO_wdt need load module and
satisfacory. However, there are many kinds of watchdog with different
implementation. Finally, a independent dracut module may be needed, it
can be put into dracut as a independent folder, e.g 06wdt which is
different then 04watchdog. 

> 
> Harald, can you please let us know your preference on this. Modify
> 04watchdog module to include relevant drivers in hostonly mode or
> push this logic into kdump module for now.
> 
> Thanks
> Vivek
> 
> On Wed, Jan 15, 2014 at 08:53:48PM +0800, Baoquan He wrote:
