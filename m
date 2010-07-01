From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] i18n: fixup
Date: Thu, 1 Jul 2010 22:39:34 +0200
Message-ID: <20100701223934.5329a489@etiriah>
References: <20100701211737.45d8a803@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/73x6rmeP1eHNF5/G9UKu=7R"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100701211737.45d8a803@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/73x6rmeP1eHNF5/G9UKu=7R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

dracut-functions: fixed typos in inst_decompress

i18n: use inst_opt_decompress for installing fonts instead of inst
---
 dracut-functions         |    2 +-
 modules.d/10i18n/install |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 4212c5f..9c2999a 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -408,7 +408,7 @@ inst_decompress() {
     for src in $@
     do
         case ${src} in
-            *.gi) cmd=3D'gzip rd' ;;
+            *.gz) cmd=3D'gzip -d' ;;
             *.bz2) cmd=3D'bzip2 -d' ;;
             *) return 1 ;;
         esac
diff --git a/modules.d/10i18n/install b/modules.d/10i18n/install
index a335260..05de54a 100755
--- a/modules.d/10i18n/install
+++ b/modules.d/10i18n/install
@@ -123,7 +123,7 @@ install_local_i18n() {
=20
     [[ ${SYSFONT} ]] || SYSFONT=3D${DEFAULT_SYSFONT}
     SYSFONT=3D${SYSFONT%.psf*}
-    inst ${kbddir}/consolefonts/${SYSFONT}.*
+    inst_opt_decompress ${kbddir}/consolefonts/${SYSFONT}.*
=20
     if [[ ${CONTRANS} ]]
     then
--=20
1.7.1

--Sig_/73x6rmeP1eHNF5/G9UKu=7R
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkws/QYACgkQ+hU8EsKEdQ1RWACeL61Q8VyAZsuI8/4Kli7uPlcO
SEAAoKahKxGnrzZg6FsyB6Vo9pMNotnu
=c5aa
-----END PGP SIGNATURE-----

--Sig_/73x6rmeP1eHNF5/G9UKu=7R--
