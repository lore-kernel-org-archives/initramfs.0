From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: RFC: mdadm and bringing up raid sets from initrd (dracut)
Date: Wed, 15 Jul 2009 11:47:07 -0700
Message-ID: <e9c3a7c20907151147q3e48e681ufd0916f6e4e390c4@mail.gmail.com>
References: <4A5C6501.3080607@redhat.com>
	 <1247581847.1991.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Ym0e+Ot0vn6zCL+/lw0bXRWZSLB4apwrYEd+6A1Ox3A=;
        b=vN0/Q5+3fyoL67kjLVTTC7sfhtnGF+DTl/Rzan32/7Quy5p8MR6ChSUy0ed6HHPMUM
         m4WOuLAloHeCrfwTJ4d0Obi4/F9VdZE53PpuWZNBADoF1Gva/8cZ/hVGyaBnK10mktDT
         IS4vbYmwaZjxdzN6AZbqrqBDEIwqQcRr1+Nh0=
In-Reply-To: <1247581847.1991.16.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Zeuthen <david-o55+BOBDEFg@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Ledford <dledford-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

[ Cc: Neil ]

On Tue, Jul 14, 2009 at 7:30 AM, David Zeuthen<david-o55+BOBDEFg@public.gmane.org> wrote:
> On Tue, 2009-07-14 at 12:59 +0200, Hans de Goede wrote:
>> Currently the udev rules use incremental assembly like this:
>> mdadm -I /dev/mdraid-member
>>
>> There are 2 problems with this:
>> 1) When doing this for native mdraid metadata arrays, if only
>> =A0 =A0 one disk is present the set never gets activated
>> 2) When doing this for imsm metadata arrays, as soon as the
>> =A0 =A0 first disk is incrementally added, the set gets activated
>> =A0 =A0 in degraded mode and stays that way, the second disk
>> =A0 =A0 will get added to the container, but not to the actual
>> =A0 =A0 sets in the container
>
> FWIW, this incremental assembly business in mdadm is actually not a v=
ery
> good idea. At least not the current implementation. I'm not sure whet=
her
> it's still a Fedora-ism or whether it's something that's in upstream
> mdadm yet. I'm talking about this udev rule
>
> =A0/lib/udev/rules.d/65-md-incremental.rules:
> =A0# This file causes block devices with Linux RAID (mdadm) signature=
s to
> =A0# automatically cause mdadm to be run.
> =A0# See udev(8) for syntax
>
> =A0SUBSYSTEM=3D=3D"block", ACTION=3D=3D"add", ENV{ID_FS_TYPE}=3D=3D"l=
inux_raid_member", \
> =A0 =A0 =A0 =A0IMPORT{program}=3D"/sbin/mdadm --examine --export $tem=
pnode", \
> =A0 =A0 =A0 =A0RUN+=3D"/bin/bash -c '[ ! -f /dev/.in_sysinit ] && mda=
dm -I $env{DEVNAME}'"
>
> For example if the user plugs in a random old disk that happens to
> contain half of a RAID1 mirror, then the incremental assembly bits se=
ts
> up an inert md-device and the user is now left to his own devices as =
to
> sort this out when he's told by partitioning tools etc. that the disk
> (or partition of) he just plugged in, is "busy" (it is claimed by the
> inert md node).
>
> I actually had to add some extra code to the GNOME Disk Utility bits =
to
> handle such things (stop inert md devices) - makes the user experienc=
e
> quite a bit worse since there's now an extra state to worry about. An=
d
> most current users don't use the UI bits yet for this so they get ext=
ra
> confused when trying to use e.g. parted(8) or fdisk(8) on the device.
>
> FWIW, I'd wish people would stop playing games like this. If you want=
 to
> do auto-assembly at the system-level, at the very least don't leave t=
he
> system in a state like this. For example, one way to do auto-assembly
> without such bugs would be to use libudev to enumerate all md compone=
nt
> devices with the same MD_UUID. Then you count the number of component=
s
> and only start the array if the number of components equals MD_DEVICE=
S.
> That's much better than incrementally adding to an md device node tha=
t
> might never get used.
>
> I've complained to Doug about this already for Fedora but, since it's
> still broken and, AFAICT, up it's way to upstream mdadm, it's worth
> reiterating the complaint.
>
> Thanks,
> David
>
> [1] : And, except for booting, it's not clear to me that you want to
> have policy like auto-assembling RAID arrays at the system. I'd leave
> such policy to desktop bits where the user can control it and the
> software can actually interact with the user. And where it's easy to
> turn off features like this.
>

mdadm-3.0 has facilities to prevent assembly of certain metadata types
[1] or arrays with certain uuids [2].  I wonder if we also need a
facility to prevent auto-assembly of arrays *not* listed in
mdadm.conf?  So the mdadm.conf file installed in the initramfs would
only identify the root array and all other randomly identified md
devices would be ignored (rather than assembled with a foreign name).

Thoughts?

Thanks,
Dan

[1]: http://neil.brown.name/git?p=3Dmdadm;a=3Dcommitdiff;h=3D31015d57
[2]: http://neil.brown.name/git?p=3Dmdadm;a=3Dcommitdiff;h=3D112cace6
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
