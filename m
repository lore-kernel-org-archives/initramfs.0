From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Mon, 22 Jun 2009 13:22:55 -0400
Message-ID: <1245691375.3875.15.camel@lap75545.ornl.gov>
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

Just to be sure I'm coming across clearly -- I want us to work properly
if the admin hasn't configured the network nicely for us, but I do not
want us to slow down at all when he has.

My networks will be configured correctly, and I'm an impatient bastard.
I don't want to wait if I don't have to. But not everyone will have the
luxury of control of their network.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
