From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 3/3] dracut-functions: find_rule a bit smarter
Date: Mon, 5 Jul 2010 11:24:07 +0200
Message-ID: <20100705112407.26026f40@etiriah>
References: <20100705090647.30b3c2bc@etiriah>
	<20100705090847.4a2bcc7e@etiriah>
	<20100705091220.670f00f7@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/czzM/Wt_aSFBPQlb0YTuIV/"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100705091220.670f00f7@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/czzM/Wt_aSFBPQlb0YTuIV/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Matches rules filename if it's specified without prefix number.
---
 dracut-functions |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index be6b2e9..1f2528e 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -319,11 +319,32 @@ inst_symlink() {
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
+    local rule t
+
     [[ -f $1 ]] && { echo "$1"; return 0; }
     for r in . /lib/udev/rules.d /etc/udev/rules.d $dracutbasedir/rules.d;=
 do
-	[[ -f $r/$1 ]] && { echo "$r/$1"; return 0; }
+        if ls $r/*$1 &>/dev/null; then
+            if [[ -f $r/$1 ]]; then
+                echo "$r/$1"
+                return 0
+            else
+                rule=3D$(ls "$r"/??"-$1" 2>/dev/null)
+                t=3D($rule)
+                if (( ${#t[@]} > 1 )); then
+                    derror "Ambigous rules filename.  Matches: ${t[@]}"
+                elif [[ -f "$rule" ]]; then
+                    echo $rule
+                    return 0
+                fi
+            fi
+        fi
     done
     return 1
 }
--=20
1.7.1

--Sig_/czzM/Wt_aSFBPQlb0YTuIV/
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwxpLcACgkQ+hU8EsKEdQ1yKACffs2Un2FhmuFy+aVYO/jc2JLR
J3sAoMGLIWJAtJc2tDXciKoFCPQnSXT0
=JoqK
-----END PGP SIGNATURE-----

--Sig_/czzM/Wt_aSFBPQlb0YTuIV/--
