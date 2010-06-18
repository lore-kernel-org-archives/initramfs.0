From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut: setup English locales for Dracut build script
Date: Fri, 18 Jun 2010 13:38:41 +0200
Message-ID: <20100618133841.61845f0d@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Rxs9gJQgEqoHS8_OQ8/y.5b"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/Rxs9gJQgEqoHS8_OQ8/y.5b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dracut rely upon programs' output like ldd's "not a dynamic executable".
Assume user sets up Polish locales and then ldd prints
"nie jest dynamicznym programem wykonywalnym".  The patch prevents this.
---
 dracut |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/dracut b/dracut
index 3be4989..1437625 100755
--- a/dracut
+++ b/dracut
@@ -71,6 +71,17 @@ Creates initial ramdisk images for preloading modules
 "
 }
=20
+# Change locales and language leaving existing suffix (.utf8 or similar).
+# $1 =3D language (e.g. en_US)
+change_locales() {
+    local lang=3D(${LANG/./ })
+    lang[0]=3D$1                                                          =
             =20
+    lang=3D${lang[@]}
+    LANG=3D${lang/ /.}
+    LC_ALL=3D${LANG}
+    export LANG LC_ALL
+}
+
 while (($# > 0)); do
     case $1 in
 	-f|--force) force=3Dyes;;
@@ -107,6 +118,10 @@ done
=20
 PATH=3D/sbin:/bin:/usr/sbin:/usr/bin
 export PATH
+# We rely upon programs' output like ldd's "not found", so we have to
+# set up English locales.
+change_locales en_US
+
=20
 [[ $debug ]] && {=20
     export PS4=3D'${BASH_SOURCE}@${LINENO}(${FUNCNAME[0]}): ';
--=20
1.7.1

--Sig_/Rxs9gJQgEqoHS8_OQ8/y.5b
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwbWsEACgkQ+hU8EsKEdQ0QKQCfUG+JC6VDXyVUj+mRAKBMOQNT
6EsAmgPBhe0qyd9K+lRDP9Fiyt5bllVE
=OePa
-----END PGP SIGNATURE-----

--Sig_/Rxs9gJQgEqoHS8_OQ8/y.5b--
