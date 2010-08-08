From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] 10i18n: --quiet for loadkeys
Date: Sun, 8 Aug 2010 20:07:00 +0200
Message-ID: <20100808200700.3ea940a6@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/qbLigK2_6DOz/gXR6ao6xoP"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/qbLigK2_6DOz/gXR6ao6xoP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

---
 modules.d/10i18n/console_init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/10i18n/console_init b/modules.d/10i18n/console_init
index 7d7ae99..a5cdfb7 100755
--- a/modules.d/10i18n/console_init
+++ b/modules.d/10i18n/console_init
@@ -36,7 +36,7 @@ set_keymap() {
=20
     [ "${UNICODE}" =3D 1 ] && utf_switch=3D-u
=20
-    loadkeys ${utf_switch} ${KEYMAP} ${EXT_KEYMAPS}
+    loadkeys -q ${utf_switch} ${KEYMAP} ${EXT_KEYMAPS}
 }
=20
 set_font() {
--=20
1.7.2

--Sig_/qbLigK2_6DOz/gXR6ao6xoP
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkxe8kQACgkQ+hU8EsKEdQ2dMwCgqqp8DigEbbXU4K4Lx3+1/cNs
W2gAnRTZzoV4henZVzSvHFAVdH57HddO
=0wJU
-----END PGP SIGNATURE-----

--Sig_/qbLigK2_6DOz/gXR6ao6xoP--
