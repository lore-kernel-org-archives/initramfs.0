From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut-functions: find_rule a bit smarter; thanks to V.
 Lowther
Date: Wed, 7 Jul 2010 12:27:55 +0200
Message-ID: <20100707122755.2b1b8214@etiriah>
References: <20100705090647.30b3c2bc@etiriah>
	<20100705090847.4a2bcc7e@etiriah>
	<20100705091220.670f00f7@etiriah>
	<20100705112407.26026f40@etiriah>
	<1278341637.4056.17.camel@localhost.localdomain>
	<20100707111946.568b4775@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/11=6069wLM/g=qmxi9aSEdr"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100707111946.568b4775@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/11=6069wLM/g=qmxi9aSEdr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Matches rules filename if it's specified without prefix number.

Thanks to Victor Lowther for advice of not using ls command.  Use
globbing and parameter expansion instead.
---
 dracut-functions |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 0caf0d6..7a1d82f 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -319,13 +319,36 @@ inst_symlink() {
     inst "$realsrc" && ln -s "$realsrc" "$target"
 }
=20
-# find a udev rule in the usual places.
+# find a udev rule in the usual places and try to be smart (just a bit).
+# See example:
+#   find_rule default.rules
+#   find_rule 50-default.rules
+# All of them will return: /lib/udev/rules.d/50-udev-default.rules
+# If there are few matching files, error message is printed.
 find_rule() {
+    local rd f files=3D()
+
     [[ -f $1 ]] && { echo "$1"; return 0; }
-    for r in . /lib/udev/rules.d /etc/udev/rules.d $dracutbasedir/rules.d;=
 do
-	[[ -f $r/$1 ]] && { echo "$r/$1"; return 0; }
+
+    for rd in . /lib/udev/rules.d /etc/udev/rules.d $dracutbasedir/rules.d=
; do
+        for f in "$rd/$1" "$rd"/*-"$1"
+        do
+            [[ -f $f ]] || continue
+            [[ ${f##*/} =3D~ [0-9][0-9]-.*\.rules ]] || continue
+            files+=3D($f)
+        done
+        # If detecting ambiguousness among different directories isn't des=
ired,
+        # uncomment this:
+        # (( ${#files[@]} >=3D 1 )) && break
     done
-    return 1
+
+    (( ${#files[@]} < 1 )) && return 1
+    (( ${#files[@]} > 1 )) && {
+        derror "Ambigous rules filename.  Matches: ${files[@]}"
+        return 1
+    }
+
+    echo "$files"
 }
=20
 # udev rules always get installed in the same place, so
--=20
1.7.1

--Sig_/11=6069wLM/g=qmxi9aSEdr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkw0VqsACgkQ+hU8EsKEdQ0PEQCeNvTul32wgj2Zol7OpPbkRpcF
j8sAn0l4bOZPy69PdzZN6kt8DLLhbrRG
=m4C1
-----END PGP SIGNATURE-----

--Sig_/11=6069wLM/g=qmxi9aSEdr--
