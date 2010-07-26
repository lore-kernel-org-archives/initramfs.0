From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/2] 99base: no modprobe and rmmod if --no-kernel
Date: Mon, 26 Jul 2010 10:17:42 +0200
Message-ID: <20100726101742.63c1d2c9@aidecoe.name>
References: <20100726101540.37af47d8@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/shIFTH6/CkmCoCaMGQPUrwr"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100726101540.37af47d8-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/shIFTH6/CkmCoCaMGQPUrwr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If we build initramfs without modules, instead of adding modprobe and
rmmod, create symlinks to /bin/true to don't produce unnecessary errors.
Anyway it's a workaround for following desired behaviour:
modprobe tries to insert module only if it's not built into kernel
---
 modules.d/99base/install |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/modules.d/99base/install b/modules.d/99base/install
index 6ba9e7e..0fd84ed 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -1,6 +1,13 @@
 #!/bin/bash
-dracut_install mount mknod mkdir modprobe pidof sleep chroot \
-    sed ls flock cp mv dmesg rm ln rmmod mkfifo less=20
+dracut_install mount mknod mkdir pidof sleep chroot \
+    sed ls flock cp mv dmesg rm ln mkfifo less
+if [[ $no_kernel ]]; then
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
1.7.1.1

--Sig_/shIFTH6/CkmCoCaMGQPUrwr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEARECAAYFAkxNRKYACgkQ+hU8EsKEdQ2hNwCdGCQH/PVMLhswlVsWhad3PqIp
W3IAn3XT8ccU7nS7BndXrg++nudGBF4b
=lFfk
-----END PGP SIGNATURE-----

--Sig_/shIFTH6/CkmCoCaMGQPUrwr--
