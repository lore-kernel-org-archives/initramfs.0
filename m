From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: question: shell restriction for modules
Date: Wed, 01 Jun 2011 08:33:06 +0200
Message-ID: <1306909406-sup-4628@ittemni>
References: <4DE57109.9070107@ziu.info>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-1306909986-436401-17990-1319-1-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4DE57109.9070107-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--=-1306909986-436401-17990-1319-1-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Michal Soltys's message of Wed Jun 01 00:51:53 +0200 2011:
> Just to be sure - should it be strict posix (in such case, afaik -
> even 'local' wouldn't be allowed) or should I follow dash (which seems
> to be the de-facto constraint on the syntax allowed).
>
> Or perhaps something else ?

Just follow common subset of features of main shells we can use: bash,
dash and possibly ash (which comes with busybox).

Btw, have in mind that 'local' in dash takes only one variable.


Cheers,

-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1306909986-436401-17990-1319-1-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJN5d0iAAoJEPATRTHh2/q10QEH/1TmmPIuEOaWPZo0w8gwZPfb
PcWiKgdTkxAoJWAKIAREdnlQhh8prtrqoxYwLd3SIKncwyY7S5RqLmnXz/Wtxd9A
zsG2ORUnPjA5PV/sx4AFq79PWPtzMiOK74HGZeXE8TJIFBeAlKio/dN11kN7AYk6
k5dYlzVhLLh+9EiqhIxyjmCG77mhGTy4xmaayyXaZ8U93h1oPN5IsW/o/MCQX1cg
L4wgZ7gsCvlHa1zKpc/LE0x2XrYsMMNe2GyPalNueQKXi0PCrmAXvuUQwrTSqQmQ
A9yBAY52ED6UZf1oGmbz4bk91PzpooXmB/IFKMqBtrzw/uDXjZRtPZoK6W+glXg=
=xm09
-----END PGP SIGNATURE-----

--=-1306909986-436401-17990-1319-1-=--
