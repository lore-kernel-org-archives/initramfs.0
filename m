From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut-functions: cosmetic changes to inst_rules
Date: Mon, 5 Jul 2010 11:25:21 +0200
Message-ID: <20100705112521.37ec8c65@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/HAN/Jwm9M1hDg_ZQ2Nq46W6"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/HAN/Jwm9M1hDg_ZQ2Nq46W6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

---
 dracut-functions |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 0caf0d6..be6b2e9 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -331,13 +331,14 @@ find_rule() {
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

--Sig_/HAN/Jwm9M1hDg_ZQ2Nq46W6
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwxpQEACgkQ+hU8EsKEdQ1J5wCfd8VUQQTu+MxYK5TcC7ZndQTx
RYwAnic00/8GNfgW8g21bRNS2ri0bxbn
=9v8W
-----END PGP SIGNATURE-----

--Sig_/HAN/Jwm9M1hDg_ZQ2Nq46W6--
