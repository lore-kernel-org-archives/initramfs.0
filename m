From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8] dracut: add support for custom locale definitions
Date: Sat, 23 Apr 2016 10:50:40 +0300
Message-ID: <571B2950.5060209@gmail.com>
References: <1460758050.3211.2.camel@trentalancia.net>
 <5711D4E7.9070705@gmail.com> <1460815966.4296.13.camel@trentalancia.net>
 <57127BC9.70103@gmail.com> <1460835143.3201.10.camel@trentalancia.net>
 <1460837622.3201.14.camel@trentalancia.net>
 <1460838269.3201.18.camel@trentalancia.net>
 <1461026208.2262.1.camel@trentalancia.net>
 <1461157491.11229.3.camel@trentalancia.net> <5718AA77.8090600@redhat.com>
 <1461341618.21231.0.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=ICK9GbAghFl1rWHpKo69dS8oBZ6XZXMyVrqvjFonlPA=;
        b=IwkdR8lPx3JsrOj6Z8f1ePDJW/VvklXY1wYys+Po1iCjkmiI75eKNDZbRRoVJ2BVS+
         S3jdBkl1+IGNMb3SrBrRSwq7UswhL+/y6oesJHEI0x8x+N3+fsAsKUEP5UdPc7/AZ7SL
         tk51ajw07+d09roIp6BtB34HdrRE5e4qohJYdkXD2RMddFeLt7RKKiWThcu51jEVv9TU
         bceeSek0L0BxT0I3OjVOttiNCtRWtyCgy/jP1dwEdNUP6ZsIrC5AZW18Pcuy608Wo26D
         WLFTLTDN4gURSPXTdTrIszdP/akQmCfoSnd1sTKHV90n0vrefUy+lKj5ZKAkiNalFR7y
         PdCg==
In-Reply-To: <1461341618.21231.0.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

22.04.2016 19:13, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Compile and install locale definitions using localedef from GNU libc =
or,
> if locale definitions cannot be compiled but are available on the sys=
tem
> as split definitions, just install them.
>=20
> The resulting locale definitions archive contains at most two differe=
nt
> locale definitions, therefore its size is relatively small.
>=20
> Add support for localised messages from core packages (LC_MESSAGES).
>=20
> Add support for non-latin fonts using Unicode (tested successfully wi=
th
> Greek, Hebrew and Cyrillic).
>=20
> This revised version fixes several issues in the initial patch (inclu=
ding
> the possibility to build locale definitions). Thanks to Andrei Borzen=
kov
> for reviewing the initial patch and providing useful suggestions.
>=20
> Thanks for Harald Hoyer for the full style review and other useful
> suggestions.
>=20
> Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> ---
>  NEWS                                  |    4
>  dracut-bash-completion.sh             |   11 +-
>  dracut-init.sh                        |   37 ++++++++
>  dracut.8.asc                          |    8 +
>  dracut.conf.5.asc                     |   14 ++-
>  dracut.sh                             |   20 +++-
>  modules.d/10i18n/README               |    1
>  modules.d/10i18n/console_init.sh      |   58 +++++++++-----
>  modules.d/10i18n/module-setup.sh      |  140 +++++++++++++++++++++++=
++++++++++-
>  modules.d/10i18n/parse-i18n.sh        |    8 +
>  modules.d/90crypt/module-setup.sh     |    4
>  modules.d/91crypt-gpg/module-setup.sh |    4
>  modules.d/99base/init.sh              |    4
>  modules.d/99base/module-setup.sh      |    4
>  14 files changed, 279 insertions(+), 38 deletions(-)
>=20
> diff -pru dracut-git-orig/dracut.8.asc dracut-git-10i18n-full-support=
-for-localisation/dracut.8.asc
> --- dracut-git-orig/dracut.8.asc	2016-04-19 02:19:10.650042399 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/dracut.8.asc	2016=
-04-21 17:13:53.043188284 +0200
> @@ -358,6 +358,14 @@ provide a valid _/etc/fstab_.
>      LVM or an encrypted partition.
>      [NB --device can be used for compatibility with earlier releases=
]
> =20
> +**--msg-localisation**::
> +    Include full localisation support for the i18n module (slightly =
increases
> +    the initramfs size).
> +

It is not "full" in any case. You only install message catalogs for
selected compnents.

> +**--no-msg-localisation**::
> +    Do not include full localisation support for the i18n module (to=
 save
> +    storage space or force the default locale).
> +
>  **-i, --include** _<SOURCE>_ _<TARGET>_::
>      include the files in the SOURCE directory into the
>      TARGET directory in the final initramfs. If SOURCE is a file, it=
 will be
