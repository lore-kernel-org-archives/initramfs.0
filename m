From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 4/4 - V2] crypt/parse-crypt.sh: hide encrypted devices from
 systemd timeout warnings.
Date: Wed, 1 Apr 2015 08:57:41 +1100
Message-ID: <20150401085741.4aea1463@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/3oduO2HVYiu+34jHkvJPPvl"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/3oduO2HVYiu+34jHkvJPPvl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable



When systemd's crypttab generator parsed crypttab, it tells
systemd about several devices which may not appear until later
in the boot sequence, and which are not needed while dract is running.

This can particularly happen when an md array is encrypted,
and the array is newly degraded so that it doesn't appear until
dracut runs mdraid_start.sh.

This can result in systemd printing warning messages which are
inappropriate.

So tell systemd that the timeout for each of these is zero.

This is involves splitting some functionality out of wait_for_dev()

That function does two things:
 - creates 'finished' hooks so that dracut will wait for the device,
   and
 - sets the systemd timeout for the device to zero, so systemd doesn't
   wait.

We only want the second of these for most encrypted devices.
So split that out into a new function set_systemd_timeout_for_dev(),
and call it from parse-crypt.sh

Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

--
This version fixes the missing redirect from /etc/crypttab
NeilBrown


diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse-cry=
pt.sh
index 94ad1f63ae6f..87e674a849a0 100755
--- a/modules.d/90crypt/parse-crypt.sh
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -14,6 +14,10 @@ else
     LUKS=3D$(getargs rd.luks.uuid -d rd_LUKS_UUID)
     tout=3D$(getarg rd.luks.key.tout)
=20
+    while read _mapper _dev _rest ; do
+        set_systemd_timeout_for_dev $_dev
+    done < /etc/crypttab
+
     if [ -n "$LUKS" ]; then
         for luksid in $LUKS; do
=20
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 259e2057b67e..c8ff3c1a32d1 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -895,12 +895,10 @@ dev_unit_name()
     printf -- "%s" "$dev"
 }
=20
-# wait_for_dev <dev>
-#
-# Installs a initqueue-finished script,
-# which will cause the main loop only to exit,
-# if the device <dev> is recognized by the system.
-wait_for_dev()
+# set_systemd_timeout_for_dev <dev>
+# Set 'rd.timeout' as the systemd timeout for <dev>
+
+set_systemd_timeout_for_dev()
 {
     local _name
     local _needreload
@@ -915,19 +913,6 @@ wait_for_dev()
     _timeout=3D$(getarg rd.timeout)
     _timeout=3D${_timeout:-0}
=20
-    _name=3D"$(str_replace "$1" '/' '\x2f')"
-
-    type mark_hostonly >/dev/null 2>&1 && mark_hostonly "$hookdir/initqueu=
e/finished/devexists-${_name}.sh"
-
-    [ -e "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh" ] &&=
 return 0
-
-    printf '[ -e "%s" ]\n' $1 \
-        >> "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh"
-    {
-        printf '[ -e "%s" ] || ' $1
-        printf 'warn "\"%s\" does not exist"\n' $1
-    } >> "${PREFIX}$hookdir/emergency/80-${_name}.sh"
-
     if [ -n "$DRACUT_SYSTEMD" ]; then
         _name=3D$(dev_unit_name "$1")
         if ! [ -L ${PREFIX}/etc/systemd/system/initrd.target.wants/${_name=
}.device ]; then
@@ -952,6 +937,36 @@ wait_for_dev()
         fi
     fi
 }
+# wait_for_dev <dev>
+#
+# Installs a initqueue-finished script,
+# which will cause the main loop only to exit,
+# if the device <dev> is recognized by the system.
+wait_for_dev()
+{
+    local _name
+    local _noreload
+
+    if [ "$1" =3D "-n" ]; then
+        _noreload=3D-n
+        shift
+    fi
+
+    _name=3D"$(str_replace "$1" '/' '\x2f')"
+
+    type mark_hostonly >/dev/null 2>&1 && mark_hostonly "$hookdir/initqueu=
e/finished/devexists-${_name}.sh"
+
+    [ -e "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh" ] &&=
 return 0
+
+    printf '[ -e "%s" ]\n' $1 \
+        >> "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh"
+    {
+        printf '[ -e "%s" ] || ' $1
+        printf 'warn "\"%s\" does not exist"\n' $1
+    } >> "${PREFIX}$hookdir/emergency/80-${_name}.sh"
+
+    set_systemd_timeout_for_dev $_noreload $1
+}
=20
 cancel_wait_for_dev()
 {

--Sig_/3oduO2HVYiu+34jHkvJPPvl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVRsYVTnsnt1WYoG5AQL0pxAAjwajkjDYdAZo6t5Wp3p/OHRB8U7zur/7
V8RlrRqttftfAqg/swYRCKZEyjYxnmazQzfPRJTGGkGs2JNBOA9oI+uFxp5m66w7
O9XfR3BeK0D/uDkkL5/Pq/OfCBAUsNKNzyhtsgrTG/t9XqRj8obOspf8nvCL6iiH
SO0kfIg55udzisfm3+wWnx/1RJ7ae2f0WvB2K9ct7U/ba5NR7Sj/TUfu3n7SnsYf
y5JT0j4r0ZZSbPsgoUws7zXA/cdDOS5obXlp648JWOMNMrY8CWQB4dLjuWakWArz
YujyRvqbFtcQAgNk7xibLY0MQctGBEsIXpjEQ+njjCt8jTuUGCDuQnncBNqzYaWG
hURhZtiQzYfHgkRVAewoBYNNZmatphUxJuAYmxBiijYs0baI8ztNagJ6H3STGlgt
jrISMUfKOg6lV8HGNuGEYYMw2MSgDf8J6U2GbEficXZcKApxYtt/G/IdOCIx8v6s
ksh63BzNDVBeASthVwaWEg4s3vz3704GjITynn67owoMdHjMYiUQRItftD5hd1TA
yuZPCVuGaQ89ZFeqbsEaHYkJZu4ZXQs9QY7EnmTNHPU/fSd2Vn/G3QxsRqv3Lv9P
NETrM9q5xZrgPKd0c8Wua0pLUz3YSXmkMuVJTygHgYS5QAFw15rbdPjmWsR3IYDn
P3tHJszWZIk=
=+GdD
-----END PGP SIGNATURE-----

--Sig_/3oduO2HVYiu+34jHkvJPPvl--
