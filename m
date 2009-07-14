From: Doug Ledford <dledford@redhat.com>
Subject: Re: RFC: mdadm and bringing up raid sets from initrd (dracut)
Date: Tue, 14 Jul 2009 09:39:43 -0400
Message-ID: <1955210A-EF27-479F-8C58-BA4FA9018A56@redhat.com>
References: <4A5C6501.3080607@redhat.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-87-836127628"
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <4A5C6501.3080607@redhat.com>
Sender: linux-hotplug-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: initramfs <initramfs@vger.kernel.org>, linux-hotplug@vger.kernel.org, "Danecki, Jacek" <jacek.danecki@intel.com>, Harald Hoyer <harald@redhat.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-87-836127628
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

On Jul 14, 2009, at 6:59 AM, Hans de Goede wrote:
> Hi,
>
> As you probably know I'm working on making Fedora 12 use mdraid
> instead of dmraid for Intel BIOS-RAID setups.
>
> The installer (anaconda) part is mostly done (needs more testing)
> and now I'm looking at implementing support for this in dracut
> (the new mkinitrd for Fedora 12).
>
> So I've been testing how this works for both imsm mdraid sets
> and native mdraid metadata sets, in both cases using a 2 disk
> mirror, so that the set can also be brought up in degraded mode.
>
> Currently the udev rules use incremental assembly like this:
> mdadm -I /dev/mdraid-member

Hmmm...does dracut use udev during initramfs time?  mkinitrd didn't,  
so this would be a change.  In particular, I didn't have these  
problems with mkinitrd because I didn't use udev rules in the initrd,  
I ran mdadm -A instead.  In fact, the F11 method of bringup of raid  
devices is as such:

initrd: use mdadm -As --run <mddevice name with matching ARRAY entry  
in /etc/mdadm.conf>
rc.sysinit: use mdadm -As --run (no md device name, which means all  
arrays listed in mdadm.conf will get brought up, plus extra arrays not  
listed in mdadm.conf but which can be found and identified by metadata)
udev: in 65-md-incremental.rules use mdadm -I <block device> (but only  
if /dev/.in.rcsysinit does not exist, so we don't run udev incremental  
rules until after the system is up and running, which means for hot  
plugged devices...in particular we will never run the udev rule on any  
device that was present on boot, instead the previous two calls will  
catch these devices, and those previous calls will run degraded  
arrays, this allows me to safely refuse to run degraded arrays in the  
udev rules file without risking failing to boot, instead a degraded  
hot plugged array will need minor manual intervention, but the system  
will be fully up and operational no matter what)

I find this setup to be a rather safe, conservative way of handling md  
raid array hot plug.  Are we going to be totally changing this with  
dracut and F12?  This method very nicely resolves the issues you posted.

> There are 2 problems with this:
> 1) When doing this for native mdraid metadata arrays, if only
>   one disk is present the set never gets activated
> 2) When doing this for imsm metadata arrays, as soon as the
>   first disk is incrementally added, the set gets activated
>   in degraded mode and stays that way, the second disk
>   will get added to the container, but not to the actual
>   sets in the container
>
> And these 2 problems have 2 different solutions:
> 1) An incomplete, but potentially activatable in degraded mode
>   set can be activated using mdadm --run /dev/md#
> 2) One can stop this problem by using:
>   mdadm -I --no-degraded /dev/mdraid-member
>   instead (this does not change anything for
>   native mdraid metadata format sets)
>   But if that is done, the sets in the container never get
>   activated, this can be fixed by running
>   mdadm -I /dev/md# on the container device
>
> So my proposed solution for this is when udev is done scanning
> (when the event queue is empty, detected using the same mechanism as
> dracut is using for dmraid), do the following:
>
> For each /dev/md#
>  run mdadm --export --detail, and get the MD_LEVEL
>  if MD_LEVEL == "container":
>    mdadm -I /dev/md#
>  else
>    mdadm --run /dev/md#
>
> This will:
> 1) Bring up raid sets inside containers (such as imsm raidsets)
> 2) Bring up incomplete raid sets in degraded mode where possible
>
> I'll post a patch implementing this later today.
>
> Regards,
>
> Hans


--

Doug Ledford <dledford@redhat.com>

GPG KeyID: CFBFF194
http://people.redhat.com/dledford

InfiniBand Specific RPMS
http://people.redhat.com/dledford/Infiniband





--Apple-Mail-87-836127628
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)

iEYEARECAAYFAkpcip8ACgkQQ9aEs6Ims9gFrwCeJaRTPjU7ApfT8BYGqTnfG7nI
4hAAn2KsTrkPLCmdhePBtj9pqF7tAa+b
=nFUK
-----END PGP SIGNATURE-----

--Apple-Mail-87-836127628--
