From: Scott James Remnant <scott-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>
Subject: Re: initramfs-tools stable release 0.93.3
Date: Thu, 11 Jun 2009 11:42:07 +0100
Message-ID: <1244716927.4532.34.camel@quest>
References: <20090610153017.GA19401@stro.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-+JWQRV6WUflwoJFsPzYp"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090610153017.GA19401-U9r9yeDMy7A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org


--=-+JWQRV6WUflwoJFsPzYp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-06-10 at 17:30 +0200, maximilian attems wrote:

> hook-functions: Add i915 module for kms.
>=20
This is exactly the kind of bloat I want to avoid for the initramfs.
The initramfs should do one thing only, that's mount the root filesystem
and chain load into it.

Anything else is an extravagance.

Why load the KMS driver in the initramfs?  Because it takes too long to
get to the point in the real system where we can load it!  Why does it
take too long to get there?  Because we spend so long in the initramfs!

Slimming the initramfs right down to the essentials reduces the boot
time by over a second!  Paradoxically, this means that the driver can be
loaded in the real system at roughly the same time point as it would be
loaded in a bloated initramfs.

Scott
--=20
Scott James Remnant
scott-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org

--=-+JWQRV6WUflwoJFsPzYp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkow338ACgkQSnQiFMl4yK6LSQCfQMUECbGsGtMJwL8coT1IYw+s
n1UAoJwitjl4wyTxaGnnSZzmwEZiUGzr
=OeL7
-----END PGP SIGNATURE-----

--=-+JWQRV6WUflwoJFsPzYp--

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
