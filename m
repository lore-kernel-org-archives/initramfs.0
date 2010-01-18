From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [dracut] Loading of modules that don't have a uevent or pci	device:
 ideas?
Date: Mon, 18 Jan 2010 10:12:30 +0100
Message-ID: <4B5425FE.7080408@redhat.com>
References: <20091221212600.GA7132@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091221212600.GA7132-6K5HmflnPlqSPmnEAIUT9EEOCMrvLtNR@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/21/2009 10:26 PM, Konrad Rzeszutek Wilk wrote:
> Hey Harald and initramfs mailing list,
>
> I am working on de-coupling a lot of Xen modules from the PV-OPS
> kernel (git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen.git)
> so that it is not neccessary to have them compiled in.
>
> I've gotten to the point that all of the drivers (fbfront, kbdfront,
> netfront, blkfront, pcifront) can be loaded on demand. Some of them
> can't be unloaded (still working on that).
>
> The next stage is to make the loading automatic, and detect if the kernel
> is running under Xen (PV) and if so load the neccesssary modules.
>
> To solve that, my thought was to:
>
> a) Write udev rules that would be act up if the kernel emitted such
> rules. But the kernel does not emit any uevents for this purpose and
> it does not emit any virtualization ones until the virtualization modules
> are loaded.  I could write up code that would emit this
> information and be generic enough that it would do so for anything
> that uses the paravirt strutures. So basically a SysFS interface for
> the paravirt interface.
>
> b) Or utilize xen-detect and load the appropiate modules if we are
> running in Xen PV land. The second is by far much simpler but I don't
> know if more appropiate. I am attaching an example patch to demonstrate
> what I had in mind. (Caveat: I didn't include the pre-requisite for
> xen-tools yet).
>
> c). Another way? Any ideas would be much appreciated.
>

pushed until the kernel can autoload those modules
