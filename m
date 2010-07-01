From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] add module i18n
Date: Thu, 1 Jul 2010 21:17:37 +0200
Message-ID: <20100701211737.45d8a803@etiriah>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/s8lsKnl_BP5uZoeFX0ff55r"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/s8lsKnl_BP5uZoeFX0ff55r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

dracut-functions: added functions: mksubdirs, inst_decompress,
                  inst_opt_decompress and print_vars

dracut.conf.d: added configuration files for Gentoo and RedHat/Fedora
---
 dracut-functions                         |   63 ++++++++++
 dracut.conf.d/gentoo-openrc.conf.example |   10 ++
 dracut.conf.d/gentoo.conf.example        |   10 ++
 dracut.conf.d/redhat.conf.example        |   10 ++
 modules.d/10i18n/10-console.rules        |    2 +
 modules.d/10i18n/check                   |    7 +
 modules.d/10i18n/console_init            |  107 ++++++++++++++++
 modules.d/10i18n/install                 |  195 ++++++++++++++++++++++++++=
++++
 modules.d/10i18n/parse-i18n.sh           |   24 ++++
 modules.d/10redhat-i18n/10-console.rules |    2 +
 10 files changed, 430 insertions(+), 0 deletions(-)
 create mode 100644 dracut.conf.d/gentoo-openrc.conf.example
 create mode 100644 dracut.conf.d/gentoo.conf.example
 create mode 100644 dracut.conf.d/redhat.conf.example
 create mode 100644 modules.d/10i18n/10-console.rules
 create mode 100755 modules.d/10i18n/check
 create mode 100755 modules.d/10i18n/console_init
 create mode 100755 modules.d/10i18n/install
 create mode 100755 modules.d/10i18n/parse-i18n.sh
 create mode 100644 modules.d/10redhat-i18n/10-console.rules

diff --git a/dracut-functions b/dracut-functions
index 2cd573a..4212c5f 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -24,6 +24,10 @@ IF_dynamic=3D""
 # Generic substring function.  If $2 is in $1, return 0.
 strstr() { [[ $1 =3D~ $2 ]]; }
