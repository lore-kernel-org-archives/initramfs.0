From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC ONLY 3/5] netroot: remove netif from handler invocation
Date: Mon, 06 Jul 2009 12:06:05 -0400
Message-ID: <1246896365.24010.14.camel@lap75545.ornl.gov>
References: <cover.1246656269.git.dave@thedillows.org>
 <44494af931ad839908cb4542f7c35ae59a4ef65e.1246656269.git.dave@thedillows.org>
 <4A520291.7010203@bfh.ch> <1246891382.24010.6.camel@lap75545.ornl.gov>
 <4A521208.2050605@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A521208.2050605-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2009-07-06 at 17:02 +0200, Seewer Philippe wrote:
> David Dillow wrote:
> > On Mon, 2009-07-06 at 15:56 +0200, Seewer Philippe wrote:
> >> Discussion: Instead of implementing the dhcp options server failover
> >> just for nfs, why not extend this to all protocols?
> > 
> > This does implement it for all protocols, if they choose to use it.
> 
> Yes, that is correct. I meant it more like, why should only nfs choose 
> to use it? We could insert the server into the root argument for each 
> handler inside netroot instead of just "delegating" it.

Sorry, I misunderstood.

I like the concept of other protocols using server_id as a fall back
when no server IP is given in their arguments (ie nbd::9000 would use
port 9000 on the DHCP server) as it makes it easier to share configs
among DHCP servers.

I suspect others will find it confusing, though.


> > $1 used to be $netif, so we'd get /tmp/iscsiroot.eth0.1234.out. Now we'd
> > get /tmp/iscsiroot.root=iscsi:..:blah.1234.out instead. Hence the
> > removal of $1.
> 
> Oh, didn't realize that. Thanks for claryfing.

If this series looks to be worth it, I'll try to do better on the commit
message regarding this point.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