> diff -pru dracut-git-orig/dracut-bash-completion.sh dracut-git-10i18n=
-full-support-for-localisation/dracut-bash-completion.sh
> --- dracut-git-orig/dracut-bash-completion.sh	2016-04-19 02:19:10.648=
042373 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/dracut-bash-compl=
etion.sh	2016-04-21 17:16:41.148400079 +0200
> @@ -28,11 +28,12 @@ _dracut() {
>                                --ro-mnt --force --kernel-only --no-ke=
rnel --strip --nostrip
>                                --hardlink --nohardlink --noprefix --m=
dadmconf --nomdadmconf
>                                --lvmconf --nolvmconf --debug --profil=
e --verbose --quiet
> -                              --local --hostonly --no-hostonly --fst=
ab --help --bzip2 --lzma
> -                              --xz --no-compress --gzip --list-modul=
es --show-modules --keep
> -                              --printsize --regenerate-all --noimage=
ifnotneeded --early-microcode
> -                              --no-early-microcode --print-cmdline -=
-prelink --noprelink --reproducible
> -                              --uefi
> +                              --local --hostonly --no-hostonly --fst=
ab --msg-localisation
> +                              --no-msg-localisation --help --bzip2 -=
-lzma --xz --no-compress
> +                              --gzip --list-modules --show-modules -=
-keep --printsize
> +                              --regenerate-all --noimageifnotneeded =
--early-microcode
> +                              --no-early-microcode --print-cmdline -=
-prelink --noprelink
> +                              --reproducible --uefi
>                                '
> =20
>                         [ARG]=3D'-a -m -o -d -I -k -c -L --kver --add=
 --force-add --add-drivers
> diff -pru dracut-git-orig/dracut.conf.5.asc dracut-git-10i18n-full-su=
pport-for-localisation/dracut.conf.5.asc
> --- dracut-git-orig/dracut.conf.5.asc	2016-04-19 02:19:10.650042399 +=
0200
> +++ dracut-git-10i18n-full-support-for-localisation/dracut.conf.5.asc=
	2016-04-21 17:21:57.576555027 +0200
> @@ -99,9 +99,6 @@ Configuration files must have the extens
>  *hostonly_cmdline=3D*"__{yes|no}__"::
>      If set, store the kernel command line arguments needed in the in=
itramfs
> =20
> -*i18n_install_all=3D*"__{yes|no}__"::
> -    If set to yes, install all available fonts and keyboard files.
> -
>  *persistent_policy=3D*"__<policy>__"::
>      Use _<policy>_ to address disks and partitions.
>      _<policy>_ can be any directory name found in /dev/disk.
> @@ -196,7 +193,16 @@ provide a valid _/etc/fstab_.
>      Default is "LatArCyrHeb-16".
> =20
>  *i18n_install_all=3D*"__{yes|no}__"::
> -    Install everything regardless of generic or hostonly mode.
> +    Install all available fonts and keyboard files regardless of gen=
eric
> +    or hostonly mode.
> +
> +*msg-localisation=3D*"__{yes|no}__"::
> +    Add full localisation support (includes message-based localisati=
on
> +    and non latin font support).
> +

Are not fonts always installed? I do not see any dependency on this
setings for fonts installation.

> +*no-msg-localisation=3D*"__{yes|no}__"::
> +    Do not add full localisation support (only keyboard localisation
> +    is added): saves some storage space.
> =20
>  *reproducible=3D*"__{yes|no}__"::
>      Create reproducible images.
> diff -pru dracut-git-orig/dracut-init.sh dracut-git-10i18n-full-suppo=
rt-for-localisation/dracut-init.sh
> --- dracut-git-orig/dracut-init.sh	2016-04-19 02:19:10.649042386 +020=
0
> +++ dracut-git-10i18n-full-support-for-localisation/dracut-init.sh	20=
16-04-22 18:05:08.033519479 +0200
> @@ -214,6 +214,43 @@ inst_multiple() {
>      return $_ret
>  }
> =20
> +# Install package translations (message-based localisations)
> +inst_i18n() {

l10n is more common abbreviation for message translations. i18n usually
refers to ability to process non-ASCII characters.

> +    local _locale_dirs_dup
> +    local _locale_dirs
> +    local _tmppath
> +    [[ $1 ]] || return 1  # no package name
> +    [ -f /etc/locale.conf ] && . /etc/locale.conf
> +    if [ ${LC_ALL} ]; then
> +        read LC_ALL_LOCALE LC_ALL_CHARMAP < <(echo ${LC_ALL//./ })
> +    fi
> +    if [ ${LANG} ]; then
> +        read LANG_LOCALE LANG_CHARMAP < <(echo ${LANG//./ })
> +    fi
> +    if [ ${LC_MESSAGES} ]; then
> +        read LC_MESSAGES_LOCALE LC_MESSAGES_CHARMAP < <(echo ${LC_ME=
SSAGES//./ })
> +    fi
> +    [[ ${LC_ALL_LOCALE} ]] && read LC_ALL_LOCALE_SHORT LC_ALL_LOCALE=
_COUNTRY < <(echo ${LC_ALL_LOCALE//_/ })
> +    [[ ${LANG_LOCALE} ]] && read LANG_LOCALE_SHORT LANG_LOCALE_COUNT=
RY < <(echo ${LANG_LOCALE//_/ })
> +    [[ ${LC_MESSAGES_LOCALE} ]] && read LC_MESSAGES_LOCALE_SHORT LC_=
MESSAGES_LOCALE_COUNTRY < <(echo ${LC_MESSAGES_LOCALE//_/ })
> +    _locale_dirs_dup=3D"${LC_ALL_LOCALE} ${LANG_LOCALE} ${LC_MESSAGE=
S_LOCALE} ${LC_ALL_LOCALE_SHORT} ${LANG_LOCALE_SHORT} ${LC_MESSAGES_LOC=
ALE_SHORT}"
> +    _tmppath=3D
> +    _locale_dirs=3D
> +    for dir in ${_locale_dirs_dup}
> +    do
> +        case $_tmppath in
> +            *\ ${dir}) ;;
> +            *) _locale_dirs=3D"${_tmppath} ${dir}";;
> +        esac
> +        _tmppath=3D${_locale_dirs}
> +    done
> +    for dir in ${_locale_dirs}; do
> +        [[ -d "/usr/share/locale/${dir}" ]] && for file in `find "/u=
sr/share/locale/${dir}" -type f -name "$1.mo"`; do
> +            inst_simple "${file}"
> +        done
> +    done
> +}
> +
>  dracut_install() {
>      inst_multiple "$@"
>  }
> diff -pru dracut-git-orig/dracut.sh dracut-git-10i18n-full-support-fo=
r-localisation/dracut.sh
> --- dracut-git-orig/dracut.sh	2016-04-19 02:19:10.652042425 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/dracut.sh	2016-04=
-21 23:06:34.022740183 +0200
> @@ -163,6 +163,10 @@ Creates initial ramdisk images for prelo
>    --mount "[MP]"	Same as above, but [DEV], [FSTYPE] and [FSOPTS] are
>  			determined by looking at the current mounts.
>    --add-device "[DEV]"  Bring up [DEV] in initramfs
> +  --msg-localisation    Add full localisation support rather than on=
ly
> +                        the minimal keyboard support (default)
> +  --no-msg-localisation Do not add full localisation support, but on=
ly
> +                        minimal keyboard support
>    -i, --include [SOURCE] [TARGET]
>                          Include the files in the SOURCE directory in=
to the
>                           Target directory in the final initramfs.
> @@ -344,6 +348,8 @@ rearrange_params()
>          --long no-hostonly-cmdline \
>          --long persistent-policy: \
>          --long fstab \
> +        --long msg-localisation \
> +        --long no-msg-localisation \
>          --long help \
>          --long bzip2 \
>          --long lzma \
> @@ -538,6 +544,10 @@ while :; do
>          --persistent-policy)
>                         persistent_policy_l=3D"$2";       PARMS_TO_ST=
ORE+=3D" '$2'"; shift;;
>          --fstab)       use_fstab_l=3D"yes" ;;
> +        --msg-localisation)
> +                       msg_localisation_l=3D"yes" ;;
> +        --no-msg-localisation)
> +                       msg_localisation_l=3D"no" ;;
>          -h|--help)     long_usage; exit 1 ;;
>          -i|--include)  include_src+=3D("$2");          PARMS_TO_STOR=
E+=3D" '$2'";
>                         shift;;
> @@ -730,6 +740,8 @@ stdloglvl=3D$((stdloglvl + verbosity_mod_l
>  [[ $i18n_install_all_l ]] && i18n_install_all=3D$i18n_install_all_l
>  [[ $persistent_policy_l ]] && persistent_policy=3D$persistent_policy=
_l
>  [[ $use_fstab_l ]] && use_fstab=3D$use_fstab_l
> +[[ $msg_localisation_l ]] && msg_localisation=3D$msg_localisation_l
> +[[ $msg_localisation_l ]] || msg_localisation=3D"yes"
>  [[ $mdadmconf_l ]] && mdadmconf=3D$mdadmconf_l
>  [[ $lvmconf_l ]] && lvmconf=3D$lvmconf_l
>  [[ $dracutbasedir ]] || dracutbasedir=3D/usr/lib/dracut
> @@ -1269,10 +1281,10 @@ export initdir dracutbasedir \
>      mods_to_load \
>      fw_dir drivers_dir debug no_kernel kernel_only \
>      omit_drivers mdadmconf lvmconf root_dev \
> -    use_fstab fstab_lines libdirs fscks nofscks ro_mnt \
> -    stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
> -    debug host_fs_types host_devs swap_devs sshkey add_fstab \
> -    DRACUT_VERSION udevdir prefix filesystems drivers \
> +    use_fstab fstab_lines msg_localisation libdirs fscks \
> +    nofscks ro_mnt stdloglvl sysloglvl fileloglvl kmsgloglvl \
> +    logile debug host_fs_types host_devs swap_devs sshkey \
> +    add_fstab DRACUT_VERSION udevdir prefix filesystems drivers \
>      systemdutildir systemdsystemunitdir systemdsystemconfdir \
>      hostonly_cmdline loginstall \
>      tmpfilesdir
> diff -pru dracut-git-orig/modules.d/10i18n/console_init.sh dracut-git=
-10i18n-full-support-for-localisation/modules.d/10i18n/console_init.sh
> --- dracut-git-orig/modules.d/10i18n/console_init.sh	2016-04-20 14:11=
:02.824944921 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/=
console_init.sh	2016-04-22 17:54:50.913345284 +0200
> @@ -6,6 +6,7 @@ if [ -x $systemdutildir/systemd-vconsole
>      $systemdutildir/systemd-vconsole-setup "$@"
>  fi
> =20
> +[ -e /etc/locale.conf ] && . /etc/locale.conf
>  [ -e /etc/vconsole.conf ] && . /etc/vconsole.conf
> =20
>  DEFAULT_FONT=3DLatArCyrHeb-16
> @@ -19,14 +20,14 @@ set_keyboard() {
>  }
> =20
>  set_terminal() {
> -    local dev=3D$1
> -
>      if [ "${UNICODE}" =3D 1 ]; then
> -        printf '\033%%G' >&7
> -        stty -F ${dev} iutf8
> +        if [ "${FONT}" -a ! "${FONT_MAP}" ]; then
> +            /usr/bin/unicode_start "${FONT}"
> +        elif [ "${FONT}" -a "${FONT_MAP}" ]; then
> +            /usr/bin/unicode_start "${FONT}" "${FONT_MAP}"
> +        fi
>      else
> -        printf '\033%%@' >&7
> -        stty -F ${dev} -iutf8
> +        /usr/bin/unicode_stop
>      fi
>  }
> =20
> @@ -44,16 +45,6 @@ set_keymap() {
>      loadkeys -q ${utf_switch} ${KEYMAP} ${EXT_KEYMAPS}
>  }
> =20
> -set_font() {
> -    local dev=3D$1; local trans=3D''; local uni=3D''
> -
> -    [ -z "${FONT}" ] && FONT=3D${DEFAULT_FONT}
> -    [ -n "${FONT_MAP}" ] && trans=3D"-m ${FONT_MAP}"
> -    [ -n "${FONT_UNIMAP}" ] && uni=3D"-u ${FONT_UNIMAP}"
> -
> -    setfont ${FONT} -C ${dev} ${trans} ${uni}
> -}
> -
>  dev_close() {
>      exec 6>&-
>      exec 7>&-
> @@ -74,6 +65,27 @@ devname=3D${dev#/dev/}
>      exit 1
>  }
> =20
> +if [ "${UNICODE}" ]; then
> +    if [ "${UNICODE}" =3D YES -o "${UNICODE}" =3D yes -o "${UNICODE}=
" =3D 1 ]; then
> +        UNICODE=3D1
> +    elif [ "${UNICODE}" =3D NO -o "${UNICODE}" =3D no -o "${UNICODE}=
" =3D 0 ]; then
> +        UNICODE=3D0
> +    else
> +        UNICODE=3D''
> +    fi
> +fi
> +if [ ! "${UNICODE}" ]; then
> +    IFS=3D.
> +    set -- $LANG
> +    tail=3D$2
> +    IFS=3D-
> +    set -- $tail
> +    type=3D$1
> +    if [ "${type}" =3D "UTF" ]; then
> +        UNICODE=3D1
> +    fi

What about LANG=3Den_US.utf8? You probably want "locale charmap" here.

> +fi
> +
>  dev_open ${dev}
> =20
>  for fd in 6 7; do
> @@ -84,9 +96,19 @@ for fd in 6 7; do
>      fi
>  done
> =20
> +# Immediately after booting up, the
> +# display driver needs to settle,
> +# otherwise the Unicode mode cannot
> +# be enabled and the non latin
> +# characters do not render properly.
> +if [ -d /usr/share/locale ]; then
> +    if [ ! -e /tmp/dracut-vga-init-complete ]; then
> +        sleep 2 && :> /tmp/dracut-vga-init-complete
> +    fi
> +fi
> +
>  set_keyboard
> -set_terminal ${dev}
> -set_font ${dev}
> +set_terminal
>  set_keymap
> =20
>  dev_close
> diff -pru dracut-git-orig/modules.d/10i18n/module-setup.sh dracut-git=
-10i18n-full-support-for-localisation/modules.d/10i18n/module-setup.sh
> --- dracut-git-orig/modules.d/10i18n/module-setup.sh	2016-04-22 14:25=
:26.949983919 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/=
module-setup.sh	2016-04-22 15:42:18.988741282 +0200
> @@ -4,7 +4,11 @@
>  check() {
>      [[ "$mount_needs" ]] && return 1
> =20
> -    require_binaries setfont loadkeys kbd_mode || return 1
> +    if [[ $msg_localisation =3D=3D "yes" ]]; then
> +        require_binaries setfont loadkeys kbd_mode unicode_start uni=
code_stop stty tty tset reset sleep || return 1
> +    else
> +        require_binaries setfont loadkeys kbd_mode unicode_start uni=
code_stop || return 1
> +    fi
> =20

Well, you should move common stuff that is always required outside of
"if". As soon as you need to modify the same item in two places, you ar=
e
bound to make mistakes.

>      return 0
>  }
> @@ -27,6 +31,11 @@ install() {
>      I18N_CONF=3D"/etc/locale.conf"
>      VCONFIG_CONF=3D"/etc/vconsole.conf"
> =20
> +    # Core packages: always install the message-based localisation
> +    if [[ $msg_localisation =3D=3D "yes" ]]; then
> +        CORE_PACKAGES=3D"libc bash coreutils util-linux e2fsprogs gr=
ep sed kbd"
> +    fi
> +

How custom modules are supposed to extend this list?

>      # This is from 10redhat-i18n.
>      findkeymap () {
>          local MAP=3D$1
> @@ -93,7 +102,11 @@ install() {
>      }
> =20
>      install_base() {
> -        inst_multiple setfont loadkeys kbd_mode stty
> +        if [[ $msg_localisation =3D=3D "yes" ]]; then
> +            inst_multiple setfont loadkeys kbd_mode unicode_start un=
icode_stop stty tty tset reset sleep
> +        else
> +            inst_multiple setfont loadkeys kbd_mode unicode_start un=
icode_stop
> +        fi
> =20

Same here.

>          if ! dracut_module_included "systemd"; then
>              inst ${moddir}/console_init.sh /lib/udev/console_init
> @@ -212,11 +225,132 @@ install() {
>              inst_simple ${kbddir}/unimaps/${FONT_UNIMAP}.uni
>          fi
> =20
> +        if [[ $msg_localisation =3D=3D "yes" ]]; then
> +            [[ ${LC_ALL} || ${LANG} || ${LC_MESSAGES} ]] && inst_dir=
 /usr/lib/locale
> +
> +            # Check if we can compile locale definitions
> +            command -v localedef > /dev/null && HAS_LOCALEDEF=3Dtrue=
 || HAS_LOCALEDEF=3Dfalse
> +            if [ ${LC_ALL} ]; then
> +                read LC_ALL_LOCALE LC_ALL_CHARMAP < <(echo ${LC_ALL/=
/./ })
> +            fi
> +            if [ ${LANG} ]; then
> +                read LANG_LOCALE LANG_CHARMAP < <(echo ${LANG//./ })
> +            fi
> +            if [ ${LC_MESSAGES} ]; then
> +                read LC_MESSAGES_LOCALE LC_MESSAGES_CHARMAP < <(echo=
 ${LC_MESSAGES//./ })
> +            fi
> +            if [[ -e /usr/share/i18n/locales/${LC_ALL_LOCALE} || -e =
/usr/share/i18n/locales/${LANG_LOCALE} || -e /usr/share/i18n/locales/${=
LC_MESSAGES_LOCALE} ]]; then
> +                HAS_LOCALE_SOURCES=3Dtrue
> +            else
> +                HAS_LOCALE_SOURCES=3Dfalse
> +            fi
> +            if [[ ${HAS_LOCALEDEF} =3D=3D true && ${HAS_LOCALE_SOURC=
ES} =3D=3D true ]]; then
> +                CAN_BUILD_LOCALE=3Dtrue
> +            else
> +                CAN_BUILD_LOCALE=3Dfalse
> +            fi
> +
> +            # Generate locale definitions for LC_ALL
> +            if [[ ${LC_ALL} && ${LC_ALL_LOCALE} && ${LC_ALL_CHARMAP}=
 ]]; then
> +                if [ ${CAN_BUILD_LOCALE} =3D=3D true ]; then
> +                    if [ -e /usr/share/i18n/locales/${LC_ALL_LOCALE}=
 ]; then
> +                        localedef --prefix=3D"${initdir}" -i ${LC_AL=
L_LOCALE} -f ${LC_ALL_CHARMAP} ${LC_ALL}
> +                    fi
> +                fi
> +            fi
> +
> +            # Generate locale definitions for LANG
> +            if [[ ${LANG} && ${LANG_LOCALE} && ${LANG_CHARMAP} ]]; t=
hen
> +                if [ ${CAN_BUILD_LOCALE} =3D=3D true ]; then
> +                    if [ -e /usr/share/i18n/locales/${LANG_LOCALE} ]=
; then
> +                        localedef --prefix=3D"${initdir}" -i ${LANG_=
LOCALE} -f ${LANG_CHARMAP} ${LANG}
> +                    fi
> +                fi
> +            fi
> +
> +            # Generate locale definitions for LC_MESSAGES
> +            if [[ ${LC_MESSAGES} && ${LC_MESSAGES_LOCALE} && ${LC_ME=
SSAGES_CHARMAP} ]]; then
> +                if [ ${CAN_BUILD_LOCALE} =3D=3D true ]; then
> +                    if [ -e /usr/share/i18n/locales/${LC_MESSAGES_LO=
CALE} ]; then
> +                        localedef --prefix=3D"${initdir}" -i ${LC_ME=
SSAGES_LOCALE} -f ${LC_MESSAGES_CHARMAP} ${LC_MESSAGES}
> +                    fi
> +                fi
> +            fi
> +
> +            # If locale definitions cannot be built, but compiled sp=
lit definitions are
> +            # available, then install them
> +            if [ ${CAN_BUILD_LOCALE} =3D=3D false ]; then

You set CAN_BUILD_LOCALE if *any* source is found. If some sources are
missing they will be neither compiled nor installed. So you really need
to change logic and simply do for every LC_ALL, LANG, LC_MESSAGES

if source exists
 compile
else if binary exists
 install

This actually makes code more clear.

> +                if [[ ${LC_ALL} && -d /usr/lib/locale/${LC_ALL} ]]; =
then
> +                    cp -prfL -t "${initdir}/usr/lib/locale/" /usr/li=
b/locale/${LC_ALL}
> +                fi
> +                if [[ ${LANG} && -d /usr/lib/locale/${LANG} ]]; then
> +                    cp -prfL -t "${initdir}/usr/lib/locale/" /usr/li=
b/locale/${LANG}
> +                fi
> +                if [[ ${LC_MESSAGES} && -d /usr/lib/locale/${LC_MESS=
AGES} ]]; then
> +                    cp -prfL -t "${initdir}/usr/lib/locale/" /usr/li=
b/locale/${LC_MESSAGES}
> +                fi
> +            fi
> +
> +            # Install individual localisation files for core package=
s
> +            [ -e /usr/share/locale/locale.alias ] && inst_simple /us=
r/share/locale/locale.alias
> +            [[ ${LC_ALL_LOCALE} ]] && inst_dir "/usr/share/locale/${=
LC_ALL_LOCALE}"
> +            [[ ${LANG_LOCALE} ]] && inst_dir "/usr/share/locale/${LA=
NG_LOCALE}"
> +            [[ ${LC_MESSAGES_LOCALE} ]] && inst_dir "/usr/share/loca=
le/${LC_MESSAGES_LOCALE}"
> +            [[ ${LC_ALL_LOCALE} ]] && read LC_ALL_LOCALE_SHORT LC_AL=
L_LOCALE_COUNTRY < <(echo ${LC_ALL_LOCALE//_/ })
> +            [[ ${LANG_LOCALE} ]] && read LANG_LOCALE_SHORT LANG_LOCA=
LE_COUNTRY < <(echo ${LANG_LOCALE//_/ })
> +            [[ ${LC_MESSAGES_LOCALE} ]] && read LC_MESSAGES_LOCALE_S=
HORT LC_MESSAGES_LOCALE_COUNTRY < <(echo ${LC_MESSAGES_LOCALE//_/ })
> +            [[ ${LC_ALL_LOCALE_SHORT} ]] && inst_dir "/usr/share/loc=
ale/${LC_ALL_LOCALE_SHORT}"
> +            [[ ${LANG_LOCALE_SHORT} ]] && inst_dir "/usr/share/local=
e/${LANG_LOCALE_SHORT}"
> +            [[ ${LC_MESSAGES_LOCALE_SHORT} ]] && inst_dir "/usr/shar=
e/locale/${LC_MESSAGES_LOCALE_SHORT}"
> +
> +            locale_dirs=3D"${LC_ALL_LOCALE} ${LANG_LOCALE} ${LC_MESS=
AGES_LOCALE} ${LC_ALL_LOCALE_SHORT} ${LANG_LOCALE_SHORT} {LC_MESSAGES_L=
OCALE_SHORT}"
> +            for dir in ${locale_dirs}; do
> +                [ -d "/usr/share/locale/${dir}" ] && for pkg in ${CO=
RE_PACKAGES}; do
> +                    for file in `find "/usr/share/locale/${dir}" -ty=
pe f -name "${pkg}.mo"`; do
> +                        inst_simple "${file}"
> +                    done
> +                done
> +            done
> +
> +            # Install ISO-8859 and Unicode charmap modules from GNU =
libc
> +            if [ -e "${initdir}/lib/ld-linux.so.*" ]; then
> +                LIBDIR=3Dlib
> +            else
> +                LIBDIR=3Dlib64
> +            fi

What about multi-arch and non-x86 systems? I have both
/lib/ld-linus.so.* and /lib64/ld-linux.so.* on 64 bit Ubuntu here.

> +            inst_multiple /usr/${LIBDIR}/gconv/ISO8859-*.so
> +            if [ ${UNICODE} =3D=3D 1 ]; then
> +                inst_multiple /usr/${LIBDIR}/gconv/UTF-*.so /usr/${L=
IBDIR}/gconv/UNICODE.so
> +            fi

And I have none of these files (assuming those files are required, can
you explain where they are used)? I have /usr/lib/x86_64-linux-gnu/gcon=
v
and /usr/lib/i386-linux-gnu/gconv (and /usr/lib32/gconv, not sure how
they two are related to each other).

> +            if command -v iconvconfig > /dev/null; then
> +                if [ -e /usr/${LIBDIR}/gconv/gconv-modules ]; then
> +                    grep -E "^[[:space:]]*alias[[:space:]]*ISO[-]*88=
59-" /usr/${LIBDIR}/gconv/gconv-modules > /tmp/gconv-modules
> +                    if [ ${UNICODE} =3D=3D 1 ]; then
> +                        grep -E "^[[:space:]]*alias.*UTF-" /usr/${LI=
BDIR}/gconv/gconv-modules >> /tmp/gconv-modules
> +                        grep -E "^[[:space:]]*alias.*UNICODE" /usr/$=
{LIBDIR}/gconv/gconv-modules >> /tmp/gconv-modules
> +                    fi
> +                    grep -E "^[[:space:]]*module[[:space:]]*ISO[-]*8=
859-" /usr/${LIBDIR}/gconv/gconv-modules | grep INTERNAL >> /tmp/gconv-=
modules
> +                    if [ ${UNICODE} =3D=3D 1 ]; then
> +                        grep -E "^[[:space:]]*module[[:space:]]*UTF-=
" /usr/${LIBDIR}/gconv/gconv-modules | grep INTERNAL >> /tmp/gconv-modu=
les
> +                        grep -E "^[[:space:]]*module[[:space:]]*UNIC=
ODE" /usr/${LIBDIR}/gconv/gconv-modules | grep INTERNAL >> /tmp/gconv-m=
odules
> +                    fi
> +                    if [ -e /tmp/gconv-modules ]; then
> +                        inst /tmp/gconv-modules /usr/${LIBDIR}/gconv=
/gconv-modules && rm -f /tmp/gconv-modules
> +                    fi
> +                fi
> +                iconvconfig --prefix=3D"${initdir}"
> +            else
> +                if [ -e /usr/${LIBDIR}/gconv/gconv-modules.cache ]; =
then
> +                    inst_simple /usr/${LIBDIR}/gconv/gconv-modules.c=
ache
> +                fi
> +            fi
> +        fi
> +
>          if dracut_module_included "systemd" && [[ -f ${I18N_CONF} ]]=
; then
>              inst_simple ${I18N_CONF}
>          else
>              mksubdirs ${initdir}${I18N_CONF}
> -            print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
> +            print_vars LANG LC_ALL LC_MESSAGES >> ${initdir}${I18N_C=
ONF}
>          fi
> =20
>          if dracut_module_included "systemd" && [[ -f ${VCONFIG_CONF}=
 ]]; then
> diff -pru dracut-git-orig/modules.d/10i18n/parse-i18n.sh dracut-git-1=
0i18n-full-support-for-localisation/modules.d/10i18n/parse-i18n.sh
> --- dracut-git-orig/modules.d/10i18n/parse-i18n.sh	2016-04-20 14:11:0=
2.825944933 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/=
parse-i18n.sh	2016-04-19 02:26:46.617644187 +0200
> @@ -23,11 +23,13 @@ inst_key_val /etc/vconsole.conf FONT_UNI
>  inst_key_val /etc/vconsole.conf UNICODE      1 rd.vconsole.font.unic=
ode UNICODE vconsole.unicode
>  inst_key_val /etc/vconsole.conf EXT_KEYMAP  '' rd.vconsole.keymap.ex=
t   EXT_KEYMAP
> =20
> -inst_key_val /etc/locale.conf   LANG        '' rd.locale.LANG       =
    LANG
> -inst_key_val /etc/locale.conf   LC_ALL      '' rd.locale.LC_ALL     =
    LC_ALL
> -
> +inst_key_val /etc/locale.conf   LANG              '' rd.locale.LANG =
              LANG
> +inst_key_val /etc/locale.conf   LC_ALL            '' rd.locale.LC_AL=
L             LC_ALL
> +inst_key_val /etc/locale.conf   LC_MESSAGES       '' rd.locale.LC_ME=
SSAGES        LC_MESSAGES
> +=20
>  if [ -f /etc/locale.conf ]; then
>      . /etc/locale.conf
>      export LANG
>      export LC_ALL
> +    export LC_MESSAGES
>  fi
> diff -pru dracut-git-orig/modules.d/10i18n/README dracut-git-10i18n-f=
ull-support-for-localisation/modules.d/10i18n/README
> --- dracut-git-orig/modules.d/10i18n/README	2016-04-20 14:11:02.82694=
4946 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/=
README	2016-04-19 02:26:46.617644187 +0200
> @@ -65,6 +65,7 @@ I'm leaving it in case...  The following
> =20
>      LANG
>      LC_ALL
> +    LC_MESSAGES
> =20
>  If UNICODE variable is not provided, script indicates if UTF-8 shoul=
d be
>  used on the basis of LANG value (if it ends with ".utf8" or similar)=
=2E
> diff -pru dracut-git-orig/modules.d/90crypt/module-setup.sh dracut-gi=
t-10i18n-full-support-for-localisation/modules.d/90crypt/module-setup.s=
h
> --- dracut-git-orig/modules.d/90crypt/module-setup.sh	2016-04-19 02:1=
9:10.662042554 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/90crypt=
/module-setup.sh	2016-04-21 22:26:38.113859320 +0200
> @@ -88,6 +88,10 @@ install() {
> =20
>      inst_simple "$moddir/crypt-lib.sh" "/lib/dracut-crypt-lib.sh"
> =20
> +    if [[ $msg_localisation =3D=3D "yes" ]]; then
> +        inst_i18n cryptsetup
> +    fi
> +

Oh, no, you should check for enabled l10n inside of inst_l10n and just
let other modules always install stuff they need. Let core logic handle
enabled stuff.

>      if dracut_module_included "systemd"; then
>          inst_multiple -o \
>                        $systemdutildir/system-generators/systemd-cryp=
tsetup-generator \
> diff -pru dracut-git-orig/modules.d/91crypt-gpg/module-setup.sh dracu=
t-git-10i18n-full-support-for-localisation/modules.d/91crypt-gpg/module=
-setup.sh
> --- dracut-git-orig/modules.d/91crypt-gpg/module-setup.sh	2016-04-19 =
02:19:10.667042618 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/91crypt=
-gpg/module-setup.sh	2016-04-22 18:06:54.504926340 +0200
> @@ -17,4 +17,8 @@ depends() {
>  install() {
>      inst_multiple gpg
>      inst "$moddir/crypt-gpg-lib.sh" "/lib/dracut-crypt-gpg-lib.sh"
> +
> +    if [[ $msg_localisation =3D=3D "yes" ]]; then
> +        inst_i18n gnupg
> +    fi
>  }
> diff -pru dracut-git-orig/modules.d/99base/init.sh dracut-git-10i18n-=
full-support-for-localisation/modules.d/99base/init.sh
> --- dracut-git-orig/modules.d/99base/init.sh	2016-04-20 14:11:02.8269=
44946 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/99base/=
init.sh	2016-04-20 14:02:01.578137511 +0200
> @@ -8,6 +8,8 @@
> =20
>  export -p > /tmp/export.orig
> =20
> +[ -f /etc/locale.conf ] && . /etc/locale.conf
> +
>  NEWROOT=3D"/sysroot"
>  [ -d $NEWROOT ] || mkdir -p -m 0755 $NEWROOT
> =20
> @@ -323,7 +325,7 @@ for i in $(export -p); do
>      i=3D${i%%=3D*}
>      [ -z "$i" ] && continue
>      case $i in
> -        root|PATH|HOME|TERM|PS4|RD_*)
> +        root|PATH|HOME|TERM|PS4|RD_*|LANG|LC_*)
>              :;;
>          *)
>              unset "$i";;
> diff -pru dracut-git-orig/modules.d/99base/module-setup.sh dracut-git=
-10i18n-full-support-for-localisation/modules.d/99base/module-setup.sh
> --- dracut-git-orig/modules.d/99base/module-setup.sh	2016-04-20 14:11=
:02.827944958 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/99base/=
module-setup.sh	2016-04-21 20:01:54.611592039 +0200
> @@ -26,6 +26,10 @@ install() {
>          (ln -s bash "${initdir}/bin/sh" || :)
>      fi
> =20
> +    if dracut_module_included "i18n"; then
> +       inst ${moddir}/profile /etc/profile
> +    fi
> +

Where this file comes from? It is not part of this patch?

>      #add common users in /etc/passwd, it will be used by nfs/ssh cur=
rently
>      grep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x=
:0:0::/root:/bin/sh' >> "$initdir/etc/passwd"
>      grep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
> =CE=9C=CF=8C=CE=BD=CE=BF =CF=83=CF=84=CE=BF dracut-git-10i18n-full-su=
pport-for-localisation/modules.d/99base: profile
> diff -pru dracut-git-orig/NEWS dracut-git-10i18n-full-support-for-loc=
alisation/NEWS
> --- dracut-git-orig/NEWS	2016-04-19 02:19:10.648042373 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/NEWS	2016-04-21 1=
7:00:46.436792093 +0200
> @@ -6,6 +6,7 @@ dracut now requires libkmod for the drac
>  dracut.sh:
>  - restorecon final image file
>  - fail hard, if we find modules and modules.dep is missing
> +- add an option to disable the new full localisation support
> =20
>  dracut-functions.sh:
>  - fix check_vol_slaves() volume group name stripping
> @@ -34,6 +35,9 @@ general initramfs fixes:
>  - call dracut-cmdline-ask.service, if /etc/cmdline.d/*.conf exists
>  - break at switch_root only for bare rd.break
> =20
> +i18n:
> +- add full localisation support (includes message-based localisation=
)
> +
>  dmsquash-live:
>  - fixed livenet-generator execution flag
>    and include only, if systemd is used
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
