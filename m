From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: dracut
Date: Tue, 26 Oct 2010 13:23:01 +0200
Message-ID: <1288091666-sup-5419@etiriah>
References: <4CBDA328.40401@googlemail.com> <4CC17713.4030504@googlemail.com> <4CC6B6E5.50402@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256"; boundary="=-1288092182-56383-17531-2317-9-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4CC6B6E5.50402-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1288092182-56383-17531-2317-9-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Harald Hoyer's message of Tue Oct 26 13:09:25 +0200 2010:
> On 10/22/2010 01:35 PM, Mr Dash Four wrote:
> > Is it possible to build dracut for system/architecture which is diffe=
rent from
> > the host on which dracut is run?
> >
> > I have been looking through the various functions dracut provides (in=
st_binary
> > in particular) and it seems that dracut picks-up dependencies/librari=
es/kernel
> > modules and files on the host machine when building the initrd image,=
 which to
> > me indicates that the resulting initrd image is tied to the current
> > kernel/architecture on which the host is run and cross-building won't=
 be possible.
> =

> kernel/architecture, yes

But we cannot do this with Dracut itself, if Mr Dash Four was asking
about it.  We need to compile all binaries we're including for specified
architecture.  Similar tool has such a feature - Gentoo's Genkernel.
But it uses sources and compilies them specially for initramfs with
hardcoded instructions.
--
Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1288092182-56383-17531-2317-9-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQEcBAEBCAAGBQJMxroVAAoJEPATRTHh2/q14qsH/0HsaFwLyYPNL9vEK/oRnjKO
f0FyXcdkOqqYb/3PTQOVUxvr7swSBMfOfRosMDpgmiDQyWErsdEYIMO+VVXMqVKf
yvvBWzW+dNfcNOi0OVrfgRDVPslWjCHYRd4efyL6Vr+tW4b58czXo4XX8PBeB6Ma
VUk3XKv7CiF3u32PP/oPw7SB6BtRyzzJzlgQ7OUONmEXm2nq8c2BzR/1/UrkjCQX
PG1zQ/CUcJUYrkBN+P2BzI0hE4Vw20sW59p4BumL3qaLZX3H+qwVJsemqiU+E81p
2WWn5As0lCO4Ual7XIAsNW5mKWgl/03HMDmdbeAgnDao4DlO/q7n2zIjAIY8z/E=
=kt2P
-----END PGP SIGNATURE-----

--=-1288092182-56383-17531-2317-9-=--
