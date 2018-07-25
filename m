From: Ben Hutchings <ben@decadent.org.uk>
Subject: initramfs-tools 0.132 release
Date: Thu, 26 Jul 2018 01:59:11 +0800
Message-ID: <d57ef33923c6067a21d5f2a3c35ec73df521340f.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-QXWJrshMC2IcwlHCoY4x"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-Message-ID: <dkvavvpVla.A.R8H.9sLWbB@bendel>
List-Id: <initramfs.vger.kernel.org>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/d57ef33923c6067a21d5f2a3c35ec73df521340f.camel@decadent.org.uk
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, kernel-team@lists.ubuntu.com


--=-QXWJrshMC2IcwlHCoY4x
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release fixes several more bugs reported to Debian, including the
known regression in the previous release.

It adds support for compressed module files, when kmod is built with
support for them.

The update-initramfs command will now always take over other initramfs
images.  (It already worked this way in Ubuntu since 2006 when
operating on a single kernel version, but "-k all" would still skip
them.)

Ben.

Ben Hutchings (12):
      mkinitramfs: Don't try to remove nonexistent /var/cache/ldconfig
      hook-functions: Quote exclusions in copy_modules_dir
      hook-functions: Add support for compressed module files
      Update debian/.gitignore
      mkinitramfs: Create usr-merged filesystem layout
      hooks/resume: Loop over all swap devices when selecting automatically
      hooks/resume: Reject zram swap devices when selecting automatically
      update-initramfs: Always take over other initramfs images
      update-initramfs: Make "-k all" take over other initramfs images
      scripts/functions: Fix parsing of device name from ip parameter
      scripts/functions: Merge information from BOOTIF/DEVICE and ip parame=
ters
      Releasing version 0.132.

--=20
Ben Hutchings
Tomorrow will be cancelled due to lack of interest.


--=-QXWJrshMC2IcwlHCoY4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAltYum8ACgkQ57/I7JWG
EQk2CxAAwBRXGGRHUgsIMTJhgL7urC96gqSzd6KdXPg5VnFVRVEHkJ6oUT+xFkN0
ETFbDs/FghkaCr9+eaYCGvJk0fbE254hLj2x/IhmTRbyEavGsP5+xfgRO5eemRqZ
02GyKY6X9OItQvauGJwLVSNnoG+ZUeOGnmyWeiB4Lcj7GmqerYcbsRSJIb7gT93S
ZQ6YydaPlMsq6RK8uCwu29s3eGQTSSAQ7kn3nRcrPQH5aFaaZnMpKbTARFDMXCYS
jZsU8hdom1pkq08hjW5mldbgrHdgdyXpc6Gh0oNjShd9HeuTFAQCtantxrxPcDJ5
fBcE2YWiDkgTBLs8jsYyZL7Uwg3I47VTAfuBVbuAW5kYVBRKO6DTVKMQRdpOa5XA
h2QDcYp2Y+ly+E5t8CVoF2H5XW1DOWzND/bhyFgMs28YiM1m3gehTa8crjsU7J9p
bTZ79V/Mp5LsCgjowojZBznlrqgugoS1/22sqrUZtLj38kTkV1cNGzvzsQKD47x2
jzqhXbK5dho8s2sL+v6B9Fo8eE4nDM4Vmg15rArRfe7Co36INY9NcudJ0MC+TUG5
EtnJPI4gcQ1x97u3a9n1xLL4QT6WFIwaDyDBDlKHB6CONZ6AQ0JZxaolfeXi3Bbo
T8lU5XAbmzbr+QIcu4Bcitpg5Q7pKvAEBvA+GdyZaGIIzP1/zzg=
=jBFl
-----END PGP SIGNATURE-----

--=-QXWJrshMC2IcwlHCoY4x--

