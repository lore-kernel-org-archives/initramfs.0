From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.120 release
Date: Mon, 13 Apr 2015 01:22:48 +0100
Message-ID: <1428884568.29665.59.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-C9l5cUpuHRMO4GQvZeHz"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-C9l5cUpuHRMO4GQvZeHz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a minor update, improving the way we report the results of fsck
and documenting more of the fall-out from mounting /usr.

Ben Hutchings (6):
      Add '.log' to fsck log output file, and document its existence
      Remove old comment about running shell on failure of fsck
      Create stamp files to tell the real init system fsck was successful
      NEWS: Improve wording of the entry about mdadm's INITRDSTART setting
      NEWS: Add entries about other ways of mounting /usr that won't work
      Releasing version 0.120.

Ben.

--=20
Ben Hutchings
Everything should be made as simple as possible, but not simpler.
                                                           - Albert Einstei=
n

--=-C9l5cUpuHRMO4GQvZeHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVSsMWOe/yOyVhhEJAQrJ6BAAurHZENhW9FZwZVEBzqPvk2tX1Yw5KRAz
MBp5xQqXuA3G5q96Txm6dkTXHCGXrezGWLKorTXhe5s/v5yQt67mV9XdeBRc4Pi2
j1ZccYuZWsifGebJDQG26zRZThYWkHMm4FmL8A2FOVeKwSuIkF3UVQ20hZjl2r5P
kFvJ1uVhJiMvKxiLDQ3P5/NHp4Pkno/Vp65DxVjSr4JNOWukRjW96zMcG9WvoBv4
AC9EKrHsLBM8FHnWFK9d/CQDMGCOVx2RbMkELM8Rjn4vmR4tYChfF4PJXuOQsRxx
IZ8bf2BQ0v2pPBmP7U9qsP8ksGMcVEreAWlHJxP98f/yc8JdY/dIY3rYb1NTIzrv
X9Q7jfd/ffLypzoiLTfQ5HPuWpScTx7/K2qpahbNVz8nd3SV1Rjc/Ot8EQ92Qg5Y
MtneJXw2KJrjgwZFV5oY692ByukCHJGYKHtSrqExXIXDIR6mZL5AzRncR+JNZ9qm
SzGGm+OcP+aB1uzj4y7vmgVAGwjyaHec9Uamd4jWEHlKyL74ZVrh53pN7g4u5pig
O/beCDd2GTBYDPAhz2k2IF7IveXNz9ZZfg+tgDHcZubKCZaIjMjb/QMMPyvO2oKh
5auzyGD1b58LhPOJOIBd1ukW8VyJvIKifOA1T5b4kq1PbEaFOFv0iA9oHwZ5b1lz
g07E0fCjH+0=
=VgQk
-----END PGP SIGNATURE-----

--=-C9l5cUpuHRMO4GQvZeHz--
