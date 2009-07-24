From: Thilo Bangert <thilo.bangert-hi6Y0CQ0nG0@public.gmane.org>
Subject: [patch] support for unusual terminfo location
Date: Fri, 24 Jul 2009 22:01:35 +0200
Message-ID: <200907242201.39741.thilo.bangert@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2470651.7MFhGl0GEC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--nextPart2470651.7MFhGl0GEC
Content-Type: multipart/mixed;
  boundary="Boundary-01=_hMhaKkF28o9Tqw0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_hMhaKkF28o9Tqw0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

the following patch makes the 95terminfo module work on gentoo.

thanks
kind regards
Thilo

--Boundary-01=_hMhaKkF28o9Tqw0
Content-Type: text/x-patch;
  charset="UTF-8";
  name="95terminfo-fix-for-weird-distros.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="95terminfo-fix-for-weird-distros.patch"

diff --git a/modules.d/95terminfo/install b/modules.d/95terminfo/install
index 7f14aa1..4d8f395 100755
--- a/modules.d/95terminfo/install
+++ b/modules.d/95terminfo/install
@@ -1,3 +1,8 @@
 #!/bin/bash
 # terminfo bits make things work better if you fall into interactive mode
-dracut_install $(find /lib/terminfo -type f)
\ No newline at end of file
+TERMINFODIR="/lib/terminfo"
+
+[ ! -d ${TERMINFODIR} -a -d "/etc/terminfo" ] && \
+	TERMINFODIR="/etc/terminfo"
+
+dracut_install $(find ${TERMINFODIR} -type f)

--Boundary-01=_hMhaKkF28o9Tqw0--

--nextPart2470651.7MFhGl0GEC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkpqEyMACgkQxRElEoA5AneABgCg2W7+A0Nh47HO9rA7QouIrgOc
4DcAnROAYRyuHuuhUjMgudHKem9YQFEv
=JaBv
-----END PGP SIGNATURE-----

--nextPart2470651.7MFhGl0GEC--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
