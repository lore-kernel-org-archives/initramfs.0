From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Tue, 23 Jun 2009 09:31:31 +0200
Message-ID: <4A4084D3.3060705@bfh.ch>
References: <4A3B968C.5070600@bfh.ch> <20090619144705.GD2514@nostromo.devel.redhat.com> <4A3BA5EA.3020202@bfh.ch> <84DF1DC6-5F06-4D6D-91A4-56D996D229B1@gmail.com> <1245428342.32104.3.camel@lap75545.ornl.gov> <4A3F37B8.7050902@suse.de> <1245683450.3544.6.camel@obelisk.thedillows.org> <4A3FAE9E.5000201@bfh.ch> <1245691069.3875.11.camel@lap75545.ornl.gov> <4A3FD1C5.30006@bfh.ch> <1245704521.3875.31.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245704521.3875.31.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

David Dillow wrote:
[snip]
> To check any of these, you'll need a separate utility. bash
> has /dev/tcp/IP/port redirection, but I doubt dash supports that. And
> even then you'll have some klunky trickery in the shell script to add a
> timeout to it. Nor will you be able to work with anything over UDP.
> 
> I think that checking an IP is reachable is sufficient to verify that
> traffic is flowing -- and we have choices there. We can use the server
> IP if it is local, and the gateway IP if not. If we're concerned about
> firewalls blocking ICMP, we could use 'arping' to send ARP requests. If
> there's a way to kick off an arp request with 'ip' or something in /proc
> or /sys, that'd avoid additional bloat, but I'm not aware of one.

Ha! You're brilliant. I completely forgot about ARP.

Including arping isn't such a bad idea. First of all, I tried using
arping to solve the problem some years ago but busybox' arping didn't
have the options required, iputils' arping does. Second, we should
include it anyway since doing DAD in dhcp-script isn't such a bad idea.

Now, I'd use the gateway for detection if possible. But if it isn't 
available, how to guess the server? That logic currently resides in
the root-handlers/-parsers and I'd prefer not to have the root-handler
do the checking.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
