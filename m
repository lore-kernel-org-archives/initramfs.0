From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.119 release
Date: Wed, 04 Mar 2015 21:00:19 +0000
Message-ID: <1425502819.3164.33.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-RPNJOZUZgZD0NWahvZSU"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-RPNJOZUZgZD0NWahvZSU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As I failed to send an announcement for 0.118, this announcement covers
changes in both 0.118 and 0.119, the "Wait smarter not harder" release.

Version 0.117 introduced mounting of /usr and fscking of both /
and /usr.  This resulted in numerous regressions as several other
packages were not prepared for this (most notably sysvinit-core, upstart
and klibc-utils).  The worst regressions were fixed in 0.118.  I believe
the remainder are fixed in 0.119, or documented in NEWS so users can
reconfigure if necessary.

A short summary of the changes:

- Only mount /usr if the init we're going to run is systemd
- Restore compatibility with klibc-utils, requiring an upgraded version
- Disable the time check in e2fsck
- Fix fsck return code checking
- Fix case where we couldn't work out which fsck to include
- Add a script phase for (re)trying stacked device creation, needed for
  configurations such as LVM on USB storage or /usr on a different LVM
  VG from / (thanks to Goswin von Brederlow for prototyping this)
- Require upgraded cryptsetup and lvm2 packages
- Many fixes to module dependency generation, including driver types
  needed for ARM multiplatform kernels
- lsinitramfs now works with initramfs images that include early
  microcode (thanks to Brett Parker and Olivier Berger)
- Remove the special casing of noexec $TMPDIR which added undocumented
  restrictions on hook/script naming
- Reduce xz compression level for the benefit of low-memory systems
- Include xhci-pci driver, split from xhci-hcd in Linux 3.18
- Many documentation and message fixes (thanks to Helmut Grohne and
  Trent W. Buck for some of these)

Now the git shortlog:

Bastian Blank (1):
      hook-functions: Add xhci-pci to module list

Ben Hutchings (65):
      manual_add_modules: Set the kernel version when checking module firmw=
are deps
      lsinitramfs: Move the decompress | cpio pipeline into a function
      lsinitramfs: Parse and list files that include early microcode
      lsinitramfs: Include -l option in usage message
      Add more sanity checks on root device name in dep_add_modules
      Support MODULES=3Ddep usage when root was mounted from hidden /dev/ro=
ot
      Check for root device's module dependencies at all levels of device h=
ierarchy
      Revert "scripts/functions: untested without busybox"
      Merge branch 'fix-dep-from-nonmod-kernel'
      Merge branch 'fix-lsinitramfs'
      Merge branch 'fix-firmware-list'
      init: Decide what the real init is immediately before mounting /usr
      init: Fix validation of the real init program
      init: Resolve both absolute and relative symlinks in validate_init
      init: Only mount /usr if the real init is systemd
      debian/control: Add Breaks: systemd-sysv (<< 186)
      debian/control: Conflict with linux-initramfs-tool
      hooks/fsck: Add hwclock, related configuration files and udev rules
      panic: Do not return if reboot fails
      debian/control: Add versioned Depends on util-linux to avoid adjustin=
g clock twice
      Merge branch 'fix-system-time'
      Merge branch 'fix-panic'
      debian/control: Fix minimum version of util-linux
      init: Set and export PATH before running any external commands
      Require new klibc-utils or busybox, to get 'readlink -f' and 'mount -=
o defaults'
      Merge branch 'fix-klibc-compat'
      Merge branch 'mount-usr-for-systemd-only'
      Releasing version 0.118.
      Always generate ORDER files in mkinitramfs
      Move get_source, set_initlist, get_prereq_pairs, call_scripts to hook=
-functions
      Merge branch 'always-cache-order'
      hook-functions: Add modules for various important device types
      mkinitramfs.8: Update default temporary directory
      initramfs-tools.8: Refer to lsinitramfs rather than suggesting gunzip=
 | cpio
      Add comment to /usr/share/initramfs-tools/modules that it is not a co=
