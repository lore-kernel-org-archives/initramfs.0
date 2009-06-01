From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC PATCH 7/9] netroot: add common handler for network root
 devices
Date: Mon, 01 Jun 2009 07:02:54 -0400
Message-ID: <1243854174.3844.133.camel@obelisk.thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
	 <7d7efa4a3d959a5f834cd1d5e73c1e15112aa77c.1243833882.git.dave@thedillows.org>
	 <4A23985C.9040509@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A23985C.9040509-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 10:59 +0200, Seewer Philippe wrote:
> David Dillow wrote:
> > +if [ -z "$root" ]; then
> > +    root=dhcp
> > +fi
> 
> Is this really necessary? I mean if no root option is supplied, we don't 
> really know if dhcp is really desired or the default /dev/sda1 fallback 
> should be used.

I tend to think that any default root= needs to go -- a quick glance
through nash's source code doesn't seem show a default root device
there. In this case, we'd only default to dhcp if the network module is
included.

> I'd suggest to only ever do netroot if the user explicitely requests it. 
> This would include disabling all network related udev scripts if we 
> don't want netroot.

This happens if you don't include the network module, or specify a root=
line that doesn't require the network. In that case we just exit early
from ifup and never do any configuration.

> > -if [ "$root" = "dhcp" -a -z "$ip" ]; then
> 
> Hmmm... Weird configuration: What do we do if root=dhcp and the ip 
> options contain's non-dhcp related stuff? (Never thought of that before)

Currently, I use the ip= lines as an override on what we get back from
DHCP. If you specify enough info, no DHCP is used.

> > +# Run the handler; don't store the root, it may change from device to device
> > +# XXX other variables to export?
> > +export NEWROOT
> > +if $handler $netif $root; then
> > +    >/tmp/netroot.done
> > +fi
> > +exit 0
> 
> Question 1: Is it really necessary to have each handler implements it's 
> own mount-call? I don't know about iSCSI but isn't it usually just a 
> matter of setting fstype, options and source? I think this could be 
> generalized.

In the case of network-block-device, I'd like to be able to use the
existing block udev handlers. NFS root can mount itself.

> Question 2: How do plan to loop over mount-scripts? As you described if 
> might be desirable to retry mounting if the server is overloaded. I see 
> a few problems there if we loop inside netboot/handler-scripts: We could 
> be trying to mount on the wrong interface.

The loop over the mount-scripts seems to be vestigial -- we mount block
root via udev now. I haven't thought too hard about how to handle the
fail loop for netboot, but I figure it would either just walk the list
of network interfaces and send uevents, or just do another udevadm
trigger and settle pair.

Speaking of which, at some point the network root stuff is going to want
to be able to change the settle timeout. 


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
