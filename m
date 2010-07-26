From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/2] 10i18n: exit if console already initialized
Date: Mon, 26 Jul 2010 10:15:40 +0200
Message-ID: <20100726101540.37af47d8@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/k3KD5uoXBtmCeMV1tIv3NV0"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/k3KD5uoXBtmCeMV1tIv3NV0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


---
 modules.d/10i18n/console_init |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/modules.d/10i18n/console_init b/modules.d/10i18n/console_init
index fa74595..0d4fa8f 100755
--- a/modules.d/10i18n/console_init
+++ b/modules.d/10i18n/console_init
@@ -63,12 +63,15 @@ dev_open() {
=20
=20
 dev=3D/dev/${1#/dev/}
+devname=3D${dev#/dev/}
=20
 [ -c "${dev}" ] || {
     echo "Usage: $0 device" >&2
     exit 1
 }
=20
+[ -e /tmp/console_init.${devname} ] && exit 0
+
 dev_open ${dev}
=20
 for fd in 6 7; do
@@ -85,3 +88,4 @@ set_font ${dev}
 set_keymap
=20
 dev_close
+>/tmp/console_init.${devname}
--=20
1.7.1.1

--Sig_/k3KD5uoXBtmCeMV1tIv3NV0
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEARECAAYFAkxNRCwACgkQ+hU8EsKEdQ1Z9ACgu5AbA32uP3yAd/AuoKhzabAa
NxoAoJP6a5kRleZ+MdafvCOX76vRdKn1
=qOV1
-----END PGP SIGNATURE-----

--Sig_/k3KD5uoXBtmCeMV1tIv3NV0--
