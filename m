From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v9] dracut: add support for custom locale definitions
Date: Wed, 11 Oct 2017 15:17:51 +0200
Message-ID: <7206831a-5136-5acf-fe29-12d81fd083e9@redhat.com>
References: <1460758050.3211.2.camel@trentalancia.net>
 <5711D4E7.9070705@gmail.com> <1460815966.4296.13.camel@trentalancia.net>
 <57127BC9.70103@gmail.com> <1460835143.3201.10.camel@trentalancia.net>
 <1460837622.3201.14.camel@trentalancia.net>
 <1460838269.3201.18.camel@trentalancia.net>
 <1461026208.2262.1.camel@trentalancia.net>
 <1461157491.11229.3.camel@trentalancia.net> <5718AA77.8090600@redhat.com>
 <1461341618.21231.0.camel@trentalancia.net>
 <1461430242.2604.15.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461430242.2604.15.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Please file a pull request on https://github.com/dracutdevs/dracut


On 23.04.2016 18:50, Guido Trentalancia wrote:
> Compile and install locale definitions using localedef from GNU libc or,
> if locale definitions cannot be compiled but are available on the system
> as split definitions, just install them.
> 
> The resulting locale definitions archive contains at most two different
> locale definitions, therefore its size is relatively small.
> 
> Add support for localised messages from core packages (LC_MESSAGES).
> 
> Add support for non-latin fonts using Unicode (tested successfully with
> Greek, Hebrew and Cyrillic).
> 
> This revised version fixes several issues in the initial patch (including
> the possibility to build locale definitions). Thanks to Andrei Borzenkov
> for reviewing the initial patch and providing useful suggestions.
> 
> Thanks for Harald Hoyer for the full style review and other useful
> suggestions.
> 
> Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> ---
>  NEWS                                  |    4 +
>  dracut-bash-completion.sh             |   11 +--
>  dracut-init.sh                        |   37 ++++++++++
>  dracut.8.asc                          |    8 ++
>  dracut.conf.5.asc                     |   14 ++-
>  dracut.sh                             |   20 ++++-
>  modules.d/10i18n/README               |    1
>  modules.d/10i18n/console_init.sh      |   58 +++++++++++-----
>  modules.d/10i18n/module-setup.sh      |  123 +++++++++++++++++++++++++++++++++-
>  modules.d/10i18n/parse-i18n.sh        |    8 +-
>  modules.d/90crypt/module-setup.sh     |    6 +
>  modules.d/91crypt-gpg/module-setup.sh |    6 +
>  modules.d/99base/init.sh              |    4 -
>  modules.d/99base/module-setup.sh      |    4 +
>  modules.d/99base/profile              |    9 ++
>  15 files changed, 275 insertions(+), 38 deletions(-)
> 
> diff -pruN dracut-git-orig/dracut.8.asc dracut-git-10i18n-full-support-for-localisation/dracut.8.asc
> --- dracut-git-orig/dracut.8.asc	2016-04-19 02:19:10.650042399 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/dracut.8.asc	2016-04-21 17:13:53.043188284 +0200
> @@ -358,6 +358,14 @@ provide a valid _/etc/fstab_.
>      LVM or an encrypted partition.
>      [NB --device can be used for compatibility with earlier releases]
>  
> +**--msg-localisation**::
> +    Include full localisation support for the i18n module (slightly increases
> +    the initramfs size).
> +
> +**--no-msg-localisation**::
> +    Do not include full localisation support for the i18n module (to save
> +    storage space or force the default locale).
> +
>  **-i, --include** _<SOURCE>_ _<TARGET>_::
>      include the files in the SOURCE directory into the
>      TARGET directory in the final initramfs. If SOURCE is a file, it will be
> diff -pruN dracut-git-orig/dracut-bash-completion.sh dracut-git-10i18n-full-support-for-localisation/dracut-bash-completion.sh
> --- dracut-git-orig/dracut-bash-completion.sh	2016-04-19 02:19:10.648042373 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/dracut-bash-completion.sh	2016-04-21 17:16:41.148400079 +0200
> @@ -28,11 +28,12 @@ _dracut() {
>                                --ro-mnt --force --kernel-only --no-kernel --strip --nostrip
>                                --hardlink --nohardlink --noprefix --mdadmconf --nomdadmconf
>                                --lvmconf --nolvmconf --debug --profile --verbose --quiet
> -                              --local --hostonly --no-hostonly --fstab --help --bzip2 --lzma
> -                              --xz --no-compress --gzip --list-modules --show-modules --keep
> -                              --printsize --regenerate-all --noimageifnotneeded --early-microcode
> -                              --no-early-microcode --print-cmdline --prelink --noprelink --reproducible
> -                              --uefi
> +                              --local --hostonly --no-hostonly --fstab --msg-localisation
> +                              --no-msg-localisation --help --bzip2 --lzma --xz --no-compress
> +                              --gzip --list-modules --show-modules --keep --printsize
> +                              --regenerate-all --noimageifnotneeded --early-microcode
> +                              --no-early-microcode --print-cmdline --prelink --noprelink
> +                              --reproducible --uefi
>                                '
>  
>                         [ARG]='-a -m -o -d -I -k -c -L --kver --add --force-add --add-drivers
> diff -pruN dracut-git-orig/dracut.conf.5.asc dracut-git-10i18n-full-support-for-localisation/dracut.conf.5.asc
> --- dracut-git-orig/dracut.conf.5.asc	2016-04-19 02:19:10.650042399 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/dracut.conf.5.asc	2016-04-21 17:21:57.576555027 +0200
> @@ -99,9 +99,6 @@ Configuration files must have the extens
>  *hostonly_cmdline=*"__{yes|no}__"::
>      If set, store the kernel command line arguments needed in the initramfs
>  
> -*i18n_install_all=*"__{yes|no}__"::
> -    If set to yes, install all available fonts and keyboard files.
> -
>  *persistent_policy=*"__<policy>__"::
>      Use _<policy>_ to address disks and partitions.
>      _<policy>_ can be any directory name found in /dev/disk.
> @@ -196,7 +193,16 @@ provide a valid _/etc/fstab_.
>      Default is "LatArCyrHeb-16".
>  
>  *i18n_install_all=*"__{yes|no}__"::
> -    Install everything regardless of generic or hostonly mode.
> +    Install all available fonts and keyboard files regardless of generic
> +    or hostonly mode.
> +
> +*msg-localisation=*"__{yes|no}__"::
> +    Add full localisation support (includes message-based localisation
> +    and non latin font support).
> +
> +*no-msg-localisation=*"__{yes|no}__"::
> +    Do not add full localisation support (only keyboard localisation
> +    is added): saves some storage space.
>  
>  *reproducible=*"__{yes|no}__"::
>      Create reproducible images.
> diff -pruN dracut-git-orig/dracut-init.sh dracut-git-10i18n-full-support-for-localisation/dracut-init.sh
> --- dracut-git-orig/dracut-init.sh	2016-04-19 02:19:10.649042386 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/dracut-init.sh	2016-04-22 18:05:08.033519479 +0200
> @@ -214,6 +214,43 @@ inst_multiple() {
>      return $_ret
>  }
>  
> +# Install package translations (message-based localisations)
> +inst_i18n() {
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
> +        read LC_MESSAGES_LOCALE LC_MESSAGES_CHARMAP < <(echo ${LC_MESSAGES//./ })
> +    fi
> +    [[ ${LC_ALL_LOCALE} ]] && read LC_ALL_LOCALE_SHORT LC_ALL_LOCALE_COUNTRY < <(echo ${LC_ALL_LOCALE//_/ })
> +    [[ ${LANG_LOCALE} ]] && read LANG_LOCALE_SHORT LANG_LOCALE_COUNTRY < <(echo ${LANG_LOCALE//_/ })
> +    [[ ${LC_MESSAGES_LOCALE} ]] && read LC_MESSAGES_LOCALE_SHORT LC_MESSAGES_LOCALE_COUNTRY < <(echo ${LC_MESSAGES_LOCALE//_/ })
> +    _locale_dirs_dup="${LC_ALL_LOCALE} ${LANG_LOCALE} ${LC_MESSAGES_LOCALE} ${LC_ALL_LOCALE_SHORT} ${LANG_LOCALE_SHORT} ${LC_MESSAGES_LOCALE_SHORT}"
> +    _tmppath=
> +    _locale_dirs=
> +    for dir in ${_locale_dirs_dup}
> +    do
> +        case $_tmppath in
> +            *\ ${dir}) ;;
> +            *) _locale_dirs="${_tmppath} ${dir}";;
> +        esac
> +        _tmppath=${_locale_dirs}
> +    done
> +    for dir in ${_locale_dirs}; do
> +        [[ -d "/usr/share/locale/${dir}" ]] && for file in `find "/usr/share/locale/${dir}" -type f -name "$1.mo"`; do
> +            inst_simple "${file}"
> +        done
> +    done
> +}
> +
>  dracut_install() {
>      inst_multiple "$@"
>  }
> diff -pruN dracut-git-orig/dracut.sh dracut-git-10i18n-full-support-for-localisation/dracut.sh
> --- dracut-git-orig/dracut.sh	2016-04-19 02:19:10.652042425 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/dracut.sh	2016-04-21 23:06:34.022740183 +0200
> @@ -163,6 +163,10 @@ Creates initial ramdisk images for prelo
>    --mount "[MP]"	Same as above, but [DEV], [FSTYPE] and [FSOPTS] are
>  			determined by looking at the current mounts.
>    --add-device "[DEV]"  Bring up [DEV] in initramfs
> +  --msg-localisation    Add full localisation support rather than only
> +                        the minimal keyboard support (default)
> +  --no-msg-localisation Do not add full localisation support, but only
> +                        minimal keyboard support
>    -i, --include [SOURCE] [TARGET]
>                          Include the files in the SOURCE directory into the
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
>                         persistent_policy_l="$2";       PARMS_TO_STORE+=" '$2'"; shift;;
>          --fstab)       use_fstab_l="yes" ;;
> +        --msg-localisation)
> +                       msg_localisation_l="yes" ;;
> +        --no-msg-localisation)
> +                       msg_localisation_l="no" ;;
>          -h|--help)     long_usage; exit 1 ;;
>          -i|--include)  include_src+=("$2");          PARMS_TO_STORE+=" '$2'";
>                         shift;;
> @@ -730,6 +740,8 @@ stdloglvl=$((stdloglvl + verbosity_mod_l
>  [[ $i18n_install_all_l ]] && i18n_install_all=$i18n_install_all_l
>  [[ $persistent_policy_l ]] && persistent_policy=$persistent_policy_l
>  [[ $use_fstab_l ]] && use_fstab=$use_fstab_l
> +[[ $msg_localisation_l ]] && msg_localisation=$msg_localisation_l
> +[[ $msg_localisation_l ]] || msg_localisation="yes"
>  [[ $mdadmconf_l ]] && mdadmconf=$mdadmconf_l
>  [[ $lvmconf_l ]] && lvmconf=$lvmconf_l
>  [[ $dracutbasedir ]] || dracutbasedir=/usr/lib/dracut
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
> diff -pruN dracut-git-orig/modules.d/10i18n/console_init.sh dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/console_init.sh
> --- dracut-git-orig/modules.d/10i18n/console_init.sh	2016-04-20 14:11:02.824944921 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/console_init.sh	2016-04-22 17:54:50.913345284 +0200
> @@ -6,6 +6,7 @@ if [ -x $systemdutildir/systemd-vconsole
>      $systemdutildir/systemd-vconsole-setup "$@"
>  fi
>  
> +[ -e /etc/locale.conf ] && . /etc/locale.conf
>  [ -e /etc/vconsole.conf ] && . /etc/vconsole.conf
>  
>  DEFAULT_FONT=LatArCyrHeb-16
> @@ -19,14 +20,14 @@ set_keyboard() {
>  }
>  
>  set_terminal() {
> -    local dev=$1
> -
>      if [ "${UNICODE}" = 1 ]; then
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
>  
> @@ -44,16 +45,6 @@ set_keymap() {
>      loadkeys -q ${utf_switch} ${KEYMAP} ${EXT_KEYMAPS}
>  }
>  
> -set_font() {
> -    local dev=$1; local trans=''; local uni=''
> -
> -    [ -z "${FONT}" ] && FONT=${DEFAULT_FONT}
> -    [ -n "${FONT_MAP}" ] && trans="-m ${FONT_MAP}"
> -    [ -n "${FONT_UNIMAP}" ] && uni="-u ${FONT_UNIMAP}"
> -
> -    setfont ${FONT} -C ${dev} ${trans} ${uni}
> -}
> -
>  dev_close() {
>      exec 6>&-
>      exec 7>&-
> @@ -74,6 +65,27 @@ devname=${dev#/dev/}
>      exit 1
>  }
>  
> +if [ "${UNICODE}" ]; then
> +    if [ "${UNICODE}" = YES -o "${UNICODE}" = yes -o "${UNICODE}" = 1 ]; then
> +        UNICODE=1
> +    elif [ "${UNICODE}" = NO -o "${UNICODE}" = no -o "${UNICODE}" = 0 ]; then
> +        UNICODE=0
> +    else
> +        UNICODE=''
> +    fi
> +fi
> +if [ ! "${UNICODE}" ]; then
> +    IFS=.
> +    set -- $LANG
> +    tail=$2
> +    IFS=-
> +    set -- $tail
> +    type=$1
> +    if [ "${type}" = "UTF" ]; then
> +        UNICODE=1
> +    fi
> +fi
> +
>  dev_open ${dev}
>  
>  for fd in 6 7; do
> @@ -84,9 +96,19 @@ for fd in 6 7; do
>      fi
>  done
>  
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
>  
>  dev_close
> diff -pruN dracut-git-orig/modules.d/10i18n/module-setup.sh dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/module-setup.sh
> --- dracut-git-orig/modules.d/10i18n/module-setup.sh	2016-04-22 14:25:26.949983919 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/module-setup.sh	2016-04-23 18:23:14.911103135 +0200
> @@ -4,7 +4,11 @@
>  check() {
>      [[ "$mount_needs" ]] && return 1
>  
> -    require_binaries setfont loadkeys kbd_mode || return 1
> +    require_binaries setfont loadkeys kbd_mode unicode_start unicode_stop
> +
> +    if [[ $msg_localisation == "yes" ]]; then
> +        require_binaries stty tty tset reset sleep || return 1
> +    fi
>  
>      return 0
>  }
> @@ -27,6 +31,11 @@ install() {
>      I18N_CONF="/etc/locale.conf"
>      VCONFIG_CONF="/etc/vconsole.conf"
>  
> +    # Core packages: always install the message-based localisation
> +    if [[ $msg_localisation == "yes" ]]; then
> +        CORE_PACKAGES="libc bash coreutils util-linux e2fsprogs grep sed kbd"
> +    fi
> +
>      # This is from 10redhat-i18n.
>      findkeymap () {
>          local MAP=$1
> @@ -93,7 +102,11 @@ install() {
>      }
>  
>      install_base() {
> -        inst_multiple setfont loadkeys kbd_mode stty
> +        inst_multiple setfont loadkeys kbd_mode unicode_start unicode_stop
> +
> +        if [[ $msg_localisation == "yes" ]]; then
> +            inst_multiple stty tty tset reset sleep
> +        fi
>  
>          if ! dracut_module_included "systemd"; then
>              inst ${moddir}/console_init.sh /lib/udev/console_init
> @@ -212,11 +225,115 @@ install() {
>              inst_simple ${kbddir}/unimaps/${FONT_UNIMAP}.uni
>          fi
>  
> +        if [[ $msg_localisation == "yes" ]]; then
> +            [[ ${LC_ALL} || ${LANG} || ${LC_MESSAGES} ]] && inst_dir /usr/lib/locale
> +
> +            # Check if we can compile locale definitions
> +            if command -v localedef > /dev/null; then
> +                HAS_LOCALEDEF=true
> +            else
> +                HAS_LOCALEDEF=false
> +            fi
> +            if [ ${LC_ALL} ]; then
> +                read LC_ALL_LOCALE LC_ALL_CHARMAP < <(echo ${LC_ALL//./ })
> +            fi
> +            if [ ${LANG} ]; then
> +                read LANG_LOCALE LANG_CHARMAP < <(echo ${LANG//./ })
> +            fi
> +            if [ ${LC_MESSAGES} ]; then
> +                read LC_MESSAGES_LOCALE LC_MESSAGES_CHARMAP < <(echo ${LC_MESSAGES//./ })
> +            fi
> +
> +            # Generate locale definitions for LC_ALL or install compiled split
> +            # definitions where available
> +            if [[ ${LC_ALL} && ${LC_ALL_LOCALE} && ${LC_ALL_CHARMAP} ]]; then
> +                if [[ ${HAS_LOCALEDEF} == true && -e /usr/share/i18n/locales/${LC_ALL_LOCALE} ]]; then
> +                    localedef --prefix="${initdir}" -i ${LC_ALL_LOCALE} -f ${LC_ALL_CHARMAP} ${LC_ALL}
> +                elif [ -d "/usr/lib/locale/${LC_ALL}" ]; then
> +                    cp -prfL -t "${initdir}/usr/lib/locale/" /usr/lib/locale/${LC_ALL}
> +                fi
> +            fi
> +
> +            # Generate locale definitions for LANG or install compiled split
> +            # definitions where available
> +            if [[ ${LANG} && ${LANG_LOCALE} && ${LANG_CHARMAP} ]]; then
> +                if [[ ${HAS_LOCALEDEF} == true && -e /usr/share/i18n/locales/${LANG_LOCALE} ]]; then
> +                    localedef --prefix="${initdir}" -i ${LANG_LOCALE} -f ${LANG_CHARMAP} ${LANG}
> +                elif [ -d "/usr/lib/locale/${LANG}" ]; then
> +                    cp -prfL -t "${initdir}/usr/lib/locale/" /usr/lib/locale/${LANG}
> +                fi
> +            fi
> +
> +            # Generate locale definitions for LC_MESSAGES of install compiled split
> +            # definitions where available
> +            if [[ ${LC_MESSAGES} && ${LC_MESSAGES_LOCALE} && ${LC_MESSAGES_CHARMAP} ]]; then
> +                if [[ ${HAS_LOCALEDEF} == true && -e /usr/share/i18n/locales/${LC_MESSAGES_LOCALE} ]]; then
> +                    localedef --prefix="${initdir}" -i ${LC_MESSAGES_LOCALE} -f ${LC_MESSAGES_CHARMAP} ${LC_MESSAGES}
> +                elif [ -d "/usr/lib/locale/${LC_MESSAGES}" ]; then
> +                    cp -prfL -t "${initdir}/usr/lib/locale/" /usr/lib/locale/${LC_MESSAGES}
> +                fi
> +            fi
> +
> +            # Install individual localisation files for core packages
> +            [ -e /usr/share/locale/locale.alias ] && inst_simple /usr/share/locale/locale.alias
> +            [[ ${LC_ALL_LOCALE} ]] && inst_dir "/usr/share/locale/${LC_ALL_LOCALE}"
> +            [[ ${LANG_LOCALE} ]] && inst_dir "/usr/share/locale/${LANG_LOCALE}"
> +            [[ ${LC_MESSAGES_LOCALE} ]] && inst_dir "/usr/share/locale/${LC_MESSAGES_LOCALE}"
> +            [[ ${LC_ALL_LOCALE} ]] && read LC_ALL_LOCALE_SHORT LC_ALL_LOCALE_COUNTRY < <(echo ${LC_ALL_LOCALE//_/ })
> +            [[ ${LANG_LOCALE} ]] && read LANG_LOCALE_SHORT LANG_LOCALE_COUNTRY < <(echo ${LANG_LOCALE//_/ })
> +            [[ ${LC_MESSAGES_LOCALE} ]] && read LC_MESSAGES_LOCALE_SHORT LC_MESSAGES_LOCALE_COUNTRY < <(echo ${LC_MESSAGES_LOCALE//_/ })
> +            [[ ${LC_ALL_LOCALE_SHORT} ]] && inst_dir "/usr/share/locale/${LC_ALL_LOCALE_SHORT}"
> +            [[ ${LANG_LOCALE_SHORT} ]] && inst_dir "/usr/share/locale/${LANG_LOCALE_SHORT}"
> +            [[ ${LC_MESSAGES_LOCALE_SHORT} ]] && inst_dir "/usr/share/locale/${LC_MESSAGES_LOCALE_SHORT}"
> +
> +            locale_dirs="${LC_ALL_LOCALE} ${LANG_LOCALE} ${LC_MESSAGES_LOCALE} ${LC_ALL_LOCALE_SHORT} ${LANG_LOCALE_SHORT} {LC_MESSAGES_LOCALE_SHORT}"
> +            for dir in ${locale_dirs}; do
> +                [ -d "/usr/share/locale/${dir}" ] && for pkg in ${CORE_PACKAGES}; do
> +                    for file in `find "/usr/share/locale/${dir}" -type f -name "${pkg}.mo"`; do
> +                        inst_simple "${file}"
> +                    done
> +                done
> +            done
> +
> +            # Install ISO-8859 and Unicode charmap modules from GNU libc
> +            if [ -e "${initdir}/lib/ld-linux.so.*" ]; then
> +                LIBDIR=lib
> +            else
> +                LIBDIR=lib64
> +            fi
> +            inst_multiple /usr/${LIBDIR}/gconv/ISO8859-*.so
> +            if [ ${UNICODE} == 1 ]; then
> +                inst_multiple /usr/${LIBDIR}/gconv/UTF-*.so /usr/${LIBDIR}/gconv/UNICODE.so
> +            fi
> +            if command -v iconvconfig > /dev/null; then
> +                if [ -e /usr/${LIBDIR}/gconv/gconv-modules ]; then
> +                    grep -E "^[[:space:]]*alias[[:space:]]*ISO[-]*8859-" /usr/${LIBDIR}/gconv/gconv-modules > /tmp/gconv-modules
> +                    if [ ${UNICODE} == 1 ]; then
> +                        grep -E "^[[:space:]]*alias.*UTF-" /usr/${LIBDIR}/gconv/gconv-modules >> /tmp/gconv-modules
> +                        grep -E "^[[:space:]]*alias.*UNICODE" /usr/${LIBDIR}/gconv/gconv-modules >> /tmp/gconv-modules
> +                    fi
> +                    grep -E "^[[:space:]]*module[[:space:]]*ISO[-]*8859-" /usr/${LIBDIR}/gconv/gconv-modules | grep INTERNAL >> /tmp/gconv-modules
> +                    if [ ${UNICODE} == 1 ]; then
> +                        grep -E "^[[:space:]]*module[[:space:]]*UTF-" /usr/${LIBDIR}/gconv/gconv-modules | grep INTERNAL >> /tmp/gconv-modules
> +                        grep -E "^[[:space:]]*module[[:space:]]*UNICODE" /usr/${LIBDIR}/gconv/gconv-modules | grep INTERNAL >> /tmp/gconv-modules
> +                    fi
> +                    if [ -e /tmp/gconv-modules ]; then
> +                        inst /tmp/gconv-modules /usr/${LIBDIR}/gconv/gconv-modules && rm -f /tmp/gconv-modules
> +                    fi
> +                fi
> +                iconvconfig --prefix="${initdir}"
> +            else
> +                if [ -e /usr/${LIBDIR}/gconv/gconv-modules.cache ]; then
> +                    inst_simple /usr/${LIBDIR}/gconv/gconv-modules.cache
> +                fi
> +            fi
> +        fi
> +
>          if dracut_module_included "systemd" && [[ -f ${I18N_CONF} ]]; then
>              inst_simple ${I18N_CONF}
>          else
>              mksubdirs ${initdir}${I18N_CONF}
> -            print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
> +            print_vars LANG LC_ALL LC_MESSAGES >> ${initdir}${I18N_CONF}
>          fi
>  
>          if dracut_module_included "systemd" && [[ -f ${VCONFIG_CONF} ]]; then
> diff -pruN dracut-git-orig/modules.d/10i18n/parse-i18n.sh dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/parse-i18n.sh
> --- dracut-git-orig/modules.d/10i18n/parse-i18n.sh	2016-04-20 14:11:02.825944933 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/parse-i18n.sh	2016-04-19 02:26:46.617644187 +0200
> @@ -23,11 +23,13 @@ inst_key_val /etc/vconsole.conf FONT_UNI
>  inst_key_val /etc/vconsole.conf UNICODE      1 rd.vconsole.font.unicode UNICODE vconsole.unicode
>  inst_key_val /etc/vconsole.conf EXT_KEYMAP  '' rd.vconsole.keymap.ext   EXT_KEYMAP
>  
> -inst_key_val /etc/locale.conf   LANG        '' rd.locale.LANG           LANG
> -inst_key_val /etc/locale.conf   LC_ALL      '' rd.locale.LC_ALL         LC_ALL
> -
> +inst_key_val /etc/locale.conf   LANG              '' rd.locale.LANG               LANG
> +inst_key_val /etc/locale.conf   LC_ALL            '' rd.locale.LC_ALL             LC_ALL
> +inst_key_val /etc/locale.conf   LC_MESSAGES       '' rd.locale.LC_MESSAGES        LC_MESSAGES
> + 
>  if [ -f /etc/locale.conf ]; then
>      . /etc/locale.conf
>      export LANG
>      export LC_ALL
> +    export LC_MESSAGES
>  fi
> diff -pruN dracut-git-orig/modules.d/10i18n/README dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/README
> --- dracut-git-orig/modules.d/10i18n/README	2016-04-20 14:11:02.826944946 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/10i18n/README	2016-04-19 02:26:46.617644187 +0200
> @@ -65,6 +65,7 @@ I'm leaving it in case...  The following
>  
>      LANG
>      LC_ALL
> +    LC_MESSAGES
>  
>  If UNICODE variable is not provided, script indicates if UTF-8 should be
>  used on the basis of LANG value (if it ends with ".utf8" or similar).
> diff -pruN dracut-git-orig/modules.d/90crypt/module-setup.sh dracut-git-10i18n-full-support-for-localisation/modules.d/90crypt/module-setup.sh
> --- dracut-git-orig/modules.d/90crypt/module-setup.sh	2016-04-19 02:19:10.662042554 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/90crypt/module-setup.sh	2016-04-23 17:09:50.584472072 +0200
> @@ -88,6 +88,12 @@ install() {
>  
>      inst_simple "$moddir/crypt-lib.sh" "/lib/dracut-crypt-lib.sh"
>  
> +    if dracut_module_included "i18n"; then
> +        if [[ $msg_localisation == "yes" ]]; then
> +            inst_i18n cryptsetup
> +        fi
> +    fi
> +
>      if dracut_module_included "systemd"; then
>          inst_multiple -o \
>                        $systemdutildir/system-generators/systemd-cryptsetup-generator \
> diff -pruN dracut-git-orig/modules.d/91crypt-gpg/module-setup.sh dracut-git-10i18n-full-support-for-localisation/modules.d/91crypt-gpg/module-setup.sh
> --- dracut-git-orig/modules.d/91crypt-gpg/module-setup.sh	2016-04-19 02:19:10.667042618 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/91crypt-gpg/module-setup.sh	2016-04-23 17:10:10.783667188 +0200
> @@ -17,4 +17,10 @@ depends() {
>  install() {
>      inst_multiple gpg
>      inst "$moddir/crypt-gpg-lib.sh" "/lib/dracut-crypt-gpg-lib.sh"
> +
> +    if dracut_module_included "i18n"; then
> +        if [[ $msg_localisation == "yes" ]]; then
> +            inst_i18n gnupg
> +        fi
> +    fi
>  }
> diff -pruN dracut-git-orig/modules.d/99base/init.sh dracut-git-10i18n-full-support-for-localisation/modules.d/99base/init.sh
> --- dracut-git-orig/modules.d/99base/init.sh	2016-04-20 14:11:02.826944946 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/99base/init.sh	2016-04-20 14:02:01.578137511 +0200
> @@ -8,6 +8,8 @@
>  
>  export -p > /tmp/export.orig
>  
> +[ -f /etc/locale.conf ] && . /etc/locale.conf
> +
>  NEWROOT="/sysroot"
>  [ -d $NEWROOT ] || mkdir -p -m 0755 $NEWROOT
>  
> @@ -323,7 +325,7 @@ for i in $(export -p); do
>      i=${i%%=*}
>      [ -z "$i" ] && continue
>      case $i in
> -        root|PATH|HOME|TERM|PS4|RD_*)
> +        root|PATH|HOME|TERM|PS4|RD_*|LANG|LC_*)
>              :;;
>          *)
>              unset "$i";;
> diff -pruN dracut-git-orig/modules.d/99base/module-setup.sh dracut-git-10i18n-full-support-for-localisation/modules.d/99base/module-setup.sh
> --- dracut-git-orig/modules.d/99base/module-setup.sh	2016-04-20 14:11:02.827944958 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/99base/module-setup.sh	2016-04-21 20:01:54.611592039 +0200
> @@ -26,6 +26,10 @@ install() {
>          (ln -s bash "${initdir}/bin/sh" || :)
>      fi
>  
> +    if dracut_module_included "i18n"; then
> +       inst ${moddir}/profile /etc/profile
> +    fi
> +
>      #add common users in /etc/passwd, it will be used by nfs/ssh currently
>      grep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/root:/bin/sh' >> "$initdir/etc/passwd"
>      grep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
> diff -pruN dracut-git-orig/modules.d/99base/profile dracut-git-10i18n-full-support-for-localisation/modules.d/99base/profile
> --- dracut-git-orig/modules.d/99base/profile	1970-01-01 01:00:00.000000000 +0100
> +++ dracut-git-10i18n-full-support-for-localisation/modules.d/99base/profile	2016-04-21 23:43:08.049029619 +0200
> @@ -0,0 +1,9 @@
> +# /etc/profile
> +
> +# Load locale settings
> +if [ -f /etc/locale.conf ]; then
> +  . /etc/locale.conf
> +  [ -n "${LANG}" ] && export LANG || unset LANG
> +  [ -n "${LC_ALL}" ] && export LC_ALL || unset LC_ALL
> +  [ -n "${LC_MESSAGES}" ] && export LC_MESSAGES || unset LC_MESSAGES
> +fi
> diff -pruN dracut-git-orig/NEWS dracut-git-10i18n-full-support-for-localisation/NEWS
> --- dracut-git-orig/NEWS	2016-04-19 02:19:10.648042373 +0200
> +++ dracut-git-10i18n-full-support-for-localisation/NEWS	2016-04-21 17:00:46.436792093 +0200
> @@ -6,6 +6,7 @@ dracut now requires libkmod for the drac
>  dracut.sh:
>  - restorecon final image file
>  - fail hard, if we find modules and modules.dep is missing
> +- add an option to disable the new full localisation support
>  
>  dracut-functions.sh:
>  - fix check_vol_slaves() volume group name stripping
> @@ -34,6 +35,9 @@ general initramfs fixes:
>  - call dracut-cmdline-ask.service, if /etc/cmdline.d/*.conf exists
>  - break at switch_root only for bare rd.break
>  
> +i18n:
> +- add full localisation support (includes message-based localisation)
> +
>  dmsquash-live:
>  - fixed livenet-generator execution flag
>    and include only, if systemd is used
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
