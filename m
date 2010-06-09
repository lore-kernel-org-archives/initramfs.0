From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/3] Support old version of module-init-tools
Date: Wed, 9 Jun 2010 10:36:05 +0200
Message-ID: <20100609103605.50a6acec@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/s0+s5QEJLPwHnyVw6_MDWPq"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/s0+s5QEJLPwHnyVw6_MDWPq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

modprobe included in version prior to 3.7 of module-init-tools doesn't
have -d | --dirname option which allows to give a prefix other than
'/' for kernel modules path. Dracut assumes existence of that
option and uses it even with default '/'. The patch passes -d option
only if it's different from default and also checks module-init-tools
version if user changes the prefix by --kmoddir Dracut option.
---
 dracut           |    8 +++++++-
 dracut-functions |   44 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/dracut b/dracut
index 35be7eb..139d0e0 100755
--- a/dracut
+++ b/dracut
@@ -183,7 +183,13 @@ esac
 abs_outfile=3D$(readlink -f "$outfile") && outfile=3D"$abs_outfile"
=20
 srcmods=3D"/lib/modules/$kernel/"
-[[ $drivers_dir ]] && srcmods=3D"$drivers_dir"
+[[ $drivers_dir ]] && {
+    if verlt $(modprobe --version | cut -d' ' -f3) 3.7; then
+        derror 'To use --kmoddir option module-init-tools >=3D 3.7 is requ=
ired.'
+        exit 1
+    fi
+    srcmods=3D"$drivers_dir"
+}
 export srcmods
=20
 if [[ -f $outfile && ! $force ]]; then
diff --git a/dracut-functions b/dracut-functions
index a76cc22..fbac282 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -24,6 +24,39 @@ IF_dynamic=3D""
 # Generic substring function.  If $2 is in $1, return 0.
 strstr() { [[ $1 =3D~ $2 ]]; }
=20
+# Version comparision function.  Returns result similar to C strcmp,
+# but instead of -1 is 2.  Function assumes version scheme like does
+# Linux kernel.
+vercmp() {
+    local n1 n2 i=3D1
+
+    while true
+    do
+        n1=3D$(echo $1 | cut -d'.' -f$i)
+        n2=3D$(echo $2 | cut -d'.' -f$i)
+
+        [[ ! $n1 && ! $n2 ]] && return 0
+        [[ $n1 -lt $n2 ]] && return 2
+        [[ $n1 -gt $n2 ]] && return 1
+
+        ((i++))
+    done
+}
+
+# Variation of version comparision function.  If $1 >=3D $2, return 0.
+verge() {
+    vercmp $1 $2
+
+    [[ $? =3D 0 || $? =3D 1 ]]
+}
+
+# Variation of version comparision function.  If $1 < $2, return 0.
+verlt() {
+    vercmp $1 $2
+
+    [[ $? =3D 2 ]]
+}
+
 # Log initrd creation.
 if ! [[ $dracutlogfile ]]; then
     [[ $dracutbasedir =3D /usr/share/dracut ]] && \
@@ -487,7 +520,7 @@ filter_kernel_modules () (
 # install kernel modules along with all their dependencies.
 instmods() {
     [[ $no_kernel =3D yes ]] && return
-    local mod mpargs modpath modname cmd
+    local mod mpargs modpath modname cmd moddirname
     while (($# > 0)); do
 	mod=3D${1%.ko*}
 	case $mod in
@@ -519,10 +552,17 @@ instmods() {
 	        ! echo $add_drivers | grep -qe "\<${mod}\>" &&	{
 		    shift; continue;=20
 		}
+
+		# We use '-d' option in modprobe only if modules prefix path
+		# differs from default '/'.  This allows us to use Dracut with
+		# old version of modprobe which doesn't have '-d' option.
+		moddirname=3D${srcmods%%/lib/modules/*}
+		[[ -n ${moddirname} ]] && moddirname=3D"-d ${moddirname}/"
+
 		# ok, load the module, all its dependencies, and any firmware
 		# it may require
 		for_each_kmod_dep install_kmod_with_fw $mod \
-		    --set-version $kernel -d ${srcmods%%/lib/modules/*}/
+		    --set-version $kernel ${moddirname}
 		;;
 	esac     =20
 	shift
--=20
1.7.1

--Sig_/s0+s5QEJLPwHnyVw6_MDWPq
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwPUnUACgkQ+hU8EsKEdQ0CigCfWDY0f6CliyxB6nRV5XUiHCEi
miMAoLzn7ND+OYhvtuawC/9HEHILCRxT
=wfXP
-----END PGP SIGNATURE-----

--Sig_/s0+s5QEJLPwHnyVw6_MDWPq--
