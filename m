From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Mon, 22 Jun 2009 18:17:34 +0200
Message-ID: <4A3FAE9E.5000201@bfh.ch>
References: <4A3B968C.5070600@bfh.ch>	 <20090619144705.GD2514@nostromo.devel.redhat.com> <4A3BA5EA.3020202@bfh.ch>	 <84DF1DC6-5F06-4D6D-91A4-56D996D229B1@gmail.com>	 <1245428342.32104.3.camel@lap75545.ornl.gov>  <4A3F37B8.7050902@suse.de> <1245683450.3544.6.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245683450.3544.6.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

David Dillow wrote:
> On Mon, 2009-06-22 at 09:50 +0200, Hannes Reinecke wrote:
>> David Dillow wrote:
>>> On Fri, 2009-06-19 at 11:08 -0500, Victor Lowther wrote:
>>>> Or you can include ethtool and check every half second until a timeout  
>>>> to see if the link is back.
>>> With most switches, you'll get a link back almost immediately, but it
>>> will be in blocking mode and won't transmit your packets for 20-30
>>> seconds.
>> <And a huge grin spreads over my face>
>> Finally. I'm not alone anymore:-)
>> (I have been fighting the STP issue for years now.)
> 
> Yep, portfast is your friend if you have any control over your
> network...
> 
>> No, no, no. You don't want to add 'just' a sleep here because things
>> don't work as expected. Certainly not in this case.
> 
> Certainly we don't want to sleep if there is no reason to... why slow
> down the boot if the network admin has the switch nicely configured for
> us?

What if he hasn't?

> It may just be a matter of letting DHCP retry a sufficiency long time
> before we look at the results and try to boot. As long as we don't down
> the link after getting our information, the mount/login to the root
> device should proceed fairly quickly. If we do down the link, the
> blocking mode timer starts again and our very quick boot takes at least
> 40-60 seconds.

DHCP timeout already is 60 seconds. That's dhclient's default if you
don't provide other options.

The problem only manifests itself it we have to correct the mtu after dhcp,
which currently set's the interface down and up (paranoia I guess), or if
we do static configuration.

For dhcp the solution could be easy: Either we ignore the mtu or don't 
down/up the interface to set it.

> So, should we give dhclient 45-60 seconds to do its thing, and the admin
> can use ip= lines to disable interfaces we know aren't going to get a
> response?

Disabling interfaces is not needed I think. If you know which interfaces
are used/not used, you just tell dracut which interface(s) to use. All
other interfaces will be ignored.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
