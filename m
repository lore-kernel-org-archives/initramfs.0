From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] Fix /lib/udev/firmware install for new udev
Date: Sun, 17 Jan 2010 09:28:58 +0300
Message-ID: <201001170929.02662.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2811521.riE6EohbxI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--nextPart2811521.riE6EohbxI
Content-Type: multipart/mixed;
  boundary="Boundary-01=_q4qULoIgcnHP64s"
Content-Transfer-Encoding: 7bit


--Boundary-01=_q4qULoIgcnHP64s
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fix firmware loading installation for new udev.

-andrey

--Boundary-01=_q4qULoIgcnHP64s
Content-Type: application/x-shellscript;
  name="firmware.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="firmware.sh"

Subject: [PATCH] Fix /lib/udev/firmware install for new udev
From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

Current udev replaced /lib/udev/firmware.sh script with binary
program. This results in error:

E: Failed to install /lib/udev/firmware.sh

Fix it by not installing firmware.sh explicitly and adding firmware
to list of files installed conditionally.

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 modules.d/95udev-rules/install |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/install
index 2d378de..5069630 100755
--- a/modules.d/95udev-rules/install
+++ b/modules.d/95udev-rules/install
@@ -15,7 +15,6 @@ inst_rules "$moddir/01-ignore.rules"
 
 # for firmware loading
 inst_rules 50-firmware.rules
-dracut_install /lib/udev/firmware.sh
 dracut_install cat uname
 
 if [ ! -x /lib/udev/vol_id ]; then
@@ -31,6 +30,7 @@ ata_id \
 cdrom_id \
 create_floppy_devices \
 edd_id \
+firmware \
 firmware.sh \
 fw_unit_symlinks.sh \
 hid2hci \

--Boundary-01=_q4qULoIgcnHP64s--

--nextPart2811521.riE6EohbxI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAktSrioACgkQR6LMutpd94wySgCdE0cTHczT8HEwFsRKNEO5VNJJ
VKkAoLlSY/yZ0v5LD5UrzVoMQQiEPeIW
=K4r3
-----END PGP SIGNATURE-----

--nextPart2811521.riE6EohbxI--
