From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: [ANNOUNCE] klibc 2.0.8
Date: Sat, 22 Aug 2020 02:19:09 +0100
Message-ID: <efdb4a196643182753c5aa1e667f15a01a0963e1.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-KKv0Hy+yEXBZ+wd8VH+j"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: klibc mailing list <klibc-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-KKv0Hy+yEXBZ+wd8VH+j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have released version 2.0.8.  This is available in the git
repository at:

    https://git.kernel.org/pub/scm/libs/klibc/klibc.git

and as a tarball at:

    https://mirrors.kernel.org/pub/linux/libs/klibc/2.0/

New features:
- Support for building with clang and lld, at least on x86
- Defined sysconf(), initially supporting only _SC_PAGE_SIZE
- Defined clearerr() as extern
- Defined stdio _unlocked functions and macros
- Support for building without bash

Bug fixes:
- Fix build regression with gcc 10
- Executable stacks are disabled on architectures where they are not
  needed
- fstype no longer checks whether an ext4 module is installed, which
  did not work correctly with compressed modules
- losetup uses the kernel's structure definitions, rather than its own
  which were wrong for some architectures
- ipconfig ignores extra fields in the ip and nfsaddrs kernel
  parameters, rather than treating them as an error
- Various warning fixes

Other changes:
- Removed cris port
- losetup always uses the modern loop ioctl API
- dash changes from upstream are documented

A git shortlog of changes since version 2.0.7 follows.

Ben.

Antonio Ospite (2):
      [klibc] dash: shell: Fix clang warnings about "string plus integer"
      [klibc] dash: output: Fix clang warnings about GNU old-style field de=
signator

Ben Hutchings (26):
      [klibc] 2.0.7 released, next version is 2.0.8
      [klibc] fstype: Drop obsolete support for "ext4dev"
      [klibc] losetup: Fix char signedness mismatches with <linux/loop.h>
      [klibc] losetup: Delete fallbacks to LOOP_{GET,SET}_STATUS
      [klibc] losetup: Use LOOP_CTL_GET_FREE to find free device
      [klibc] ipconfig: Document support for DNS server addresses
      [klibc] ipconfig: Ignore NTP server address and any additional fields
      [klibc] Kbuild: Tell gas we don't want executable stacks
      [klibc] dash: README.dash: Change patch sync commands to use mailbox
      [klibc] dash: README.dash: Do all patch filtering with filterdiff
      [klibc] dash: README.dash: Include "dash:" and upstream commit in pat=
ches
      [klibc] dash: README.dash: List the changes from upstream
      [klibc] Suppress format truncation warnings for sprintf() and vsprint=
f()
      [klibc] ipconfig: Fix alignment of packet structure
      [klibc] nfsmount: Fix alignment of packet structures
      [klibc] README.klibc: Document the KBUILD_REPRODUCIBLE variable
      [klibc] arch: Remove cris port
      Revert "[klibc] Kbuild: Tell gas we don't want executable stacks"
      [klibc] Kbuild: Add a per-architecture option to disable exectable st=
acks
      [klibc] arch: Explicitly disable or enable executable stacks
      [klibc] Kbuild: Fix the compiler execstack option
      [klibc] stdio: Add extern definition of clearerr()
      [klibc] stdio: Define all the _unlocked functions and macros
      Merge remote-tracking branch 'origin/sysconf'
      [klibc] tests: Add a trivial test for sysconf()
      [klibc] klcc: Treat CC, LD, STRIP as multiple words

Bill Wendling (5):
      [klibc] Kbuild: add support for clang builds
      [klibc] Kbuild: support clang's lld
      [klibc] Kbuild: Add "-fcommon" for clang builds
      [klibc] Clean up clang warnings
      [klibc] use "--just-symbols" for compatibility with LLD

Dimitri John Ledkov (1):
      [klibc] loop: switch to linux/loop.h

H. Peter Anvin (1):
      [klibc] Framework and trivial implementation of sysconf(3)

Olliver Schinagl (1):
      klcc: Remove the need for bash

--=20
Ben Hutchings
When in doubt, use brute force. - Ken Thompson



--=-KKv0Hy+yEXBZ+wd8VH+j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl9Aco4ACgkQ57/I7JWG
EQluoRAAjtRILMHGZQaQxOTtnIJIOAX4oj6jfDoLK93kLqL+JFyKFcEUDPO+kGhk
b9wkrkCEKk0J2eQpj7oTtDMwANO+fRZY6EcSqmk3Kn4ZlN9GFn42LrtkErs4UY3G
BT4VTQzPmrWAH/lYt8GWOXs2Zf1A5XoNxlNlgH8CZVNjOdN6j/wcaNqUehPuVBPG
ayEYczWa9b6fcY6A30IIxAAsLUolLuVv5sS58ZZyDkSdwi25pjP1E4LD3F2XwwKd
gwjWxEnQ+lJdzWyFvzk7ZBZUq301IwStgiyhG6Lyq0VK2KUhxfbeQHpQZth+l3iu
4iBOaeq8qJKqKz9azlKKK5Ug/gHqtwrPt+drgb2CZVzCjAhDImPwxQHrG+8JqyVJ
YmW1Wh8+NCPfxtcispogCmqHDDd2Vh/po7PdmiGtvnhSMQeMFmEuDIfpvz9gBw92
SRtNODTnAREAzZS8GZM8MVsmnqps4w8aCLpWOWpL/34vL/+zFh66yHskTIyhaa7L
JlEW02kYot7Q+SKakRbQ+FtbH3cLDiXWeTjCHcP4Hvar0/u4DZPTdsCfhN8186OM
cRxnufbB0PtGbnI0DeI5LhjlQJ62UGwVHEDLUKO990kn6c6rnwZRaERzhori9p9r
oV1gigKhZ3gLjD2O7YHNfYJOpaP4XO7NYpmLQhxI4Wx1mIxOnWQ=
=FU8J
-----END PGP SIGNATURE-----

--=-KKv0Hy+yEXBZ+wd8VH+j--
