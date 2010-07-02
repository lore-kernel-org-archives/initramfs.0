From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/2] i18n: removed unused functions from console_init
Date: Fri, 2 Jul 2010 10:32:18 +0200
Message-ID: <20100702103218.3ac4fb9e@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/8eauRMtl.lQysWXj0l283+G"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/8eauRMtl.lQysWXj0l283+G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

---
 modules.d/10i18n/console_init |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/modules.d/10i18n/console_init b/modules.d/10i18n/console_init
index 9a8d621..146cd26 100755
--- a/modules.d/10i18n/console_init
+++ b/modules.d/10i18n/console_init
@@ -7,26 +7,6 @@ DEFAULT_SYSFONT=3DLatArCyrHeb-16
 DEFAULT_KEYMAP=3D/etc/sysconfig/console/default.kmap
=20
=20
-print_vars() {
-    local var value
-
-    for var in $@
-    do
-        value=3D$(eval echo \$$var)
-        [ -n "${value}" ] && echo "${var}=3D\"${value}\""
-    done
-}
-
-run_debug() {
-    echo -n $@
-    echo -n '   '
-    if $@; then
-        echo 'OK'
-    else
-        echo 'Failed!'
-    fi
-}
-
 set_keyboard() {
     local param
=20
--=20
1.7.1

--Sig_/8eauRMtl.lQysWXj0l283+G
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwtpBIACgkQ+hU8EsKEdQ3tKACggSLxHVquM4Kn8Ca5cwOpr74p
TtQAni5FzMD8PHER00A8g9C8Jn3iJVJn
=UW6T
-----END PGP SIGNATURE-----

--Sig_/8eauRMtl.lQysWXj0l283+G--
