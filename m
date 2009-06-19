From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: udevadm settle timeout semantics
Date: Thu, 18 Jun 2009 22:51:24 -0400
Message-ID: <1245379884.28792.5.camel@lap75545.ornl.gov>
References: <4A3A218C.7020405@bfh.ch> <1245327385.7315.3.camel@yio.site>
 <4A3A393C.6000405@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A3A393C.6000405-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2009-06-18 at 14:55 +0200, Seewer Philippe wrote:
> This creates a problem for network configuration: If dhcp takes
> longer than 30 seconds plus the time we allow for mount fall-through,
> an emergency-shell will appear while maybe mount is happending in the
> background because dhcp succeeded.
> 
> Any thoughts?

Network booting likely needs to retry DHCP and NFS/netroot mounts if
they timeout during boot. Booting a large cluster can cause these
timeouts to occur if they overload the server and it's a real PITA to
find the machines that didn't boot properly and reboot them.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
