From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/3] dracut-functions: info which udev rules are skipped
Date: Mon, 5 Jul 2010 09:08:47 +0200
Message-ID: <20100705090847.4a2bcc7e@etiriah>
References: <20100705090647.30b3c2bc@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/FbTrPzofeR18LBd/=W=B4Dt"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100705090647.30b3c2bc@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/FbTrPzofeR18LBd/=W=B4Dt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I found it useful.  Maybe help others debugging.
---
 dracut-functions |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 9c2999a..0caf0d6 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -335,8 +335,9 @@ inst_rules() {
     inst_dir "/lib/udev/rules.d"
     inst_dir "$target"
     for rule in "$@"; do=20
-	rule=3D$(find_rule "$rule") && \
-	    inst_simple "$rule" "$target/${rule##*/}"
+	rule1=3D$(find_rule "$rule") && \
+	    inst_simple "$rule1" "$target/${rule1##*/}" \
+	    || dinfo "Skipping udev rule: $rule"
     done
 }
=20
--=20
1.7.1

--Sig_/FbTrPzofeR18LBd/=W=B4Dt
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwxhP8ACgkQ+hU8EsKEdQ0prwCbBDcnpj7rEXL7jJAU3wOoLeIO
x0EAn0vG98fUgA+Cg2hxVTUevIVFS6Fc
=fp9W
-----END PGP SIGNATURE-----

--Sig_/FbTrPzofeR18LBd/=W=B4Dt--
