From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.109.1 release
Date: Wed, 17 Apr 2013 02:54:09 +0100
Message-ID: <1366163649.3196.5.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-FpSxLj3IjflK1hjOKURJ"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Cc: kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-FpSxLj3IjflK1hjOKURJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This has the single fix for missing HID drivers, which I considered to
be release-critical for wheezy:

Ben Hutchings (2):
      hook-functions: Include more HID drivers in base
      Releasing version 0.109.1.

This comes from a new wheezy branch.  I also committed the fix to the
master branch.

As this is my first attempt to release initramfs-tools, and I didn't
discuss it beforehand, I've uploaded to the DELAYED queue with a delay
of 2 days so it can be cancelled or overridden if necessary.

Ben.

--=20
Ben Hutchings
The first rule of tautology club is the first rule of tautology club.

--=-FpSxLj3IjflK1hjOKURJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUW4Awee/yOyVhhEJAQp/1hAAp4twCCDiTSBXrNtnaX3wiK+PAVkGfV7Z
2G3uQNscYK8z2d52va6uA/WRoquH5fxG39guZfGqtT7A4Q4uEL4vjVsvQCAt+ePQ
V/9f5v8yE3w8GGarUWBGATEH50GN5fSAw0416VgbVUZPsYrHYqCZreLEwp+Yv6xv
5qnOYm6Km88MdmbWkbPwpOob7UOe7qXvbdw5jvJKlYZ62cfkfsiW/vtrCK+Phb0v
j7oqrUz8XJ0PqcRdTha62RCnA/OPdy1t9ednrP65SQY0Rfek8mjQQ2eOmsSs0LZB
GPJvCVn9lyMRi5k8+2K6nw8Os/hrQa2JlTeC23SwGpnbU0vZY1FYOWh0wP212OAK
CskX4M+5xn1fOu29SRaRmuVYFus4EmGY0rhANdR9chFKv3IwhW4YcQs+Kf3+tx3p
2ljFHVt5cCbRA0aTn9ADcrl+cQzLvqZrQzAKgws8R88hbH1tLlvn7B55bGJU91H0
iBRkU8mtGBZIKpUsCaIDJ2RlvegZmkKfBqWFtdr/OKbWc0GIT2uHeESa2NXtKhAP
C0ipHzkupZo9W0mQLHygtnileMpO774QnmQJovY83/SiZ35HVD5R1GAL6rjCspi2
3TaPVrjGQQJB9kc3RWpxidlQX2RSgZFblJBHo99hPxFwLxAvQWijNRIJTEvvNWUR
5p5v0Wa6U+s=
=J15L
-----END PGP SIGNATURE-----

--=-FpSxLj3IjflK1hjOKURJ--
