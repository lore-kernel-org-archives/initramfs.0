From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/2] use $libdir and $usrlibdir instead of individual detect
 with ldd
Date: Wed, 18 Aug 2010 20:11:29 +0200
Message-ID: <20100818201129.486a0c43@aidecoe.name>
References: <20100818200644.4e1e79de@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/7_DVBMSfEeDE6kXehkn=hD2"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100818200644.4e1e79de-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/7_DVBMSfEeDE6kXehkn=hD2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

---
 modules.d/01fips/install                      |   24 ++++++++-------------=
---
 modules.d/40network/install                   |   15 +++++----------
 modules.d/50plymouth/plymouth-populate-initrd |   13 ++++---------
 modules.d/90dmraid/install                    |   11 ++---------
 modules.d/90lvm/install                       |   11 ++---------
 modules.d/90multipath/install                 |   10 +---------
 modules.d/95nfs/install                       |   14 +++++---------
 modules.d/95udev-rules/install                |    8 +++-----
 8 files changed, 30 insertions(+), 76 deletions(-)

diff --git a/modules.d/01fips/install b/modules.d/01fips/install
index 53f54de..f74ea6a 100755
--- a/modules.d/01fips/install
+++ b/modules.d/01fips/install
@@ -3,21 +3,13 @@
 inst_hook pre-trigger 01 "$moddir/fips.sh"
 dracut_install sha512hmac rmmod insmod mount uname umount
=20
-libdir=3D"lib"
-if ldd $(find_binary sha512hmac) |grep -q /lib64/; then
-    libdir=3D"lib64"
-fi
-
-if [ -e /usr/$libdir/libsoftokn3.so ]; then
-    dracut_install \
-        /usr/$libdir/libsoftokn3.so /usr/$libdir/libsoftokn3.chk \
-        /usr/$libdir/libfreebl3.so /usr/$libdir/libfreebl3.chk=20
-else
-    dracut_install \
-        /$libdir/libsoftokn3.so /$libdir/libsoftokn3.chk \
-        /$libdir/libfreebl3.so /$libdir/libfreebl3.chk=20
-fi
-
-dracut_install /usr/$libdir/hmaccalc/sha512hmac.hmac
+for dir in "$usrlibdir" "$libdir"; do
+    [[ -e $dir/libsoftokn3.so ]] && \
+        dracut_install $dir/libsoftokn3.so $dir/libsoftokn3.chk \
+            $dir/libfreebl3.so $dir/libfreebl3.chk && \
+                break
+done
+
+dracut_install $usrlibdir/hmaccalc/sha512hmac.hmac
=20
 # vim:ts=3D8:sw=3D4:sts=3D4:et
diff --git a/modules.d/40network/install b/modules.d/40network/install
index 398d4e4..c809ece 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -12,17 +12,12 @@ inst_hook cmdline 98 "$moddir/parse-bridge.sh"
 inst_hook cmdline 99 "$moddir/parse-ifname.sh"
 inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
=20
-if ldd $(which sh) | grep -q lib64; then
-    LIBDIR=3D"/lib64"
-else
-    LIBDIR=3D"/lib"
-fi
+arch=3D$(uname -m)
=20
-ARCH=3D$(uname -m)
-
-for dir in /usr/$LIBDIR/tls/$ARCH/ /usr/$LIBDIR/tls/ /usr/$LIBDIR/$ARCH/ /=
usr/$LIBDIR/ /$LIBDIR/; do
-    for i in $(ls $dir/libnss_dns.so.* $dir/libnss_mdns4_minimal.so.* 2>/d=
ev/null); do
-	dracut_install $i
+for dir in "$usrlibdir/tls/$arch" "$usrlibdir/tls" "$usrlibdir/$arch" \
+        "$usrlibdir" "$libdir"; do
+    for i in "$dir"/libnss_dns.so.* "$dir"/libnss_mdns4_minimal.so.*; do
+        dracut_install "$i"
     done
 done
