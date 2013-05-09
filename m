From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: PROBLEM: Errors in instmods_1 are ignored
Date: Thu, 09 May 2013 13:18:02 +0200
Message-ID: <6426657.ZbTK3INMtd@ernie>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2451064.2sNN1STat3"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart2451064.2sNN1STat3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!

I found a problem with add_drivers / module installation.

Current behaviour:
When instmods_1 cannot find a module (for example), it returns an error (1). 
It's caller, instmods, aborts the installation of any further modules and also 
returns an error (1). dracut then ignores that error and does not even output 
a warning.

Expected behaviour:
Variant 1: instmods outputs a warning when instmods_1 returns an error, but 
continues to install the other modules.
Variant 2: dracut outputs an error message, including the module that failed, 
and aborts the whole operation.

See also: https://github.com/haraldh/dracut/issues/8

Best regards,
Dennis
--nextPart2451064.2sNN1STat3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlGLhf4ACgkQjqfyF1DtJW5wHACgktJ0TPGw454ITlLwSCr9/G/I
yGwAoLILb8IboA7OChH9dnX1ZBcUogaX
=q+w2
-----END PGP SIGNATURE-----

--nextPart2451064.2sNN1STat3--
