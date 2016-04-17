From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.125 release
Date: Sun, 17 Apr 2016 23:26:48 +0100
Message-ID: <1460932008.9121.44.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-VUYWGjrMkLXBAf8y3n49"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-VUYWGjrMkLXBAf8y3n49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a brown paper bag release, fixing a regression in 0.124. =C2=A0Ther=
e
is also a further change to support Debian's experimental linux-signed
package, and a minor cleanup I made along the way.

Ben.

Ben Hutchings (4):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0update-initramfs: Remove $USETRIGGERS v=
ariable and condition
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0initramfs-tools: Install script to be i=
nvoked by linux-signed postinst
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mkinitramfs: Fix wildcard for excluding=
 dot-files
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Releasing version 0.125.

--=20
Ben Hutchings
Make three consecutive correct guesses and you will be considered an expert=
.

--=-VUYWGjrMkLXBAf8y3n49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXFA2oAAoJEOe/yOyVhhEJRAcQAIU4JskNf7+yItP4Fw6EXZvA
q+WeUkzuzHJVBoWaIhrNOKTemkOtVkKQ2hMSjR1rH1dfHTZlsqhdTUEjHUW8ceGb
Is0TA6s6KrBafnAiQ6V2OiDUQM4dYJPKahUjJmBIuSV0T+5gDka5/ZENN/E3/EUs
3nmx/OoKz3+zJqn6oTQC/Vc44mwU0MSI6aE1Tax24aGStrOLEodxA+sxMak3oW/o
JdtT5VxT1BIgtyPEeZlrPUykXXGEMEZH8YEm1mQnqeol1Z+t05IefLyA0UE4yCiV
XhmDgXAjypDRRHSkbzZ6aQNDo2O25u3ZGPFD1JHpGF/GzD+E6ihXoKkFJZczus0t
2c/RhHzB5wN0mTzXjfImN+qUpfqXvDaFEPR2wzOvwLnQscU4Gzgt/IumdGaxU7mV
i1Nx5KlHrPQ6FduErNid/f1gZ9Qdn8+uBKTJ+FxRToXjiaPsN3xIHKWv6Wh1NFDO
XvfHFkSqoZzlKzcOCk/TqbZ7HMrgGqs0v4v2aWq0KkBL7g4CMW9NVL1PZ0yXfbds
0XjqIrvO7xje0MYZXNRTD30JfCg5fjMPV5nTZkAoihkyQBhMSWbgholup++k4JAS
Yf1PBvhxmt/3zaqX30DhWcUBk2DXy7zx0k4ku6ZX1Q8YZULv3eQ26U3s0kWJdQK/
6YkOCWhzQpvF3L8N9cw+
=2ddK
-----END PGP SIGNATURE-----

--=-VUYWGjrMkLXBAf8y3n49--
