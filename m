From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 3/3] dracut-functions: find_rule a bit smarter
Date: Mon, 5 Jul 2010 09:12:20 +0200
Message-ID: <20100705091220.670f00f7@etiriah>
References: <20100705090647.30b3c2bc@etiriah>
	<20100705090847.4a2bcc7e@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/G4PI9m/M9xo+p43u8Dt.DQY"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100705090847.4a2bcc7e@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/G4PI9m/M9xo+p43u8Dt.DQY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

btw cosmetic changes to inst_rules
---
 dracut-functions |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 0caf0d6..6da36ad 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -319,11 +319,27 @@ inst_symlink() {
     inst "$realsrc" && ln -s "$realsrc" "$target"
 }
=20
-# find a udev rule in the usual places.
+# find a udev rule in the usual places and try to be smart (just a bit).
+# See example:
+#   find_rule default.rules
+#   find_rule udev-default.rules
+#   find_rule 50-udev-default.rules
+# All of them will return: /lib/udev/rules.d/50-udev-default.rules
 find_rule() {
+    local rule
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
+                rule=3D$(ls "$r"/??"-$1" 2>/dev/null || \
+                    ls "$r"/??"-udev-$1" 2>/dev/null)
+                [[ -f $rule ]] && echo $rule && return 0
+            fi
+        fi
     done
     return 1
 }
@@ -331,13 +347,14 @@ find_rule() {
 # udev rules always get installed in the same place, so
 # create a function to install them to make life simpler.
 inst_rules() {=20
-    local target=3D/etc/udev/rules.d
+    local target=3D/etc/udev/rules.d rule found
+
     inst_dir "/lib/udev/rules.d"
     inst_dir "$target"
     for rule in "$@"; do=20
-	rule1=3D$(find_rule "$rule") && \
-	    inst_simple "$rule1" "$target/${rule1##*/}" \
-	    || dinfo "Skipping udev rule: $rule"
+        found=3D$(find_rule "$rule") && \
+            inst_simple "$found" "$target/${found##*/}" \
+            || dinfo "Skipping udev rule: $rule"
     done
 }
=20
--=20
1.7.1

--Sig_/G4PI9m/M9xo+p43u8Dt.DQY
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwxhdQACgkQ+hU8EsKEdQ3RngCg20HaS5y155UmRTeTULc9sjkU
aoUAnRyNX17XySQdJvzxQB+U4q7ErIjS
=zlgl
-----END PGP SIGNATURE-----

--Sig_/G4PI9m/M9xo+p43u8Dt.DQY--
