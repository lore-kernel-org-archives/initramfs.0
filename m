From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Mon, 22 Jun 2009 17:02:01 -0400
Message-ID: <1245704521.3875.31.camel@lap75545.ornl.gov>
References: <4A3B968C.5070600@bfh.ch>
 <20090619144705.GD2514@nostromo.devel.redhat.com> <4A3BA5EA.3020202@bfh.ch>
 <84DF1DC6-5F06-4D6D-91A4-56D996D229B1@gmail.com>
 <1245428342.32104.3.camel@lap75545.ornl.gov> <4A3F37B8.7050902@suse.de>
 <1245683450.3544.6.camel@obelisk.thedillows.org> <4A3FAE9E.5000201@bfh.ch>
 <1245691069.3875.11.camel@lap75545.ornl.gov> <4A3FD1C5.30006@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A3FD1C5.30006-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-22 at 20:47 +0200, Seewer Philippe wrote:
> David Dillow wrote:
> > Ok, then we just need to set the udev settle time to 60 seconds in the
> > event of a netroot and avoid downing the link wherever possible. Given
> > that timeout, the only problem cases are static configs and MTU changes
> > on devices that cannot do that while UP'd.
> 
> I'd prefer not use an absolute settle time but instead "test/wait" the
> queue. But that's a minor detail.

True, I'm just thinking that older udevs probably don't give us much
options here.

As an aside, we should keep in mind that we shouldn't wait for all of
the disks to become available if we don't have to -- I've got a few
systems with quite a few LUNs to scan, but we only need one for the
root. If it can find it and continue, then the rest can be done in
parallel later.

> Hmmm... I'm not sure that a failing 'ip set eth0 mtu xy' is an indicator
> that we have to down/set mtu/up the interface. But to be honest, the 
> hardware/driver combinations I'm able to test on seem to be working 
> without down/up.
> 
> Are there any other methods to decide if we can set the mtu on the fly?

Only by doing it. If it fails, it may be an indication that the MTU is
invalid for the device, or that it cannot be changed while the device is
up. If it is invalid, it fails then as well.

This method is a compromise; those with good hardware/drivers can use
large MTUs without taking a penalty, and it still works for those less
fortunate. Only the guys trying to set an invalid MTU pay a potentially
needless time penalty, but I'm OK with that. :)

> Actually, if I'm not mistaken STP can have a maximum timeout of 90
> seconds. Add some paranoia and you're at 100. :-)
> 
> But yes, sleep 60 is a really bad idea for impatient people like you or me.
> 
> On the other hand, I'd really prefer other solutions to "ping" (if there
> are any). Having used it myself doesn't mean I like it. First of all,
> needing another utility enlarges the initrd even more, there's a possible
> risk of having paranoid firewalls and we'd have to check the effective
> service-port which isn't possible with standard iputils-ping.

To check any of these, you'll need a separate utility. bash
has /dev/tcp/IP/port redirection, but I doubt dash supports that. And
even then you'll have some klunky trickery in the shell script to add a
timeout to it. Nor will you be able to work with anything over UDP.

I think that checking an IP is reachable is sufficient to verify that
traffic is flowing -- and we have choices there. We can use the server
IP if it is local, and the gateway IP if not. If we're concerned about
firewalls blocking ICMP, we could use 'arping' to send ARP requests. If
there's a way to kick off an arp request with 'ip' or something in /proc
or /sys, that'd avoid additional bloat, but I'm not aware of one.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
