From: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: LUKS passphrase asked twice when using plain device names
Date: Tue, 23 Sep 2014 08:06:48 +0200
Message-ID: <1411452408.5121.15.camel@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-auIHvIpFKG8PIrY3+z8V"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: systemd-devel <systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-auIHvIpFKG8PIrY3+z8V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear systemd and dracut folks,


with Debian Sid/unstable, using plain device names like `/dev/sda1` in
`/etc/fstab` and `/etc/crypttab` the LUKS passphrase has to be entered
twice. Once it asked by dracut and once by systemd. I did not yet try
with UUIDs and ask first if that is an error?


Thanks,

Paul

--=-auIHvIpFKG8PIrY3+z8V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlQhDggACgkQPX1aK2wOHVjT3QCbBKs9nWB1erM/fUTQz6DjVpIn
fWcAniBfdfi2xnYaTNTjsj0qyPjZhTwr
=dXyr
-----END PGP SIGNATURE-----

--=-auIHvIpFKG8PIrY3+z8V--
