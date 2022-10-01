From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: [ANNOUNCE] klibc 2.0.11
Date: Sun, 02 Oct 2022 01:54:15 +0200
Message-ID: <a059cb1a79928f64adc3a2401482bb149e604cf4.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-vmDJq+t3+clMr6sEjf0G"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
To: klibc mailing list <klibc-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-vmDJq+t3+clMr6sEjf0G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have released version 2.0.11.=C2=A0 This is available in the git
repository at:

=C2=A0=C2=A0=C2=A0 https://git.kernel.org/pub/scm/libs/klibc/klibc.git

and as a tarball at:

=C2=A0=C2=A0=C2=A0 https://mirrors.kernel.org/pub/linux/libs/klibc/2.0/

New features:
- The insmod command has been reinstated

Bug fixes:
- Fixed build failure for some architectures with Linux 5.19 headers
- Fixed infinite recursion in calloc() when built with Clang 14
- Disabled executable stacks in statically linked executables
- Ensured that all executables have some static data, avoiding ELF
  loader bugs affecting executables that have only BSS
- arm64: Fixed overwrite of 4 bytes after errno
- A couple of fixes for out-of-tree builds

A git shortlog of changes since version 2.0.10 follows.

Ben.

Ben Hutchings (9):
      [klibc] 2.0.10 released, next version is 2.0.11
      [klibc] ia64: Fix out-of-tree build
      [klibc] Fix header installation from out-of-tree build
      [klibc] Kbuild: Properly disable executable stacks in static builds
      [klibc] README.klibc: Add note about headers_install in cross-build
      [klibc] README.klibc: Update note about building compat user-space
      [klibc] fcntl: Fix build failure for some architectures with Linux 5.=
19
      [klibc] Work around ELF loader bugs when executables have only BSS
      [klibc] zalloc: Fix infinite recursion with Clang 14
=20
Greg Thelen (2):
      [klibc] Revert " remove local insmod.c copy"
      [klibc] arm64: store 4 bytes in arm64 errno

--=20
Ben Hutchings
Hoare's Law of Large Problems:
   Inside every large problem is a small problem struggling to get out.

--=-vmDJq+t3+clMr6sEjf0G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmM40ycACgkQ57/I7JWG
EQlZqg//cPAac+HvWu7THFqP1UCc9QVk9KH/RfoGjh9SlgW9aXwAblYANm2Zpzi/
1Xrw5Rzj0jE5dXQZqjwCtswBMN4poqqAtj2Vx7gsck5EnnCRFxmhyjYLkPTNqxa3
2EjHkZJodBUy+ojfwUZbd3YFhCFdr0Hu9IdxKgNJFY9KMVtay287q+960KDnjbhz
E/h769TevJC7JfTvnLazRHBZlypdMqR1fnVF20P73ABTx0ypJ0iDD+iTr6AitOLL
BcAIsWwyC+UkGVLeMdQo5t/kNQvunXSjNhwsQguP9VXc5a0ZtUNvm1aUG+HpMAqe
NZDNBgW22SI7TLBy0qZ7a4pIU1qaikAfOXggqie/rlwt/snjTosNJAGGx3IiWKim
BC5FKkbrNRL1MFREftCkodXrAKwlLNMcCPRrDfSR2v654nK+Jj6NSRiLffIq7hK5
DiZ8eknItkERTuah5nv37CjIqmFkILQJtrYlryiL549ApdYcJ/IfiyZYg/EBE3fs
xQ9jRfwuSoon8ASunso2cf5kpvs0JjTnkqmfYYkeXvlyGvwRFCqsmF1ILSak7fn/
53zRfW7YUXH8JuEd0aLDQVxKylMubMLwS35Ewlpsh2IgKcCrOifPg4mNbOBSltpz
NkIuV4Fe6iC16Nw9sphX/N+r0yuBU35Vps1XPjTFCnUQ2qWETaM=
=t1vc
-----END PGP SIGNATURE-----

--=-vmDJq+t3+clMr6sEjf0G--
