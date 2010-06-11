From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut, dracut-functions: better vercmp; credits go to V.
 Lowther
Date: Fri, 11 Jun 2010 21:10:34 +0200
Message-ID: <20100611211034.609135f8@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/5Bb79wR_f63cky=gV/Y2UrF"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/5Bb79wR_f63cky=gV/Y2UrF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

---
 dracut           |    2 +-
 dracut-functions |   47 ++++++++++++++++++++---------------------------
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/dracut b/dracut
index 139d0e0..3b1e7e8 100755
--- a/dracut
+++ b/dracut
@@ -184,7 +184,7 @@ abs_outfile=3D$(readlink -f "$outfile") && outfile=3D"$=
abs_outfile"
=20
 srcmods=3D"/lib/modules/$kernel/"
 [[ $drivers_dir ]] && {
-    if verlt $(modprobe --version | cut -d' ' -f3) 3.7; then
+    if vercmp $(modprobe --version | cut -d' ' -f3) lt 3.5; then
         derror 'To use --kmoddir option module-init-tools >=3D 3.7 is requ=
ired.'
         exit 1
     fi
diff --git a/dracut-functions b/dracut-functions
index 500e3ae..58f119f 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -24,38 +24,31 @@ IF_dynamic=3D""
 # Generic substring function.  If $2 is in $1, return 0.
 strstr() { [[ $1 =3D~ $2 ]]; }
=20
-# Version comparision function.  Returns result similar to C strcmp,
-# but instead of -1 is 2.  Function assumes version scheme like does
-# Linux kernel.
-# $1 < $2 -> 2
-# $1 =3D $2 -> 0
-# $1 > $2 -> 1
-# To remember it easy, ask the question: Which argument is greater? ;-)
+# Version comparision function.  Assumes Linux style version scheme.
+# $1 =3D version a
+# $2 =3D comparision op (gt, ge, eq, le, lt, ne)
+# $3 =3D version b
 vercmp() {
-    local i n1=3D(${1//./ }) n2=3D(${2//./ })
+    local n1=3D(${1//./ }) op=3D$2 n2=3D(${3//./ }) i res
=20
     for ((i=3D0; ; i++))
-    do=20
-        [[ ${n1[i]} && ! ${n2[i]} ]] && return 1
-        [[ ! ${n1[i]} && ${n2[i]} ]] && return 2
-        [[ ${n1[i]} && ${n2[i]} ]] || return 0
-        ((${n1[i]} > ${n2[i]})) && return 1
-        ((${n1[i]} < ${n2[i]})) && return 2
+    do
+        if [[ ! ${n1[i]}${n2[i]} ]]; then res=3D0
+        elif ((${n1[i]:-0} > ${n2[i]:-0})); then res=3D1
+        elif ((${n1[i]:-0} < ${n2[i]:-0})); then res=3D2
+        else continue
+        fi
+        break
     done
-}
=20
-# Variation of version comparision function.  If $1 >=3D $2, return 0.
-verge() {
-    vercmp $1 $2
-
-    [[ $? =3D 0 || $? =3D 1 ]]
-}
-
-# Variation of version comparision function.  If $1 < $2, return 0.
-verlt() {
-    vercmp $1 $2
-
-    [[ $? =3D 2 ]]
+    case $op in
+        gt) ((res =3D=3D 1));;
+        ge) ((res !=3D 2));;
+        eq) ((res =3D=3D 0));;
+        le) ((res !=3D 1));;
+        lt) ((res =3D=3D 2));;
+        ne) ((res !=3D 0));;
+    esac
 }
=20
 # Log initrd creation.
--=20
1.7.1

--Sig_/5Bb79wR_f63cky=gV/Y2UrF
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwSiioACgkQ+hU8EsKEdQ2ZXwCfa5Jx1WTVcOwVO44ONbLNN6CH
ZyUAnRa9k2lSHyL+kK9SQ/hPEYJceOyg
=ZwPA
-----END PGP SIGNATURE-----

--Sig_/5Bb79wR_f63cky=gV/Y2UrF--