=20
diff --git a/modules.d/50plymouth/plymouth-populate-initrd b/modules.d/50pl=
ymouth/plymouth-populate-initrd
index effb0f9..aa3d8fa 100755
--- a/modules.d/50plymouth/plymouth-populate-initrd
+++ b/modules.d/50plymouth/plymouth-populate-initrd
@@ -1,9 +1,4 @@
 #!/bin/bash
-if ldd /sbin/plymouthd |grep -q lib64; then
-    LIBDIR=3D"/usr/lib64"
-else
-    LIBDIR=3D"/usr/lib"
-fi
 PLYMOUTH_LOGO_FILE=3D"/usr/share/pixmaps/system-logo-white.png"
 PLYMOUTH_THEME=3D$(plymouth-set-default-theme)
=20
@@ -15,8 +10,8 @@ dracut_install /bin/plymouth \
 mkdir -p "${initdir}/usr/share/plymouth"
=20
 if [[ $hostonly ]]; then=20
-    dracut_install "${LIBDIR}/plymouth/text.so" \
-	"${LIBDIR}/plymouth/details.so" \
+    dracut_install "${usrlibdir}/plymouth/text.so" \
+	"${usrlibdir}/plymouth/details.so" \
 	"/usr/share/plymouth/themes/details/details.plymouth" \
 	"/usr/share/plymouth/themes/text/text.plymouth" \
