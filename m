From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [RFC] Generic I18N module - install script
Date: Sun, 20 Jun 2010 18:59:19 +0200
Message-ID: <20100620185919.19b9c83a@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/D_usZV7Qb9qDZ5jFV6KL3_H"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/D_usZV7Qb9qDZ5jFV6KL3_H
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I'd like to present a draft of install script of new generic i18n
module.


~ Abstract ~

Different distros have variables holding keyboard settings, fonts and so
in different files and even under different names.  Sometimes it's
=E2=80=9CSYSFONT=E2=80=9D in /etc/sysconfig/i18n, sometimes it's =E2=80=9Cc=
onsolefont=E2=80=9D in
/etc/conf.d/consolefont.  I came up with idea to hold mappings in
configuration file (dracut.conf or dracut.conf.d/=C2=ABdistro=C2=BB.conf). =
The
script gathers variables and prepares two =E2=80=9Cunified=E2=80=9D files i=
nside
Dracut overlay.

The rest of the script is quite the same as redhat-i18n but some tweaks.
Dracut uses console_init written in C included in initscripts RPM, but
I'm gonna rewrite it in bash and then i18n module will be fully generic.


Please post here any doubts, questions, suggestions, insults=E2=80=A6 ;-)


Cheers,
Amadeusz =C5=BBo=C5=82nowski

PS. What do you think about moving inst_decompress, mksubdirs into
dracut-functions?

--
#!/bin/bash

# WE EXPECT FOLLOWING VARS
#
# ~ Keyboard ~
# KEYMAP
# UNIKEYMAP
# GRP_TOGGLE
# EXT_KEYMAPS
#
# ~ i18n ~
# UNICODE
# SYSFONT
# CONTRANS
# UNIMAP
#
# ~ Locales ~
# LANG
# LC_*
#
#
# SAMPLE MAPPINGS
#=20
# ~ Fedora ~
# Keyboard: /etc/sysconfig/keyboard:KEYTABLE-KEYMAP
# i18n: /etc/sysconfig/i18n:SYSFONT,SYSFONTACM-CONTRANS,UNIMAP
#
# ~ Gentoo Base 1.0 ~
# Keyboard: /etc/conf.d/keymaps:KEYMAP,EXTENDED_KEYMAPS-EXT_KEYMAPS
# i18n: /etc/conf.d/consolefont:CONSOLEFONT-SYSFONT,CONSOLETRANSLATION-CONT=
RANS /etc/rc.conf:UNICODE
#
# ~ Gentoo Base 2.0 ~
# Keyboard: /etc/conf.d/keymaps:keymap-KEYMAP,extended_keymaps-EXT_KEYMAPS
# i18n: /etc/conf.d/consolefont:consolefont-SYSFONT,consoletranslation-CONT=
RANS /etc/rc.conf:unicode-UNICODE


KBDSUBDIRS=3Dconsolefonts,consoletrans,keymaps,unimaps
DEFAULT_SYSFONT=3DLatArCyrHeb-16


