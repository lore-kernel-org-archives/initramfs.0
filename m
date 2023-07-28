From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: [ANNOUNCE] klibc 2.0.13
Date: Fri, 28 Jul 2023 03:00:40 +0200
Message-ID: <688a7863c7023794bb8e93b6d526e8fab4336fb2.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-IYf0GuNvETFHCDPdwvuU"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
To: klibc mailing list <klibc-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-IYf0GuNvETFHCDPdwvuU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have released version 2.0.13.=C2=A0 This is available in the git
repository at:

=C2=A0=C2=A0=C2=A0 https://git.kernel.org/pub/scm/libs/klibc/klibc.git

and as a tarball at:

=C2=A0=C2=A0=C2=A0 https://mirrors.kernel.org/pub/linux/libs/klibc/2.0/

New features:
- The statx() and clock_{gettime,settime,nanosleep}() system calls are
  supported.
- time_t is 64-bit on all architectures.
- The LoongArch64 architecture is supported.
- kinit supports kernel parameter root=3DPARTLABEL=3D...

Bug fixes:
- select() with a NULL timeout works correctly when select() is a
  wrapper function.
- ipconfig no longer busy-polls in certain conditions.
- It's possible to build for MIPS64 R6 with newer gcc versions.
- The command aliases of gzip and halt are installed as links instead
  of copies.

Other changes:
- All architectures use the RT signals API (i386, m68k, and s390(x)
  previously did not).
- The address layout for arm and riscv64 has been changed to work
  around a QEMU bug.
- ipconfig retries failed sends after 1 second instead of 10 seconds.

A git shortlog of changes since version 2.0.12 follows.

Ben.

Ben Hutchings (20):
      [klibc] 2.0.12 released, next version is 2.0.13
      [klibc] m68k,s390,x86: signal: Stop using broken <asm/signal.h>
      [klibc] i386,m68k,s390: signal: Switch to RT signal API
      [klibc] signal: Make RT signals mandatory
      [klibc] resource: Avoid using <linux/resource.h>
      [klibc] stat: Make all stat calls wrappers for statx()
      [klibc] utimes: Make all utimes calls wrappers for utimensat()
      [klibc] select: Remove support for pselect7() syscall
      [klibc] select: Fix handling of NULL timeout when wrapping pselect()
      [klibc] select: Make all select calls wrappers for pselect6()
      [klibc] time: Use clock_* system calls for time-of-day and sleep
      [klibc] time: Use 64-bit time types on all architectures
      Merge branch 'time64'
      [klibc] ipconfig: Do not poll sockets we don't intend to read from
      [klibc] ipconfig: Handle error events from poll
      [klibc] ipconfig: Retry failed send after 1 second
      [klibc] mips64: Compatibility with R6 compact branches
      [klibc] arm: Move shared library below executables
      [klibc] riscv64: Move shared library below executables
      [klibc] Install command links as appropriate
=20
Feiyang Chen (1):
      [klibc] Add LoongArch64 port
=20
Rob Vandermeulen (1):
      [klibc] kinit: Support specifying root with PARTLABEL

--=20
Ben Hutchings
Design a system any fool can use, and only a fool will want to use it.


--=-IYf0GuNvETFHCDPdwvuU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmTDEzgACgkQ57/I7JWG
EQlk2BAA091Z4tt6ywuBGC8d5PQwXU5hL89y6le5aOdJb8mNEThwC3s5viSNoYv+
g1rrzp57fporhFntr/2ngYTEvxOe8qlaPBAO6p8hFwMrUy/YIK1j470EzbjhqvJs
EBHMDe0+SXefx4GjCC/tQMoGNw44wiCHuDyW9vC1+L2qL5wiSRpG/QztIxrACBAt
yFhyqvLr5Jj0ztg6m1/Ln/UdFyDmXpqBA7JliZr0xt3I6AwbFA9/GPN56NQnrhem
z+XZGCySxtvaM77OH69iupHFePaSSCB6Hh81LdXEoB+JGqxrSAp+ZL1TlfYBhnpK
YqeIS1Fc+5FF43r7u0S+jvwXjMEchPXgEbv+4lalyBIQTt/nfSenejqcVTUQBf66
Bc4OQ8bEyEaJawduIQiVIy3SfMom7u4eWpRxnzr4bN4s05KfZALhMy8YbZT/GSng
VJhCRDqGy1U32e+bFyP1B5xYr/EyRRM4WejuiMeEtpBWuE8H0T1a2lly2yXpn9Gh
5/2QZQ62rCj2cpGYD+FOkv2Rzb/CAA5Rd3Trs+hB/ueHpqKhQgl/bOyW1DeAe2kV
w/Ej+75buSouZEu+tp8K//kYmE/jsRWJZiSMVzMWxOsXM35D/PnFQczrWd62jEq0
ILP4vr98a5Vy61TUgQJy6hwexYUUpKI0bvrtxdEWcQTh3bgsEvY=
=9NsA
-----END PGP SIGNATURE-----

--=-IYf0GuNvETFHCDPdwvuU--
