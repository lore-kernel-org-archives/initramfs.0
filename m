From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Mon, 22 Jun 2009 18:06:43 +0200
Message-ID: <4A3FAC13.8040009@bfh.ch>
References: <4A3B968C.5070600@bfh.ch> <20090619144705.GD2514@nostromo.devel.redhat.com> <4A3BA5EA.3020202@bfh.ch> <84DF1DC6-5F06-4D6D-91A4-56D996D229B1@gmail.com> <1245428342.32104.3.camel@lap75545.ornl.gov> <4A3F37B8.7050902@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3F37B8.7050902-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hannes Reinecke wrote:
> David Dillow wrote:
>> On Fri, 2009-06-19 at 11:08 -0500, Victor Lowther wrote:
>>> Or you can include ethtool and check every half second until a timeout  
>>> to see if the link is back.
>> With most switches, you'll get a link back almost immediately, but it
>> will be in blocking mode and won't transmit your packets for 20-30
>> seconds.
> 
> <And a huge grin spreads over my face>
> Finally. I'm not alone anymore:-)
> (I have been fighting the STP issue for years now.)

You can say that loud. Over the years I've tried various solutions,
from sleeping, to catching states via netlink, to guessing STP
timeouts (on newer switches probability of RSTP-like behaviour is
95%) to your mentioned ping... 

> No, no, no. You don't want to add 'just' a sleep here because things
> don't work as expected. Certainly not in this case.

Sleep isn't a good solution, I agree there. But it's simple.
Hence the RFT to see if someone can construct a real life case
where it actually isn't enough.

> The problem here is that most programs don't / can't distinguish
> between an EHOSTUNREACH during startup (where we should retry as
> the link / connection might not be up yet) and an EHOSTUNREACH
> during normal operation (where we should return the error as this
> is a genuine error condition).
> 
> The only safe way here is to send a ping to the host port we're
> trying to connect to, and limit this with a timeout.
> And start up the command once the ping succeeds.
> Otherwise timeout and start error recovery.

Yes. If we know that 1) We're using the correct interface and
2) provided server data is correct. Otherwise we just unnecessary
lengthen to boot process.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