=20
@@ -31,7 +26,7 @@ if [[ $hostonly ]]; then
 	inst /usr/share/plymouth/themes/default.plymouth
         # Install plugin for this theme
 	PLYMOUTH_PLUGIN=3D$(grep "^ModuleName=3D" /usr/share/plymouth/themes/defa=
ult.plymouth | while read a b c; do echo $b; done;)
-	inst ${LIBDIR}/plymouth/${PLYMOUTH_PLUGIN}.so
+	inst "${usrlibdir}/plymouth/${PLYMOUTH_PLUGIN}.so"
     fi
 else
     for x in /usr/share/plymouth/themes/{text,details}/* ; do
@@ -40,7 +35,7 @@ else
 	mkdir -p "${initdir}/$THEME_DIR"
         dracut_install "$x"
     done
-    for x in ${LIBDIR}/plymouth/{text,details}.so ; do
+    for x in "${usrlibdir}"/plymouth/{text,details}.so ; do
         [[ -f "$x" ]] || continue
         [[ "$x" !=3D "${x%%/label.so}" ]] && continue
         dracut_install "$x"
diff --git a/modules.d/90dmraid/install b/modules.d/90dmraid/install
index a016e4d..90bf62c 100755
--- a/modules.d/90dmraid/install
+++ b/modules.d/90dmraid/install
@@ -3,17 +3,10 @@ dracut_install dmraid partx kpartx
=20
 inst  dmeventd
=20
-if ldd $(which dmraid) | grep -q lib64; then
-    LIBDIR=3D"/lib64"
-else
-    LIBDIR=3D"/lib"
-fi
-
-for i in $(ls /{usr,}/$LIBDIR/libdmraid-events*.so 2>/dev/null); do
-    dracut_install $i
+for i in {"$libdir","$usrlibdir"}/libdmraid-events*.so; do
+    dracut_install "$i"
 done
=20
-
 inst_rules 10-dm.rules 13-dm-disk.rules 95-dm-notify.rules=20
=20
 inst "$moddir/dmraid.sh" /sbin/dmraid_scan
diff --git a/modules.d/90lvm/install b/modules.d/90lvm/install
index 3e20866..0e19c7d 100755
--- a/modules.d/90lvm/install
+++ b/modules.d/90lvm/install
@@ -17,13 +17,6 @@ inst_rules 10-dm.rules 13-dm-disk.rules 95-dm-notify.rul=
es 11-dm-lvm.rules
 inst "$moddir/lvm_scan.sh" /sbin/lvm_scan
 inst_hook cmdline 30 "$moddir/parse-lvm.sh"
=20
-
-if ldd $(which lvm) | grep -q lib64; then
-    LIBDIR=3D"/lib64"
-else
-    LIBDIR=3D"/lib"
-fi
-
-for i in $(ls /{usr,}/$LIBDIR/libdevmapper-event-lvm*.so 2>/dev/null); do
-    dracut_install $i
+for i in {"$libdir","$usrlibdir"}/libdevmapper-event-lvm*.so; do
+    dracut_install "$i"
 done
diff --git a/modules.d/90multipath/install b/modules.d/90multipath/install
index ed2d698..d42e411 100755
--- a/modules.d/90multipath/install
+++ b/modules.d/90multipath/install
@@ -1,11 +1,5 @@
 #!/bin/bash
=20
-if ldd $(which multipath) 2>/dev/null |grep -q lib64; then
-    LIBDIR=3D"/lib64"
-else
-    LIBDIR=3D"/lib"
-fi
-
 for f in  \
     /sbin/dmsetup \
     /sbin/kpartx \
@@ -17,12 +11,10 @@ for f in  \
     /etc/xdrdevices.conf \
     /etc/multipath.conf \
     /etc/multipath/wwids \
-    $(ls $LIBDIR/libmultipath* $LIBDIR/multipath/* 2>/dev/null) \
-    	;do
+    "$libdir"/libmultipath* "$libdir"/multipath/*; do
     [ -e "$f" ] && inst "$f"
 done
=20
 inst_hook pre-trigger 02 "$moddir/multipathd.sh"
 inst_hook pre-pivot   02 "$moddir/multipathd-stop.sh"
 inst_rules 40-multipath.rules
-
diff --git a/modules.d/95nfs/install b/modules.d/95nfs/install
index 5d3c535..c54552a 100755
--- a/modules.d/95nfs/install
+++ b/modules.d/95nfs/install
@@ -9,15 +9,11 @@ dracut_install /etc/nsswitch.conf /etc/rpc /etc/protocols
 dracut_install rpc.idmapd /etc/idmapd.conf
 dracut_install sed
=20
-if ldd $(which rpc.idmapd) |grep -q lib64; then
-    LIBDIR=3D"/lib64"
-else
-    LIBDIR=3D"/lib"
-fi
-
-dracut_install $(ls {/usr,}$LIBDIR/libnfsidmap_nsswitch.so* 2>/dev/null )
-dracut_install $(ls {/usr,}$LIBDIR/libnfsidmap/*.so 2>/dev/null )
-dracut_install $(ls {/usr,}$LIBDIR/libnfsidmap*.so* 2>/dev/null )
+for i in {"$libdir","$usrlibdir"}/libnfsidmap_nsswitch.so* \
+        {"$libdir","$usrlibdir"}/libnfsidmap/*.so \
+        {"$libdir","$usrlibdir"}/libnfsidmap*.so*; do
+    dracut_install "$i"
+done
=20
 nsslibs=3D$(sed -e '/^#/d' -e 's/^.*://' -e 's/\[NOTFOUND=3Dreturn\]//' /e=
tc/nsswitch.conf \
               |  tr -s '[:space:]' '\n' | sort -u | tr -s '[:space:]' '|')
diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/install
index e89acb5..d57dd8d 100755
--- a/modules.d/95udev-rules/install
+++ b/modules.d/95udev-rules/install
@@ -48,8 +48,6 @@ done
=20
 [ -f /etc/arch-release ] && inst "$moddir/load-modules.sh" /lib/udev/load-=
modules.sh
=20
-if ldd $(find_binary udevd) |grep -q /lib64/; then
-    dracut_install /lib64/libnss_files*
-else
-    dracut_install /lib/libnss_files*
-fi
+for i in {"$libdir","$usrlibdir"}/libnss_files*; do
+    dracut_install "$i"
+done
--=20
1.7.2

--Sig_/7_DVBMSfEeDE6kXehkn=hD2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkxsIlEACgkQ+hU8EsKEdQ2hDQCcCOTH9r0OS5g0UcsJhGccV+Yf
fEMAoJYxZ+rZUfGuOjE9HmR6dCkuy9a/
=Hzrt
-----END PGP SIGNATURE-----

--Sig_/7_DVBMSfEeDE6kXehkn=hD2--
