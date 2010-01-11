From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [dracut] Loading of modules that don't have a uevent or pci	device:
 ideas?
Date: Mon, 11 Jan 2010 16:40:14 +0100
Message-ID: <4B4B465E.4000308@suse.de>
References: <20091221212600.GA7132@phenom.dumpdata.com> <4B30D79F.9080506@redhat.com> <20091222152221.GC2785@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091222152221.GC2785-6K5HmflnPlqSPmnEAIUT9EEOCMrvLtNR@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Konrad,

Konrad Rzeszutek Wilk wrote:
> On Tue, Dec 22, 2009 at 03:28:47PM +0100, Harald Hoyer wrote:
>> On 12/21/2009 10:26 PM, Konrad Rzeszutek Wilk wrote:
>>> Hey Harald and initramfs mailing list,
>>>
>>> I am working on de-coupling a lot of Xen modules from the PV-OPS
>>> kernel (git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen.gi=
t)
>>> so that it is not neccessary to have them compiled in.
>>>
>>> I've gotten to the point that all of the drivers (fbfront, kbdfront=
,
>>> netfront, blkfront, pcifront) can be loaded on demand. Some of them
>>> can't be unloaded (still working on that).
>>>
>>> The next stage is to make the loading automatic, and detect if the =
kernel
>>> is running under Xen (PV) and if so load the neccesssary modules.
>>>
>>> To solve that, my thought was to:
>>>
>>> a) Write udev rules that would be act up if the kernel emitted such
>>> rules. But the kernel does not emit any uevents for this purpose an=
d
>>> it does not emit any virtualization ones until the virtualization m=
odules
>>> are loaded.  I could write up code that would emit this
>>> information and be generic enough that it would do so for anything
>>> that uses the paravirt strutures. So basically a SysFS interface fo=
r
>>> the paravirt interface.
>>>
>>> b) Or utilize xen-detect and load the appropiate modules if we are
>>> running in Xen PV land. The second is by far much simpler but I don=
't
>>> know if more appropiate. I am attaching an example patch to demonst=
rate
>>> what I had in mind. (Caveat: I didn't include the pre-requisite for
>>> xen-tools yet).
>>>
>>> c). Another way? Any ideas would be much appreciated.
>>>
>> I would favor "modalias" files in /sys, which will be used to modpro=
be=20
>> the modules with the modalias.
>> Have a look at this:
>> $ find /sys -name modalias
>=20
> I think I did not explain the problem quite well. The modalias values
> appear after the modules have been loaded. I am at the situation wher=
e I am
> trying to figure out if I should load the modules or not - so the mod=
alias
> values are not present.
>=20
D'oh.

But that's exactly the wrong way round.
The sole reason for having a modalias attribute (in the device) is to f=
acilitate
module autoloading.
If the modalias attribute appears _after_ the module has been loaded yo=
u might
want to redesign the module ...

> The one option that exists right now to detect whether we are running
> under Xen is to use 'xen-detect', which I think you are OK with?
>=20
>> I am sure this could be automated in the kernel without the need of =
extra=20
>> special xen handling with scripts.
>>
>>> +xen-detect
>>> +RC=3D$?
>>> +if [ "$RC" =3D "1" ] ; then
>> why not?
>>
>> if xen-detect ; then ...; fi
>=20
> Ooh, the patches I've for xen-detect return three different return va=
lues.
> 1 for PV Xen, 2 for HVM Xen, and 0 if no Xen.
>=20
> Also xen-detect prints this out (depending on the scenario):
>=20
> Running in HVM context on Xen v4.0.
> Running in PV context on Xen v4.0.
> Not running on Xen.
>=20
> And it looks that 'if xen-detect', the if clause takes under consider=
ation
> the output - which means that on machines not running Xen it would st=
ill jump in the
> "then" clause.
>=20
> I think I am going to modify the xen-detect to accept another flag th=
at would
> just print a string if it is running in a PV context and nothing else=
- that
> should make it easier.

Easiest bit would be if there were some bits of (virtual) devices, to w=
hich the Xen
drivers could attach to. Doesn't Xen already provide something here?

What does xen-detect do?
If it's just looking at some sysfs attributes then we can easily build =
up a udev rule.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
