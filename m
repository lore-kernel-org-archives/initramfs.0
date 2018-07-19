From: Ben Hutchings <ben@decadent.org.uk>
Subject: initramfs-tools 0.131 release
Date: Thu, 19 Jul 2018 17:03:02 +0100
Message-ID: <c61f8c8dc68911ccc1ea5e5c4e379ef058a094ba.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-A8Cdx8Xdx87u791FIPm3"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-Message-ID: <TN6RYv9__RD.A.9fH.QZLUbB@bendel>
List-Id: <initramfs.vger.kernel.org>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/c61f8c8dc68911ccc1ea5e5c4e379ef058a094ba.camel@decadent.org.uk
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, kernel-team@lists.ubuntu.com


--=-A8Cdx8Xdx87u791FIPm3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This overdue release fixes most of the important or higher severity
bugs open in Debian, and includes most of the patches submitted since
the last release.

I also did some cleanup of the documentation and the debian/control
file.

There is one known regression, which is a (non-fatal) error message
from mkinitramfs if there is no /var/cache in the initramfs.  This will
be fixed in the next release, probably quite soon.

Ben.

Ben Hutchings (42):
      debian/control: Remove maximilian attems and Adam Conrad from Uploade=
rs field
      hooks/resume: Generalise logic to replace dev name with UUID when RES=
UME=3Dauto
      hooks/resume: Store /dev/mapper path for swap if possible when RESUME=
auto
      Merge branch 'master' into 'master'
      Merge branch 'master' into 'master'
      Merge branch 'narrower-sync' into 'master'
      Merge branch 'add-lz4-support-to-mkinitramfs' into 'master'
      debian/control: Point Vcs URLs to Salsa
      hooks/fsck: Fix invocation of fstype at build time
      docs: Convert maintainer notes to Markdown format
      docs/maintainer-notes.md: Update references to Alioth, to Salsa
      docs/maintainer-notes.md: Delete mention of git-core package
      docs/maintainer-notes.md: Change BTS link to specify source package
      docs/maintainer-notes.md: Link to tracker.debian.org instead of PTS
      docs/maintainer-notes.md: Remove stale link to Debian bug count graph
      docs/maintainer-notes.md: Use HTTP-S for Debian wiki and popcon links
      docs/maintainer-notes.md: Link directly to Ubuntu bug list
      docs/maintainer-notes.md: Add myself as co-author
      hook-functions: Correct the comment above hidden_dep_add_modules
      hook-functions: Remove directory information from hidden_dep_add_modu=
les
      hook-functions: Check modules.builtin in hidden_dep_add_modules
      hook-functions: Handle i8042 hidden dependency on psmouse
      hook-functions: Handle nvme hidden dependency on vmd
      unmkinitramfs, lsinitramfs: Split multiple early initramfs sections
      debian/control: Add e2fsprogs to Depends for initramfs-tools-core
      initramfs.conf: Update documentation of the DEVICE variable
      mkinitramfs: Build reproducible images when SOURCE_DATE_EPOCH is set
      mkinitramfs: Exclude ldconfig auxiliary cache from initramfs image
      mkinitramfs(8): Remove description of nonexistent options
      mkinitramfs(8), hook-functions: Correct references to "ramdisk"
      docs: Move initramfs-tools man page to section 7
      docs: Update man page header dates
      docs: Set man page header source and manual parameters correctly
      docs: Don't package maintainer documentation in initramfs-tools-core
      docs: Remove outdated "HACKING" documentation file
      debian/initramfs-tools-core.manpages: Fix filenames
      debian/control: Remove obsolete Breaks and Depends relations
      debian/control: Update Standards-Version to 4.1.5
      debian/initramfs-tools-core.doc-base: Remove
      initramfs-tools: Override lintian warning "breaks-without-version ups=
tart"
      docs/maintainer-notes.md: Update the name of this file
      Releasing version 0.131.

Benjamin Drung (6):
      Add mlx4 and mlx5 InfiniBand modules to hidden_dep_add_modules
      Add option to clear screen at the beginning
      Fix indentation (spaces to tabs)
      Fix config directory in error message
      Double quote to prevent globbing and word splitting
      Make size of /run configurable

Colin Watson (1):
      Only sync the filesystem containing the initramfs

Ivan Kozik (1):
      init: export DEVICE so that when configured, it is actually set in co=
nfigure_networking

Karsten Merker (1):
      Include the axp20x_usb_power module in the base modules list for MODU=
LES=3Dmost

Paul Menzel (2):
      mkinitramfs: Add LZ4 support
      control: Remove suggestion of *lz4-tools*

Riku Voipio (1):
      auto_add_modules: add mfd for MODULES=3D=3Dmost

Steve Langasek (1):
      Skip dmsetup resume devices if they are randomly encrypted.

--=20
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                         - Albert Camus


--=-A8Cdx8Xdx87u791FIPm3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAltQtjYACgkQ57/I7JWG
EQmBfg/8CSzjfhG41b7uGEbNUmiaZKafJAUvKkU9rPLhJ0oOdMSr7NekBiWBMYD9
1v3n5BHs74wPT1bxeiWmtC+5eLJTjiY2/2gl/bawjcgddt7pXqhHSo/sAr91T2XK
WlQhf0q+r4zFaJiM4wXcB+k3IUIF553s2GkYLYOAj7sXxTrrfkfiZycT5rSbP8Dx
XEDfr94FIBLa+G2ac87uFPrpaZGX8Yw6tn0uXzq6YI50My4WJkDUax3QLYoWdCr4
IXIdC3a/hXxbDQzcqqNkrj+wKL/V3vzX1TMz9mNmGbJQ4K/n8YJgrCq2jOhpNXsq
6WnSCVlehDa1+sdHMnRDCAUv6mqYnTZdDGaL21IOhAiFWNLbD0SNuqZFhOSsYesB
pUWoPJPTk7+ub86+rVNnxhCjLbpwA1Pcjaanz7ZrKhnw2C2/RLTz2S7MQL7mVjqV
Abjxe4BX8fXiKYt1teLQY9vZjexE9bPQtSSfGIgJPl3aBQRA/RZ1J1Dr4Pj3J5/w
eeTczOZAV3eLQIxSf/tRHtEHYF6fBPidosMZnKcOwgy1WGfnGuODtUI1IiyNcaVW
gjFBuGfZQOcdbChspYzkxiI0XMR9SBr0klWqDp0UHKImQLJtVT32c0bI1bHdQcPP
RoFrAFMTWXINvzE+4Fv1oF+kS+ZgcQ8WNEwWRxR/hDp4hbTO/P4=
=3Ac6
-----END PGP SIGNATURE-----

--=-A8Cdx8Xdx87u791FIPm3--

