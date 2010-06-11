From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: [PATCH] dracut, dracut-functions: better vercmp; credits go to
 V. Lowther
Date: Fri, 11 Jun 2010 21:47:21 +0200
Message-ID: <20100611214721.58062841@etiriah.ds.pg.gda.pl>
References: <20100611211034.609135f8@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/36LzQSBdxxNFK_C76sgydvU"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100611211034.609135f8-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/36LzQSBdxxNFK_C76sgydvU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Left incorrect module-init-tools version in the patch, here's the fix:
---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 3b1e7e8..3be4989 100755
--- a/dracut
+++ b/dracut
@@ -184,7 +184,7 @@ abs_outfile=3D$(readlink -f "$outfile") && outfile=3D"$=
abs_outfile"
=20
 srcmods=3D"/lib/modules/$kernel/"
 [[ $drivers_dir ]] && {
-    if vercmp $(modprobe --version | cut -d' ' -f3) lt 3.5; then
+    if vercmp $(modprobe --version | cut -d' ' -f3) lt 3.7; then
         derror 'To use --kmoddir option module-init-tools >=3D 3.7 is requ=
ired.'
         exit 1
     fi
--=20
1.7.1

--Sig_/36LzQSBdxxNFK_C76sgydvU
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwSkskACgkQ+hU8EsKEdQ1iZwCdHyKf55E+QzOmxHqB+kh3XMtf
xIsAoJkm2VyzYJ/F5wYcmHdJ7vP1Yer/
=N+9A
-----END PGP SIGNATURE-----

--Sig_/36LzQSBdxxNFK_C76sgydvU--
