From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [klibc] [ANNOUNCE] klibc 2.0.13
Date: Mon, 31 Jul 2023 14:58:26 +0200
Message-ID: <2179500f1c35299452d1e1dc04e85145bb6f5fed.camel@decadent.org.uk>
References: <688a7863c7023794bb8e93b6d526e8fab4336fb2.camel@decadent.org.uk>
         <xr93edko8x8v.fsf@gthelen-cloudtop.c.googlers.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-RngNnuO5yBe+KtkqhWb7"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <xr93edko8x8v.fsf-70RgUwATE2L0OAmNFB7Q3HdI/KCU8OHYLMHrShElKjA@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
To: Greg Thelen <gthelen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, klibc mailing list <klibc-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-RngNnuO5yBe+KtkqhWb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2023-07-30 at 22:29 -0700, Greg Thelen wrote:
[...]
> Is there a minimum kernel that klibc is expected to build against? I ask
> because klibc-2.0.13 includes a change that requires kernel 5.11+.
[...]

I don't currently keep track of what the minimum version is.  But in
general, you should expect it to require a recent version at both
compile- and run-time.

Ben.

--=20
Ben Hutchings
Design a system any fool can use, and only a fool will want to use it.


--=-RngNnuO5yBe+KtkqhWb7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmTHr/MACgkQ57/I7JWG
EQnS4Q//ePZ7kggN7I/VBywtaJwAmGkiUXuyzQ7ujfYFh1VaYSh8N5Ib1Ynlzp7K
6Iu4NJ7fiKz/YASqPK3vPyER9oMaRXeYy08JHabDyYezcFM4VcpfopFzUcDmSOLy
4Kc0K9BXoB0jzY1Ui+ScOhrZd9Nrrnq7MGxnwMBCuA0MnI39bpgTOu6eqlIGXYmY
z1aGKdT5WypI5rXfMGM3lfW6GRgQNPWhhNYvf6qh4rqB7/aHI7aAi/CQoXJMljOc
oQzc1RHFmG0907K1ybFsZUy6z7wvXo5kY3fddcSDX/c/9SjNM99GQ4iv1xh6qsM6
+zi+u1byxFLpPih4mTZaYbcHKDgYFsmzE/UrMrhO/eZTQDEtrLVs/gXwy+gldO3J
ACCHSoSZvE/07gfTjljBWnfYPBqIyQn7NWPX9Y5rkyJyzNXKKJGKAyxxKOOInFkT
vnkz2PDgx7RrIEz+GwggtqcdCBCRwzpdW7UZZ2X2o2zarmEL3VM5O7cx/bq58c3w
n2xwY5/s38lUePy7N9Jqt2AN9UMvcZZle9yNggsIAjFen69knNDREL7DI+yUDXRF
kHEAn0oHmIAezOgvwcNL247MfbR2kVcwZm+f7IU88tLtCPVZArlrWeEeR2n9ZQNl
8nJFI+w9Qb7yN+Loa3JwntugkyuYu+8zSnlgXcJfXUXRIs7AKH4=
=pmj5
-----END PGP SIGNATURE-----

--=-RngNnuO5yBe+KtkqhWb7--
