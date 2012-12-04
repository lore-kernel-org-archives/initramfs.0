From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] dracut: add team device support
Date: Tue, 4 Dec 2012 17:18:39 -0500
Message-ID: <20121204221839.GE5738@redhat.com>
References: <1352991509-31740-1-git-send-email-amwang@redhat.com>
 <50BC1871.4050009@redhat.com>
 <1354505223.28101.11.camel@cr0>
 <20121203142452.GB3054@minipsycho.orion>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121203142452.GB3054-RDzucLLXGGI88b5SBfVpbw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Mon, Dec 03, 2012 at 03:24:52PM +0100, Jiri Pirko wrote:
> Mon, Dec 03, 2012 at 04:27:03AM CET, amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:
> >On Mon, 2012-12-03 at 11:11 +0800, Dave Young wrote:
> >> > -    instmods =drivers/net/phy ecb arc4 bridge stp llc ipv6 bonding
> >> 8021q af_packet virtio_net
> >> > +    instmods =drivers/net/phy ecb arc4 bridge stp llc ipv6 bonding
> >> 8021q af_packet virtio_net =drivers/net/team
> >> 
> >> 
> >> 
> >> 40network installs all related kernel modules. This will create a big
> >> initramfs though some of them are not used at all.
> >> 
> >> I'm thinking it's better to conditionally install them. In the long
> >> run
> >> maybe network module should be splited to to multiple modules.
> >> 
> >> And for now I think it's better to install them only if there's team
> >> related user space tools in running system. 
> >
> >It is not as easy as what you think, users may specify their network
> >config at _run time_ via cmdline, so it is not easy to know which kernel
> >module will be used until we get all the cmdline.
> >
> >For kdump, one solution is removing all unnecessary stuffs including
> >kernel modules and user-space utitlies at setup time, because kdump
> >parses the network config at setup time. Obviously this only applies for
> >kdump, for others, e.g. anaconda, this problem still exists, but they
> >probably don't care about the memory usage as much as kdump.
> >
> >However, I don't think this is relevant here, we should do this in a
> >different patch. It is unfair to only blame team driver here, there are
> >already some other modules in the same line anyway...
> 
> + team modules are thin.

Will they be included in host only mode too (-H, --host-only) ? We use 
hostonly option for building kdump initramfs. So if root is not on team
device, will it still be included.

If no, it is fine but if yes, then we need to fix it. We try very hard to
keep kdump initramfs size small.

Thanks
Vivek
