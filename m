From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Fri, 22 Oct 2010 18:40:09 +0200
Message-ID: <1287761977-sup-4635@etiriah>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <4CBE44D3.6070000@googlemail.com> <1287580805-sup-6517@etiriah> <4CBF004F.9070201@googlemail.com> <1287586242-sup-9146@etiriah> <20101021132916.GC22186@nb.net.home> <4CC0462E.20507@googlemail.com> <20101021151802.GD22186@nb.net.home> <4CC060B3.3050508@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256"; boundary="=-1287765609-549042-16039-3569-3-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4CC060B3.3050508-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1287765609-549042-16039-3569-3-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This thread is becoming huuuge. :-)


Excerpts from Mr Dash Four's message of Thu Oct 21 17:48:03 +0200 2010:
> My point still stands though - leaving the 'guessing' of the target fil=
e =

> system to mount is not a good idea and <key_dev_fs> should not be =

> removed as a parameter (it may not be mandatory, but should always be =

> catered for).

File system is mounted read-only, so even on wrong guess nothing bad may
happen.  I think Karel has made good point about <key_dev_fs> parameter.

But if you need to insist on having it, we might introduce following
syntax:

  rd.luks.key=3D<key_path>[:<key_dev>[:<luks_dev>]]

Unfolding <key_dev> in BNF:

  <key_dev> ::=3D "UUID=3D" <uuid> | "LABEL=3D" <label> | <path_part>
  <path_part> ::=3D "FS=3D" <fs> "=3D" <path> | <path>

Where <path> matches following regular expression:

  ^/dev/.*

Hope everything's clear and that will satisfy you. :-)

Karel, what do you think about it?


> I would also add that both <key_dev> and <luks_dev> should be able to
> support the Linux drive notation (sdXX, hdXX etc) in addition to label
> and uuid.

It does already with my latest not yet merged patch.  Hope to work on it
this weekend to be merged on Monday.
--
Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1287765609-549042-16039-3569-3-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQEcBAEBCAAGBQJMwb5pAAoJEPATRTHh2/q1GaQH/iKI9IvV0Xxz7Q7C0ltQRRL5
QxRFzjM/1xsQzeC9v1F0btaw48DagfnN/TlZPtHQoUK4tjNSiFcTMB14+7URBHjo
UxJMWwQqAUhpb8rmMSAEtxTiyQmiZVIoa50Ieh0eddYRw4xDJnLcBeMCknTsoUZd
ltH8aAh8m8Vzon9UeHQbliff9QgJA0VTGCac4aEOsI9w+cc7Qihh5Bukc9i3B/7M
A6yGBglXzOYdEG1gm9MF4bYU2MdsFZe0Nhcj6IpxhTwH1NOeuMLohCHM5584Q/N/
/S2N9GtLvgWpQkEAHQ/6ATiiL/KjeJEDUfSSsqjNKBQLMKsMEKTkmNi9qx22LBg=
=Uf5K
-----END PGP SIGNATURE-----

--=-1287765609-549042-16039-3569-3-=--
