From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] add option --ignore-kernel-modules
Date: Wed, 4 Aug 2010 18:15:19 +0200
Message-ID: <20100804181519.5eaf9f1c@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/v/+ICrU0zh1MxnGHHl5Eq.t"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/v/+ICrU0zh1MxnGHHl5Eq.t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Instead of adding modprobe and rmmod, create symlinks to /bin/true to
don't produce unnecessary errors.  Anyway it's a workaround for
following desired behaviour: modprobe tries to insert module only if
it's not built into kernel
---
 dracut                   |   10 +++++++++-
 dracut.8                 |    4 ++++
 modules.d/99base/install |   13 ++++++++++---
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/dracut b/dracut
index c22051c..e0c2186 100755
--- a/dracut
+++ b/dracut
@@ -46,6 +46,10 @@ Creates initial ramdisk images for preloading modules
                         firmwares, separated by :
   --kernel-only         Only install kernel drivers and firmware files
   --no-kernel           Do not install kernel drivers and firmware files
+  --ignore-kernel-modules
+                        Don't try to load modules. It automatically implies
+                        '--no-kernel'. It's assumed that everything needed
+                        is built into kernel.
   --strip               Strip binaries in the initramfs
   --nostrip             Do not strip binaries in the initramfs (default)
   --mdadmconf           Include local /etc/mdadm.conf
@@ -86,6 +90,10 @@ while (($# > 0)); do
 	--fwdir) fw_dir_l=3D"$2"; shift;;
 	--kernel-only) kernel_only=3D"yes"; no_kernel=3D"no";;
 	--no-kernel) kernel_only=3D"no"; no_kernel=3D"yes";;
+    --ignore-kernel-modules) kernel_only=3D"no"; no_kernel=3D"yes"
+        ignore_kmodules=3D"yes"
+        omit_dracutmodules_l+=3D\ kernel-modules
+        ;;
 	--strip) do_strip_l=3D"yes";;
 	--nostrip) do_strip_l=3D"no";;
         --mdadmconf) mdadmconf_l=3D"yes";;
@@ -228,7 +236,7 @@ chmod 755 "$initdir"
=20
 export initdir hookdirs dracutbasedir dracutmodules drivers \
     fw_dir drivers_dir debug beverbose no_kernel kernel_only \
-    add_drivers mdadmconf lvmconf filesystems
+    add_drivers mdadmconf lvmconf filesystems ignore_kmodules
=20
 if [[ $kernel_only !=3D yes ]]; then
     # Create some directory structure first
diff --git a/dracut.8 b/dracut.8
index 3a85cb5..4890357 100644
--- a/dracut.8
+++ b/dracut.8
@@ -52,6 +52,10 @@ only install kernel drivers and firmware files
 .BR \-\-no-kernel
 do not install kernel drivers and firmware files
 .TP
+.BR \-\-ignore-kernel-modules
+don't try to load modules; it automatically implies \fB--no-kernel\fR; it's
+assumed that everything needed is built into kernel
+.TP
 .BR \-\-mdadmconf
 include local /etc/mdadm.conf
 .TP
diff --git a/modules.d/99base/install b/modules.d/99base/install
index 6ba9e7e..9cdb086 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -1,6 +1,13 @@
 #!/bin/bash
-dracut_install mount mknod mkdir modprobe pidof sleep chroot \
-    sed ls flock cp mv dmesg rm ln rmmod mkfifo less=20
+dracut_install mount mknod mkdir pidof sleep chroot sed ls flock cp mv dme=
sg \
+        rm ln mkfifo less=20
+if [[ ${ignore_kmodules} =3D yes ]]; then
+    inst /bin/true
+    ln -s /bin/true "${initdir}"/sbin/modprobe
+    ln -s /bin/true "${initdir}"/sbin/rmmod
+else
+    dracut_install modprobe rmmod
+fi
 if [ ! -e "${initdir}/bin/sh" ]; then
     dracut_install bash
     (ln -s bash "${initdir}/bin/sh" || :)
@@ -18,7 +25,7 @@ if which switch_root >/dev/null 2>&1; then
     dracut_install switch_root=20
 else
     inst "$moddir/switch_root" "/sbin/switch_root" \
-	|| derror "Failed to install switch_root"
+            || derror "Failed to install switch_root"
 fi
 inst "$moddir/dracut-lib.sh" "/lib/dracut-lib.sh"
 inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
--=20
1.7.2

--Sig_/v/+ICrU0zh1MxnGHHl5Eq.t
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkxZkhcACgkQ+hU8EsKEdQ2URwCfZz95uS4AB/MPqXxkhM+g9c0K
I2AAmwfZQfznK4jw0HVFkiMdseu+dFDm
=5X9m
-----END PGP SIGNATURE-----

--Sig_/v/+ICrU0zh1MxnGHHl5Eq.t--
