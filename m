From: Ben Hutchings <ben@decadent.org.uk>
Subject: initramfs-tools 0.126 release
Date: Thu, 15 Dec 2016 23:05:11 +0000
Message-ID: <1481843111.2651.2.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-IC7lonv/gIseGSix9mTN"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-Message-ID: <xJqybKOH2JC.A.xoD.-GyUYB@bendel>
List-Id: <initramfs.vger.kernel.org>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/1481843111.2651.2.camel@decadent.org.uk
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, kernel-team@lists.ubuntu.com


--=-IC7lonv/gIseGSix9mTN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This update fixes a number of bugs reported in the Debian bug tracker,
adds the unmkinitramfs command, and reverts the changes in 0.124 and
0.125 to support detached module signatures.

Ben.

Ben Hutchings (17):
      bash-completion: Fix installation of update-initramfs completion scri=
pt
      Revert "hook-functions: Add detached module signatures if present"
      update-initramfs, hooks/resume: Use ischroot command instead of our o=
wn function
      hook-functions: Make copy_file return 0 on creating a link to an exis=
ting file
      Fix initramfs.conf move to ensure default values are upgraded
      Remove obsolete bash-completion file on upgrade
      Remove code that prunes 'broken' symlinks and sometimes /etc/mtab
      auto_add_modules: Add all I2C bus and mux drivers when MODULES=3Dmost
      maintainer-notes.html: Update 'git buildpackage' commands to use gbp =
too
      maintainer-notes.html: Fix post-clean option to gbp buildpackage
      Use debhelper compatibility level 9
      debian/control: Update Standards-Version to 3.9.8; no changes needed
      Revert "initramfs-tools: Install script to be invoked by linux-signed=
 postinst"
      unmkinitramfs: Rewrite command syntax
      unmkinitramfs: Unpack early and main cpio archives in separate direct=
ories
      initramfs-tools: Remove obsolete linux-signed postinst script on upgr=
ade
      Releasing version 0.126.

Kevin Locke (1):
      Create unmkinitramfs command

Michael Prokop (1):
      mkinitramfs: consider *.conf files only, also from /lib/modprobe.d/ +=
 don't complain about empty dirs

--=20
Ben Hutchings
It is easier to change the specification to fit the program than vice
versa.

--=-IC7lonv/gIseGSix9mTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlhTIagACgkQ57/I7JWG
EQkCgQ//Q2I0Mvew3+Wd1WFBEjeOEEDPGp4lDYmbeeeIOL4v6arAxbUK4jmRWA8u
gZAXUqVq22C9vjN4pkRRQv8Sm9npFZhztO36vSSV3xHidfOdSnx7O2InZQgXoRXF
g51ilIchwXxNzhmv8I2nGyKrjrgJ5sgySuXM3zq1QgZlBEuzFf/eOPiuvMXmsFEY
oTulDelofkfxvRwAkA+rP8yHHkKqMbnLxpyKHiSxxH6IR4BOGof8KDuANr4Yw63q
j99QzWhgD4xdXg1WoU/jteZ3/8T2tEccH3dTO8gpaYZpGtNeYWgxGY4WN+xacEWX
aPPWXQzYxyf+UIfCS+zWkLxRYWkxZpeQFhoh0m8T4qnJIbNUGF+J8m5ZfRzneIhp
uc/fGbl3ZC2hS+QFqK8z3iSQkHIztqh+4okDBrEFBZLxTw/jWG5GsUNE1bnVbCgU
fZ257SCTGGWwGgB2/8agW/N0rd4MZ7LjjGJjlpC8M/nRo7LegJXbkUkSQpTJQBqG
Xn/5HJMURC50F/N+G1lunILl6QHNg7tIxN6BHtVkxG6MioeLJI32Dk6XUCC090r+
DjCLwex8l+T05H1saVZzHA1I5XEn13aWHRvizTjSOqgyQCbmGDePxMm4Hicc7wOT
aqh04myEogUJtYj70OsZVTQki7zsF8kwtPMtGm16Wosjv3mxwnU=
=z3eE
-----END PGP SIGNATURE-----

--=-IC7lonv/gIseGSix9mTN--

