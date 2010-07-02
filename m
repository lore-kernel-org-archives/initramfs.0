From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/2] i18n: loading additional keymaps declared in
 EXT_KEYMAPS
Date: Fri, 2 Jul 2010 10:37:21 +0200
Message-ID: <20100702103721.3884c924@etiriah>
References: <20100702103218.3ac4fb9e@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/F0gCd7Td4EIjywUa=lNCBDC"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100702103218.3ac4fb9e@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/F0gCd7Td4EIjywUa=lNCBDC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


---
 modules.d/10i18n/console_init |    2 +-
 modules.d/10i18n/install      |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/modules.d/10i18n/console_init b/modules.d/10i18n/console_init
index 146cd26..fa74595 100755
--- a/modules.d/10i18n/console_init
+++ b/modules.d/10i18n/console_init
@@ -36,7 +36,7 @@ set_keymap() {
=20
     [ "${UNICODE}" =3D 1 ] && utf_switch=3D-u
=20
-    loadkeys ${utf_switch} ${KEYMAP}.map
+    loadkeys ${utf_switch} ${KEYMAP} ${EXT_KEYMAPS}
 }
=20
 set_font() {
diff --git a/modules.d/10i18n/install b/modules.d/10i18n/install
index 05de54a..caa3fac 100755
--- a/modules.d/10i18n/install
+++ b/modules.d/10i18n/install
@@ -98,7 +98,6 @@ install_local_keyboard() {
=20
     # Gentoo user may have KEYMAP set to something like "-u pl2",
     KEYMAP=3D${KEYMAP#-* }
-    EXT_KEYMAPS=3D${EXT_KEYMAPS:-backspace}
     # I'm not sure of the purpose of UNIKEYMAP and GRP_TOGGLE.  They were =
in
     # original redhat-i18n module.  Anyway it won't hurt.
     EXT_KEYMAPS+=3D\ ${UNIKEYMAP}\ ${GRP_TOGGLE}
--=20
1.7.1

--Sig_/F0gCd7Td4EIjywUa=lNCBDC
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwtpUEACgkQ+hU8EsKEdQ2vyQCgyPiJprO2cC/vY86sSBL+Fb7R
BUQAoKawi+wCFhZYWMtSheuWNg2fLrOw
=lQaR
-----END PGP SIGNATURE-----

--Sig_/F0gCd7Td4EIjywUa=lNCBDC--
