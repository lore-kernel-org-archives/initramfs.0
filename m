From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/3] dracut: info which module is sourced; updated dracut
 usage
Date: Mon, 5 Jul 2010 09:06:47 +0200
Message-ID: <20100705090647.30b3c2bc@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/FCrwR+i+ynDFK.EF6.eP4c8"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/FCrwR+i+ynDFK.EF6.eP4c8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Added description for --confdir.
---
 dracut |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/dracut b/dracut
index 3be4989..6b590f5 100755
--- a/dracut
+++ b/dracut
@@ -57,6 +57,8 @@ Creates initial ramdisk images for preloading modules
   -v, --verbose         Verbose output during the build process
   -c, --conf [FILE]     Specify configuration file to use.
                          Default: /etc/dracut.conf
+  --confdir [DIR]       Specify configuration directory to use *.conf file=
s from.
+                         Default: /etc/dracut.conf.d
   -l, --local           Local mode. Use modules from the current working
                          directory instead of the system-wide installed in
                          /usr/share/dracut/modules.d.
@@ -243,6 +245,7 @@ check_modules
 for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
     mod=3D${moddir##*/}; mod=3D${mod#[0-9][0-9]}
     if strstr "$mods_to_load" " $mod "; then
+	dinfo "*** Sourcing module $mod"
 	if [[ $kernel_only =3D yes ]]; then
 	    [[ -x $moddir/installkernel ]] && . "$moddir/installkernel"
 	else
--=20
1.7.1

--Sig_/FCrwR+i+ynDFK.EF6.eP4c8
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwxhIcACgkQ+hU8EsKEdQ2ZagCgw6mdKFiHvEWCuSl6ZK8WmuaJ
/ukAn0UWK99h73bUinzFpul4Mz9T+f9p
=LiKy
-----END PGP SIGNATURE-----

--Sig_/FCrwR+i+ynDFK.EF6.eP4c8--
