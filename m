From: Ben Hutchings <ben@decadent.org.uk>
Subject: initramfs-tools 0.141 release
Date: Mon, 11 Apr 2022 00:21:56 +0200
Message-ID: <c1d9154cf59b0013b61ab248613742e13163dbe6.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-O9K2k9g1yl2yODFOdhlG"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane-mx.org@lists.debian.org>
Resent-Message-ID: <lLNQ4XoouhJ.A.ynH.bi1UiB@bendel>
List-Id: <initramfs.vger.kernel.org>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/c1d9154cf59b0013b61ab248613742e13163dbe6.camel@decadent.org.uk
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, kernel-team@lists.ubuntu.com


--=-O9K2k9g1yl2yODFOdhlG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes a number of bugs:
- shellcheck warnings which broke the build.  Also, shellcheck is no
  longer run during package build, so future changes there won't make
  this happen again.
- Missing /dev/fd and /dev/std* device nodes after udev stopped
  creating them
- Required modules for several Arm-based systems were not included
- USB Ethernet drivers were not included when MODULES=3Dmost
- configure_networking would not wait very long for an interface
  specified by MAC address rather than name
- When busybox-static was used in the initramfs, its modprobe was
  wrongly used instead of kmod's modprobe.  For now, this issue still
  exists in other packages whose initramfs scripts run modprobe.
- Error message when the initramfs did not contain any kernel modules

This release changes the default compression method from gzip to
zstd -9.

Possible breaking changes:
- The wait for a network device to appear in configure_networking has
  been rewritten, and we don't (yet) have automated testing for it
- mkinitramfs requires the kernel configuration to be installed in
  /boot/config-<version>, so that it can check which compressors are
  supported

The shortlog is below.

Ben.

Alper Nebi Yasak (1):
      hook-functions: Include io-domain in dw_mmc-rockchip hidden dependenc=
ies
=20
Ariel D'Alessandro (1):
      hook-functions: Add nvmem-imx-ocotp driver module to network boot
=20
Ben Hutchings (21):
      Only run shellcheck in Salsa CI
      Fix shellcheck warning "Avoid x-prefix in comparisons ..."
      hook-functions: Fix shellcheck warning "Expansions inside ${..} need =
to be ..."
      Merge branch 'rockchip-io-domain-rename' into 'master'
      Merge branch 'dev-setup' into 'master'
      Merge branch 'master' into 'master'
      mkiniramfs: Log warning about missing compressor to stderr
      mkinitramfs: Generalise kernel compression support check
      d/salsa-ci.yml: Disable non-arch:all builds
      d/salsa-ci.yml: Suppress groff-message warnings caused by bug #973313
      debian/tests/control: Add zstd as dependency to avoid (fatal) warning=
s
      Merge branch 'wip/adalessandro/imx8m-fec-nvmem-module' into 'master'
      Merge branch 'modprobe-fullpath' into 'master'
      Merge branch 'fix-zstd-thread-option' into 'master'
      hook-functions: Support network boot via USB Ethernet adapters
      Merge branch 'fix_modules_list_error' into 'master'
      scripts/functions: Refactor device name logic in configure_networking
      scripts/functions: Make configure_networking wait for device specifie=
d any way
      Merge branch 'benh/config-net-generalise-wait' into 'master'
      Revert "d/salsa-ci.yml: Suppress groff-message warnings caused by bug=
 #973313"
      Releasing version 0.141.
=20
Ben Love (1):
      Fully-qualify modprobe calls to avoid busybox
=20
Dan Streetman (1):
      hook-functions: check for dir before running find on it
=20
Hideki Yamane (5):
      Use zstd as default compression for initramfs
      Recommends: s/pigz/zstd/
      Add check whether zstd support kernel (>=3D 5.9) and CONFIG_RD_ZSTD=
=3Dy or not
      As comparison, compression level 9 is better.
      Consider SOURCE_DATE_EPOCH option for zstd
=20
Michael Biebl (1):
      Setup /dev/fd and /dev/std{in,out,err} after mounting devtmpfs
=20
Vagrant Cascadian (3):
      hook-functions: Add pwm-rockchip to "fb" modules for Pinebook PRO LCD=
 display.
      hook-functions: Add usb/typec/tcpm modules to support keyboard on Pin=
ebook PRO.
      hook-functions: Add panel-edp to "fb" modules for Pinebook PRO LCD di=
splay.

--=20
Ben Hutchings
The program is absolutely right; therefore, the computer must be wrong.

--=-O9K2k9g1yl2yODFOdhlG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmJTWIQACgkQ57/I7JWG
EQn1+hAAjqpgsvK8gyP8jdNU2yybxjbP1OlC5xt4/7hrnpRc6gT3CaQsACKkbwdd
CoVRNFZRWN2XtKSrE98ZnwdeoQizXfdSY7IUcvkGq4g6un3TF5VlQH2UCvkpjN85
Duq6Jd6l9du8TwRkROMCbMPvmNQvEdFKqlfsaC9upfG0IKn9iLIXnykAVW1c8Cjk
27vexvq/S2yubkHayWOC3ndcnDTME9m897f9TZIwjaExI2QYxuD6D2umu9MmYpmg
pdzb5kwurFiv0peUn5qVnFpK6UQ+VymuNY5COMTCoROIzAXzjXgUBHBGuZp++oec
gQNuHLnkiAF+jSAIXKVOZUmOChSprqLAy1Ejw4akVVPOOidXiSJdq7sp6L5EWHnJ
dnR3A7MkqLT86d+2sb/vesEyW2UXfvT6NEF+TsUixDG2hnie2+EzlwdPEtG6vyZx
GfpOnc/USlieCY0+BhNVeUOCm8Y0WG/D1LH9OFghktZA49NYG3lgPrLSdvBRzqur
P1DrPrHhZFY482nhpNk8Sl7JUoRjVysXpLzsiNKjvi65bxPuRVD41S3SWTzizVps
tUsO7/hXLu7hcexstlAxw3SR5emyaT1z4JBTZlk/s2X6Wfos8fkV+ELORUwvCpmb
acU2FTvuKNZaBto37GMwpgFwuiPLResIW+SrWpoW4eAkH3cAAeo=
=KxNM
-----END PGP SIGNATURE-----

--=-O9K2k9g1yl2yODFOdhlG--

