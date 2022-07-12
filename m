From: Ben Hutchings <ben@decadent.org.uk>
Subject: initramfs-tools 0.142 release
Date: Wed, 13 Jul 2022 00:54:40 +0200
Message-ID: <db21dad89390442010de6b4520a311791a58b764.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Xf31lXDInca+jV+or1FF"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane-mx.org@lists.debian.org>
Resent-Message-ID: <ValxkU4w5hJ.A.5RE.FvfziB@bendel>
List-Id: <initramfs.vger.kernel.org>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/db21dad89390442010de6b4520a311791a58b764.camel@decadent.org.uk
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, kernel-team@lists.ubuntu.com


--=-Xf31lXDInca+jV+or1FF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes a number of bugs and compatibility issues:
- Swap devices on zvols could be automatically selected as resume
  devices, even though they can't be used as such
- modules.builtin.modinfo was not included in the initramfs, which
  depmod now complains about
- UFS drivers would not be included in an initramfs built with
  MODULES=3Dmost for Linux 5.19 onward

New features in this release:
- Compressed kernel modules are decompressed in the initramfs image,
  which should reduce the image size and boot time
- Compression level can be overridden in initramfs.conf or on the
  mkinitramfs command line
- The fsck binary is always included, so that it can be used in the
  initramfs shell
- Drivers needed for a working display on the MNT Reform 2 are
  included with MODULES=3Dmost

The shortlog is below.

Ben.

Ben Hutchings (8):
      Merge branch 'szubersk-resume' into 'master'
      Merge branch 'decompress-modules' into 'master'
      Merge branch 'always_include_fsck' into 'master'
      Merge branch 'compresslevel' into 'master'
      hook-functions: Remove support for ieee1394 and i2o
      hook-functions: auto_add_modules: Include UFS drivers from drivers/uf=
s/
      Merge branch 'bug-1014319' into 'master'
      Releasing version 0.142.

Dan Streetman (1):
      hooks/fsck: always include fsck binary

Dimitri John Ledkov (1):
      mkinitramfs: decompress compressed kernel modules

Johannes Schauer Marin Rodrigues (1):
      hook-functions: Add pwm-imx27, nwl-dsi, ti-sn65dsi86, imx-dcss, mxsfb=
, mux-mmio and imx8mq-interconnect for MNT Reform 2 panel/backlight.

Rich Ercolani (1):
      Add support for specifying compression level

Sven Joachim (1):
      Copy modules.builtin.modinfo into initramfs

Vagrant Cascadian (1):
      Merge branch 'reform2-di-modules' into 'master'

szubersk (1):
      resume: Don't resume from a swap device on a ZVOL

--=20
Ben Hutchings
friends: People who know you well, but like you anyway.

--=-Xf31lXDInca+jV+or1FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmLN+7AACgkQ57/I7JWG
EQnOshAAxwHn33KULvpuNk6A03LCkTcwP9bj0OJLAlcSO/T3hN4hVq6RtjOewZPi
bmgvTu+zFJW3SWRogCiq2XYV5vLOOSr2iE+FMYIlsxhpRa9zqrJOP2bmjZnoPTc3
gXK0X5LqfSkScI1osM/AZ07TD7ie354HEzeAyuc3g8iYAEXDCGXy85VzrzX8wwu0
7pXN9FE/gS8os6ERT+1zmDK3Z5JiV/8rjS2bEBL0CKWw00y0+QRXCzrjj+VpscpY
3ptGnx1fg1PnXX+mJePYrtGSJsuIKjuVxQS3i3KM9ke9ho/Gmu6rIla9SD05czub
/IhYV/7c94eJNYG6a2F3e76Yc4ffNUYv/++Ek1e+qmNaL3Vw0d2Mszel5pb9bRs8
fYss0ud919aOqZjhMyQQfutS+TtyK07sNYzDXH9hiURHW7xnrdnWc/B/eZtoN//o
wEZrCeTY+s6RGfNdV702GmSa52IS2uHMiNwefZ2qsXTuA5so/tLt470R/FnKzant
1MZ/Erp6sxNbZ9qQqYy8CQ7cmG78lU9gfQ3zJVEcvYaLR9QE8YuAGfTyJWeG5uy5
d1kw6ADHyIr5W0Mq53mwL/UZbFN06b5szr/pG82cnTFuACiHKXD+U0WakNj34LOi
OO0baRlSvZQKL4o9GX5/l0ZMoLvkhCBaWnj87fqMMw3nOuZrzdk=
=lD9d
-----END PGP SIGNATURE-----

--=-Xf31lXDInca+jV+or1FF--

