From: Michael Prokop <mika-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: initramfs-tools 0.109 release
Date: Sat, 6 Oct 2012 00:52:48 +0200
Message-ID: <2012-10-06T00-49-24@devnull.michael-prokop.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lwdfKABU4AhUWl+O"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--lwdfKABU4AhUWl+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

the initramfs-tools 0.109 release addresses #689336 to provide a
check for loadkeys/setupcon and inform the user if KEYMAP=y is set
(as done by crypsetup, see #689722) but one of the tools is missing.

git shortlog:

  Michael Prokop (2):
      keymap hook: provide warning message if loadkeys/setupcon are not available
      Releasing version 0.109

regards,
-mika-

--lwdfKABU4AhUWl+O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlBvZMAACgkQ2N9T+zficuiaEQCdEymwpTAK6bUc9yHh2WbhwQn9
bvsAn1ggU5EqXXA51FG1QHmfnrqEOu5r
=47fL
-----END PGP SIGNATURE-----

--lwdfKABU4AhUWl+O--
