From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Fri, 22 Oct 2010 18:51:01 +0200
Message-ID: <1287765714-sup-7469@etiriah>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <4CBE44D3.6070000@googlemail.com> <1287580805-sup-6517@etiriah> <4CBF004F.9070201@googlemail.com> <1287586242-sup-9146@etiriah> <4CBF0CA3.1070801@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256"; boundary="=-1287766261-435007-16039-5262-4-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4CBF0CA3.1070801-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1287766261-435007-16039-5262-4-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Mr Dash Four's message of Wed Oct 20 17:37:07 +0200 2010:
> That is the problem though - there is no way you can have crypttab for =

> root as there is nowhere to put it in, other than outside initrd or =

> hard-code it in initrd in which case once there it cannot be changed. =

> For all other partitions the solution is simple - use root, but for =

> (encrypted) root itself the options are rather limited.

It's not hard-coding.  Please look at "--hostonly" option and see its
consequences. I've explained it a bit by the way in

  dracut/modules.d/10i18n/README

Reading this file might give you some light on how we deal with
configuration files and so.  Please also switch to 007 version or better
- git, because you sometimes mention things already solved there.
--
Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1287766261-435007-16039-5262-4-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQEcBAEBCAAGBQJMwcD1AAoJEPATRTHh2/q1sPkH/AsVwJqFIOwlLAkZY9b4zv4a
ge4Q7ZxnZNdjdE2IK3PnEDqJS7NLhFtGRzjvYX5lnfProbJFT+iSvlOzcYRy8ila
dEeQZQkYa6qtM5dm4B2sk4K7eB2N8ALfQDv4YMHbH+Rz8jld1CGbSpNL7mRwH7Bs
BfrCGdZbyd7SE684t47nk55k0GXB7izUv/MBYxPkeJUAtOjRyLeyWxkjZO29Exsa
FAKHlsj7eamEUbWVdb9kaRfz6FtVwc9bkeFu8gQ6HZHzhLY35c981CN/d7P3OFn6
E+I/jtB3n8rU2fPXqcvhF4HSCXvEx9gYVmLv8WNGqPyz2tInqAg+9aIWqvdY32k=
=Ucwc
-----END PGP SIGNATURE-----

--=-1287766261-435007-16039-5262-4-=--
