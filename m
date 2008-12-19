From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Fri, 19 Dec 2008 12:08:05 -0500
Message-ID: <44C50A6A-0FDB-4BF0-8B8B-CD9DAC7B7ED4@redhat.com>
References: <1229540094.28858.150.camel@aglarond.local>	 <20081217190700.GA15377@infradead.org>  <4949FD67.6040906@suse.de> <1229631131.13174.23.camel@aglarond.local> <494B5979.3080606@suse.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <494B5979.3080606-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Dec 19, 2008, at 3:21 AM, Hannes Reinecke wrote:
> Jeremy Katz wrote:
>> (dropping lkml again)
>> On Thu, 2008-12-18 at 08:36 +0100, Hannes Reinecke wrote:
>> By instead moving to where we're basing everything off of uevents  
>> we can
>> hopefully move away from the massive shell scripts of doom, speed up
>> boot and also maybe get to where a more general initramfs can be  
>> built
>> _with the kernel_ instead of per-system.
> Believe me, I tried. But it's _hard_, if not impossible.

Nothing that's easy is fun or worth spending time on :-)

> One thing we should clarify, though:
> What is the overall goal of dracut?
> Should it create an streamlined initramfs, containing as little code
> as possible and booting exactly on the system it was created on?
> (IE creating a SUSE-style initramfs)
> Or should it create a build-once-run-everywhere initramfs?

Build-one-run-everywhere.  In fact, until yesterday, it really  
couldn't be built on the system it was to be booted on. :)

> If you were going with the former, you face the challenge that you
> have to initialize the root fs _only_, and skipping all other systems.
> Hence you have the challenge to include the required udev rules only.
> And, most obviously, you have to _detect_ the root fs. And make sure
> to configure the underlying block devices properly.
> And suddenly you end up with zillions of bash code, just to detect the
> root fs.

Yep.  I think we all know what this looks like

> If you were to go with the build-once-run-everywhere approach, you'd
> have the advantage that you could copy the udev configuration over.
> And in theory you could then configure the entire system with udev.
> Well, after someone fixed up LVM to work properly with udev, that is.
> But the problem here is: it's quite impractical to include support
> for every possible configuration. Normal block devices, ok.
> LVM, MD, sure. Multipath, yes, of course. iSCSI ... yes, but,
> should we include _all_ NIC modules? Do we even _ship_ all of them?
> And which network modules to we need? Netfilter? VPN support?

As my last mail said, I suspect that once we start talking about some  
of the network boot methods, you have to "buy-in" as they do have a  
non-trivial cost.  Including all the network modules, though, really  
isn't much worse than all the storage drivers.  Actually, I think it  
was better the last time I checked.

> So either we include _all_ kernel modules (which consume at the
> last count 82 MByte) or make a shortcut here and there.
> Which goes against the initial goal of the build-once-run-everywhere
> approach.

Well, you don't need _all_.  I've yet to come up with a convincing  
reason to want the sound drivers for example :)

And yes, everywhere is really more like everywhere(*) -- the stock  
config being "local block devices" but with the ability to expand out  
and support the more esoteric cases.

> I do agree the latter approach is more appealing, but so
> far I haven't found a proper solution for the kernel module
> problem.

Kernel modules compress well and modprobe supports loading gzipped  
modules.  That helps the size aspect at least somewhat

> No, I favour a completely different approach: Link the required
> modules into the kernel. When we run the mkinitrd prg (or whatever  
> it's called) to create
> the initrd, we will be detecting the modules which are required
> to boot the kernel and mount the rootfs.
> If it were now possible to link these modules into the kernel
> directly via some 'ld' magic, we could get away with loading
> just one kernel image without any initramfs. No modprobe,
> nothing. That would be _fast_. And we would be having the
> advantage that we could kexec into the 'normal' boot image
> with initramfs if this 'single shot' approach doesn't work.

You still have to have an initramfs as you aren't going to have the  
logic for LVM activation in the kernel.  Or to handle resume from  
hibernate.  Or dm-crypt.  Etc.  So an initramfs is really something  
akin to a requirement for non-trivial systems.  And the speed really  
isn't a fundamental factor of dealing with an initramfs.  I was  
actually quite surprised by how fast I was able to boot with a dracut- 
generated initramfs

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
