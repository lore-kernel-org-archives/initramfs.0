From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: initramfs-tools 0.137 release
Date: Wed, 29 Apr 2020 19:57:03 +0100
Message-ID: <adf50227e1ad1093b4ab5365344d609f63f7966e.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-zNWY5nl7po2idb2s0UlQ"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--=-zNWY5nl7po2idb2s0UlQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes a number of bugs reported to Debian, including a
regression in 0.136 which can cause graphics drivers to be included in
the initramfs unnecessarily.  The shortlog is below.  Note that the
commit with a description referring to "libgcc_s.so.0" actually uses
the correct filename, "libgcc_s.so.1".

Ben.

AP (1):
      hook-functions: Search for firmware under /lib/firmware/updates

Ben Hutchings (7):
      Document copy_exec as usable for shared libraries
      hook-functions: copy_exec: Copy libgcc_s.so.0 along with libpthread.s=
o
      hook-functions: copy_exec: Correct verbose log message for symlinks
      hook-functions: Factor out device class walking into a function
      hook-functions: Don't add backlight modules if we have generic fb dev=
ice
      Fix new shellcheck warnings around unquoted parameter expansion
      Releasing version 0.137.

--=20
Ben Hutchings
Horngren's Observation:
              Among economists, the real world is often a special case.



--=-zNWY5nl7po2idb2s0UlQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl6pzgAACgkQ57/I7JWG
EQmLPQ/+KdrNYDmMvsQEry24kiFjMEV4I+f0f09fvPhb2Rp/oJm3b5GyQXKK1MQY
XfCzETDVnsaD0OuIqBedSIgPpaZdHAfvcH3yPjJjqJU0MzvGe1ZMcmsVUTWtuJS8
rWEmbdzV7SWW1A+N20m4jh/0VzdQWP81V9f1SqXa2khCnPvJlRUrzgTwIWgOrDxT
OUTFYU4lRo59Le4ucdQunZbqqLL2iwWpminks2U9+D2Qm2Dha/NQRoHgero+w8Mb
aVBqbDTJaQhQyOnvsfryeWLcQvobHxVWbXfdzFwFe31mKynqKp7wXCKP9WWEQOkT
n5s90GgNexSIrYmpRtsFAOdh4nD55IQiueR+/dEK4C5thGHjiPEqaG8IFCVHmg6J
3DSQcjsJNYGUIVKIWtRCD7NPk4QKqStfMJDHZehk1MKmL24FI/UhibA6owPOfqj7
YuUTzSD365Jj+8jciKvDu602J88Y710vnjPvpx4plPEH0+4FfR0Nv9sxQlE8FNaZ
oyD/4SFayrPDLCPXXy7VoPalNXTw8koll86TPZ+bu9+TvDpCWSGDjexBqcqmD3I2
oe2YBBL1u2ofWsZkXjIwsJc3n5kBR/cD6iN70nWTZ2I4v4+mrY2bxCNuPLQK5GCg
ZXlh1CFkwNEXkqGh16MsoFdb4CLSOSvin9u3m/5kMUu5FipF3hw=
=3F2A
-----END PGP SIGNATURE-----

--=-zNWY5nl7po2idb2s0UlQ--
