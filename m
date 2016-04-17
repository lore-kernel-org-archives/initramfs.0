From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.124 release
Date: Sun, 17 Apr 2016 02:56:41 +0100
Message-ID: <1460858201.4051.2.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-qeiegvfDbHMC1VwU7a8t"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-qeiegvfDbHMC1VwU7a8t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This update fixes a small number of bugs reported in the Debian bug
tracker, and adds support for detached module signatures as used in
Debian's experimental linux-signed package.

Ben.

Ben Hutchings (7):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Add detached module sig=
natures if present
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hook-functions: Create ORDER files even=
 if there are no valid scripts
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mkinitramfs: Exclude VCS directories wh=
en copying /etc/initramfs-tools/scripts
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0parse_numeric: Do not attempt to canoni=
calise root device name
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0auto_add_modules: Include most USB host=
 drivers
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0auto_add_modules: Include all bus drive=
r modules
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Releasing version 0.124.

--=20
Ben Hutchings
Make three consecutive correct guesses and you will be considered an expert=
.

--=-qeiegvfDbHMC1VwU7a8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXEu1ZAAoJEOe/yOyVhhEJtj0P/iErcx0ftGRAhtqsREzdwrsX
wVnkBsmABJVQtIJylZCVrLvVL6JbympxhbcdCeFiwZP+9/HjcegWgwHhZsX5s5yo
Wlb/VQzOuKOZiydc//KDkL4lbGNNk9w7bZQhSX2WaUfbQOYgNCyPVV9TuvSsAjH7
N9oa5g1phvMgN4/4/NSDWW6cLskJk4Rxiq+Uau+OFrzhTSom8a5UY3cD2EXyzsAz
fbe+ZA5ySgZuPXyQXimQD9/Sm5BSMSJfkHEtWQ4peAHh3rbM8m5tZmQiZQxjy5Sy
GjBd/oOboDqGI+rQdOI815eSrZysqry2Y7Q1BQ1uEXXEcF4dijVKZpmRm3UFeUMt
ySrxKREj6aLOIPOeudiFdTeE446HiAaB84LdQJr/wzHNTR5PYxGcNDGvA1w3ianP
HHPAJqJCSyfJMy1qCpXSaPNqNDIp2z1L1q8e+y9SeLnxnOTkxVcfmp1kSLwSafme
KJc0CrhpIKk/WdozRGS1Uqf7L52fPpt6OOvqyPumEVo/6W1yycnofopR1zHfTaK+
bAOt+bYwEiGIQ739j7DWuAMkyvsWp48vazAuWpjisGajyZ9jTX3ki7fMZgaJ9j1s
q41e1vufBFTnbOQU5N8k4nyxpVKA4ZqXLiaD4u+OVzWlY7AO/NOOaKdJfBW/Q75V
K7tbv4PO8Ad4vRGMsRCC
=BCK7
-----END PGP SIGNATURE-----

--=-qeiegvfDbHMC1VwU7a8t--
