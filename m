From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [PATCH] Use modinfo to gather module dependencies
Date: Mon, 27 Feb 2012 13:39:20 +0100
Message-ID: <5302218.kzCNfpoIIU@samson>
References: <2369135.eJzU9GBXlg@ernie> <CALAkbJMqL-p95Yb=jsP8BZAjhJkByHn-QZV=C0nmsTkMW1qZ1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8990860.hYRauKIK7L"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALAkbJMqL-p95Yb=jsP8BZAjhJkByHn-QZV=C0nmsTkMW1qZ1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart8990860.hYRauKIK7L
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
--nextPart8990860.hYRauKIK7L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk9LeXgACgkQjqfyF1DtJW4DvwCgga7fVu5Iy+sqoVZoHjojoNEL
QYcAnRHHUNCDUZtge4i0Y5KWHXHiBy9x
=RQx9
-----END PGP SIGNATURE-----

--nextPart8990860.hYRauKIK7L--
