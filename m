From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 2/2] gentoo.conf: let udevdir= be handled by pkg-config and use
 udevaltdirs
Date: Sun, 27 Jan 2013 10:38:53 +0100
Message-ID: <20130127093853.15973.4134@localhost>
References: <1358966239-19496-1-git-send-email-aidecoe@aidecoe.name>
 <1358966239-19496-2-git-send-email-aidecoe@aidecoe.name>
 <kdpek7$b01$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="===============8776991468744013688=="
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <kdpek7$b01$1@ger.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--===============8776991468744013688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Quoting Colin Guthrie (2013-01-23 20:45:13)
> I wouldn't recommend this is committed as it is purely transitional as
> I said.

Why not support transitional scenarios, too?  Who knows if somebody is
not going to move udev around once again in the future?  This patch
isn't intrusive.


-- =

Amadeusz =C5=BBo=C5=82nowski

--===============8776991468744013688==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJRBPWtAAoJEPATRTHh2/q1sKYH/08pwRJtm4OhrwTu8x8mczkI
iBfqCFY40BD4VDaPUYUv6HRjibhM3lL6Q/Oc0r08P+ez6LnYfAQ8DImJXsL1uKjD
dpr1/YeDdINPd+InpAL3OsMlBxlAr4HllwHtENDbgSmur2tWIQk5cuGXxrMt+QJL
cXRsh7d0gfnFlB9s1N2a/ziyl7g0k4D4ttQMsw3OENBp+8EPRb2w6mOvgcOZo4z+
oYhEY0qD1zvmXb73MQJd0LoJiLzp/ioxghGBkAjIux33JAE/pLhQILx81r0gPOTy
S15W2ZG130v0kkbdeti50Jjru6fFmg08oA0IafpbyvX8z1hcfASYxe5oSPXJi4A=
=napQ
-----END PGP SIGNATURE-----

--===============8776991468744013688==--
