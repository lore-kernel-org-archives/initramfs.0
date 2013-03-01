From: Michael Prokop <mika-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: initramfs-tools 0.110 release
Date: Fri, 1 Mar 2013 12:47:18 +0100
Message-ID: <2013-03-01T12-42-40@devnull.michael-prokop.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

we just uploaded initramfs-tools 0.110 to Debian/experimental,
getting rid of deprecated references to '2.6' and making sure the
changes in recent upstream kernel with the nfsv{2,3,4} split and the
new ehci-pci module are adressed.

The shortlog has the details:

Ben Hutchings (2):
      Bug#697319: [PATCH 1/2] Remove '2.6.' from initramfs wildcard in bug script (Closes: #697319)
      Remove more references to linux-2.6 in manual page and comments

Michael Prokop (3):
      Install nfsv{2,3,4} kernel modules as used by Kernels >=3.6
      include ehci-pci in auto_add_modules list
      Releasing version 0.110

regards,
-mika-

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlEwlUYACgkQ2N9T+zficui48gCeOnRI5jBzM6DbACC5UY6OdWta
Ur4An0tvWWlPML/3SSrCniFztWr1HXqF
=HuqD
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