=20
+# Create all subdirectories for given path without creating the last eleme=
nt.
+# $1 =3D path
+mksubdirs() { mkdir -p ${1%/*}; }
+
 # Version comparision function.  Assumes Linux style version scheme.
 # $1 =3D version a
 # $2 =3D comparision op (gt, ge, eq, le, lt, ne)
@@ -77,6 +81,18 @@ derror() {
     [[ -w $dracutlogfile ]] && echo "E: $@" >>"$dracutlogfile"
 }
=20
+# Function prints global variables in format name=3Dvalue line by line.
+# $@ =3D list of global variables' name
+print_vars() {
+    local var value
+
+    for var in $@
+    do
+        value=3D$(eval echo \$$var)
+        [[ ${value} ]] && echo "${var}=3D\"${value}\""
+    done
+}
+
 get_fs_env() {
     eval $(udevadm info --query=3Denv --name=3D$1|egrep 'ID_FS_(TYPE|UUID)=
=3D')
     [[ $ID_FS_TYPE ]] && return
@@ -381,6 +397,53 @@ dracut_install() {
     done
 }
=20
+# install function decompressing the target and handling symlinks
+# $@ =3D list of compressed (gz or bz2) files or symlinks pointing to such=
 files
+#
+# Function install targets in the same paths inside overlay but decompress=
ed
+# and without extensions (.gz, .bz2).
+inst_decompress() {
+    local src dst realsrc realdst cmd
+
+    for src in $@
+    do
+        case ${src} in
+            *.gi) cmd=3D'gzip rd' ;;
+            *.bz2) cmd=3D'bzip2 -d' ;;
+            *) return 1 ;;
+        esac
+
+        if [[ -L ${src} ]]
+        then
+            realsrc=3D"$(readlink -f ${src})" # symlink target with extens=
ion
+            dst=3D"${src%.*}" # symlink without extension
+            realdst=3D"${realsrc%.*}" # symlink target without extension
+            mksubdirs "${initdir}/${src}"
+            # Create symlink without extension to target without extension.
+            ln -s "${realdst}" "${initdir}/${dst}"
+        fi
+
+        # If the source is symlink we operate on its target.
+        [[ ${realsrc} ]] && src=3D${realsrc}
+        inst ${src}
+        # Decompress with chosen tool.  We assume that tool changes name e=
.g.
+        # from 'name.gz' to 'name'.
+        ${cmd} "${initdir}${src}"
+    done
+}
+
+# It's similar to above, but if file is not compressed, performs standard
+# install.
+# $@ =3D list of files
+inst_opt_decompress() {
+    local src
+
+    for src in $@
+    do
+        inst_decompress "${src}" || inst "${src}"
+    done
+}
+
 check_module_deps() {
     local moddir dep ret
     # if we are already set to be loaded, we do not have to be checked aga=
in.
diff --git a/dracut.conf.d/gentoo-openrc.conf.example b/dracut.conf.d/gento=
o-openrc.conf.example
new file mode 100644
index 0000000..cd5da46
--- /dev/null
+++ b/dracut.conf.d/gentoo-openrc.conf.example
@@ -0,0 +1,10 @@
+# /etc/dracut.conf.d/gentoo-openrc.conf
+# Dracut config file customized for Gentoo Base System release 2
+
+#
+# Modules
+#
+
+# i18n
+keyboard_vars=3D"/etc/conf.d/keymaps:keymap-KEYMAP,extended_keymaps-EXT_KE=
YMAPS"
+i18n_vars=3D"/etc/conf.d/consolefont:consolefont-SYSFONT,consoletranslatio=
n-CONTRANS /etc/rc.conf:unicode-UNICODE"
diff --git a/dracut.conf.d/gentoo.conf.example b/dracut.conf.d/gentoo.conf.=
example
new file mode 100644
index 0000000..43e66e8
--- /dev/null
+++ b/dracut.conf.d/gentoo.conf.example
@@ -0,0 +1,10 @@
+# /etc/dracut.conf.d/gentoo.conf
+# Dracut config file customized for Gentoo Base System release 1
+
+#
+# Modules
+#
+
+# i18n
+keyboard_vars=3D"/etc/conf.d/keymaps:KEYMAP,EXTENDED_KEYMAPS-EXT_KEYMAPS"
+i18n_vars=3D"/etc/conf.d/consolefont:CONSOLEFONT-SYSFONT,CONSOLETRANSLATIO=
N-CONTRANS /etc/rc.conf:UNICODE"
diff --git a/dracut.conf.d/redhat.conf.example b/dracut.conf.d/redhat.conf.=
example
new file mode 100644
index 0000000..ae8f6e7
--- /dev/null
+++ b/dracut.conf.d/redhat.conf.example
@@ -0,0 +1,10 @@
+# /etc/dracut.conf.d/redhat.conf
+# Dracut config file customized for RedHat/Fedora.
+
+#
+# Modules
+#
+
+# i18n
+keyboard_vars=3D"/etc/sysconfig/keyboard:KEYTABLE-KEYMAP"
+i18n_vars=3D"/etc/sysconfig/i18n:SYSFONT,SYSFONTACM-CONTRANS,UNIMAP"
diff --git a/modules.d/10i18n/10-console.rules b/modules.d/10i18n/10-consol=
e.rules
new file mode 100644
index 0000000..c234c8a
--- /dev/null
+++ b/modules.d/10i18n/10-console.rules
@@ -0,0 +1,2 @@
+# Console initialization - keyboard, font, etc.
+KERNEL=3D=3D"tty0",		RUN+=3D"/lib/udev/console_init %k"
diff --git a/modules.d/10i18n/check b/modules.d/10i18n/check
new file mode 100755
index 0000000..ec85ce9
--- /dev/null
+++ b/modules.d/10i18n/check
@@ -0,0 +1,7 @@
+#!/bin/bash
+
+# TODO: We should check if ${keyboard_vars} && ${i18n_vars} are set for
+# hostonly setup.
+[[ $1 =3D -h ]] && exit 0
+
+exit 255
diff --git a/modules.d/10i18n/console_init b/modules.d/10i18n/console_init
new file mode 100755
index 0000000..9a8d621
--- /dev/null
+++ b/modules.d/10i18n/console_init
@@ -0,0 +1,107 @@
+#!/bin/sh
+
+. /etc/sysconfig/i18n
+. /etc/sysconfig/keyboard
+
+DEFAULT_SYSFONT=3DLatArCyrHeb-16
+DEFAULT_KEYMAP=3D/etc/sysconfig/console/default.kmap
+
+
+print_vars() {
+    local var value
+
+    for var in $@
+    do
+        value=3D$(eval echo \$$var)
+        [ -n "${value}" ] && echo "${var}=3D\"${value}\""
+    done
+}
+
+run_debug() {
+    echo -n $@
+    echo -n '   '
+    if $@; then
+        echo 'OK'
+    else
+        echo 'Failed!'
+    fi
+}
+
+set_keyboard() {
+    local param
+
+    [ "${UNICODE}" =3D 1 ] && param=3D-u || param=3D-a
+    kbd_mode ${param}
+}
+
+set_terminal() {
+    local dev=3D$1
+
+    if [ "${UNICODE}" =3D 1 ]; then
+        printf '\033%%G' >&7
+        stty -F ${dev} iutf8
+    else
+        printf '\033%%@' >&7
+    fi
+}
+
+set_keymap() {
+    local utf_switch
+
+    if [ -z "${KEYMAP}" ]; then
+        [ -f "${DEFAULT_KEYMAP}" ] && KEYMAP=3D${DEFAULT_KEYMAP}
+    fi
+
+    [ -n "${KEYMAP}" ] || return 1
+
+    [ "${UNICODE}" =3D 1 ] && utf_switch=3D-u
+
+    loadkeys ${utf_switch} ${KEYMAP}.map
+}
+
+set_font() {
+    local dev=3D$1; local trans=3D''; local uni=3D''
+
+    [ -z "${SYSFONT}" ] && SYSFONT=3D${DEFAULT_SYSFONT}
+    [ -n "${CONTRANS}" ] && trans=3D"-m ${CONTRANS}"
+    [ -n "${UNIMAP}" ] && uni=3D"-u ${UNIMAP}"
+
+    setfont ${SYSFONT} -C ${dev} ${trans} ${uni}
+}
+
+dev_close() {
+    exec 6>&-
+    exec 7>&-
+}
+
+dev_open() {
+    local dev=3D$1
+
+    exec 6<${dev} && \
+    exec 7>>${dev}
+}
+
+
+dev=3D/dev/${1#/dev/}
+
+[ -c "${dev}" ] || {
+    echo "Usage: $0 device" >&2
+    exit 1
+}
+
+dev_open ${dev}
+
+for fd in 6 7; do
+    if ! [ -t ${fd} ]; then
+        echo "ERROR: File descriptor not opened: ${fd}" >&2
+        dev_close
+        exit 1
+    fi
+done
+
+set_keyboard
+set_terminal ${dev}
+set_font ${dev}
+set_keymap
+
+dev_close
diff --git a/modules.d/10i18n/install b/modules.d/10i18n/install
new file mode 100755
index 0000000..a335260
--- /dev/null
+++ b/modules.d/10i18n/install
@@ -0,0 +1,195 @@
+#!/bin/bash
+
+KBDSUBDIRS=3Dconsolefonts,consoletrans,keymaps,unimaps
+DEFAULT_SYSFONT=3DLatArCyrHeb-16
+I18N_CONF=3D"${initdir}/etc/sysconfig/i18n"
+KEYBOARD_CONF=3D"${initdir}/etc/sysconfig/keyboard"
+
+
+# This is from 10redhat-i18n.
+findkeymap () {
+    local MAP=3D$1
+    [[ ! -f $MAP ]] && \
+    MAP=3D$(find ${kbddir}/keymaps -type f -name $MAP -o -name $MAP.\* | h=
ead -n1)
+    [[ " $KEYMAPS " =3D *" $MAP "* ]] && return
+    KEYMAPS=3D"$KEYMAPS $MAP"
+    case $MAP in
+        *.gz) cmd=3Dzgrep;;
+        *.bz2) cmd=3Dbzgrep;;
+        *) cmd=3Dgrep ;;
+    esac
+
+    for INCL in $($cmd "^include " $MAP | cut -d' ' -f2 | tr -d '"'); do
+        for FN in $(find ${kbddir}/keymaps -type f -name $INCL\*); do
+            findkeymap $FN
+        done
+    done
+}
+
+# Function gathers variables from distributed files among the tree, maps to
+# specified names and prints the result in format "new-name=3Dvalue".
+#
+# $@ =3D list in format specified below (BNF notation)
+#
+# <list> ::=3D <element> | <element> " " <list>
+# <element> ::=3D <conf-file-name> ":" <map-list>
+# <map-list> ::=3D <mapping> | <mapping> "," <map-list>
+# <mapping> ::=3D <src-var> "-" <dst-var> | <src-var>
+#
+# We assume no whitespace are allowed between symbols.
+# <conf-file-name> is a file holding <src-var> in your system.
+# <src-var> is a variable holding value of meaning the same as <dst-var>.
+# <dst-var> is a variable which will be set up inside initramfs.
+# If <dst-var> has the same name as <src-var> we can omit <dst-var>.
+#
+# Example:
+# /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
+# <list> =3D /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
+# <element> =3D /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
+# <conf-file-name> =3D /etc/conf.d/keymaps
+# <map-list> =3D KEYMAP,extended_keymaps-EXT_KEYMAPS
+# <mapping> =3D KEYMAP
+# <src-var> =3D KEYMAP
+# <mapping> =3D extended_keymaps-EXT_KEYMAPS
+# <src-var> =3D extended_keymaps
+# <dst-var> =3D EXT_KEYMAPS
+gather_vars() {
+    local item map value
+
+    for item in $@
+    do
+        item=3D(${item/:/ })
+        for map in ${item[1]/,/ }
+        do
+            map=3D(${map/-/ })
+            value=3D$(grep "^${map[0]}=3D" "${item[0]}")
+            value=3D${value#*=3D}
+            echo "${map[1]:-${map[0]}}=3D${value}"
+        done
+    done
+}
+
+install_base() {
+    dracut_install setfont loadkeys kbd_mode stty
+    inst ${moddir}/console_init /lib/udev/console_init
+    inst_rules ${moddir}/10-console.rules
+    inst_hook cmdline 20 "${moddir}/parse-i18n.sh"
+}
+
+install_all_kbd() {
+    local rel f
+
+    for f in $(eval find ${kbddir}/{${KBDSUBDIRS}} -type f -print)
+    do
+        inst $f
+    done
+
+    # remove unnecessary files
+    rm -f "${initdir}${kbddir}/consoletrans/utflist"
+    find "${initdir}${kbddir}/" -name README\* -delete
+
+    dracut_install gzip bzip2
+}
+
+install_local_keyboard() {
+    local map
+
+    eval $(gather_vars ${keyboard_vars})
+
+    # Gentoo user may have KEYMAP set to something like "-u pl2",
+    KEYMAP=3D${KEYMAP#-* }
+    EXT_KEYMAPS=3D${EXT_KEYMAPS:-backspace}
+    # I'm not sure of the purpose of UNIKEYMAP and GRP_TOGGLE.  They were =
in
+    # original redhat-i18n module.  Anyway it won't hurt.
+    EXT_KEYMAPS+=3D\ ${UNIKEYMAP}\ ${GRP_TOGGLE}
+
+    [[ ${KEYMAP} ]] || derror 'No KEYMAP.' || return 1
+    findkeymap ${KEYMAP}
+
+    for map in ${EXT_KEYMAPS}
+    do
+        dinfo "Adding extra map: ${map}"
+        findkeymap ${map}
+    done
+
+    inst_opt_decompress ${KEYMAPS}
+
+    mksubdirs ${KEYBOARD_CONF}
+    print_vars KEYMAP EXT_KEYMAPS >> ${KEYBOARD_CONF}
+}
+
+install_local_i18n() {
+    eval $(gather_vars ${i18n_vars})
+
+    [[ ${SYSFONT} ]] || SYSFONT=3D${DEFAULT_SYSFONT}
+    SYSFONT=3D${SYSFONT%.psf*}
+    inst ${kbddir}/consolefonts/${SYSFONT}.*
+
+    if [[ ${CONTRANS} ]]
+    then
+        CONTRANS=3D${CONTRANS%.trans}
+        inst ${kbddir}/consoletrans/${CONTRANS}.trans
+    fi
+
+    if [[ ${UNIMAP} ]]
+    then
+        UNIMAP=3D${UNIMAP%.uni}
+        inst ${kbddir}/unimaps/${UNIMAP}.uni
+    fi
+
+    if [[ ${UNICODE} ]]
+    then
+        if [[ ${UNICODE^^} =3D YES || ${UNICODE} =3D 1 ]]
+        then
+            UNICODE=3D1
+        elif [[ ${UNICODE^^} =3D NO || ${UNICODE} =3D 0 ]]
+        then
+            UNICODE=3D0
+        else
+            UNICODE=3D''
+        fi
+    fi
+    if [[ ! ${UNICODE} && ${LANG^^} =3D~ .*\.UTF-?8 ]]
+    then
+        UNICODE=3D1
+    fi
+
+    mksubdirs ${I18N_CONF}
+    print_vars LC_ALL LANG UNICODE SYSFONT CONTRANS UNIMAP >> ${I18N_CONF}
+}
+
+checks() {
+    for kbddir in ${kbddir} /usr/lib/kbd /lib/kbd /usr/share
+    do
+        [[ -d "${kbddir}" ]] && \
+        for dir in ${KBDSUBDIRS//,/ }
+        do
+            [[ -d "${kbddir}/${dir}" ]] && continue
+            false
+        done || kbddir=3D''
+    done
+
+    [[ ${kbddir} ]] || {
+        derror "Directories ${KBDSUBDIRS//,/, } not found.  Please inform =
us about the issue including your OS name and version."
+        return 1
+    }
+
+    [[ ! ${hostonly} || ${keyboard_vars} && ${i18n_vars} ]] || {
+        derror 'Please set up keyboard_vars and i18n_vars in configuration=
 file.'
+        return 1
+    }
+}
+
+
+if checks
+then
+    install_base
+
+    if [[ ${hostonly} ]]
+    then
+        install_local_keyboard
+        install_local_i18n
+    else
+        install_all_kbd
+    fi
+fi
diff --git a/modules.d/10i18n/parse-i18n.sh b/modules.d/10i18n/parse-i18n.sh
new file mode 100755
index 0000000..785b51b
--- /dev/null
+++ b/modules.d/10i18n/parse-i18n.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+inst_key_val() {
+    local value
+    value=3D$(getarg $1)
+    [ -n "${value}" ] && printf '%s=3D"%s"\n' $1 ${value} >> $2
+}
+
+
+mkdir -p /etc/sysconfig
+inst_key_val KEYMAP /etc/sysconfig/keyboard
+inst_key_val EXT_KEYMAPS /etc/sysconfig/keyboard
+inst_key_val UNICODE /etc/sysconfig/i18n
+inst_key_val SYSFONT /etc/sysconfig/i18n
+inst_key_val CONTRANS /etc/sysconfig/i18n
+inst_key_val UNIMAP /etc/sysconfig/i18n
+inst_key_val LANG /etc/sysconfig/i18n
+inst_key_val LC_ALL /etc/sysconfig/i18n
+
+if [ -f /etc/sysconfig/i18n ]; then
+    . /etc/sysconfig/i18n
+    export LANG
+    export LC_ALL
+fi
diff --git a/modules.d/10redhat-i18n/10-console.rules b/modules.d/10redhat-=
i18n/10-console.rules
new file mode 100644
index 0000000..c234c8a
--- /dev/null
+++ b/modules.d/10redhat-i18n/10-console.rules
@@ -0,0 +1,2 @@
+# Console initialization - keyboard, font, etc.
+KERNEL=3D=3D"tty0",		RUN+=3D"/lib/udev/console_init %k"
--=20
1.7.1

--Sig_/s8lsKnl_BP5uZoeFX0ff55r
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkws6dEACgkQ+hU8EsKEdQ0+TgCeIeEidEhc9jCXFK92Bo5YOoqv
luoAnR/11PUJgSZGM4EAy18Afm3DfsSP
=sg3C
-----END PGP SIGNATURE-----

--Sig_/s8lsKnl_BP5uZoeFX0ff55r--
