From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] add a new option "testonly"
Date: Thu, 16 Jan 2014 10:12:02 +0800
Message-ID: <20140116021202.GE3807@dhcp-16-126.nay.redhat.com>
References: <1389790430-17808-1-git-send-email-bhe@redhat.com>
 <20140115201608.GA13541@redhat.com>
 <20140116020647.GD3807@dhcp-16-126.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140116020647.GD3807-je1gSBvt1TcFLmT5oZ11vB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 01/16/14 at 10:06am, Dave Young wrote:
> On 01/15/14 at 03:16pm, Vivek Goyal wrote:
> > Bao,
> > 
> > This is harald's call but personally to me this testonly options look
> > little odd.
> > 
> > I am looking at old discussion here.
> > 
> > http://thread.gmane.org/gmane.linux.kernel.initramfs/3370
> > 
> > So harald's suggestion of using systemd looks fine. It is just a matter of
> > figuring out who should load watchdog modules in initramfs.
> > 
> > I personally feel it should be watchdog module but if harald does not
> > like it, we can atleast for the time being keep that logic in kdump
> > module. But trying to create this testonly mode feels odd to me.
> > 
> > Harald, can you please let us know your preference on this. Modify
> > 04watchdog module to include relevant drivers in hostonly mode or
> > push this logic into kdump module for now.
> > 
> 
> Adding wdt stuff in dracut would also help diskless system and NFS root system.

NFS root can use watchdog in real root. so correct myself, it only benifits the
initramfs-only system.

Thanks
Dave
