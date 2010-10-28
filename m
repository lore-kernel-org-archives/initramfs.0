From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: New rd.* namespace for dracut-008
Date: Thu, 28 Oct 2010 13:40:49 -0400
Message-ID: <20101028174048.GA2367@nostromo.devel.redhat.com>
References: <4CC99414.5060607@redhat.com>
 <4CC9AB0E.2040604@linux.vnet.ibm.com>
 <4CC9AD55.7010104@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CC9AD55.7010104-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Steffen Maier <maier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Harald Hoyer (harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) said: 
> because it's the "dasd" parameter of the dasd_mod module
> 
> one could specify it directly on the kernel command with
> "dasd_mod.dasd=", which would be honored by the module itsself. So I
> just added "rd." to indicate the sole use for the initramfs.

We don't unload and reload the module (do we?), so I don't
see how having a version that's solely for initramfs usage
makes sense here.

Bill
