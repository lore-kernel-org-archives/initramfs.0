From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH 3/3] 90crypt: 'crypto_LUKS' identifier corrected
Date: Wed, 9 Jun 2010 11:04:05 +0200
Message-ID: <20100609110405.21e9a39a@etiriah.ds.pg.gda.pl>
References: <20100609103605.50a6acec@etiriah.ds.pg.gda.pl>
	<20100609103836.6d14d542@etiriah.ds.pg.gda.pl>
	<20100609104031.01d37912@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Xz9dg5X5HYIk+.Ps0ObNL4w"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100609104031.01d37912-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/Xz9dg5X5HYIk+.Ps0ObNL4w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

---
 modules.d/90crypt/check |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90crypt/check b/modules.d/90crypt/check
index 07c53f9..7ba499a 100755
--- a/modules.d/90crypt/check
+++ b/modules.d/90crypt/check
@@ -19,7 +19,7 @@ is_crypt() { [[ $(get_fs_type /dev/block/$1) =3D crypto_L=
UKS ]]; }
 	check_block_and_slaves is_crypt "$rootdev" || exit 1
     else
 	# root is not on a block device, use the shotgun approach
-	blkid | grep -q crypt_LUKS || exit 1
+	blkid | grep -q 'crypto\?_LUKS' || exit 1
     fi
 }
=20
--=20
1.7.1


--Sig_/Xz9dg5X5HYIk+.Ps0ObNL4w
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwPWQUACgkQ+hU8EsKEdQ0utQCgwpwaxOfGTMx6yYqKRzX9F4L9
03kAnRHg1WgR5hdEtyFGWnZ2NbheFFzb
=TzhQ
-----END PGP SIGNATURE-----

--Sig_/Xz9dg5X5HYIk+.Ps0ObNL4w--
