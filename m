From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.136 release
Date: Sat, 18 Jan 2020 19:20:07 +0000
Message-ID: <b93b842c72db34c42f36cb4f807b3124ed9d9185.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-gxzuL89RtVzpdr4NioPj"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-gxzuL89RtVzpdr4NioPj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes a number of bugs reported to Debian.  The most
obvious of these was the appearance of error messages from kmod about
missing modules.builtin.bin.

mkinitramfs now enables multithreaded xz compression (this was already
done for gzip/pigz).  It includes drivers in the initramfs that are
needed by some ChromeOS devices and by PowerPC Macs, and includes the
f2fs filesystem by default.

Possible breaking changes:
- I removed several workarounds and special cases that should no longer
  be needed
- The /run/initramfs directory is no longer world-readable

Ben.

Alexander Volkov (1):
      Don't require build dependency on shellcheck when nocheck profile is =
enabled

Alper Nebi Yasak (2):
      hook-functions: Handle dw_mmc-rockchip hidden dependency on rockchip-=
io-domain
      hook-functions: Include modules for Chromebook Plus display

Ben Hutchings (24):
      Merge branch 'master' into 'master'
      debian/tests/control: Mark shellcheck test as superficial
      Merge branch 'cbp-display' into 'master'
      Merge branch 'rockchip-io-domain-for-dwmmc' into 'master'
      Merge branch 'master' into 'master'
      Merge branch 'josch-master-patch-65772' into 'master'
      mkinitramfs: Remove workaround for old udev versions
      mkinitramfs: Remove special case for Arm OABI ports
      mkinitramfs: Remove armhf dynamic linker hack
      Merge branch 'f2fs' into 'master'
      debian/rules: Suppress execution of dh_installinitramfs
      Merge branch 'janitor-bot-guest/initramfs-tools-lintian-fixes'
      Merge branch 'tighten-run-initramfs-perms' into 'master'
      mkinitramfs: Use cp -p option for ld.so.conf* instead of -aZ
      Merge branch 'cgzones-guest/initramfs-tools-selinux'
      initramfs-tools(7): Change example to use copy_exec instead of cp
      Revert "mkinitramfs: check if initramfs has a shell"
      mkinitramfs: Copy modules.builtin.bin into initramfs
      init: Remove special case for kernel parameter resume=3DUUID=3D...
      update-initramfs: Make "-c -k all" options useful again
      init: Mount /dev with "exec" option if v86d is present
      hook-functions: Drop ext4dev from filesystem module list
      mkinitramfs: Enable multihreaded xz compression
      Releasing version 0.136.

Christian G=C3=B6ttsche (1):
      Do not copy SELinux context in mkinitramfs (Closes: #948365)

Debian Janitor (2):
      Bump debhelper from old 9 to 12.
      Set debhelper-compat version in Build-Depends.

Johannes 'josch' Schauer (1):
      hook-functions: preloaded libraries should not end up in the initramf=
s

Mathieu Malaterre (1):
      Update to new name for kernel module therm_pm72

Romain Perier (1):
      hook-functions: Add f2fs as base in auto_add_modules

Topi Miettinen (1):
      Tighten permissions for /run/initramfs

--=20
Ben Hutchings
Humans are not rational beings; they are rationalising beings.


--=-gxzuL89RtVzpdr4NioPj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl4jWmcACgkQ57/I7JWG
EQkZmg/+PwxRIV3q5whAKHN9g1mrPG46QVPGj8p6vGB5btDY3I5Icch3nInAolED
eEAtmhwroIPH8uooQw2Pw6wBuYxqX6jsyu4goqlr7KEbpJNrzXjmPLLCGchJ9EaR
ksLsYoYmM8Mugi6z+Yr8ODfEY3vzN6hqWLs/oRkJ58imEc0OlLwPasRlQggj1c67
lqxbDQPThLnr6iBH95OFAIw+sv65CcNbVXm/ONylPib+78z6zaluXI3LW67sacC/
JmFYph56O5Uzs2q57csk2fN2vz1/f+MnPaRHJLtUPBUsEpPsvZsuToKOz0gHbYwl
f6OYR9evVltZGFGe43+dD8VBIWqw9zDPJs5IL6tSpyZSVS6I+Wi5XBcZBkLJm2F7
CDnw2B254dftdu4nbwgCwdmEW9AqQMwkMeO5BRKmIwwb5GAvtBZpRv7N0Xc5n+Sg
QVVtDU2R+UDranVhtRCw6DT2L30SMAadoLDaFiDze0bHjwOjmqyQJtFArb2Bclqe
2Wbpy1Lx5Z7Bh7B5sHUmB0iGfLd4vz8kq6TAEz+DqTLmlnVrUus637JDNRbZKq+T
EiYlaGyHGGbuyvmvUE9W03MD7PJE6icoSzUJhDlTFavsBy9bqDPYWPhevuEl7F2m
3gr/796twJpHLtMdBW8kbhScAag+JlQSjkD9qh9vEf9IqQ+qrtk=
=eSWZ
-----END PGP SIGNATURE-----

--=-gxzuL89RtVzpdr4NioPj--
