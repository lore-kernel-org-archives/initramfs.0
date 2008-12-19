From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Fri, 19 Dec 2008 09:21:13 +0100
Message-ID: <494B5979.3080606@suse.de>
References: <1229540094.28858.150.camel@aglarond.local>	 <20081217190700.GA15377@infradead.org>  <4949FD67.6040906@suse.de> <1229631131.13174.23.camel@aglarond.local>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1229631131.13174.23.camel-T9xAYgMuJli44ywRPIzf9A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Jeremy,

Jeremy Katz wrote:
> (dropping lkml again)
>=20
> On Thu, 2008-12-18 at 08:36 +0100, Hannes Reinecke wrote:
>> We definitely should get together to hammer our one implementation.
>> Having different scripts for every distributions is a PITA.
>=20
> Indeed -- but as davej noticed, going with one distro's implementatio=
n
> is unlikely to fly and so we need to start over
>=20
>> I'm not saying my implementation is the greatest on earth, so
>> if anyone has any better suggestions I'm all ears.
>=20
> I had actually looked at it some a couple of months ago when the
> discussion started, but it looked like the same thing that an
> initramfs/initrd has always been -- piles of shell scripts that are
> strung together based on what the system building the initramfs looks
> like.  The problem is that you then a) have a fair bit of system
> dependence in the initramfs b) spend a lot of time running shell
> scripts.=20
>=20
Granted for both points. However, I tried to get the information
from the running system by querying programs / sysfs directly and
_not_ relying on any configuration scripts. So that should alleviate
point a) slightly.
b) is, sadly, true.

> By instead moving to where we're basing everything off of uevents we =
can
> hopefully move away from the massive shell scripts of doom, speed up
> boot and also maybe get to where a more general initramfs can be buil=
t
> _with the kernel_ instead of per-system.
>=20
Believe me, I tried. But it's _hard_, if not impossible.

One thing we should clarify, though:
What is the overall goal of dracut?
Should it create an streamlined initramfs, containing as little code
as possible and booting exactly on the system it was created on?
(IE creating a SUSE-style initramfs)
Or should it create a build-once-run-everywhere initramfs?

If you were going with the former, you face the challenge that you
have to initialize the root fs _only_, and skipping all other systems.
Hence you have the challenge to include the required udev rules only.
And, most obviously, you have to _detect_ the root fs. And make sure
to configure the underlying block devices properly.
And suddenly you end up with zillions of bash code, just to detect the
root fs.

If you were to go with the build-once-run-everywhere approach, you'd
have the advantage that you could copy the udev configuration over.
And in theory you could then configure the entire system with udev.
Well, after someone fixed up LVM to work properly with udev, that is.
But the problem here is: it's quite impractical to include support
for every possible configuration. Normal block devices, ok.
LVM, MD, sure. Multipath, yes, of course. iSCSI ... yes, but,
should we include _all_ NIC modules? Do we even _ship_ all of them?
And which network modules to we need? Netfilter? VPN support?

So either we include _all_ kernel modules (which consume at the
last count 82 MByte) or make a shortcut here and there.
Which goes against the initial goal of the build-once-run-everywhere
approach.

I do agree the latter approach is more appealing, but so
far I haven't found a proper solution for the kernel module
problem.

No, I favour a completely different approach: Link the required
modules into the kernel.=20
When we run the mkinitrd prg (or whatever it's called) to create
the initrd, we will be detecting the modules which are required
to boot the kernel and mount the rootfs.
If it were now possible to link these modules into the kernel
directly via some 'ld' magic, we could get away with loading
just one kernel image without any initramfs. No modprobe,
nothing. That would be _fast_. And we would be having the
advantage that we could kexec into the 'normal' boot image
with initramfs if this 'single shot' approach doesn't work.

Oops. That was longer than expected. Anyway.

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
