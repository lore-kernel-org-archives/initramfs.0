From: Scott James Remnant <scott-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>
Subject: Re: initramfs-tools stable release 0.93.3
Date: Wed, 29 Jul 2009 13:44:31 +0100
Message-ID: <1248871471.23840.50.camel@quest>
References: <20090610153017.GA19401@stro.at>
	 <1244716927.4532.34.camel@quest>  <20090725092159.GJ11967@stro.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-UckRSUbGVxFMmluMf/FZ"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090725092159.GJ11967-U9r9yeDMy7A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org


--=-UckRSUbGVxFMmluMf/FZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2009-07-25 at 11:21 +0200, maximilian attems wrote:

> On Thu, 11 Jun 2009, Scott James Remnant wrote:
>=20
> > On Wed, 2009-06-10 at 17:30 +0200, maximilian attems wrote:
> >=20
> > > hook-functions: Add i915 module for kms.
> > >=20
> > This is exactly the kind of bloat I want to avoid for the initramfs.
> > The initramfs should do one thing only, that's mount the root filesyste=
m
> > and chain load into it.
>=20
> well it is useful to resume or to load acpi modules early so boxes don't
> overheat.=20
>=20
If you don't include them in the initramfs, your initramfs will be
smaller so quicker to load, decompress and unpack.  If you then load
them immediately after mounting the root filesystem, will they be loaded
(a) sooner or (b) later than before?

Research tends to suggest (a)


If you skip the initramfs, how are they loaded otherwise?  In some cases
they may never be loaded at all!  In others, they're loaded by udev -
which is used in the initramfs as well, so why force load them?

> also there are quite some different scenarios your root can be
> on.
>=20
While true, changing the root format is a software configuration change
not a hardware configuration change.  Changing to/from software RAID,
LVM, encrypted root, etc. is all a major enough change (including fstab,
as well as raid config files, etc.) that it's ok to need to update your
initramfs to include the necessary changes.

This is very different from changing your storage controller card.
=20
> > Slimming the initramfs right down to the essentials reduces the boot
> > time by over a second!  Paradoxically, this means that the driver can b=
e
> > loaded in the real system at roughly the same time point as it would be
> > loaded in a bloated initramfs.
>=20
> well afair the intel fast boot doesn't use initramfs in the fast path
> at all
>=20
Our fast boot does use an initramfs.

Scott
--=20
Scott James Remnant
scott-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org

--=-UckRSUbGVxFMmluMf/FZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpwRC8ACgkQSnQiFMl4yK5r0gCeM8WryhS20KYBt6QZQRgVxNoo
ECMAnjBPgDaaAEoOPBnjTibOKMqERRAR
=j+BY
-----END PGP SIGNATURE-----

--=-UckRSUbGVxFMmluMf/FZ--

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
