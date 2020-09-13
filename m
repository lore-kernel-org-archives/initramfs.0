From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.139 release
Date: Sun, 13 Sep 2020 20:21:34 +0100
Message-ID: <e846559ec1c637d1e476f259b7d67425e80a439b.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-uX/8s3iOuJKR74OytAD4"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-uX/8s3iOuJKR74OytAD4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This announcement covers changes in both 0.138 and 0.139.

This release fixes a number of bugs:
- Regression in 0.137 for architectures where libgcc_s.so has soversion
  > 1
- Incorrect console parameter could lead to boot failure
- The "panic" kernel parameter's value was not interpreted consistently
  with the kernel

It adds several features:
- zstd compression support
- Automatic inclusion of firmware wanted by built-in drivers
- Automatic inclusion of drivers for Pinebook LCD

It also adds functional tests that can be run by autopkgtests.
Currently these are limited to the amd64 architecture.

Possible breaking changes:
- For compatibility with older kernel packages, update-initramfs used
  to do nothing when invoked directly by a kernel package rather than
  through its kernel hooks.  This check has been removed.
- The state directory /var/lib/initramfs-tools, which was once used to
  track which images were "owned" by update-initramfs, will be removed
  on upgrade and no longer updated.  update-initramfs already ignored
  its contents since version 0.132.
- The kernel parameter "panic=3D0" used to result in an immediate reboot
  on panic, and now results in a halt.

The shortlog is below.

Ben.

Ben Hutchings (27):
      docs/maintainer-notes.md: Delete the horizontal rules
      docs/maintainer-notes.md: Use Gitlab markup for table of contents
      docs/maintainer-notes.md: Use Gitlab markup for definition table
      docs/maintainer-notes.md: Use archive.org URL for Daniel Baumann doc
      debian/control, docs/maintainer-notes.md: Use my @debian.org address
      Merge branch 'master' into 'master'
      Merge branch 'fix-return-printf' into 'master'
      Merge branch 'add_zstd_format' into 'master'
      update-initramfs: Remove test for direct invocation from kernel packa=
ge
      Remove obsolete update-initramfs state in /var/lib/initramfs-tools
      hook-functions: copy_exec: Copy libgcc_s.so with any soversion up to =
9
      Add CI configuration for salsa.debian.org
      initramfs.conf: Delete "NFS Section" comment
      Add FSTYPE config parameter to allow overriding filesystem type detec=
tion
      Change "panic" parameter handling to work more like the kernel
      debian/tests: Add common test preparation code
      debian/tests: Add basic test for amd64 using klibc and not busybox
      debian/tests: Add basic test for amd64 using busybox
      debian/tests: Add basic tests for amd64 with only ata/virtio driver
      debian/tests: Add test for separate /usr device
      debian/tests: Add test of the panic shell and parameter handling
      Merge branch 'builtin-firmware' into 'master'
      Releasing version 0.138.
      debian/tests: Run amd64 tests on either amd64 or generic flavour
      debian/tests/control: Mark all amd64 tests as skip-not-installable
      conf/initramfs.conf: Fix typo "filesytem"
      Releasing version 0.139.

Guilherme G. Piccoli (1):
      scripts/functions: Prevents printf error carry over if wrong console =
is set

Jann Horn (1):
      Add firmware for built-in drivers

Norbert Lange (1):
      un-,mkinitramfs: add support for zstd

Unit 193 (1):
      When overriding configured compressor, warn the user.

Vagrant Cascadian (1):
      hook-functions: Add modules needed for Pinebook LCD display.

--=20
Ben Hutchings
Humour is the best antidote to reality.


--=-uX/8s3iOuJKR74OytAD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl9ecT4ACgkQ57/I7JWG
EQlpuw/9HPvizMbDnDT+Xl78pApmzTVdDdljNE3LiObW3JyweUHpf5nEo89E0tPS
VOK2N2UAVT0zPiJxwooj2WG7Spmd0OXYOFVNHr2DI3JjlMKE/+/hPn0DMtPJ4fgK
hhfZCUnz89bYa5mqr6y09LKaLNjBzRDErhLiFgMuf7zDQfJ+Y5YGzGbCFsbAd8b9
SuO0ycWMzHU9qy0k09B4YL2fxRAZNG3DVGWREIfqtTds6/Ne0CtNDLKp1ZAZiG9h
ioXJBfIOqhZFZZy0T1GBwpPRsVsy/M/gJwzttaJ9OOjBJlyyWqSp9UDg1jPU7Bnt
ZVcianszMu3GoQP5lBd37oaClHWVxsKZIugeP7gLK7yRQONkrUk7G7V8iEvrip1i
eTOGEuwpRlKNsU3Lh4gTADSMDKI3FqCTkbXoVB4aLRxFa+K79BlCCo0wldpFCxEK
0dHjSaU5ue6V65YAjCAEDJityo7XXJVnTPhS0pRJimHGkqsLSnmRbB+BTjMzXd+e
Tm6HGfKxaqAlR0gCw/Ws/feqG9TDy2fR14fD1XXkhVHRkXxMPrsBMLZ2qfFBti0G
D5/+YsmeRXTVaSJNnY7+co3RIVljOHRJQWBQN0KUPnfyC6pH934kQldEVhHZc7Sq
34fz41HZDjUQ7g8A4nrZgPS326QmkU2dmf+i9hZ6XTLvq4OrbxQ=
=Ueh2
-----END PGP SIGNATURE-----

--=-uX/8s3iOuJKR74OytAD4--
