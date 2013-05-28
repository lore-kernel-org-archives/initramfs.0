From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: PROBLEM: Errors in instmods_1 are ignored
Date: Tue, 28 May 2013 16:09:38 +0200
Message-ID: <7214709.kLtJDThxKr@ernie>
References: <6426657.ZbTK3INMtd@ernie> <51A49C8E.2040201@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10623716.z6XyPhq1DS"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A49C8E.2040201-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart10623716.z6XyPhq1DS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello Harald!

Am Dienstag, 28. Mai 2013, 14:01:18 schrieb Harald Hoyer:
> On 05/09/2013 01:18 PM, Dennis Schridde wrote:
> instmods -c a b c || exit 1
> 
> will give you:
> 
> F: Failed to install a
> 
> and dracut will exit.
So this could be used to implement variant 2 of my "expected behaviour. It 
would be nice if you could change dracut in this way. :)

> instmods ignores the errors.
It seems to me it currently does not. At least no module that comes after the 
failed one in the list is being installed. When looking at the code, errors 
indeed seemed to be ignored.

Best regards,
Dennis
--nextPart10623716.z6XyPhq1DS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iEYEABECAAYFAlGkuqYACgkQjqfyF1DtJW7t+ACeNRZLx6aOfJ9IaLAQ9mFHloWd
ygoAnR8AjrGZnS+VAPNallLkFp1cUQ/3
=fegG
-----END PGP SIGNATURE-----

--nextPart10623716.z6XyPhq1DS--
