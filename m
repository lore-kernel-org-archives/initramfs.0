From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Mon, 22 Jun 2009 13:17:49 -0400
Message-ID: <1245691069.3875.11.camel@lap75545.ornl.gov>
References: <4A3B968C.5070600@bfh.ch>
 <20090619144705.GD2514@nostromo.devel.redhat.com> <4A3BA5EA.3020202@bfh.ch>
 <84DF1DC6-5F06-4D6D-91A4-56D996D229B1@gmail.com>
 <1245428342.32104.3.camel@lap75545.ornl.gov> <4A3F37B8.7050902@suse.de>
 <1245683450.3544.6.camel@obelisk.thedillows.org> <4A3FAE9E.5000201@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A3FAE9E.5000201-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-22 at 18:17 +0200, Seewer Philippe wrote:
> David Dillow wrote:
> > Certainly we don't want to sleep if there is no reason to... why slow
> > down the boot if the network admin has the switch nicely configured for
> > us?
> 
> What if he hasn't?

That's where this part comes in:

> > It may just be a matter of letting DHCP retry a sufficiency long time
> > before we look at the results and try to boot. As long as we don't down
> > the link after getting our information, the mount/login to the root
> > device should proceed fairly quickly. If we do down the link, the
> > blocking mode timer starts again and our very quick boot takes at least
> > 40-60 seconds.
> 
> DHCP timeout already is 60 seconds. That's dhclient's default if you
> don't provide other options.

Ok, then we just need to set the udev settle time to 60 seconds in the
event of a netroot and avoid downing the link wherever possible. Given
that timeout, the only problem cases are static configs and MTU changes
on devices that cannot do that while UP'd.

> The problem only manifests itself it we have to correct the mtu after dhcp,
> which currently set's the interface down and up (paranoia I guess), or if
> we do static configuration.
>
> For dhcp the solution could be easy: Either we ignore the mtu or don't 
> down/up the interface to set it.

We shouldn't ignore the MTU, and we generally have to down/up the
interface to set it. Certainly, we should try to set it without downing
the interface, and fall back to the down/set/up sequence if that fails.
That would avoid further delay when good hardware/drivers allows it.

In the event of static config, or needing to down/up, I think it makes
sense to try to ping the server for a period of time and see if we are
able to communicate, before we try to get our root. You had even
suggested something similar some time back with your original network
scripts.

But that's not a 'sleep 60' just because we may happen be on a network
with a long blocking state. Perhaps I misread what we're talking about
and we're on the same page.

> > So, should we give dhclient 45-60 seconds to do its thing, and the admin
> > can use ip= lines to disable interfaces we know aren't going to get a
> > response?
> 
> Disabling interfaces is not needed I think. If you know which interfaces
> are used/not used, you just tell dracut which interface(s) to use. All
> other interfaces will be ignored.

That's what I meant by disabling.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
