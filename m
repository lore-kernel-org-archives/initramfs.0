From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut.8: updated I18N and LUKS sections
Date: Tue, 3 Aug 2010 13:00:13 +0200
Message-ID: <20100803130013.539710f2@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/VcmP56=2EFVrKrzkjuygp.m"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/VcmP56=2EFVrKrzkjuygp.m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

i18n/README: typo corrected
---
 dracut.8                |   54 +++++++++++++++++++++++++++++++++----------=
----
 modules.d/10i18n/README |    2 +-
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/dracut.8 b/dracut.8
index 10f1e1f..3a85cb5 100644
--- a/dracut.8
+++ b/dracut.8
@@ -167,28 +167,40 @@ set udev to loglevel info
 set udev to loglevel debug
=20
 .SS I18N
- e.g.
-  LANG=3Den_US.UTF-8
-  SYSFONT=3Dlatarcyrheb-sun16
-  KEYTABLE=3Dde-latin1-nodeadkeys
 .TP
-.BR KEYBOARDTYPE=3D sun|pc
-will be written to /etc/sysconfig/keyboard in the initramfs
+.BR KEYMAP "=3D<keymap base file name>"
+keyboard translation table loaded by loadkeys; taken from keymaps director=
y;
+will be written to /etc/sysconfig/keyboard in the initramfs, e.g.:
+KEYMAP=3Dde-latin1-nodeadkeys
+.TP
+.BR EXT_KEYMAPS "=3D<list of keymap base file names>"
+list of extra keymaps to bo loaded (sep. by space); will be written to
+/etc/sysconfig/keyboard in the initramfs
+.TP
+.BR UNICODE =3D<1|0>
+boolean, indicating UTF-8 mode; will be written to /etc/sysconfig/i18n in =
the
+initramfs
 .TP
-.BR KEYTABLE=3D "<keytable filename>"
-will be written to /etc/sysconfig/keyboard in the initramfs
+.BR SYSFONT "=3D<font base file name>"
+console font; taken from consolefonts directory;  will be written to
+/etc/sysconfig/i18n in the initramfs; e.g.: SYSFONT=3DLatArCyrHeb-16
 .TP
-.BR SYSFONT=3D "Console font"
-will be written to /etc/sysconfig/i18n in the initramfs
+.BR CONTRANS "=3D<console map base file name>"
+see description of '-m' parameter in setfont manual; taken from consoletra=
ns
+directory; will be written to /etc/sysconfig/i18n in the initramfs
 .TP
-.BR SYSFONTACM=3D "Unicode font map"
-will be written to /etc/sysconfig/i18n in the initramfs
+.BR UNIMAP "=3D<unicode table base file name>"
+see description of '-u' parameter in setfont manual; taken from unimaps
+directory; will be written to /etc/sysconfig/i18n in the initramfs
 .TP
-.BR UNIMAP=3D "Unicode font map"
-will be written to /etc/sysconfig/i18n in the initramfs
+.BR LANG "=3D<locale>"
+taken from the environment; if no UNICODE is defined we set its value in b=
asis
+of LANG value (whether it ends with ".utf8" (or similar) or not); will be
+written to /etc/sysconfig/i18n in the initramfs; e.g.: LANG=3Dpl_PL.utf8
 .TP
-.BR LANG=3D <locale>
-will be written to /etc/sysconfig/i18n in the initramfs
+.BR LC_ALL "=3D<locale>"
+taken from the environment; will be written to /etc/sysconfig/i18n in the
+initramfs
=20
 .SS LVM
 .TP
@@ -221,6 +233,16 @@ This parameter can be specified multiple times.
 .BR rd_NO_CRYPTTAB
 do not check, if LUKS partition is in /etc/crypttab
=20
+.SS "crypt LUKS - experimental removable keys support"
+works only when plymouth module is not included
+.TP
+.BR rd_LUKS_KEYPATH=3D "<path to keyfile>"
+path to keyfile inside remove device filesystem
+.TP
+.BR rd_LUKS_KEYDEV_UUID=3D "<rem. device uuid>"
+UUID of removalbe device storing keyfile; UUID doesn't have to be exact ju=
st
+like for rd_LUKS_UUID
+
 .SS MD
 .TP
 .BR rd_NO_MD
diff --git a/modules.d/10i18n/README b/modules.d/10i18n/README
index 09cb642..c1878a7 100644
--- a/modules.d/10i18n/README
+++ b/modules.d/10i18n/README
@@ -120,5 +120,5 @@ file (the same where you put mappings).
 3. Kernel parameters
=20
 If you create generic initramfs you can set up i18n by kernel
-parameters using variables listed in 2.1. (expect of UNIKEYMAP
+parameters using variables listed in 2.1. (except of UNIKEYMAP
 and GRP_TOGGLE) The recommended minimum is: SYSFONT, KEYMAP and UNICODE.
--=20
1.7.2

--Sig_/VcmP56=2EFVrKrzkjuygp.m
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkxX9r0ACgkQ+hU8EsKEdQ1/WACcC2/Q5JWLDD7/uuEkxflPerT9
zpAAoM3XZVctv2Yr+N8DOjs+UY4WDgiH
=7qEk
-----END PGP SIGNATURE-----

--Sig_/VcmP56=2EFVrKrzkjuygp.m--
