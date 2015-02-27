From: Shawn W Dunn <sfalken-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/1] Add hid-logitech-hidpp to module-setup.sh
Date: Fri, 27 Feb 2015 10:59:33 -0800
Message-ID: <1425063573.2493.4.camel@opensuse.org>
Reply-To: sfalken-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-UyFb/zUb3+jSBnKqGT6l"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-UyFb/zUb3+jSBnKqGT6l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hid-logitech-hidpp is not included in the default modules, and it=20
results in being unable to enter LUKS password with certain logitech=20
wireless (and possibly wired) keyboards on 3.19.x Kernels

Bug found on openSUSE:=20
https://bugzilla.opensuse.org/show_bug.cgi?id=3D918938Also referenced in Ma=
geia
https://bugs.mageia.org/show_bug.cgi?id=3D15198


-------------------------------------------------------------------

=46rom c593499dc0c93aabe2107a3c146619a8c5409f49 Mon Sep 17 00:00:00 2001=20
From: Shawn W Dunn <sfalken-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Date: Fri, 27 Feb 2015 10:52:11 -0800
Subject: [PATCH] Added hid-logitech-hidpp to
 modules.d/90kernel-modules/module-setup-sh

---
 modules.d/90kernel-modules/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh=20
b/modules.d/90kernel-modules/module-setup.sh
index a7b0853..396caf4 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -43,7 +43,7 @@ installkernel() {
=20
         instmods yenta_socket scsi_dh_rdac scsi_dh_emc scsi_dh_alua \
             atkbd i8042 usbhid hid-apple hid-sunplus hid-cherry hid-
logitech \
-            hid-logitech-dj hid-microsoft hid-lcpower firewire-ohci \
+            hid-logitech-dj hid-logitech-hidpp hid-microsoft hid-
lcpower firewire-ohci \
             pcmcia hid-hyperv hv-vmbus hyperv-keyboard
=20
         if [[ "$(uname -p)" =3D=3D arm* ]]; then
--
2.3.0
--=-UyFb/zUb3+jSBnKqGT6l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EABEIAAYFAlTwvpUACgkQFoHVlptUfZke1AEAjUbY+XQibP8U4x4E6hbP/H6c
q0uVbGCzjM1hduBAz/sA/j9Ube5hZQfcIq35wmA8gYa+012CFAz3XloCEISK5LYm
=ocYk
-----END PGP SIGNATURE-----

--=-UyFb/zUb3+jSBnKqGT6l--
