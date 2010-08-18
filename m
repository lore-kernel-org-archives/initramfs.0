From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/2] dracut: lib and usr/lib dirs detection
Date: Wed, 18 Aug 2010 20:06:44 +0200
Message-ID: <20100818200644.4e1e79de@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/+ks1CR/9CbaxvbF2SZdTpKO"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/+ks1CR/9CbaxvbF2SZdTpKO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

First we check if $libdir and $usrlibdir vars are already set in config
file. If not we perform simple detect. Vars are exported - to be useful
in module/check scripts.
---
 dracut |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index a50e14a..86855c9 100755
--- a/dracut
+++ b/dracut
@@ -186,6 +186,17 @@ fi
 dracutfunctions=3D$dracutbasedir/dracut-functions
 export dracutfunctions
=20
+# Detect lib paths
+[[ $libdir ]] || for libdir in /lib64 /lib; do
+    [[ -d $libdir ]] && break
+done || {
+    derror 'No lib directory?!!!'
+    exit 1
+}
+[[ $usrlibdir ]] || for usrlibdir in /usr/lib64 /usr/lib; do
+    [[ -d $usrlibdir ]] && break
+done || dwarning 'No usr/lib directory!'
+
 # This is kinda legacy -- eventually it should go away.
 case $dracutmodules in
     ""|auto) dracutmodules=3D"all" ;;
@@ -240,7 +251,7 @@ chmod 755 "$initdir"
 export initdir hookdirs dracutbasedir dracutmodules drivers \
     fw_dir drivers_dir debug beverbose no_kernel kernel_only \
     add_drivers mdadmconf lvmconf filesystems ignore_kmodules \
-    use_fstab
+    use_fstab libdir usrlibdir
=20
 if [[ $kernel_only !=3D yes ]]; then
     # Create some directory structure first
--=20
1.7.2

--Sig_/+ks1CR/9CbaxvbF2SZdTpKO
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkxsITQACgkQ+hU8EsKEdQ1WsQCfc3SZ7KX9EhMT814Ru2sjBIk3
Ri0AoOOUUJHze3vu9MjJCw+BL3UU6Cmo
=DBWr
-----END PGP SIGNATURE-----

--Sig_/+ks1CR/9CbaxvbF2SZdTpKO--
