From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Firmware assisted dump support in dracut
Date: Fri, 30 Nov 2012 10:31:57 -0500
Message-ID: <20121130153157.GD12982@redhat.com>
References: <20121128161234.GA8991@in.ibm.com>
 <50B73598.804@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50B73598.804-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: mahesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, Initramfs Dracut <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ananth Narayan <ananth-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>, Steven F Best <sbest-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

On Thu, Nov 29, 2012 at 11:14:48AM +0100, Harald Hoyer wrote:

[..]
> >    Now the question is whether it is possible for dracut to rebuild boot
> >    initramfs in place? if Yes, is there any issues in rebuilding of boot
> >    initramfs everytime when there is a change in /etc/kdump.conf?
> 
> dracut is called by /sbin/new-kernel-package. dracut is not a service, which is
> run on every boot. So, no, dracut can't watch files and build an initramfs on
> itsself.
> 
> Of course such a service could be created and create the initramfs on shutdown,
> if any of the files, which should be watched, have changed.
> 
> This of course is a dangerous automatism, which might as well lead to a
> unbootable system. Further steps (with grubby) would have to make sure, the last
> bootable entry is still there, along with the last kernel version.
> 
> I was already thinking about creating such a monster, but this would involve to
> reinvent the current /sbin/new-kernel-package / grubby infrastructure, which has
> to be done anyway in the next years. The first step was to create a common
> configuration file format for all the bootloaders, which they parse and display.
> 
> http://harald.fedorapeople.org/downloads/boot-unification.pdf
> A simple boot manager parsing the config layout as a reference implementation:
> http://freedesktop.org/wiki/Software/gummiboot
> 
> Next step is to patch grub2 to parse those config files and display the menu
> entries.
> 
> Next step is to enhance /sbin/new-kernel-package and obsolete grubby.
> 
> Then, I think we are ready to create such a service.

Once we create the infrastructure where we can regenerate the
initramfs, then kdump service should be able to detect change in
files and call relevant hook (new-kernel-package or whatever).

So important point here seems to be that yes we will regenrate initramfs
but we need to do it in such a way so that we retain the old bootable
kernel/initramfs around in case new initramfs fails to boot.

So this is like installing new kernel execpt the fact that there is no
new kernel. It is old kernel but new initramfs. 

> 
> > 
> > 2. Make dracut tool fadump aware and it will build fadump aware initrd (default
> > OS initrd) during kernel install. Once built, this initrd should never be
> > rebuilt again. Which means the default initramfs will contain vmcore capture
> > steps. This approach would pack all possible dracut modules (nfs, ssh, bonding
> > etc.) so that the default initrd will be capable of supporting all possible
> > dump target. Hence this approach will bloat the initramfs. On my Power test
> > system, the size of the default initrd generated without any changes is 16M.
> > With the above approach this size jumps to 27M.
> 
> Yeah, this is crazy.

In the long term being able to regenerate initramfs in response to kdump
configuration changes should prove to be a better way of doing things.

Thanks
Vivek
