From: Michael Prokop <mika@debian.org>
Subject: initramfs-tools 0.108 release
Date: Fri, 21 Sep 2012 12:59:04 +0200
Message-ID: <2012-09-21T12-56-01@devnull.michael-prokop.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+WA+n3pAWWgNWUs"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Content-Disposition: inline
Resent-Message-ID: <iqC2aZ3GoVC.A.HwF.boEXQB@bendel>
List-Id: <initramfs.vger.kernel.org>
List-URL: <http://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, kernel-team@lists.ubuntu.com


--R+WA+n3pAWWgNWUs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

on behalf of the initramfs-tools developers I'm announcing a new
release, which most importantly fixes a keymap issue (see bug
report http://bugs.debian.org/619711 for details).

,---- [ git shortlog ]
| Michael Prokop (2):
|       Use setupcon to install system's keymap
|       Releasing version 0.108
|
| Petr Baudis (1):
|       initramfs-tools: allow disabling initrd for make deb-pkg
|
| maximilian attems (2):
|       hook-functions: add hid-generic module
|       debian/control: Scratch 2.6 mention
`----

regards,
-mika-

--R+WA+n3pAWWgNWUs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlBcSHgACgkQ2N9T+zficuiJlQCfRCuOJJYD9+RuEXB6bkXNoISo
J8YAn3MGnaQ/neVBO9RYtVfT92XEk6nW
=NiO4
-----END PGP SIGNATURE-----

--R+WA+n3pAWWgNWUs--

