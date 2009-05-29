From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: How do we want to handle configuring network boot devices?
Date: Fri, 29 May 2009 17:26:05 +0200
Message-ID: <4A1FFE8D.8050507@bfh.ch>
References: <1243126816.4217.248.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243126816.4217.248.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


David Dillow wrote:
[snip]
> Open issues:
> * How to handle authentication data for iSCSI and NFS, if at all.

NFS4 only needs authentication data if kerberized. I suggest to postpone 
this for (a lot) later. The same applies for Wireless or stuff like 802.1x.

> * How to handle unionfs/aufs mounts?
> * How to handle dm-snapshot, eg for LiveCD overlays.

Do we really have to support these two? I suggest this is something 
distributors can add with their own mount/pre-pivot modules

> * FCoE/AoE/DBRD/SRP -- I didn't search for examples on these.
> * Lustre/network filesystem du jour support -- I think these are
> possible, just need to be careful parsing things out. Not
> terribly important right now.

If we can generalize the parsing these shouldn't be a problem at all. 
Same goes with other weird cases like booting from CIFS.

> * Using the dracut URI scheme above as a strawman, shouldn't
> "root=nfs://...." imply "ip=dhcp" if none is given?

It would be user friendly, agreed. But for the sake of forceing people 
to think at least a bit I suggest to imply ip=dhcp only if root=dhcp.

> * What about multiple devices?

Must be supported.

I've previously outlined problematic cases here:
http://article.gmane.org/gmane.linux.kernel.initramfs/393

A first set of patches supporting different boot-cases is here:
http://article.gmane.org/gmane.linux.kernel.initramfs/411
http://article.gmane.org/gmane.linux.kernel.initramfs/409
http://article.gmane.org/gmane.linux.kernel.initramfs/410

The gist of it is that netif configuration needs to be synchronized so 
only one netif can be up at any one time. I'll rebase these patches on 
your work next friday.

> * How many legacy ways of doing this should we support?

As many as possible. Will make transision easier. The current 
commandline document is pretty complete I think.

Again I think this is just a matter of parsing options.

> * How do we separate options to the network block transport vs the
> filesystem mount?

To be honest, I don't quite get what you mean here.

> * How do we allow use of these features both via the cmdline and via
> DHCP?

I'd say either the cmdline is specific or it says dhcp.

> My commentary:
> * I'd like to support the legacy way of specifying this info as much as
> is reasonably possible. People are set in their ways, and it'd be nice
> if dracut could just work for them.
> * If we don't succeed in DHCPing/mounting the root on the first attempt,
> we should loop trying, with a chance for the user to break out each time
> -- think overloaded server bringing up a cluster.

I agree. Problem is if we want to loop and support multiple devices we 
can't do everything with udev since udev doesn't block operations on 
non-related devices.

Question: Anyone have a problem if network boot mount is not handled 
from udev? As much as I'd like I can't think of a sensible way to to this.

> * A modified URI scheme like the dracut suggestion may work; use opaque
> URI's like the RFC4173 iSCSI root-path, or RH mkinitrd's nbd root-path.
> We could source a specific handler for the URI type listed, making it
> simpler to add new types in the future.

That's a good idea. With keeping in line with mounting outside udev we 
could do:

loop until mounted {
   wait for network
   source all registered option handlers, setting mount-variables
   source mount-script
}
fs-specific stuff like moving rpcbind data etc can go in pre-pivot.

This is already feasible with the current mount-loop, since the mount 
script has number 99. And that way each fs-type just has to provide a 
parser-module. I guess we can provide some helper functions to wrap 
getarg and parse dhcp-options.


> * While adding vendor-specific DHCP options is not a really good idea in
> general, I see cases we may want to support that simply will not fit in
> the 255 chars available to us in root-path, or which would make parsing
> that be unnecessarily complex.

Again, simply a matter of parsing options.

> * When testing things, it is really nice to be able to override the DHCP
> config via the kernel command line when possible. It's much cleaner to
> edit a single PXE boot file (or add it via the serial console) when
> working alongside a production environment -- less to remember to revert
> (and restart!)

As suggested: use dhcp root options only if explicitely requested by the 
commandline.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
