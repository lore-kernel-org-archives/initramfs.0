From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.127 release
Date: Mon, 23 Jan 2017 03:48:55 +0000
Message-ID: <1485143335.2998.94.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-WU9/GM6JuK1/nhHVL4SL"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-WU9/GM6JuK1/nhHVL4SL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This update fixes bugs in the new unmkinitramfs command that also
caused regressions in the lsinitramfs command.

Ben.

Ben Hutchings (3):
      unmkinitramfs: Don't attempt to create /main directory when listing
      unmkinitramfs: Change mkdir/cd/cpio command sequences to exit on fail=
ure
      Releasing version 0.127.

--=20
Ben Hutchings
Hoare's Law of Large Problems:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Inside every large problem =
is a small problem struggling to get
out.


--=-WU9/GM6JuK1/nhHVL4SL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAliFfSgACgkQ57/I7JWG
EQm16hAAkuH+cjBbpwAIYAOJzhPkDOJGEfYSPFPHNZGKiM1frKQ1VQTyTkIfBv2A
Es0iNDeOGVEVZqvqJo2qXRGsjxaddNYF8peKnAzvgkkWJsdSkZapGXSEFjKUp1sb
PkxI8AJCJdBJW+jaOFHoD/9J4hwLidBWezeqhnuNLOJB+XcZ0qdovwO+a+NXZHhu
uoRFMi9tTZWhQk2wZkGhnxnUDqRXlo7jtxTt4zTgim6z4mWTRH8zWBtragc+8uv4
qEWPI8a6+MjrEtGWD5PhCT39GKLT7M03Yo6JFlRLzm4CAL2+jaNpJM6+YS1RJFkb
hfQubkv5HJML2+pSKzYJq5xWESwj4bbpmIW/7zy4IpxkK79n0K101279SvLpC+9y
LcRG5+oasasTsag89vuqnvBA7Jt1vNSLANvgi6IoGdwMJfI24E5Yr39M7nYIjdPW
X5hQV+6Eic7MZaUz4TI3UC4SUwAX+FpmpKEYy4hhbW+g/sFAcAQgpmSTB7hYqd0V
zbETvLON8aFezJN9ih7UfcTYO208//+kAM+SNxYnD32mPUqrs8Wccep9EC+FH3Ir
agsaPQ+sq0ubAhXGRHajRscQXoT1jdusgveh27Fv+DJ/oGhb3MvPNeoawDKSLV4x
SqPAuQLfAenmMdzEUS0N6P3wJWl0pa0rqWVMQb4Dg/xHl8/00Zc=
=sXrc
-----END PGP SIGNATURE-----

--=-WU9/GM6JuK1/nhHVL4SL--
