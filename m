From: Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: RFC: mdadm and bringing up raid sets from initrd (dracut)
Date: Thu, 16 Jul 2009 21:09:52 +1000
Message-ID: <19039.2688.856024.360983@notabene.brown>
References: <4A5C6501.3080607@redhat.com>
	<1247581847.1991.16.camel@localhost.localdomain>
	<e9c3a7c20907151147q3e48e681ufd0916f6e4e390c4@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: message from Dan Williams on Wednesday July 15
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: David Zeuthen <david-o55+BOBDEFg@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Ledford <dledford-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wednesday July 15, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
> [ Cc: Neil ]
>=20
> On Tue, Jul 14, 2009 at 7:30 AM, David Zeuthen<david-o55+BOBDEFg@public.gmane.org> wrote:
> > On Tue, 2009-07-14 at 12:59 +0200, Hans de Goede wrote:
> >> Currently the udev rules use incremental assembly like this:
> >> mdadm -I /dev/mdraid-member
> >>
> >> There are 2 problems with this:
> >> 1) When doing this for native mdraid metadata arrays, if only
> >> =A0 =A0 one disk is present the set never gets activated
> >> 2) When doing this for imsm metadata arrays, as soon as the
> >> =A0 =A0 first disk is incrementally added, the set gets activated
> >> =A0 =A0 in degraded mode and stays that way, the second disk
> >> =A0 =A0 will get added to the container, but not to the actual
> >> =A0 =A0 sets in the container
> >
> > FWIW, this incremental assembly business in mdadm is actually not a=
 very
> > good idea. At least not the current implementation. I'm not sure wh=
ether
> > it's still a Fedora-ism or whether it's something that's in upstrea=
m
> > mdadm yet. I'm talking about this udev rule
> >
> > =A0/lib/udev/rules.d/65-md-incremental.rules:
> > =A0# This file causes block devices with Linux RAID (mdadm) signatu=
res to
> > =A0# automatically cause mdadm to be run.
> > =A0# See udev(8) for syntax
> >
> > =A0SUBSYSTEM=3D=3D"block", ACTION=3D=3D"add", ENV{ID_FS_TYPE}=3D=3D=
"linux_raid_member", \
> > =A0 =A0 =A0 =A0IMPORT{program}=3D"/sbin/mdadm --examine --export $t=
empnode", \
> > =A0 =A0 =A0 =A0RUN+=3D"/bin/bash -c '[ ! -f /dev/.in_sysinit ] && m=
dadm -I $env{DEVNAME}'"
> >
> > For example if the user plugs in a random old disk that happens to
> > contain half of a RAID1 mirror, then the incremental assembly bits =
sets
> > up an inert md-device and the user is now left to his own devices a=
s to
> > sort this out when he's told by partitioning tools etc. that the di=
sk
> > (or partition of) he just plugged in, is "busy" (it is claimed by t=
he
> > inert md node).
> >
> > I actually had to add some extra code to the GNOME Disk Utility bit=
s to
> > handle such things (stop inert md devices) - makes the user experie=
nce
> > quite a bit worse since there's now an extra state to worry about. =
And
> > most current users don't use the UI bits yet for this so they get e=
xtra
> > confused when trying to use e.g. parted(8) or fdisk(8) on the devic=
e.
> >
> > FWIW, I'd wish people would stop playing games like this. If you wa=
nt to
> > do auto-assembly at the system-level, at the very least don't leave=
 the
> > system in a state like this. For example, one way to do auto-assemb=
ly
> > without such bugs would be to use libudev to enumerate all md compo=
nent
> > devices with the same MD_UUID. Then you count the number of compone=
nts
> > and only start the array if the number of components equals MD_DEVI=
CES.
> > That's much better than incrementally adding to an md device node t=
hat
> > might never get used.

Yes:  auto-assembly is hard, and easy to get wrong.

While I don't claim that the current scheme is at all perfect, I don't
think your suggestion is a clear improvement.
The whole point of RAID is to survive drive failure, and that includes
drives being missing.
So I don't think "completely ignore the array if not all expected
drives are present" is the correct answer.

It is very easy to remove unwanted raid metadata=20
(mdadm --zero-superblock), and making that easily accessible from a
GUI would probably be a good and useful thing, and might solve some
problems for some people.

One thing that I have contemplated is for md to not claim exclusive
ownership of drives until the array is activated and switch to
read-write.  That would address the 'my drive was stolen by md'
problem, but it may well create other problems in its place.

My general goal at present is to make mdadm sufficiently flexible that
a distro can choose a suitable policy implement it.  If someone comes
up with a policy that works convincingly well, I could then make that
the default approach that mdadm takes.
There is certainly still room for improvement and I am happy to
discuss possibilities.

NeilBrown

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
