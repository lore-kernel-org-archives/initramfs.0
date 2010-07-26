From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut-functions: fixed ignoring additional modules when -m
 specified
Date: Mon, 26 Jul 2010 20:28:33 +0200
Message-ID: <20100726202833.4e30d7dd@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/ihAIUJJH0pJrC_og1JO7l+M"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/ihAIUJJH0pJrC_og1JO7l+M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


---
 dracut-functions |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 05e5c5b..9ead6b3 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -550,7 +550,7 @@ check_modules() {
 	# This should never happen, but...
 	[[ -d $moddir ]] || continue
 	[[ $dracutmodules !=3D all ]] && ! strstr "$dracutmodules" "$mod" && \
-	    continue
+	    ! strstr "$add_dracutmodules" "$mod" && continue
 	strstr "$omit_dracutmodules" "$mod" && continue
 	if ! strstr "$add_dracutmodules" "$mod"; then
 	    should_source_module "$moddir" || continue
--=20
1.7.1.1

--Sig_/ihAIUJJH0pJrC_og1JO7l+M
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEARECAAYFAkxN09EACgkQ+hU8EsKEdQ0/9ACdGkImKRtJpcBjrh1ehoj1w2+f
P5kAoK5iLYAEQ/l1nScCQYMaNG/f1zjg
=Duv5
-----END PGP SIGNATURE-----

--Sig_/ihAIUJJH0pJrC_og1JO7l+M--
