From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] README for 10i18n module
Date: Tue, 13 Jul 2010 09:58:47 +0200
Message-ID: <20100713095847.3506a128@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/m8m7+F8sVY61XAptBhdes=P"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/m8m7+F8sVY61XAptBhdes=P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

---
 modules.d/10i18n/README |  124 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 124 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/10i18n/README

diff --git a/modules.d/10i18n/README b/modules.d/10i18n/README
new file mode 100644
index 0000000..dd84881
--- /dev/null
+++ b/modules.d/10i18n/README
@@ -0,0 +1,124 @@
+Dracut i18n module
+------------------
+
+INDEX
+
+0. Introduction
+1. Hostonly vs Generic
+2. Configuration
+   2.1. Variables
+   2.2. Setting up mappings
+   2.3. Additional settings
+3. Kernel parameters
+
+~
+
+0. Introduction
+
+i18n module provides internationalization for initramfs at runtime.  It
+is intended to be generic across different GNU/Linux distributions.
+
+i18n and keyboard settings are stored in different files among
+distributions.  To deal with it avoiding hardcoding those differences in
+the installation script we handle it by mappings between variables used
+by Dracut and the ones in the system.  Package maintainer is expected to
+create those for his/her distribution and it's appreciated to share it
+with us, so we can include it in source package.=20
+
+
+1. Hostonly vs Generic
+
+If you invoke dracut with '-H' option, i18n module install script will
+gather variables values from your configuration files using mappings
+provided in "/etc/dracut.conf.d/<foo>.conf".  Those variables will be
+put in "etc/sysconfig/{i18n,keyboard}" files inside initramfs image.
+Next it will install only declared font, keymaps and so.
+
+When building generic image (dracut without '-H' option), install script
+copies all content of directories: consolefonts, consoletrans, unimaps
+and keymaps to image.  Take into account that's about 4 MiB.
+
+
+2. Configuration
+
+2.1. Variables
+
+The following variables are used by i18n install script and at initramfs
+runtime:
+
+    KEYMAP - keyboard translation table loaded by loadkeys
+    EXT_KEYMAPS - list of extra keymaps to bo loaded (sep. by space)
+    UNICODE - boolean, indicating UTF-8 mode
+    SYSFONT - console font
+    CONTRANS - see description of '-m' parameter in setfont manual
+    UNIMAP - see description of '-u' parameter in setfont manual
+
+The following are appended to EXT_KEYMAPS:
+
+    UNIKEYMAP
+    GRP_TOGGLE
+
+They were used in 10redhat-i18n module, but not sure of its purpose.
+I'm leaving it in case...  The following are taken from the environment:
+
+    LANG
+    LC_ALL
+
+If UNICODE variable is not provided, script indicates if UTF-8 should be
+used on the basis of LANG value (if it ends with ".utf8" or similar).
+
+
+2.2. Setting up mappings
+
+Mappings between variables listed in 2.1. and the ones spread around
+your system are set up in /etc/dracut.conf.d/<foo>.conf.  You need to
+assign mappings to fields keyboard_vars and i18n_vars.  Here's an
+example:
+
+keyboard_vars=3D"/etc/conf.d/keymaps:KEYMAP,EXTENDED_KEYMAPS-EXT_KEYMAPS"
+i18n_vars=3D"/etc/conf.d/consolefont:CONSOLEFONT-SYSFONT,CONSOLETRANSLATIO=
N-CONTRANS /etc/rc.conf:UNICODE"
+
+First we've got name of file in host file system tree.  After colon
+there's mapping: <from>-<to>.  If both variables have the same name you
+can enter just a single, but it's important to specify it!  The module
+will source only variables you've listed.
+
+Below there's detailed description in BNF:
+
+<list> ::=3D <element> | <element> " " <list>
+<element> ::=3D <conf-file-name> ":" <map-list>
+<map-list> ::=3D <mapping> | <mapping> "," <map-list>
+<mapping> ::=3D <src-var> "-" <dst-var> | <src-var>
+
+We assume no whitespace are allowed between symbols.
+<conf-file-name> is a file holding <src-var> in your system.
+<src-var> is a variable holding value of meaning the same as <dst-var>.
+<dst-var> is a variable which will be set up inside initramfs.
+If <dst-var> has the same name as <src-var> we can omit <dst-var>.
+
+Example:
+/etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
+<list> =3D /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
+<element> =3D /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
+<conf-file-name> =3D /etc/conf.d/keymaps
+<map-list> =3D KEYMAP,extended_keymaps-EXT_KEYMAPS
+<mapping> =3D KEYMAP
+<src-var> =3D KEYMAP
+<mapping> =3D extended_keymaps-EXT_KEYMAPS
+<src-var> =3D extended_keymaps
+<dst-var> =3D EXT_KEYMAPS
+
+
+2.3. Additional settings
+
+If you encounter following error message: "Directories consolefonts,
+consoletrans, keymaps, unimaps not found.", you can provide path where
+those directories lie in your system by setting kbddir in configuration
+file (the same where you put mappings).
+
+
+3. Kernel parameters
+
+If you create generic initramfs you can set up i18n by kernel
+parameters using variables listed in 2.1.  The recommended minimum is:
+SYSFONT, KEYMAP and UNICODE.
--=20
1.7.1


--Sig_/m8m7+F8sVY61XAptBhdes=P
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkw8HLcACgkQ+hU8EsKEdQ1qvQCfeIXSbQZi7URnBZt1vjvlkbh1
Y20AoNJ7sB9vYak16xKJGjYKqz2J0SP2
=65oh
-----END PGP SIGNATURE-----

--Sig_/m8m7+F8sVY61XAptBhdes=P--
