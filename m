From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Tue, 23 Jun 2009 12:16:04 -0400
Message-ID: <1245773764.11486.21.camel@lap75545.ornl.gov>
References: <4A3B968C.5070600@bfh.ch>
 <20090619144705.GD2514@nostromo.devel.redhat.com> <4A3BA5EA.3020202@bfh.ch>
 <84DF1DC6-5F06-4D6D-91A4-56D996D229B1@gmail.com>
 <1245428342.32104.3.camel@lap75545.ornl.gov> <4A3F37B8.7050902@suse.de>
 <1245683450.3544.6.camel@obelisk.thedillows.org> <4A3FAE9E.5000201@bfh.ch>
 <1245691069.3875.11.camel@lap75545.ornl.gov> <4A3FD1C5.30006@bfh.ch>
 <1245704521.3875.31.camel@lap75545.ornl.gov> <4A4084D3.3060705@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A4084D3.3060705-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, 2009-06-23 at 09:31 +0200, Seewer Philippe wrote:
> David Dillow wrote:
> [snip]
> > To check any of these, you'll need a separate utility. bash
> > has /dev/tcp/IP/port redirection, but I doubt dash supports that. And
> > even then you'll have some klunky trickery in the shell script to add a
> > timeout to it. Nor will you be able to work with anything over UDP.
> > 
> > I think that checking an IP is reachable is sufficient to verify that
> > traffic is flowing -- and we have choices there. We can use the server
> > IP if it is local, and the gateway IP if not. If we're concerned about
> > firewalls blocking ICMP, we could use 'arping' to send ARP requests. If
> > there's a way to kick off an arp request with 'ip' or something in /proc
> > or /sys, that'd avoid additional bloat, but I'm not aware of one.
> 
> Ha! You're brilliant. I completely forgot about ARP.
> 
> Including arping isn't such a bad idea. First of all, I tried using
> arping to solve the problem some years ago but busybox' arping didn't
> have the options required, iputils' arping does. Second, we should
> include it anyway since doing DAD in dhcp-script isn't such a bad idea.
> 
> Now, I'd use the gateway for detection if possible. But if it isn't 
> available, how to guess the server? That logic currently resides in
> the root-handlers/-parsers and I'd prefer not to have the root-handler
> do the checking.

I've been thinking about this a bit, and I'd like to split the duties up
a bit, as I'd like to know the server IPs needed for other reasons. My
proposed split is that legacy handling -- ie nfsroot=blah to
netroot=nfs:blah conversion -- is done as it is now, and have the root
handler do syntax validation and stop, spit out the server IP(s), and do
the mount, depending on options handed to it (--validate, --servers, and
no options, respectively).

The sourced scripts could just call into their handler to do the final
validation, and netroot would get rid of its loop as it can call the
handler directly since it has the protocol field.

The only issue is handling the legacy NFS root-path options, everything
else is expected to have nfs:/nfs4:/nbd:/iscsi: or what not. I don't
think it would be the end of the world if the that handling lived in
netroot itself, as it will be the only root-path legacy handler we have.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
