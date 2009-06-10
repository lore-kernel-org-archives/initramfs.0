From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: Netroot cmdline arguments
Date: Wed, 10 Jun 2009 08:57:47 -0400
Message-ID: <1244638667.16191.57.camel@obelisk.thedillows.org>
References: <4A2E8130.2050305@bfh.ch>
	 <1244607992.16191.33.camel@obelisk.thedillows.org>
	 <4A2F63C6.2020504@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A2F63C6.2020504-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, 2009-06-10 at 09:41 +0200, Seewer Philippe wrote:
> David Dillow wrote:
> > On Tue, 2009-06-09 at 17:35 +0200, Seewer Philippe wrote:

> >> NFS
> >> ---
> >>
> >> Preferred format:
> >> 	root=nfs[4]:[server:]path[:options]
> >>
> >> Legacy formats:
> >> 	root=/dev/nfs[4] nfsroot=[server:]path[,options]
> >>
> >> If server is unspecified it will be pulled from one of the following
> >> sources, in order:
> >> 	static ip= option on kernel command line
> >> 	DHCP next-server option
> >> 	DHCP server-id option
> >>
> >> Other formats:
> >> 	root=nfs[4]
> >> 	Plain "root=nfs" interprets DHCP root-path option as
> >> 	[ip:]path[:options] 
> >>
> >> ==> Question: I've never used/seen root=nfs before. If server-ip is
> >> missing in root-path should dhcp next-server/server-id be used?
> > 
> > root=nfs is something I did early on as a shortcut for root=/dev/nfs
> > which is supported by the kernel's nfsroot code. Similarly,
> > root={/dev/,}nfs4 is an invention to handle newer NFS versions.
> > 
> > If server-ip is missing, then it should be filled in via the server
> > argument from the appropriate ip= line, or via dhcpd
> > next-server/server-id.
> 
> Hmmm... so you say root=nfs is just a short version of root=/dev/nfs? In 
> that case the documentation isn't up to date, since (see above) root=nfs 
> says specifically that it uses dhcp root-path.

root=nfs works exactly as root=/dev/nfs works exactly as nfsroot=... it
will use DHCP root-path, and override it with the parts it can get from
the command line.

> If this is really a dracut specific "invention" I suggest we drop this.

I'd prefer to keep root=nfs as a shorthand if we keep root=/dev/nfs.
Same for root=nfs4 and root=nfs4.

But this is probably about as hard as I will argue to keep them; they
fall out easily from the legacy support.

> >> NBD
> >> ---
> >>
> >> Preferred format:
> >> 	root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]
> >>
> >> nbdopts is a comma seperated list of options to give to nbd-client
> >>
> >> Legacy formats:
> >> 	nbdroot=srv,port
> >>
> >> ==> Question: What should root= contain here? Is having no or an empty
> >> root= ok?
> > 
> > Legacy would be root=/dev/ndb[0-9]+ but Warren has suggested we drop
> > that. With my netroot= patches -- coming soon to a list near you! ;) --
> > the NBD handler will default to /dev/nbd0, or will be able to specify
> > root=LABEL=/ or root=/dev/lvm-volume/lv-name etc to use the same
> > features we get when root is on a local disk.
> 
> Hmmm... OK. The point here is that, if say nbdroot= (or iscsiroot=, 
> nfsroot=) is available, we should just ignore root= completely?

Perhaps at current, but not in the very near future -- I'm adding
support for doing proper root on LVM/LUKS when using NBD, so that will
need a root=, but it will default to root=/dev/nbd0 if it is not
present.
 
> >> ==> Question 2: The RFC specifically says hostnames or ipv6 addresses
> >> are allowed for servername. Do we have to support this?
> > 
> > I think we should, yes. IPv6 support is something we're going to want in
> > general, but it will present some challenges to our parsing schemes.
> > 
> > Perhaps we would put some limits on using IPv6 in the legacy options (no
> > ip= static config for IPv6, require the full nfs:IP:server[:,]opts
> > format, etc.)
> 
> Indeed it does. And to think further, there are two ipv6 autoconf 
> possibilities: stateless (router adviced) or stateful (dhcp6).
> 
> Legacy options should be ok, since they only contain "addresses". I'd 
> suggest to add a ip6= option for full ipv6 support later on.

Parsing nfsroot=fe80::2e0:29ff:fe34:de52:/diskless:hard,nointr is going
to be fun. :)

> As for DNS: If we use DHCP, you're correct. It's almost free. But we 
> don't have any ip= options for static configuration to set the DNS 
> Server...

Use DHCP if you want DNS support? Or do host specific and we can
use /etc/resolv.conf.

DHCP can also point us to the right LDAP server etc, but I'm not sure
that's worth the effort. Which I guess is to say I don't care enough to
implement but I wouldn't stop someone else if they did it in a clean
manner and it didn't bloat my initrd if I didn't use it.

Thanks for working on the user experience; I think that will be good for
dracut.

Dave


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
