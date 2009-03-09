From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: module 90kernel-modules-loaded
Date: Mon, 9 Mar 2009 13:46:29 +0100
Message-ID: <49B50FA5.5030304@bfh.ch>
References: <49B1439A.7030208@redhat.com> <20090306160822.GD10711@nostromo.devel.redhat.com> <1236361391.6517.0.camel@sentry-no.fnordovax.org> <20090306203921.GA28154@nostromo.devel.redhat.com> <49B239AF.3030609@bfh.ch> <Pine.LNX.4.64.0903091133490.9051@kenzo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0903091133490.9051-qcrbbFV08EMdmw7VdWMmteH3J2bgQ+4lG9Ur7JDdleE@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Bogdan Costescu <Bogdan.Costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Bogdan Costescu wrote:
> On Sat, 7 Mar 2009, Seewer Philippe wrote:
> 
>> That would mean adding tons of drivers and another layer of complex 
>> code to decide at runtime what parts of the initrd to run.
> 
> I could argue the same for the drivers for the block devices and their 
> tools. If the root is using NFS, there is no need for a block device 
> detection; this however is still needed for iSCSI (and possibly FCoE in 
> the future).

Exactly.

> 
> Maybe allow at build time to specify what boot drivers+tools to be 
> included ? This would certainly reduce the generic-ness of the 
> initramfs, but would also reduce the size and complexity.

dracut can already do this. I was speaking about an initrd of doom which 
would include all manners of drivers and tools to boot from/to anything.

> 
>> For net-boots I couldn't care less about boot time and the size of the 
>> initrd.
> 
> I do. When I boot 100+ cluster nodes at once from a single server, I 
> want to minimize the network traffic at a minimum, especially a part 
> that happens over UDP.

He. point taken.

> 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
