From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] dracut: add team device support
Date: Mon, 03 Dec 2012 11:27:03 +0800
Message-ID: <1354505223.28101.11.camel@cr0>
References: <1352991509-31740-1-git-send-email-amwang@redhat.com>
	 <50BC1871.4050009@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BC1871.4050009-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Mon, 2012-12-03 at 11:11 +0800, Dave Young wrote:
> > -    instmods =drivers/net/phy ecb arc4 bridge stp llc ipv6 bonding
> 8021q af_packet virtio_net
> > +    instmods =drivers/net/phy ecb arc4 bridge stp llc ipv6 bonding
> 8021q af_packet virtio_net =drivers/net/team
> 
> 
> 
> 40network installs all related kernel modules. This will create a big
> initramfs though some of them are not used at all.
> 
> I'm thinking it's better to conditionally install them. In the long
> run
> maybe network module should be splited to to multiple modules.
> 
> And for now I think it's better to install them only if there's team
> related user space tools in running system. 

It is not as easy as what you think, users may specify their network
config at _run time_ via cmdline, so it is not easy to know which kernel
module will be used until we get all the cmdline.

For kdump, one solution is removing all unnecessary stuffs including
kernel modules and user-space utitlies at setup time, because kdump
parses the network config at setup time. Obviously this only applies for
kdump, for others, e.g. anaconda, this problem still exists, but they
probably don't care about the memory usage as much as kdump.

However, I don't think this is relevant here, we should do this in a
different patch. It is unfair to only blame team driver here, there are
already some other modules in the same line anyway...

