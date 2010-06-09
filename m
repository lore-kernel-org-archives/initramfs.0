From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut-functions: fun. vercmp optimized; credits go to
 Victor Lowther
Date: Wed, 9 Jun 2010 17:29:36 +0200
Message-ID: <20100609172936.752221c5@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/O/=jjyRkXWVojpgxL7MwRZa"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/O/=jjyRkXWVojpgxL7MwRZa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

---
 dracut-functions |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index fbac282..500e3ae 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -27,19 +27,20 @@ strstr() { [[ $1 =3D~ $2 ]]; }
 # Version comparision function.  Returns result similar to C strcmp,
 # but instead of -1 is 2.  Function assumes version scheme like does
 # Linux kernel.
+# $1 < $2 -> 2
+# $1 =3D $2 -> 0
+# $1 > $2 -> 1
+# To remember it easy, ask the question: Which argument is greater? ;-)
 vercmp() {
-    local n1 n2 i=3D1
-
-    while true
-    do
-        n1=3D$(echo $1 | cut -d'.' -f$i)
-        n2=3D$(echo $2 | cut -d'.' -f$i)
-
-        [[ ! $n1 && ! $n2 ]] && return 0
-        [[ $n1 -lt $n2 ]] && return 2
-        [[ $n1 -gt $n2 ]] && return 1
-
-        ((i++))
+    local i n1=3D(${1//./ }) n2=3D(${2//./ })
+
+    for ((i=3D0; ; i++))
+    do=20
+        [[ ${n1[i]} && ! ${n2[i]} ]] && return 1
+        [[ ! ${n1[i]} && ${n2[i]} ]] && return 2
+        [[ ${n1[i]} && ${n2[i]} ]] || return 0
+        ((${n1[i]} > ${n2[i]})) && return 1
+        ((${n1[i]} < ${n2[i]})) && return 2
     done
 }
=20
--=20
1.7.1

--Sig_/O/=jjyRkXWVojpgxL7MwRZa
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwPs2AACgkQ+hU8EsKEdQ0FPQCfYXmKWmsjhkMJeLDULJLg14JF
kp8AnirALDZ/TEYhqnfa4KMGWTxtHQ8W
=Dae9
-----END PGP SIGNATURE-----

--Sig_/O/=jjyRkXWVojpgxL7MwRZa--
