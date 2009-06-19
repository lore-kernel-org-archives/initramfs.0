From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Fri, 19 Jun 2009 10:47:05 -0400
Message-ID: <20090619144705.GD2514@nostromo.devel.redhat.com>
References: <4A3B968C.5070600@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A3B968C.5070600-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said: 
> While testing in our production environment, I discovered
> that the time between interface configuration and trying to mount the nfs 
> root is too short if the dhcp-server provides an mtu. Having to set a mtu 
> means that netroot
> executes 'ip link down', set's the mtu and the does
> 'ip link up' again.
>
> This results in the mount error "No route to host", because
> the network equipment has not had enough time to "shake hands". The patch 
> below adds a sleep 1 after interface configuration, to give the equipment 
> enough time.

Depending on your switch configuration, the time for the switch to start
passing traffic again on link bounce couuld be anywhere from 0.1 seconds
to 20 seconds...

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
