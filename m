From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH 2/7] auto setup network without netroot
Date: Mon, 06 Feb 2012 01:45:22 -0500
Message-ID: <1328510722.10153.13.camel@obelisk.thedillows.org>
References: <20120202075952.GA12412@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120202075952.GA12412-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Thu, 2012-02-02 at 15:59 +0800, Dave Young wrote:
> Current dracut network only will be setup when netroot is used. But there are
> some cases we need network even without netroot. For example kdump will need
> copy vmcore to remote machine via scp or nfs mount. OTOH, if we use dracut as
> a recovery system the network is helpful even root is not a network device.
> 
> This implementation is based on the manually bring up method. Here add a kernel
> cmdline argument rd.neednet. If rd.neednet is set dracut will bring up network
> with ifup $INTERFACE -m. If netroot is used we still keep original behavior.

I'm sorry to keep pitching comments over the fence and running off, but
$DAYJOB is keeping me busy these days.

As one of the guys behind the netroot code -- though it's been a long
while since I've been active on it -- I think you're trying to bandaid
your needs on top of it, when restructuring is probably needed. We
didn't really consider other modules needing network access before the
root is mounted, so there is a bit of melding of the steps.

I think you'd have a much cleaner solution splitting out the
configuration of the network from the network root handling. Both
netroot and kdump could then signal that they need network services, and
you could handle it as it is now -- use ip= if available, fall back to
dhcp. If no NIC is specified, we try all of them until we can talk to
our {root,kdump} server. Cong Wang is correct, I seen no reason to add
new command line arguments.

It's been years since I've really been involved, so I suspect the
netroot code is due for a cleanup anyway.


