From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: [ANNOUNCE] klibc 2.0.12
Date: Sun, 12 Feb 2023 19:06:41 +0100
Message-ID: <fb40bf5835b0f28eab8f3f0b37dc9846218747f1.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Ml0c5W3QfEZ/GP9UbOzW"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
To: klibc mailing list <klibc-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-Ml0c5W3QfEZ/GP9UbOzW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have released version 2.0.12.=C2=A0 This is available in the git
repository at:

=C2=A0=C2=A0=C2=A0 https://git.kernel.org/pub/scm/libs/klibc/klibc.git

and as a tarball at:

=C2=A0=C2=A0=C2=A0 https://mirrors.kernel.org/pub/linux/libs/klibc/2.0/

Bug fixes:
- Fixed return value for strrchr() with c =3D=3D 0.
- Fixed return value for strstr() and memem() with zero-length
  needle.
- Fixed ls command handling of relative directory names.
- Fixed struct stat layout, specifically the times and following
  fields, on 64-bit MIPS architectures.

A git shortlog of changes since version 2.0.11 follows.

Ben.

Ben Hutchings (6):
      [klibc] 2.0.11 released, next version is 2.0.12
      [klibc] tests: Add test program for string search functions
      [klibc] strrchr: Handle c =3D=3D 0 correctly
      [klibc] strstr, memmem: Handle zero-length needle correctly
      [klibc] ls: Handle relative directory names correctly
      [klibc] mips64: Fix struct stat layout
=20
Jiaxun Yang (1):
      [klibc] mips/mips64: Get rid of delay slot hacks

--=20
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.

--=-Ml0c5W3QfEZ/GP9UbOzW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmPpKrIACgkQ57/I7JWG
EQnaNQ/+JRqOOcdikaJn9Sd3q/bkBeyLCRoEye84LutOiojZArtmOjqKPdmeQi8J
l39/hUBjYx6ZIXkuBTEcf0mNCEtN6PQdXsWzBiE0uqNZ2/qMA5zulYSTCtOvupHU
mLGSOvbZ4PoSqNaSIgpf3nMd3GggTwBS+A4dTEaHRrIyGMLtfPYovlCgVgOwcOgV
D48KtHrAvi06HBY9h1cXkRbztroGNiYI8EtD6CcUo3P20khjiDZIGK2Y+M7pkOfY
DYEo6Q2tThlERri2ScR5u2jywsNDUshY0Uv3KKwPIlXIqoCujJLSnFI8vfEYCH8t
MiEyzNtE5vcmsTLJTB4txttSsjk8h/1k4l5NTzuo8H1YqlOuGkNAB/QtJFfZS4B2
s6buQO3LRkOiu1yF/csFyeiV9Wel+btLjxwV9DGekSUKE8OAAOjkomRq8k9Vtlz8
m6FB56wUzO7ppwfjNX5RvdTrJnuB5I1EneoVO825CO5zHHtnTRoroDlMJYbm+x9p
M3hplmKEqpDWB1Tf463uloGI+M3jihxFRgt0r9edxJ4NmAYjgO8EFC0dGST870pJ
ibTRgtd0qn/rQWJz4E63a2qgRk/qvG79K3Exsne8aE++qohmLeBlVhF7lv+UAamh
oSgyvUnnDlrV92/9qI98qQoLC29+kVKujILvFi0NJlcRQC39G24=
=D20y
-----END PGP SIGNATURE-----

--=-Ml0c5W3QfEZ/GP9UbOzW--
