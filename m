From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 1/2] dracut: create ldconfig aux cache directory on the initrd
Date: Tue, 07 Dec 2010 10:49:58 +0100
Message-ID: <1291715126-sup-971@ittemni>
References: <1291686260-32371-1-git-send-email-christian.ch.heinz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256"; boundary="=-1291715398-656634-10735-4655-1-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1291686260-32371-1-git-send-email-christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1291715398-656634-10735-4655-1-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Excerpts from Christian Heinz's message of Tue Dec 07 02:44:19 +0100 2010=
:
> This will allow ldconfig to create its auxiliary cache file in order to=

> prevent `ldconfig -r' from failing completely when dracut is run as
> non-root. Applies to glibc/ldconfig versions released before Nov 22,
> 2010.

What is the benefit of "falling partially" over "falling completely".
I'm wondering if there shouldn't be check if dracut is run by non-root
and then exit immediately.  Normal user cannot read some files (e.g.
/bin/mount), so what's the point?


Cheers,
-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1291715398-656634-10735-4655-1-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQEcBAEBCAAGBQJM/gNGAAoJEPATRTHh2/q1Jo0H/0hp4npB3wFillaTWbu08saa
G3ZaFyl4CV6B/8mPYmfFw5yKiDDwvWmA9VCJaorGo/VnZYfFu/+if6tKpi3ksfLK
vGDHqt2sLg7WqUCkdvD4B98kb1IHaIYgCnot3tR68itCmOuLZ4HuA8hUD9AXi/nb
GSBXUo539cTHsqlz/F8ruYxUi99hr1sxNW+VMR4jZbnuyTwbrF/ihXNNhLnebuqM
F+6tCqxSLh561QnrGPBBBzDwSR/56oG7fhlw9c0YATkCThACdYfd0jAbD3sY+fTJ
FmCDWgF0t921yHqeJOi4lTTtGSNtD2H2pBTMx9w7qUT0kF5J3XaDdb0IRd2nitI=
=3Zki
-----END PGP SIGNATURE-----

--=-1291715398-656634-10735-4655-1-=--
