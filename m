From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] dracut-systemd: ensure grep is installed as needed by
 rootfs-generator
Date: Thu, 9 Apr 2015 14:08:40 +1000
Message-ID: <20150409140840.0bb6d59d@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/.tI0ow.0orBfJr1FTs/MT9p"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/.tI0ow.0orBfJr1FTs/MT9p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable



rootfs-generator uses 'grep', but it is not installed in the initramfs
by default.
So explicitly install it when installing rootfs-generator.sh

Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

diff --git a/modules.d/98dracut-systemd/module-setup.sh b/modules.d/98dracu=
t-systemd/module-setup.sh
index d9175573c777..780b39a2b4a1 100755
--- a/modules.d/98dracut-systemd/module-setup.sh
+++ b/modules.d/98dracut-systemd/module-setup.sh
@@ -41,6 +41,7 @@ install() {
     inst_script "$moddir/dracut-mount.sh" /bin/dracut-mount
     inst_script "$moddir/dracut-pre-pivot.sh" /bin/dracut-pre-pivot
=20
+    inst_multiple grep
     inst_script "$moddir/rootfs-generator.sh" $systemdutildir/system-gener=
ators/dracut-rootfs-generator
=20
     for i in \

--Sig_/.tI0ow.0orBfJr1FTs/MT9p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVSX7SDnsnt1WYoG5AQLWhg//Xk7DA8iij2u5hGIqXrSu0nl9MaNVA6Yh
IXIlZx+ubBVw/VBsNRX46AwOV2hRtUDJNVB+itmShSIGKRvA1UfphJ+ISIzHXQnS
rcK7eLvG2Dx+phvB8A+qDi0W7/2vDAqfAGbwn2PXglokAM9CtfFClQGYijeVqmzk
cTYNAgBg7E8pmiyQCuhT3HnnKgZXr008usNkCybeqL3OQtQbPGhoivCtKJVRlEMe
dpPTUsWC82tLkq0IX7pPpEgrlCpqevM0C+ipFmIeMAUmrF3/dHixuG5pY5dIgEpN
ISvm4NjVqcMzxX9ql1xNWJnMbdR+LEqEC6OtUVsRzUb1PayWuVQZP71BTpGRgI3a
2BBe2Ajg1SmNk9Q9JkH9Tfy93zj09AvjYjzo/mqfwnHisi7fTsPOaOljCwYsxcuA
5mYc3QpLQSjnWg2aJdEVvVQmXkJTa5nhB2giBKm6kg4K7AhkYBn8Ono3Pvr6NxD6
8k85q7reOhmcx+nzeKRRI0Xfaybg3yN26+JT+LD1NWLfkvPLU5KsjTq65A/tsecK
1grbbkOIFtrn5ldNrVJUHI1cxXPfmSm0eYBYZUmw6yLRpdsBg09sFuJ0V1by657e
tPlEXdDM4mtQ6VvQcCZdqtxcZA9K3TrKRkpxIVq541TGXAXjjKotWI55hVYzzbaQ
zHNGaTkgLyM=
=jZFw
-----END PGP SIGNATURE-----

--Sig_/.tI0ow.0orBfJr1FTs/MT9p--