nfig file
      initramfs-tools.8: Improve documentation of break parameter
      update-initramfs: Fix error message in case of excess arguments
      initramfs.conf.5: Update configuration directory
      update-initramfs: Consistently show which options take arguments
      Refer to lsinitramfs(8) from {initramfs-tools,mkinitramfs,update-init=
ramfs}(8)
      mkinitramfs: Use default xz compression level rather than -8
      mkinitramfs: Improve warning text when missing modules
      initramfs-tools.8: Refer to 'phase' rather than 'stage' of initramfs =
execution
      initramfs-tools.8: Briefly document the kernel hooks
      hooks/fsck: Remove dependency on hwclock by disabling e2fsck time che=
ck
      checkfs: Continue unless fsck reports uncorrectable errors
      checkfs: Correct error messages and emergency shell in case of failur=
e
      hooks/fsck: Fix type lookup for mount by UUID or label with type=3Dau=
to
      dep_add_modules: Add modules needed for /usr device
      Merge branch 'bwh/fsck-fixes'
      Merge branch 'bwh/usr-dependencies'
      NEWS: Begin a NEWS entry for the fsck and /usr-mount changes
      NEWS: Document the possible need to update mdadm INITRDSTART
      control: Ensure cryptsetup is upgraded to support mounting /usr
      Allow passing arguments to hooks and scripts
      local: Call local-block boot scripts to prepare additional block devi=
ces
      control: Add versioned Breaks on lvm2 without a local-block boot scri=
pt
      Merge branch 'bwh/reduce-xz-compression'
      Merge branch 'bwh/fsck-without-hwclock'
      Merge branch 'bwh/usr-stacked-device-fixes'
      local: Invoke local-block scripts from the loop in local_device_setup
      local: Use max(30, rootdelay) as timeout for block device to appear
      Merge branch 'bwh/block-device-retry'
      NEWS: Add an entry about e2fsck behaviour with RTC set to local time
      Releasing version 0.119.

maximilian attems (1):
      scripts/functions: untested without busybox

nandhp (1):
      Fix handling of root filesystem with LABEL=3D/ (/dev/disk/by-label/\x=
2f)

Ben.

--=20
Ben Hutchings
Horngren's Observation:
                   Among economists, the real world is often a special case=
.

--=-RPNJOZUZgZD0NWahvZSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVPdyaOe/yOyVhhEJAQqFbQ//Sj/DQuDl2QxbRSqIRpBBXLn2TPlQdGDc
VFVVZoN2ws49UWrsZ5d5nKwM8xTBShum7bmOQDgYGsaqMTOyFDPUx7E4rzj2bPNm
NRoGR1Wzeqcl13fem5pJ0TW82sztJLoNee6wBV2BuhyJP6f3R4ie0iaiaWcURUS9
jnRdX29VUXrduIKaCoNkh86PS51Vh0l6hV3A79lijzALy460ZdtQVcsyavdrjjqR
qXQDQwyZiGOuxpYsP665p6+EQDRGLE4lol6avhrHr8QTtceqsPDrqYtlEclHnqh0
F5IipDC4XvtB3xIZWTcU0jlgYARPmTBtQMGujAcYtWq4CPfwRbARDCkhus8GVRBx
0gHDFSe7NzEmSIP9KfRjDdSV6C5CfsAmLpOL7Mneebvnlm9Rn7l3Ywyj2Gk9eJWF
8j24MpkJCUiKFo7JLC98JRdxthMhmBO/utAjygkCsJKQZhxfOhh654VwBgMIg2Pb
nsy1kIhYM30SDeYZ9Bs4z2LZgcnkkqYY5i6mg/pol2h+flo7iK2Z1tlVXrza+TAO
ksQGfjlGhAqRBtWFHewRWPlU6vcQacY2nPjofhLFJBPd9R3vRBpbyCL+NXPIxAkU
m6MUAQRBSXYdajRo7Mxk7Dya9NiOOCqbOVA6f8457cYpwR+1yGdRpmXaflnWwluI
oKuTPCP705U=
=Bald
-----END PGP SIGNATURE-----

--=-RPNJOZUZgZD0NWahvZSU--
