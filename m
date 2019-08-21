From: Ben Hutchings <ben@decadent.org.uk>
Subject: initramfs-tools 0.135 release
Date: Wed, 21 Aug 2019 23:46:38 +0100
Message-ID: <61bc54a992a27029bdb85734ea2c0002facb467b.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7956773050661868502=="
Return-path: <kernel-team-bounces@lists.ubuntu.com>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/options/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/kernel-team>
List-Post: <mailto:kernel-team@lists.ubuntu.com>
List-Help: <mailto:kernel-team-request@lists.ubuntu.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=subscribe>
Errors-To: kernel-team-bounces@lists.ubuntu.com
Sender: "kernel-team" <kernel-team-bounces@lists.ubuntu.com>
To: initramfs@vger.kernel.org, debian-kernel@lists.debian.org, kernel-team@lists.ubuntu.com


--===============7956773050661868502==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-eZRRTBdb/E+gPzXnY/Qd"


--=-eZRRTBdb/E+gPzXnY/Qd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a pretty small release, and I've only done it now rather than
collecting more changes because of the test failure.  Shortlog is
below.

Ben.

Alper Nebi Yasak (1):
      hook-functions: Handle spi-rockchip hidden dependency on pl330

Ben Hutchings (4):
      Merge branch 'fix-dev-and-run-mount-flags' into 'master'
      autopkgtest: Only test hook and boot scripts from specific packages
      Merge branch 'pl330-for-spi-rockchip' into 'master'
      Releasing version 0.135.

Topi Miettinen (1):
      init: /dev can be noexec and /run nodev

--=20
Ben Hutchings
Quantity is no substitute for quality, but it's the only one we've got.



--=-eZRRTBdb/E+gPzXnY/Qd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl1dyc4ACgkQ57/I7JWG
EQm5OA//Q0gQMpcT9q6r6kDIoR6u01PB1V5BnqWR0nIRQIahp7j4L1qBi9SJZqIX
3V+0Xh22HHwxIw2qqJjkmUelV8MEk9JxvJw0N6ZETGDLJwdK72kXtYo24yVjBIfS
IopB4xQ3XnhbbPxvWiUSIpXtHrNhj5y1AX+F4oviN2n55ULzv7DWRq+1ujkCrWqs
4K3MCJ8bYSXfsfFYKMG22OfxE1rtxCPrcMbFo2EAWny+WropqpyZDqO7lb9aOcKX
POY99ZtSUV/Z3dkIRpwCHuCmC8NPRLcGoTG8jAdCicj14IdbQ2e67I2iBdX9AoLh
veFPjof+XKjAM79mwRx5uGLx7/S0eQMdYLv4AtO6seMmk4OJ2SlairWDlDxtzMZl
mONJp08vjgPxY+nbPRNBceKEvzVnHb0W3U6lpnNXXzwR+73a34zVmbSV1JDz+gT7
4/w7G+I/xGq4GL8xzaqhsRfHaNahVEK/LxbllAE0a+g269ZGtzmi+Pj7QkMf1fst
+Vgm3W7YRQodZNUQ4OfbvFA6SMYwCll+mfuB9w4SlkS3yip7ThsgFnCOtF7MLMbO
QxRv6lpkDKrgioTT4A4G27OBLn0ViopGbzZTV1w62dnkDMn2bPQk9yzkPR/DQTUX
M+KdgWdHtm5ijvBJEFIrzwjvgN7FduSYojUu586QbzLkpPxOl2w=
=rbYF
-----END PGP SIGNATURE-----

--=-eZRRTBdb/E+gPzXnY/Qd--


--===============7956773050661868502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

LS0gCmtlcm5lbC10ZWFtIG1haWxpbmcgbGlzdAprZXJuZWwtdGVhbUBsaXN0cy51YnVudHUuY29t
Cmh0dHBzOi8vbGlzdHMudWJ1bnR1LmNvbS9tYWlsbWFuL2xpc3RpbmZvL2tlcm5lbC10ZWFtCg==

--===============7956773050661868502==--

