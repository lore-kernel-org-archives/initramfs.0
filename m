From: Artem Sidorenko <artem-Doy5ofz6/I90ubjbjo6WXg@public.gmane.org>
Subject: PR crypt-ssh
Date: Thu, 05 Feb 2015 23:41:00 +0100
Message-ID: <54D3F17C.7040204@2realities.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="s6xUlGx0x1jE0JCV4SoKsg9T1oS44Adu2"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s6xUlGx0x1jE0JCV4SoKsg9T1oS44Adu2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I created a PR [1] with a module crypt-ssh. The intention is to enable
unlocking of luks full encrypted systems via dropbear ssh in the initramf=
s.

This module is a separate rpm package because of dropbear and openssh
dependencies. (Dropbear is coming from EPEL on RHEL/CentOS).

May you please take a look and give me feedback?

[1] - https://github.com/haraldh/dracut/pull/39

Thx,
Artem


--s6xUlGx0x1jE0JCV4SoKsg9T1oS44Adu2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJU0/F8AAoJEA3ywnEJRU9tPY0H/25AISsnZr436sUz42w+1mbJ
ygWSkrb+Ri5eUdhL1+uWYgJ8lLxNma4YqZRAMiN1CFgCYtNBcjBAqw7pS1C9eCCb
g8Nqj2h0jB8PHWbUleRXR4vkFcqM+gFvW1z8U6hy3dN2AGm44ew5vnONNwEJQ6uG
lXzi0Wc6xp6+CFdUuTyJTdH6lGCVVsCQtl71SEpE3Wp+qYfaYGp1l59utqw/cr/x
hODtuWDkvHLvLapcvy9UUA+0FcXVoknC4ax42MlFL1N0/uOP3fvsQgefmJNssRXH
LXyYGEVjce7mQqttXS2jOCSzwVCECroD1d6PEcMHrfibPmzqtgBpT9k6I+/cyO8=
=mFgt
-----END PGP SIGNATURE-----

--s6xUlGx0x1jE0JCV4SoKsg9T1oS44Adu2--