# Create all subdirectories for given path without creating the last elemen=
t.
# $1 =3D path
mksubdirs() { mkdir -p ${1%/*}; }

# install function decompressing the target and handling symlinks
# $@ =3D list of compressed (gz or bz2) files or symlinks pointing to such =
files
#
# Function install targets in the same paths inside overlay but decompressed
# and without extensions (.gz, .bz2).
inst_decompress() {
    local src dst realsrc realdst cmd

    for src in $@
    do
        case ${src} in
            *.gz) cmd=3D'gzip -d' ;;
            *.bz2) cmd=3D'bzip2 -d' ;;
            *) return 1 ;;
        esac

        if [[ -L ${src} ]]
        then
            realsrc=3D"$(readlink -f ${src})" # symlink target with extensi=
on
            dst=3D"${src%.*}" # symlink without extension
            realdst=3D"${realsrc%.*}" # symlink target without extension
            mksubdirs "${initdir}/${src}"
            # Create symlink without extension to target without extension.
            ln -s "${realdst}" "${initdir}/${dst}"
        fi

        # If the source is symlink we operate on its target.
        [[ ${realsrc} ]] && src=3D${realsrc}
        inst ${src}
        # Decompress with chosen tool.  We assume that tool changes name e.=
g.
        # from 'name.gz' to 'name'.
        ${cmd} "${initdir}${src}"
    done
}

# This is from 10redhat-i18n, not touched.
findkeymap () {
    local MAP=3D$1
    [[ ! -f $MAP ]] && \
    MAP=3D$(find ${kbddir}/keymaps -type f -name $MAP -o -name $MAP.\* | he=
ad -n1)
    [[ " $KEYMAPS " =3D *" $MAP "* ]] && return
    KEYMAPS=3D"$KEYMAPS $MAP"
    case $MAP in
        *.gz) cmd=3Dzgrep;;
        *.bz2) cmd=3Dbzgrep;;
        *) cmd=3Dgrep ;;
    esac

    for INCL in $($cmd "^include " $MAP | cut -d' ' -f2 | tr -d '"'); do
        for FN in $(find ${kbddir}/keymaps -type f -name $INCL\*); do
            findkeymap $FN
        done
    done
}

# Function gathers variables from distributed files among the tree, maps to
# specified names and prints the result in format "new-name=3Dvalue".
#
# $@ =3D list in format specified below (BNF notation)
#
# <list> ::=3D <element> | <element> " " <list>
# <element> ::=3D <conf-file-name> ":" <map-list>
# <map-list> ::=3D <mapping> | <mapping> "," <map-list>
# <mapping> ::=3D <src-var> "-" <dst-var> | <src-var>
#
# We assume no whitespace are allowed between symbols.
# <conf-file-name> is a file holding <src-var> in your system.
# <src-var> is a variable holding value of meaning the same as <dst-var>.
# <dst-var> is a variable which will be set up inside initramfs.
# If <dst-var> has the same name as <src-var> we can omit <dst-var>.
#
# Hope it's clear. ;-)
#
# Example:
# /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
# <list> =3D /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
# <element> =3D /etc/conf.d/keymaps:KEYMAP,extended_keymaps-EXT_KEYMAPS
# <conf-file-name> =3D /etc/conf.d/keymaps
# <map-list> =3D KEYMAP,extended_keymaps-EXT_KEYMAPS
# <mapping> =3D KEYMAP
# <src-var> =3D KEYMAP
# <mapping> =3D extended_keymaps-EXT_KEYMAPS
# <src-var> =3D extended_keymaps
# <dst-var> =3D EXT_KEYMAPS
gather_vars() {
    local item map value

    for item in $@
    do
        item=3D(${item/:/ })
        for map in ${item[1]/,/ }
        do
            map=3D(${map/-/ })
            value=3D$(grep "^${map[0]}=3D" "${item[0]}")
            value=3D${value#*=3D}
            echo "${map[1]:-${map[0]}}=3D${value}"
        done
    done
}

# Function prints global variables in format name=3Dvalue line by line.
# $@ =3D list of global variables' name
print_vars() {
    local var value

    for var in $@
    do
        value=3D$(eval echo \$$var)
        [[ ${value} ]] && echo "${var}=3D\"${value}\""
    done
}

install_items() {
    dracut_install setfont loadkeys
    inst ${moddir}/console_init /lib/udev/console_init
    inst_rules ${moddir}/10-console.rules
}

install_all_kbd() {
    local rel f

    for f in $(eval find ${kbddir}/{${KBDSUBDIRS}} -type f -print)
    do
        rel=3D${f#${kbddir}}
        rel=3D${rel#/}
        inst "$f" "/lib/kbd/${rel}"
    done

    # remove unnecessary files
    rm -f "${initdir}${kbddir}/consoletrans/utflist"
    find "${initdir}${kbddir}/" -name README\* -delete

    dracut_install gzip bzip2
}

install_local_keyboard() {
    local keyboard_conf=3D"${initdir}/etc/sysconfig/keyboard"
    local map

    eval $(gather_vars ${keyboard_vars})

    # Gentoo user may have KEYMAP set to something like "-u pl2",
    KEYMAP=3D${KEYMAP#-* }
    EXT_KEYMAPS=3D${EXT_KEYMAPS:-backspace}
    # I'm not sure of the purpose of UNIKEYMAP and GRP_TOGGLE.  They were in
    # original redhat-i18n module.  Anyway it won't hurt.
    EXT_KEYMAPS+=3D\ ${UNIKEYMAP}\ ${GRP_TOGGLE}

    [[ ${KEYMAP} ]] || derror 'No KEYMAP.' || return 1
    findkeymap ${KEYMAP}

    for map in ${EXT_KEYMAPS}
    do
        dinfo "Adding bonus map: ${map}"
        findkeymap ${map}
    done

    inst_decompress ${KEYMAPS}

    mksubdirs ${keyboard_conf}
    print_vars KEYMAP EXT_KEYMAPS > ${keyboard_conf}
}


install_local_i18n() {
    local i18n_conf=3D"${initdir}/etc/sysconfig/i18n"

    eval $(gather_vars ${i18n_vars})

	[[ ${SYSFONT} ]] || SYSFONT=3D${DEFAULT_SYSFONT}
    inst_decompress ${kbddir}/consolefonts/${SYSFONT}*

    if [[ ${CONTRANS} ]]
    then
        CONTRANS=3D${CONTRANS%.trans}
        inst ${kbddir}/consoletrans/${CONTRANS}.trans
    fi

    if [[ ${UNIMAP} ]]
    then
        UNIMAP=3D${UNIMAP%.uni}
        inst ${kbddir}/unimaps/${UNIMAP}.uni
    fi

    if [[ ${UNICODE} ]]
    then
        if [[ ${UNICODE^^} =3D YES || ${UNICODE} =3D 1 ]]
        then
            UNICODE=3D1
        elif [[ ${UNICODE^^} =3D NO || ${UNICODE} =3D 0 ]]
        then
            UNICODE=3D0
        else
            UNICODE=3D''
        fi
    fi
    if [[ ! ${UNICODE} && ${LANG^^} =3D~ .*\.UTF-?8 ]]
    then
        UNICODE=3D1
    fi

    mksubdirs ${i18n_conf}
    print_vars UNICODE SYSFONT CONTRANS UNIMAP > ${i18n_conf}
}


for kbddir in /usr/lib/kbd /lib/kbd /usr/share
do
    [[ -d "${kbddir}" ]] && \
    for dir in ${KBDSUBDIRS//,/ }
    do
        [[ -d "${kbddir}/${dir}" ]] && continue
        false
    done || kbddir=3D''
done

[[ ${kbddir} ]] || {
    derror "Directories ${KBDSUBDIRS//,/, } not found.  Please inform us ab=
out the issue including your OS name and version."
    exit 1
}

# Testing
keyboard_vars=3D/etc/conf.d/keymaps:KEYMAP,EXTENDED_KEYMAPS-EXT_KEYMAPS
i18n_vars=3D/etc/conf.d/consolefont:CONSOLEFONT-SYSFONT,CONSOLETRANSLATION-=
CONTRANS\ /etc/rc.conf:UNICODE

install_items

if [[ ${hostonly} ]]
then
    install_local_keyboard
    install_local_i18n
else
    install_all_kbd
fi

--Sig_/D_usZV7Qb9qDZ5jFV6KL3_H
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkweSOcACgkQ+hU8EsKEdQ18PQCeNOspxHQ12T/zhoDrp2O0Osbr
rHcAoLdBiivFbpTbA/gh+E1haXIT8ENR
=ORHA
-----END PGP SIGNATURE-----

--Sig_/D_usZV7Qb9qDZ5jFV6KL3_H--
