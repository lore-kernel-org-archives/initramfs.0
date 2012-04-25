From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount option
Date: Wed, 25 Apr 2012 18:14:53 +0200
Message-ID: <4F9822FD.1010303@redhat.com>
References: <1335167619.18028.35.camel@cr0> <4F9514E5.3010003@redhat.com> <20120423125449.GF8103@redhat.com> <1335237489.32756.8.camel@cr0> <20120424210224.GJ26708@redhat.com> <4F97C337.8040604@gmail.com> <20120425134606.GE12519@redhat.com> <4F9802CE.2030601@redhat.com> <20120425141421.GF12519@redhat.com> <4F9808A1.50206@redhat.com> <20120425150246.GG12519@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120425150246.GG12519-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 25.04.2012 17:02, schrieb Vivek Goyal:
> Problem is that I don't know all the details in kdump. Only thing user
> has told kdump is top level mount point. We don't even know that this 
> mount point is on top of multipath + iscsi + underlying network.
> 
> I was hoping that iscsi dracut module will store all the relevant 
> information when it finds a device is iscsi device and bring that
> device up in second kernel. That includes storing information about
> network card and bringing it up.
> 
> We have device traversal code in rhel6 mkdumprd but I end up duplicating
> all the code in rhel7 kdump, then it just increases the complexity
> in kdump module.
> 
> I was hoping that generic iscsi dracut-module will take care of storing
> all the info itself once it knows it has said "yes" to an iscsi device
> in check() function.
> 
> Thanks
> Vivek

Ok, here I could use some help from you guys.
