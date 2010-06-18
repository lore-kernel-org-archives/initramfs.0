From: Michael Prokop <mika-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Call for Testing: initramfs-tools 0.97
Date: Fri, 18 Jun 2010 23:48:45 +0200
Message-ID: <2010-06-18T23-46-46@devnull.michael-prokop.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HxQt9wRz9wbL5Edg"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: debian-devel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--HxQt9wRz9wbL5Edg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

we - the initramfs-tools maintainers in Debian - want to provide a
solid initramfs-tools version for squeeze. The new release 0.97 is
expected to fix many longstanding problems. It would be great if we
could receive feedback from testers.

The new release is available from Debian/unstable and is expected to
install without problems in at least lenny, squeeze and sid:

  http://cdn.debian.net/debian/pool/main/i/initramfs-tools/initramfs-tools_0.97_all.deb
  SHA256:56eb56d472d0dd24c8f2fd030222586e258ec882b716f02d114865cef9c19639

No matter how your partition layout looks like (rootfs on lvm,
crypto, sw-raid,...), if you're booting on physical hardware or a
virtualized system (Xen, openvz, kvm,...) - please give it a shot
and report any possible problems.

thanks && regards,
-mika-

--HxQt9wRz9wbL5Edg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFMG+m92N9T+zficugRAu2oAJ9zyO/PvUnfgft6SXj78eMULOiWtACfeaa9
wOUDuojNyd4IcOd3v7JQiYU=
=ZFBC
-----END PGP SIGNATURE-----

--HxQt9wRz9wbL5Edg--
