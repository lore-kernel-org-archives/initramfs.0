From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: Fwd: Re: [PATCH] Use modinfo to gather module dependencies
Date: Mon, 27 Feb 2012 12:33:29 +0100
Message-ID: <3303131.vLqtaXUY2V@samson>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2036196.0D8feHmF6T"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart2036196.0D8feHmF6T
Content-Type: multipart/mixed; boundary="nextPart1927276.V0vVnAxE3k"
Content-Transfer-Encoding: 7Bit


--nextPart1927276.V0vVnAxE3k
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"


--nextPart1927276.V0vVnAxE3k
Content-Type: message/rfc822
Content-Disposition: inline; filename="Weitergeleitete Nachricht"
Content-Description: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>: Re: [PATCH] Use modinfo to gather module dependencies

From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
To: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Use modinfo to gather module dependencies
Date: Sat, 25 Feb 2012 23:21:18 +0100
Message-ID: <1697973.2nlYcIytsy@ernie>
User-Agent: KMail/4.8.0 (Linux/3.2.6-gentoo; KDE/4.8.0; x86_64; ; )
In-Reply-To: <CALAkbJMqL-p95Yb=jsP8BZAjhJkByHn-QZV=C0nmsTkMW1qZ1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
References: <2369135.eJzU9GBXlg@ernie> <CALAkbJMqL-p95Yb=jsP8BZAjhJkByHn-QZV=C0nmsTkMW1qZ1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2698325.TexGhL44Zg"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit


--nextPart2698325.TexGhL44Zg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Harald!

Am Samstag, 25. Februar 2012, 22:18:48 schrieben Sie:
> Am 25.02.2012 22:09 schrieb "Dennis Schridde" <devurandom-hi6Y0CQ0nG0@public.gmane.org>:
> > 
> > Hence I wrote attached patch, switching from modprobe to modinfo, which
> 
> also
> 
> > seem to be the tool intended for the job. This method appears to work
> 
> reliable
> 
> > in kmod-5, but I have not tested with module-init-tools.
> 
> Just update kmod... modprobe --show-depends was fixed
Thanks for the info.

I would like know your reasons for using modprobe instead of modinfo to gather 
information about modules, since it appears to be the wrong tool to me.

Kind regards,
Dennis
--nextPart2698325.TexGhL44Zg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEABECAAYFAk9JXt4ACgkQjqfyF1DtJW7a8ACgmaf4Pcswo8UT1EfJiW6N7v6K
nggAn015Krra6zHjiS/d58Q52S1+BDFu
=neSB
-----END PGP SIGNATURE-----

--nextPart2698325.TexGhL44Zg--

--nextPart1927276.V0vVnAxE3k--

--nextPart2036196.0D8feHmF6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk9LagkACgkQjqfyF1DtJW4eTACfYs9wP2zFs8DUkGAYOnEc0Yo6
goYAn3NcpC4szQZSsI2tX0OZ84ZWUxJn
=O86R
-----END PGP SIGNATURE-----

--nextPart2036196.0D8feHmF6T--
