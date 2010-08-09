From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] add module gensplash
Date: Mon, 9 Aug 2010 12:18:31 +0200
Message-ID: <20100809121831.5e8bdbc1@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/c_rAPjlh_UStLlu13+CP9jR"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/c_rAPjlh_UStLlu13+CP9jR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

---
 modules.d/50gensplash/README                  |   42 ++++++++++++++++
 modules.d/50gensplash/check                   |    5 ++
 modules.d/50gensplash/gensplash-emergency.sh  |    5 ++
 modules.d/50gensplash/gensplash-newroot.sh    |    5 ++
 modules.d/50gensplash/gensplash-pretrigger.sh |   14 ++++++
 modules.d/50gensplash/install                 |   63 +++++++++++++++++++++=
++++
 6 files changed, 134 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/50gensplash/README
 create mode 100755 modules.d/50gensplash/check
 create mode 100755 modules.d/50gensplash/gensplash-emergency.sh
 create mode 100755 modules.d/50gensplash/gensplash-newroot.sh
 create mode 100755 modules.d/50gensplash/gensplash-pretrigger.sh
 create mode 100755 modules.d/50gensplash/install

diff --git a/modules.d/50gensplash/README b/modules.d/50gensplash/README
new file mode 100644
index 0000000..fa02cd1
--- /dev/null
+++ b/modules.d/50gensplash/README
@@ -0,0 +1,42 @@
+Dracut gensplash module
+-----------------------
+
+INDEX
+
+0. Introduction
+1. Hostonly vs Generic
+2. Configuration and kernel parameters
+
+~
+
+0. Introduction
+
+gensplash is based on Genkernel code and that's why it's Gentoo-specific. =
 It
