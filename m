From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mount other than rootfs problem
Date: Fri, 30 Sep 2011 14:38:39 -0400
Message-ID: <20110930183839.GF25891@redhat.com>
References: <4E83DE33.4020204@redhat.com>
 <4E848C48.6050506@redhat.com>
 <4E8526A6.30003@redhat.com>
 <4E85370A.7020509@redhat.com>
 <4E853A1C.5070905@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4E853A1C.5070905-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-kdump-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Fri, Sep 30, 2011 at 11:40:12AM +0800, Dave Young wrote:

[..]
> 
> Add lvm_scan in mount-sys.sh also works, so if we can make lvm_scan
> being called automaticlly via dependencies it will be good. OTOH fstab
> is better than cmdlines as an interface for multi-target dumping

Agreed that fstab.sys looks like a good interface to mouting non-root devices.

> 
> > 
> >> So If we properly deal with the dependency issue it should be possible
> >> to resolve. There's dracut module dependency currently, but question is
> >> that is there dependency of hooks? such as make the mount-sys hook
> >> depends on the lvm setup code, is it possible with current interface?
> >>
> > 
> > I don't think so, you called 'lvm_scan' and did mount manually, lvm
> > module itself will not mount it unless you add "rd_LVM_LV=". So, this
> > a not only a problem of module dependency, but also a problem
> > of lvm module code.
> 

lv_scan.sh seems to be parsing those rd_LVM_LV command line options to
come up with list of VGs and LVs to scan for. May be some script (probably
fstab-sys module) can leave some additional files in /tmp/ which lists
additional VGs and LVs to scan for. And this will be prepared by fstab-sys
module.

This is similar to lv_scan.sh reading /tmp/.lvm_scan-* files.

> 
> Yes, agree
> 
> >For kdump, even using "rd_LVM_LV=" is not a good
> > choice, because we still need to convert the device name (or UUID) into
> > the correct kernel cmdline.
> 
> 
> not understand yet, could you help to explain or give an example?

I think what he meant was that kdump.conf allows specifying UUID or LABEL
of the device to dump to. Assuming that these can directly be specified
in fstab.sys, or fstab-kdump.sys, then logic should be able to parse the
UUIDs, LABELs, and then traverse down the stack, figure out all the
dependencies.

Thanks
Vivek
