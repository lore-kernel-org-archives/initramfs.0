From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] network: add static route support
Date: Wed, 4 Jun 2014 14:25:16 +0800
Message-ID: <20140604062516.GE2194@darkstar.nay.redhat.com>
References: <1398678111-13601-1-git-send-email-bhe@redhat.com>
 <1398678111-13601-2-git-send-email-bhe@redhat.com>
 <20140505071214.GA24097@dhcp-16-116.nay.redhat.com>
 <20140522073359.GD1859@darkstar.nay.redhat.com>
 <20140527062512.GA1951@dhcp-16-116.nay.redhat.com>
 <20140529062059.GH2068@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140529062059.GH2068-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mmilgram-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 05/29/14 at 02:20pm, Dave Young wrote:
> On 05/27/14 at 02:25pm, Baoquan He wrote:
> > On 05/22/14 at 03:33pm, Dave Young wrote:
> > > On 05/05/14 at 03:12pm, Baoquan He wrote:
> > 
> > > Hi, Baoquan
> > > 
> > > The route-$netif is supposed in 1st kernel filesystem. Can we passing the
> > > detail ip/netmask/gw for specific nic in kernel cmdline instead of copy
> > > the route file in initramfs? In that way we can avoid this dracut fix.
> > > 
> > > I'm not sure if it works for the complicate route setup though.
> > 
> > I am not sure, it had better handle the route during setup net. I want
> > to hear what Harald will say. He is more familiar with this.
> 
> Ok, the route table item must be a line like "192.168.100.1 via 127.0.0.1 dev lo  metric 203"
> 
> If passing them via cmdline we need quote it with some special character and append
> it to the ip= cmdline param
> 
> The other way is copy the route file to /etc/ in initramfs like you are doing.
> But we did need the functions to handle the static route.
> 
> So leave to Harald about the interface. 

Harald, what do you prefer to passing static route item to initramfs?
Do you have beeter idea in mind?

Thanks
Dave
