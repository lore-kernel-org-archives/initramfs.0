From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Wed, 07 Jan 2009 17:14:18 +0100
Message-ID: <4964D4DA.70102@suse.de>
References: <1229540094.28858.150.camel@aglarond.local>	 <20081217190700.GA15377@infradead.org>  <4949FD67.6040906@suse.de> <1229631131.13174.23.camel@aglarond.local> <494B5979.3080606@suse.de> <44C50A6A-0FDB-4BF0-8B8B-CD9DAC7B7ED4@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <44C50A6A-0FDB-4BF0-8B8B-CD9DAC7B7ED4-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Jeremy,

Jeremy Katz wrote:
> On Dec 19, 2008, at 3:21 AM, Hannes Reinecke wrote:
>> Jeremy Katz wrote:
>>> (dropping lkml again)
>>> On Thu, 2008-12-18 at 08:36 +0100, Hannes Reinecke wrote:
>>> By instead moving to where we're basing everything off of uevents w=
e can
>>> hopefully move away from the massive shell scripts of doom, speed u=
p
>>> boot and also maybe get to where a more general initramfs can be bu=
ilt
>>> _with the kernel_ instead of per-system.
>> Believe me, I tried. But it's _hard_, if not impossible.
>=20
> Nothing that's easy is fun or worth spending time on :-)
>=20
Truly spoken :-)

>> One thing we should clarify, though:
>> What is the overall goal of dracut?
>> Should it create an streamlined initramfs, containing as little code
>> as possible and booting exactly on the system it was created on?
>> (IE creating a SUSE-style initramfs)
>> Or should it create a build-once-run-everywhere initramfs?
>=20
> Build-one-run-everywhere.  In fact, until yesterday, it really couldn=
't=20
> be built on the system it was to be booted on. :)
>=20
Ah.

>> If you were going with the former, you face the challenge that you
>> have to initialize the root fs _only_, and skipping all other system=
s.
>> Hence you have the challenge to include the required udev rules only=
=2E
>> And, most obviously, you have to _detect_ the root fs. And make sure
>> to configure the underlying block devices properly.
>> And suddenly you end up with zillions of bash code, just to detect t=
he
>> root fs.
>=20
> Yep.  I think we all know what this looks like
>=20
Indeed.

>> If you were to go with the build-once-run-everywhere approach, you'd
>> have the advantage that you could copy the udev configuration over.
>> And in theory you could then configure the entire system with udev.
>> Well, after someone fixed up LVM to work properly with udev, that is=
=2E
>> But the problem here is: it's quite impractical to include support
>> for every possible configuration. Normal block devices, ok.
>> LVM, MD, sure. Multipath, yes, of course. iSCSI ... yes, but,
>> should we include _all_ NIC modules? Do we even _ship_ all of them?
>> And which network modules to we need? Netfilter? VPN support?
>=20
> As my last mail said, I suspect that once we start talking about some=
 of=20
> the network boot methods, you have to "buy-in" as they do have a=20
> non-trivial cost.  Including all the network modules, though, really=20
> isn't much worse than all the storage drivers.  Actually, I think it =
was=20
> better the last time I checked.
>=20
>> So either we include _all_ kernel modules (which consume at the
>> last count 82 MByte) or make a shortcut here and there.
>> Which goes against the initial goal of the build-once-run-everywhere
>> approach.
>=20
> Well, you don't need _all_.  I've yet to come up with a convincing=20
> reason to want the sound drivers for example :)
>=20
Don't let this hear the folks from disability support :-)
=46or the same reason I've ended up having to include USB
modules as occasionally someone has to enter a password
and might have a USB keybord.

And I'm quite convinced you can find a setup for nearly
every driver included in the kernel.

And as you admitted we won't be including _all_ modules,
so we don't _actually_ support the 'built-once-run-everywhere'
approach.

So we should be focussing on the 'build-once-run-mostly-everywhere'
approach to enable the trivial systems to boot.
And add a API / Extension something for the non-trivial systems.

> And yes, everywhere is really more like everywhere(*) -- the stock=20
> config being "local block devices" but with the ability to expand out=
=20
> and support the more esoteric cases.
>=20
>> I do agree the latter approach is more appealing, but so
>> far I haven't found a proper solution for the kernel module
>> problem.
>=20
> Kernel modules compress well and modprobe supports loading gzipped=20
> modules.  That helps the size aspect at least somewhat
>=20
Agreed.

>> No, I favour a completely different approach: Link the required
>> modules into the kernel. When we run the mkinitrd prg (or whatever=20
>> it's called) to create
>> the initrd, we will be detecting the modules which are required
>> to boot the kernel and mount the rootfs.
>> If it were now possible to link these modules into the kernel
>> directly via some 'ld' magic, we could get away with loading
>> just one kernel image without any initramfs. No modprobe,
>> nothing. That would be _fast_. And we would be having the
>> advantage that we could kexec into the 'normal' boot image
>> with initramfs if this 'single shot' approach doesn't work.
>=20
> You still have to have an initramfs as you aren't going to have the=20
> logic for LVM activation in the kernel.  Or to handle resume from=20
> hibernate.  Or dm-crypt.  Etc.  So an initramfs is really something a=
kin=20
> to a requirement for non-trivial systems.  And the speed really isn't=
 a=20
> fundamental factor of dealing with an initramfs.  I was actually quit=
e=20
> surprised by how fast I was able to boot with a dracut-generated init=
ramfs
>=20
No, you don't. Those systems I'd consider non-trivial and should be han=
dled
from a 'real' initramfs.
The trivial system would be one where just loading a module will make t=
he device
appear (ie simple ATA / SCSI systems).

Once you need something more or different you'll have to use a proper i=
nitramfs.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
