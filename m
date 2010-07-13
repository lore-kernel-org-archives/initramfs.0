From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] 10i18n: README corrected
Date: Tue, 13 Jul 2010 10:13:55 +0200
Message-ID: <20100713101355.26a2ecb8@etiriah>
References: <20100713095847.3506a128@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/yG+w/YoeGlVoAcXEQLEEOgy"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100713095847.3506a128@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/yG+w/YoeGlVoAcXEQLEEOgy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

---
 modules.d/10i18n/README |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/10i18n/README b/modules.d/10i18n/README
index dd84881..09cb642 100644
--- a/modules.d/10i18n/README
+++ b/modules.d/10i18n/README
@@ -53,7 +53,7 @@ runtime:
     CONTRANS - see description of '-m' parameter in setfont manual
     UNIMAP - see description of '-u' parameter in setfont manual
=20
-The following are appended to EXT_KEYMAPS:
+The following are appended to EXT_KEYMAPS only during build time:
=20
     UNIKEYMAP
     GRP_TOGGLE
@@ -120,5 +120,5 @@ file (the same where you put mappings).
 3. Kernel parameters
=20
 If you create generic initramfs you can set up i18n by kernel
-parameters using variables listed in 2.1.  The recommended minimum is:
-SYSFONT, KEYMAP and UNICODE.
+parameters using variables listed in 2.1. (expect of UNIKEYMAP
+and GRP_TOGGLE) The recommended minimum is: SYSFONT, KEYMAP and UNICODE.
--=20
1.7.1

--Sig_/yG+w/YoeGlVoAcXEQLEEOgy
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkw8IEMACgkQ+hU8EsKEdQ04NwCfb2Hg1Se+WGVLb7nBSJ/Hy5Z/
xkUAoLYjVTScH0a9JL3ZnkevRRsHd9JN
=QGHk
-----END PGP SIGNATURE-----

--Sig_/yG+w/YoeGlVoAcXEQLEEOgy--
