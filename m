From: Michael Prokop <mika-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: initramfs-tools 0.101 release
Date: Tue, 6 Mar 2012 14:40:53 +0100
Message-ID: <2012-03-06T14-37-53@devnull.michael-prokop.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

we just released a new version of initramfs-tools, most important is
Ben's fix regarding the modules.builtin file, full shortlog is attached.

regards,
-mika-

-----------------------------------------------------------------
git shortlog:

Ben Hutchings (1):
      mkinitramfs: Copy modules.builtin into initramfs

Michael Prokop (2):
      Bump Standards-Version to 3.9.3
      Releasing version 0.101

Vadim Solomin (1):
      initramfs-tools: Add per default missing hid-logitech-dj

maximilian attems (3):
      hook-functions: ext4dev is gone
      debian/control: Get rid of old findutils versioned depends
      update-initramfs: Don't call flash-kernel directly
-----------------------------------------------------------------

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk9WE+UACgkQ2N9T+zficujKhACfZSnRUR3P4fyKc1rpIpaG/TmM
y0UAnA4hA9GLYRq3InWXnjwZwi1HrKZ2
=xt1n
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
