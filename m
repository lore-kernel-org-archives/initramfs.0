From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: [ANNOUNCE] klibc 2.0.9
Date: Fri, 30 Apr 2021 01:47:34 +0200
Message-ID: <d3f1107ee2eb7ca5308d8346ed1d8f7b5549dc3e.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-e/iIkK3VhE/tQ93Npu3K"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
To: klibc mailing list <klibc-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oss-security <oss-security-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org>


--=-e/iIkK3VhE/tQ93Npu3K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have released version 2.0.9.=C2=A0 This is available in the git
repository at:

=C2=A0=C2=A0=C2=A0 https://git.kernel.org/pub/scm/libs/klibc/klibc.git

and as a tarball at:

=C2=A0=C2=A0=C2=A0 https://mirrors.kernel.org/pub/linux/libs/klibc/2.0/

Security fixes:
- Integer overflows in heap functions (CVE-2021-31870, CVE-2021-31873)
- Integer overflows in cpio (CVE-2021-31871, CVE-2021-31872)

New features:
- Signal handling on alpha, s390(x), and sparc no longer requires
  stack trampolines, and the stack should no longer be executable
- The finit_module() system call has a wrapper function
- arm64 builds can be done using LLVM's lld; other architectures may
  also work

Other bug fixes:
- Signal handling on alpha and ia64
- Crash in vfork on ia64
- Build failure with older versions of make
- Build failure for some binutils configurations

Other changes:
- riscv64 builds now use linker relaxation
- Various warning fixes
- dash build uses mktemp command instead of tempfile
- Static library builds are now always reproducible, rather than this
  being optional

Thanks to Microsoft Vulnerability Research for reporting the heap bugs
and going some of the way to identifying the cpio bugs.

A git shortlog of changes since version 2.0.8 follows.

Ben.

Andrej Shadura (1):
      [klibc] dash: builtin: Default to mktemp, not tempfile

Andrew Delgadillo (1):
      [klibc] support llvm's lld for arm64

Ben Hutchings (32):
      [klibc] 2.0.8 released, next version is 2.0.9
      [klibc] alpha: Fix definitions of _NSIG and struct sigaction
      [klibc] signal: Add compile-time check on signal types
      [klibc] signal: Note another reason to define _KLIBC_NEEDS_SA_RESTORE=
R
      [klibc] signal: Add sysconfig setting to force SA_SIGINFO on
      [klibc] s390: Set sa_restorer for signals and disable executable stac=
k
      [klibc] alpha: Pass restorer to rt_sigaction() and disable executable=
 stack
      [klibc] sparc: Set sa_restorer for signals and disable executable sta=
ck
      [klibc] signal: Move rt_sigaction() argument mangling to arch directo=
ries
      [klibc] signal: Add config flag for additional sigaction fixup
      [klibc] ia64: Fix definition of struct sigaction
      [klibc] ia64: sigaction: Make signal updates atomic
      [klibc] README.klibc: List alpha and ia64 as "working"
      [klibc] README.klibc: Refresh architecture list
      [klibc] Kbuild, klcc: Support multiple objects in KLIBCCRTSHARED
      [klibc] riscv64: Make linker relaxation work and enable it
      [klibc] klcc: Force make to use a shell to run 'command'
      [klibc] Move linker option probing to Kbuild.klibc
      [klibc] Kbuild: Rename LLD to LD_IS_LLD
      [klibc] Replace all the remaining instances of -Ttext-segment
      [klibc] Make typesize extraction more robust
      [klibc] zlib: Suppress implicit-fallthrough warning
      [klibc] Kbuild: Always build static library reproducibly
      [klibc] losetup: Fix warnings about __u64 arguments to printf
      [klibc] Define SIZE_MAX in <stdint.h>
      [klibc] tests: Add test for malloc size arithmetic
      [klibc] malloc: Set errno on failure
      [klibc] malloc: Fail if requested size > PTRDIFF_MAX
      [klibc] calloc: Fail if multiplication overflows
      [klibc] malloc: Fail if block size is out of range for sbrk
      [klibc] cpio: Fix possible integer overflow on 32-bit systems
      [klibc] cpio: Fix possible crash on 64-bit systems

Bill Wendling (3):
      [klibc] dash: shell: Fix clang warnings
      [klibc] dash: shell: Fix clang warnings about format string
      [klibc] kinit: use an enum to silence a clang warning

Jessica Clarke (2):
      [klibc] ia64: Fix sigaction function implementation
      [klibc] ia64: Fix invalid memory access in vfork

Nikita Ermakov (1):
      [klibc] SYSCALLS.def: Add finit_module() system call

--=20
Ben Hutchings
I'm not a reverse psychological virus.
Please don't copy me into your signature.

--=-e/iIkK3VhE/tQ93Npu3K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmCLRZYACgkQ57/I7JWG
EQliXw/+Nf3SOWPCltXj3Y73LonCO6A8KgaDdqy/4m8cQ8kd34dDuyiVxuZ5zufA
OZNh+t6ihkSNRcBeCANFEA6Z0gFqeN0dKfnKs1UnT3zpSZ7YAi1fwzNSRwG8T+Lx
y7O2iXLQo8/fIqeSg/RdfipLUtYfmbxT+GqulJP8craiC5SluCekgOc6wsMOGxCA
VfRM0Jv4rzZmbK3WtElwpVqvistiBEtd6P4Q8XpQLjreiy7p5agRHyXRD//w9fke
3NxiRbIY2lgZgMEL2JjE2Oe6TFYJxCF0fSKjZQvwdMjemM05jeNC/BI3g1B07Yhd
rYMThkfER5W8ikiSss5zRd5K2Qntxyl4e6REImXCLFowvTL4dYvtZPYrUXwTAU6N
3Py3c+WQw5beWxd9+ja5WWXyZcE93Q4Ck2/dXoq1Nwcuqp69vrNA6u1K5FYsfR0D
lIYNnWBYOxoB6D/NUr4oryCyx/gxD/0t4XUDv4l1zbli8Trrl38ED9U5iAyI0W20
gJ/AhRAboz4XeIPu6K4t2jOeZ5+dhHL3J3pTfN7ZndObUhQGIG+3vN3pxTYJ9DRo
UOb/PlqPfLfEaQT77yyIdjJD12NaTI+FlEBjPr4CTh+UeYpNQxb6PE1vtLKRRdx3
qRxhWE4MKnl3823z5D2Htm14m704U78BiUDnZz0Ak8UQgs4HyuE=
=qYOW
-----END PGP SIGNATURE-----

--=-e/iIkK3VhE/tQ93Npu3K--
