From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Firmware assisted dump support in dracut
Date: Thu, 29 Nov 2012 11:14:48 +0100
Message-ID: <50B73598.804@redhat.com>
References: <20121128161234.GA8991@in.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121128161234.GA8991-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: mahesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Cc: Initramfs Dracut <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ananth Narayan <ananth-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>, Steven F Best <sbest-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

Am 28.11.2012 17:12, schrieb Mahesh J Salgaonkar:
> Hi Harald,
> 
> Last year I worked on adding Firmware assisted dump (fadump) support in
> PowerLinux (ppc64). This feature is now accepted upstream Linux kernel and the
> documentation is available at http://lwn.net/Articles/488132/
> 
> Like kdump, fadump also exports the memory dump through /proc/vmcore in ELF
> format. This enables us to reuse the existing kdump infrastructure for dump
> capture and filtering. However, unlike kdump, fadump does not use kexec-based
> approach, instead it depends on Power firmware to preserve the memory dump and
> reboot into new kernel. This is what happens in fadump after crash:
> 
> 1. At the crash, kernel informs power firmware that kernel has crashed.
> 2. Firmware takes the control and reboots the entire system preserving only the
> memory (resets all other devices).
> 3. The reboot follows the normal booting process (non-kexec).
> 4. The boot loader loads the default kernel and initrd from /boot
> 
> I am working on integrating fadump with existing kdump infrastructure. The
> current kdump infrastructure builds a separate initrd (whenever there is a
> change detected in kdump config file /etc/kdump.conf) which then gets loaded
> into memory by kexec tool for use by kdump kernel. But, in the fadump approach,
> the second kernel (after crash) always use the default (OS built) initramfs.
> Hence, to support fadump, change is required to introduce dump capturing steps
> in default initramfs itself. Hence the possible approaches I am looking into
> are:
> 
> 1. Rebuild the default initramfs every time when there is a change detected in
> kdump config file (/etc/kdump.conf)
>    This approach would modify existing initramfs in place. I did work on this
>    approach by enhancing mkdumprd (tool from kexec-tools package) to extract
>    and rebuild default initramfs with dump capturing steps.  After discussing
>    with Vivek Goyal, he suggested that better approach to add code to dracut
>    for rebuilding boot initramfs instead of enhancing mkdumprd.  This means
>    introducing a new dracut module that will be responsible for introducing
>    dump capture steps inside the rebuilt initramfs by pulling required modules
>    e.g. ssh, nfs etc. depending on /etc/kdump.conf
> 
>    Now the question is whether it is possible for dracut to rebuild boot
>    initramfs in place? if Yes, is there any issues in rebuilding of boot
>    initramfs everytime when there is a change in /etc/kdump.conf?

dracut is called by /sbin/new-kernel-package. dracut is not a service, which is
run on every boot. So, no, dracut can't watch files and build an initramfs on
itsself.

Of course such a service could be created and create the initramfs on shutdown,
if any of the files, which should be watched, have changed.

This of course is a dangerous automatism, which might as well lead to a
unbootable system. Further steps (with grubby) would have to make sure, the last
bootable entry is still there, along with the last kernel version.

I was already thinking about creating such a monster, but this would involve to
reinvent the current /sbin/new-kernel-package / grubby infrastructure, which has
to be done anyway in the next years. The first step was to create a common
configuration file format for all the bootloaders, which they parse and display.

http://harald.fedorapeople.org/downloads/boot-unification.pdf
A simple boot manager parsing the config layout as a reference implementation:
http://freedesktop.org/wiki/Software/gummiboot

Next step is to patch grub2 to parse those config files and display the menu
entries.

Next step is to enhance /sbin/new-kernel-package and obsolete grubby.

Then, I think we are ready to create such a service.

> 
> 2. Make dracut tool fadump aware and it will build fadump aware initrd (default
> OS initrd) during kernel install. Once built, this initrd should never be
> rebuilt again. Which means the default initramfs will contain vmcore capture
> steps. This approach would pack all possible dracut modules (nfs, ssh, bonding
> etc.) so that the default initrd will be capable of supporting all possible
> dump target. Hence this approach will bloat the initramfs. On my Power test
> system, the size of the default initrd generated without any changes is 16M.
> With the above approach this size jumps to 27M.

Yeah, this is crazy.

> 
> Since both the above approaches would require changes to dracut package, I would
> like to know your views on above approaches.
> 
> Thanks,
> -Mahesh.
> 
