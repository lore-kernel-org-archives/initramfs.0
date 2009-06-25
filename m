From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Thu, 25 Jun 2009 00:37:38 -0400
Message-ID: <1245904658.22064.31.camel@obelisk.thedillows.org>
References: <4A3B968C.5070600@bfh.ch>
	 <20090619144705.GD2514@nostromo.devel.redhat.com> <4A3BA5EA.3020202@bfh.ch>
	 <84DF1DC6-5F06-4D6D-91A4-56D996D229B1@gmail.com>
	 <1245428342.32104.3.camel@lap75545.ornl.gov> <4A3F37B8.7050902@suse.de>
	 <1245683450.3544.6.camel@obelisk.thedillows.org> <4A3FAE9E.5000201@bfh.ch>
	 <1245691069.3875.11.camel@lap75545.ornl.gov> <4A3FD1C5.30006@bfh.ch>
	 <1245704521.3875.31.camel@lap75545.ornl.gov> <4A4084D3.3060705@bfh.ch>
	 <1245773764.11486.21.camel@lap75545.ornl.gov>  <4A41CE20.5000809@bfh.ch>
	 <1245900638.22064.24.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245900638.22064.24.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

[ Hannes, Victor, Bill: I'm loathe to cut cc's normally, but if this
discussion doesn't interest you, let me know privately and I'll trim you
from my future messages on it. ]

On Wed, 2009-06-24 at 23:30 -0400, David Dillow wrote:
> /sbin/netroot:
> # Source netroot hooks before we start the handler
> source_all netroot
> 
> That would become the validity check above.

Hmm, that source_all is vestigial, I think.

This is the loop I'm thinking of:

# Figure out the handler for root=dhcp by recalling all netroot cmdline 
# handlers
if [ "$netroot" = "dhcp" ] ; then
[snip]
    for f in ./cmdline/90*.sh; do
        [ -f "$f" ] && . "$f";
    done
fi

This could go away modulo the NFS issue I mentioned.


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
