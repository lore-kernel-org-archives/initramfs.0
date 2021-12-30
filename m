From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: [ANNOUNCE] klibc 2.0.10
Date: Thu, 30 Dec 2021 16:29:43 +0100
Message-ID: <f62bebd13c95321c23cf982dd03c54d6bb57fb35.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Hf2S+WB/2+sg2ji09OpQ"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
To: klibc mailing list <klibc-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-Hf2S+WB/2+sg2ji09OpQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have released version 2.0.10.=C2=A0 This is available in the git
repository at:

=C2=A0=C2=A0=C2=A0 https://git.kernel.org/pub/scm/libs/klibc/klibc.git

and as a tarball at:

=C2=A0=C2=A0=C2=A0 https://mirrors.kernel.org/pub/linux/libs/klibc/2.0/

New features:
- s390x and sparc64 ports can now be compiled using Clang
- arm port can now be linked using LLD

Bug fixes:
- sig{set,long}jmp now honour the savesigs flag
- s390x: {set,long}jmp now save and restore correct FP registers
- utimes used to set incorrect mtime on architectures which do not
  have a utimes systtem call
- Fixed build failure in dash when using Clang 13
- arm64,x86_64: Fixed address collision when using LLD 13
- Headers consistently use definitions from <sys/types.h> instead of
  <linux/types.h>

A git shortlog of changes since version 2.0.9 follows.

Ben.

Ben Hutchings (8):
      [klibc] 2.0.9 released, next version is 2.0.10
      [klibc] Kbuild: Fix include path for Clang builds
      [klibc] Use bounded array parameter types consistently
      [klibc] include: Always include <sys/types.h> instead of <linux/types=
.h>
      [klibc] arm: Remove redundant/unsupported linker option --thumb-entry
      [klibc] s390: mmap: Change inline assembly to work with Clang
      [klibc] sparc64: Remove redundant/unsupported compiler option -mptr64
      [klibc] arm64,x86_64: Fix address collision when using LLD

Benjamin Gwin (1):
      [klibc] Fix implementation of utimes

mirabilos (2):
      sig{set,long}jmp: do not ignore sigsetjmp's second argument
      {set,long}jmp [s390x]: save/restore the correct registers

--=20
Ben Hutchings
Experience is directly proportional to the value of equipment destroyed
                                                    - Carolyn Scheppner

--=-Hf2S+WB/2+sg2ji09OpQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmHN0GcACgkQ57/I7JWG
EQnsNRAAogHb/ikXoFTRvFb4XXRWRqOw3AGUyZs/XUYzwCc0AHHzFOW/zXvSS8iw
4dfPzjb4mehydBDOaRqHEokGT5alBbF2rKzN9nw6IX0e0ySlpeKzsVFAIgJAeIgk
rlCGwhjJXWUeWpyQ+msUotXI1PGYVG9LmTNYsA7LYVY4+qTetjyCR8p6Eejt4VeP
T2TO1JhKEc8qmW7rpNbYZqx9zChuKQHpE2gptpg5Xe8wZLQBPMGeF1DzfTi9QX5H
XLhGycqoEHtArHCmmQfMTCs7atTiO4gzLqs23LjbST1Kgr+dfvHviPKJ65SoZufn
Qwa+4Rptoe2f8ORYierLLIdYvIMq4q5Rs0mkD0zI6MsarWLuS1JaJf2krtXEth9y
FgbCsv2+yDGKtHEvRf13U0e0DzX0IUV3dWeS8+OqGJN324m5kzRGuHRVIdvAm3ar
X5EWIx3gLab7t2qls05oblhmwmNHJG6wLdM3IgSXZuCvS3s1SnftuHDEJGPbWEoX
/3uBX+JICDwmn+dvVC3PhPjEV9Sl7JBW64CznYvhF+hAr+yrET/EdvQVkGJRVDst
UMm4syJmt+3Z54QKnw0+bOpol+Dq8Q3gY6oVz32AIBFC77yVkEe570DprqieAbNG
5XKCLR8z/rMm59mXrlIeYC3l62/0Yrj795wQ5QnG774YjMKvGG4=
=b/LN
-----END PGP SIGNATURE-----

--=-Hf2S+WB/2+sg2ji09OpQ--
