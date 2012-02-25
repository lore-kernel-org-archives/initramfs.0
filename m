From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: [PATCH] Use modinfo to gather module dependencies
Date: Sat, 25 Feb 2012 22:09:11 +0100
Message-ID: <2369135.eJzU9GBXlg@ernie>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2036175.IK5QL7GoGU"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--nextPart2036175.IK5QL7GoGU
Content-Type: multipart/mixed; boundary="nextPart5218710.ectezDI4ZW"
Content-Transfer-Encoding: 7Bit


--nextPart5218710.ectezDI4ZW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!

I just switched from module-init-tools to kmod and found dracut broken, 
because it uses modprobe --show-depends to find out about module locations and 
dependencies, which apparently is not implemented in kmod.

Hence I wrote attached patch, switching from modprobe to modinfo, which also 
seem to be the tool intended for the job. This method appears to work reliable 
in kmod-5, but I have not tested with module-init-tools.

Kind regards,
Dennis
--nextPart5218710.ectezDI4ZW
Content-Disposition: attachment; filename="dracut-modinfo.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="dracut-modinfo.patch"

--- /usr/lib/dracut/dracut-functions.orig	2012-02-25 20:28:31.378736079 +0100
+++ /usr/lib/dracut/dracut-functions	2012-02-25 21:53:55.278987278 +0100
@@ -964,6 +964,28 @@
     return 0
 }
 
+get_kmod_filename_with_deps_recursive() {
+    local _kmod=$1 _field _value _modpath _dep _deps
+	shift 1
+    modinfo "$@" $_kmod 2>&${_fderr} | (
+		while read _field _value ; do
+			case $_field in
+				filename:)
+					_modpath=$_value
+					;;
+				depends:)
+					_deps=${_value//,/ }
+					for _dep in $_deps ; do
+						get_kmod_filename_with_deps_recursive $_dep "$@"
+					done
+					;;
+			esac
+		done
+		echo $_modpath
+		[[ $_modpath ]] || exit 1
+	)
+}
+
 # Do something with all the dependencies of a kernel module.
 # Note that kernel modules depend on themselves using the technique we use
 # $1 = function to call for each dependency we find
@@ -972,17 +994,13 @@
 # rest of args = arguments to modprobe
 # _fderr specifies FD passed from surrounding scope
 for_each_kmod_dep() {
-    local _func=$1 _kmod=$2 _cmd _modpath _options _found=0
+    local _func=$1 _kmod=$2 _modpath _found=0
     shift 2
-    modprobe "$@" --ignore-install --show-depends $_kmod 2>&${_fderr} | (
-        while read _cmd _modpath _options; do
-            [[ $_cmd = insmod ]] || continue
-            $_func ${_modpath} || exit $?
-            _found=1
-        done
-        [[ $_found -eq 0 ]] && exit 1
-        exit 0
-    )
+    for _modpath in `get_kmod_filename_with_deps_recursive ${_kmod} "$@"` ; do
+       	$_func ${_modpath}
+        _found=1
+	done
+    [[ $_found -ne 0 ]]
 }
 
 # filter kernel modules to install certain modules that meet specific

--nextPart5218710.ectezDI4ZW--

--nextPart2036175.IK5QL7GoGU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEABECAAYFAk9JTfcACgkQjqfyF1DtJW6kpACgueTYPZkUZCWgZuEuMIPohoER
2U0AnAu0LwfhMhYYElJ5sH36YUQrgLAa
=p36l
-----END PGP SIGNATURE-----

--nextPart2036175.IK5QL7GoGU--