+requires splashutils to work.  To set up theme you may edit /etc/conf.d/sp=
lash
+or set DRACUT_GENSPLASH_THEME and DRACUT_GENSPLASH_RES variables.  Your th=
eme
+has to exist in /etc/splash and for every given resolution has to exist co=
nfig
+in theme's directory, e.g. there's 1024x768.cfg in /etc/splash/natural_gen=
too.
+List of resolutions is comma-separated.
+
+NOTE: The module will be rewritten to be distro-neutral. Its name will cha=
nge
+to fbsplash.
+
+
+1. Hostonly vs Generic
+
+All available themes are installed only if no --hostonly is specified and =
no
+DRACUT_GENSPLASH_THEME and DRACUT_GENSPLASH_RES are set.  Otherwise those =
vars
+are checked and if not set then config /etc/conf.d/splash is read.
+
+
+2. Configuration and kernel parameters
+
+Example set up by environment variables:
+    DRACUT_GENSPLASH_THEME=3Dnatural_gentoo
+    DRACUT_GENSPLASH_RES=3D1024x768,1024x600
+
+Example kernel arguments:
+    splash=3Dsilent,theme:natural_gentoo console=3Dtty1 quiet
+
+You may easily set up the module using Genkernel with arguments:
+    --gensplash=3D<theme>:<res1>,<res2>,...
diff --git a/modules.d/50gensplash/check b/modules.d/50gensplash/check
new file mode 100755
index 0000000..90b8874
--- /dev/null
+++ b/modules.d/50gensplash/check
@@ -0,0 +1,5 @@
+#!/bin/bash
+
+# TODO: splash_geninitramfs
+# TODO: /usr/share/splashutils/initrd.splash
+exit 255
diff --git a/modules.d/50gensplash/gensplash-emergency.sh b/modules.d/50gen=
splash/gensplash-emergency.sh
new file mode 100755
index 0000000..01e639b
--- /dev/null
+++ b/modules.d/50gensplash/gensplash-emergency.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+CDROOT=3D0
+. /lib/gensplash-lib.sh
+splash verbose
diff --git a/modules.d/50gensplash/gensplash-newroot.sh b/modules.d/50gensp=
lash/gensplash-newroot.sh
new file mode 100755
index 0000000..ed2d421
--- /dev/null
+++ b/modules.d/50gensplash/gensplash-newroot.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+CDROOT=3D0
+. /lib/gensplash-lib.sh
+splash set_msg 'Switching to new root'
diff --git a/modules.d/50gensplash/gensplash-pretrigger.sh b/modules.d/50ge=
nsplash/gensplash-pretrigger.sh
new file mode 100755
index 0000000..f1b0d31
--- /dev/null
+++ b/modules.d/50gensplash/gensplash-pretrigger.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+if ! getarg rd_NO_SPLASH; then
+    [ -c /dev/null ] || mknod /dev/null c 1 3
+    [ -c /dev/console ] || mknod /dev/console c 5 1
+    [ -c /dev/tty0 ] || mknod /dev/tty0 c 4 0
+
+    info "Starting Gentoo Splash"
+
+    /lib/udev/console_init tty0
+    CDROOT=3D0
+    . /lib/gensplash-lib.sh
+    splash init
+fi
diff --git a/modules.d/50gensplash/install b/modules.d/50gensplash/install
new file mode 100755
index 0000000..774ad1d
--- /dev/null
+++ b/modules.d/50gensplash/install
@@ -0,0 +1,63 @@
+#!/bin/bash
+
+call_splash_geninitramfs() {
+    local out ret=20
+
+    out=3D$(splash_geninitramfs -c "$1" ${@:2} 2>&1)
+    ret=3D$?
+
+    if [[ ${out} ]]; then
+        local IFS=3D'
+'
+        for line in ${out}; do
+            if [[ ${line} =3D~ ^Warning ]]; then
+                dwarning "${line}"
+            else
+                derror "${line}"
+                (( ret =3D=3D 0 )) && ret=3D1
+            fi
+        done
+    fi
+
+    return ${ret}
+}
+
+
+type -P splash_geninitramfs >/dev/null || exit 1
+
+opts=3D''
+
+if [[ ${DRACUT_GENSPLASH_THEME} ]]; then
+    # Variables from the environment
+    # They're supposed to be set up by e.g. Genkernel in basis of cmdline =
args.
+    # If user set them he/she would expect to be included only given theme
+    # rather then all even if we're building generic initramfs.
+    SPLASH_THEME=3D${DRACUT_GENSPLASH_THEME}
+    SPLASH_RES=3D${DRACUT_GENSPLASH_RES}
+elif [[ ${hostonly} ]]; then
+    # Settings from config only in hostonly
+    [[ -e /etc/conf.d/splash ]] && source /etc/conf.d/splash
+    [[ ! ${SPLASH_THEME} ]] && SPLASH_THEME=3Ddefault
+    [[ ${SPLASH_RES} ]] && opts+=3D" -r ${SPLASH_RES}"
+else
+    # generic
+    SPLASH_THEME=3D--all
+fi
+
+dinfo "Installing Gentoo Splash (using the ${SPLASH_THEME} theme)"
+
+cd "${initdir}"
+mv dev dev.old
+call_splash_geninitramfs "${initdir}" ${opts} ${SPLASH_THEME} || {
+    derror "Could not build splash"
+    exit 1
+}
+rm -rf dev
+mv dev.old dev
+cd - >/dev/null
+
+dracut_install chvt
+inst /usr/share/splashutils/initrd.splash /lib/gensplash-lib.sh
+inst_hook pre-pivot 90 "${moddir}"/gensplash-newroot.sh
+inst_hook pre-trigger 10 "${moddir}"/gensplash-pretrigger.sh
+inst_hook emergency 50 "${moddir}"/gensplash-emergency.sh
--=20
1.7.2

--Sig_/c_rAPjlh_UStLlu13+CP9jR
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkxf1fcACgkQ+hU8EsKEdQ13xACgnPauRHtX3swLsaeJxiO5pQ9n
xWYAnR4aeH/u+RonSu7jdA4zmbtfbGEb
=KcTt
-----END PGP SIGNATURE-----

--Sig_/c_rAPjlh_UStLlu13+CP9jR--
