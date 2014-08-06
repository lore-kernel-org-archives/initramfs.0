From: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: cryptsetup + lvm order and crypt name
Date: Wed, 06 Aug 2014 09:11:44 +0200
Message-ID: <871tsuks7j.fsf@freja.aidecoe.name>
References: <53E15A01.9040604@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53E15A01.9040604-hi6Y0CQ0nG0@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "Claudio A. T. Clemens" <asturio-hi6Y0CQ0nG0@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Claudio!

Have you tried setting target vg or lv with dracut kernel params?
Something like: rd.vg=3Dmy-vg


Cheers,

=2D-=20
Amadeusz =C5=BBo=C5=82nowski

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJT4dUwAAoJEPATRTHh2/q1NacIAIWOIyOMDjDEQ6WyXA0Ed2L6
jODEO+GXlfeuflhH6VIsq3RG+oPcfBV19DZSte+VX471KrNKyriU5w98jyhms24I
FqbkBfqNXimzQ6QLIM5TVg64bdm3Bg17hyqTMSUUwfowIeVVOYqG5B/LhCLsq8Ni
2h1prBr/d2yBjKTxLD3ovAeKQkxGcPqATfbjtUZ4Pm5/NIaf2+zyGEBRvommEvyc
N4Z76rbcVT0NiiTjcBcC02Y+ZXmSR/jv+9sxwEfYilgvGkJCxYtXt9bXNvXWGtQT
BxPs6NyVaeFvc+4y00sLJT7L2Z93IRQy2y+g9p0xt5ACSbyji1ctPS+jG608x30=
=rlMo
-----END PGP SIGNATURE-----
--=-=-=--
