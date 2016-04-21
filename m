From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH v7] dracut: add support for custom locale definitions
Date: Thu, 21 Apr 2016 14:30:41 +0200
Message-ID: <1461241841.10934.12.camel@trentalancia.net>
References: <1460758050.3211.2.camel@trentalancia.net>
	 <5711D4E7.9070705@gmail.com> <1460815966.4296.13.camel@trentalancia.net>
	 <57127BC9.70103@gmail.com> <1460835143.3201.10.camel@trentalancia.net>
	 <1460837622.3201.14.camel@trentalancia.net>
	 <1460838269.3201.18.camel@trentalancia.net>
	 <1461026208.2262.1.camel@trentalancia.net>
	 <1461157491.11229.3.camel@trentalancia.net> <5718AA77.8090600@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5718AA77.8090600-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello Harald !

On Thu, 21/04/2016 Guido Trentalancia wrote:
> > Compile and install locale definitions using localedef from GNU
> > libc or,
> > if locale definitions cannot be compiled but are available on the
> > system
> > as split definitions, just install them.
> >=20
> > The resulting locale definitions archive contains at most two
> > different
> > locale definitions, therefore its size is relatively small.
> >=20
> > Add support for localised messages from core packages
> > (LC_MESSAGES).
>=20
> Do we really need this in the initramfs?

It's a killer functionality !!! And it requires very little extra disk
space compared to the actual initramfs. You know, we tend not to use
the floppy disk anymore nowadays !...

If you agree with me, I will be glad to keep working on it so that the
change you propose are introduced. There are not few changes proposed
and they need testing, I will only carry them out if you are then
really going to commit the whole work.

Please confirm and I'll be glad to help.

Regards,

Guido

> > Add support for non-latin fonts using Unicode (tested successfully
> > with
> > Greek, Hebrew and Cyrillic).
> >=20
> > This revised version fixes several issues in the initial patch
> > (including
> > the possibility to build locale definitions). Thanks to Andrei
> > Borzenkov
> > for reviewing the initial patch and providing useful suggestions.
> >=20
> > Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> > ---
> > =C2=A0modules.d/10i18n/README=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A01
> > =C2=A0modules.d/10i18n/console_init.sh |=C2=A0=C2=A0=C2=A024 ++++++=
+++++
> > =C2=A0modules.d/10i18n/module-setup.sh |=C2=A0=C2=A0=C2=A082
> > +++++++++++++++++++++++++++++++++++++--
> > =C2=A0modules.d/10i18n/parse-i18n.sh=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=
=C2=A0=C2=A08 ++-
> > =C2=A0modules.d/99base/bashrc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A09 ++++
> > =C2=A0modules.d/99base/init.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A04 +
> > =C2=A0modules.d/99base/module-setup.sh |=C2=A0=C2=A0=C2=A0=C2=A04 +
> > =C2=A07 files changed, 125 insertions(+), 7 deletions(-)
> >=20
> > diff -pruN dracut-git-orig/modules.d/10i18n/console_init.sh dracut-
> > git-10i18n-add-support-for-custom-locale-
> > definitions/modules.d/10i18n/console_init.sh
> > --- dracut-git-orig/modules.d/10i18n/console_init.sh	2016-
> > 04-20 14:11:02.824944921 +0200
> > +++ dracut-git-10i18n-add-support-for-custom-locale-
> > definitions/modules.d/10i18n/console_init.sh	2016-04-20
> > 14:01:51.452010155 +0200
> > @@ -74,6 +74,28 @@ devname=3D${dev#/dev/}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exit 1
> > =C2=A0}
> > =C2=A0
> > +shopt -q -s nocasematch
> > +if [[ ${UNICODE} ]]
> > +then
> > +=C2=A0=C2=A0=C2=A0=C2=A0if [[ ${UNICODE} =3D YES || ${UNICODE} =3D=
 1 ]]
> > +=C2=A0=C2=A0=C2=A0=C2=A0then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UNICODE=3D1
> > +=C2=A0=C2=A0=C2=A0=C2=A0elif [[ ${UNICODE} =3D NO || ${UNICODE} =3D=
 0 ]]
> > +=C2=A0=C2=A0=C2=A0=C2=A0then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UNICODE=3D0
> > +=C2=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UNICODE=3D''
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +fi
> > +if [[ ! ${UNICODE} && ${LANG} =3D~ .*\.UTF-?8 ]]
> > +then
> > +=C2=A0=C2=A0=C2=A0=C2=A0UNICODE=3D1
> > +fi
> > +shopt -q -u nocasematch
> > +
> > +[[ ${UNICODE} =3D=3D 1 && ${FONT} && ! ${FONT_MAP} ]] && [ -x
> > /usr/bin/unicode_start ] && /usr/bin/unicode_start ${FONT}
> > +[[ ${UNICODE} =3D=3D 1 && ${FONT} && ${FONT_MAP} ]] && [ -x
> > /usr/bin/unicode_start ] && /usr/bin/unicode_start ${FONT}
> > ${FONT_MAP}
> > +
> > =C2=A0dev_open ${dev}
> > =C2=A0
> > =C2=A0for fd in 6 7; do
> > @@ -89,5 +111,7 @@ set_terminal ${dev}
> > =C2=A0set_font ${dev}
> > =C2=A0set_keymap
> > =C2=A0
> > +reset
> > +
> > =C2=A0dev_close
>=20
> Please don't use bashisms in initramfs scripts which are not
> explicitly marked with "#!/bin/bash".
> To test it:
> - install "dash"
> - run "make syncheck"
> - activate the "00dash" dracut module and boot with it
>=20
> > =C2=A0
> > diff -pruN dracut-git-orig/modules.d/10i18n/module-setup.sh dracut-
> > git-10i18n-add-support-for-custom-locale-
> > definitions/modules.d/10i18n/module-setup.sh
> > --- dracut-git-orig/modules.d/10i18n/module-setup.sh	2016-
> > 04-20 14:11:02.825944933 +0200
> > +++ dracut-git-10i18n-add-support-for-custom-locale-
> > definitions/modules.d/10i18n/module-setup.sh	2016-04-20
> > 14:44:39.610119250 +0200
> > @@ -1,10 +1,15 @@
> > =C2=A0#!/bin/bash
> > =C2=A0
> > +# Updated: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> > +#
> > +#=C2=A0=C2=A0Added full localisation support (including message-ba=
sed
> > +#=C2=A0=C2=A0program localisation and support for non-latin charse=
ts)
>=20
> git history should be enough, we don't mention it in the individual
> files
>=20
> > +
> > =C2=A0# called by dracut
> > =C2=A0check() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[[ "$mount_needs" ]] && return 1
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0require_binaries setfont loadkeys kbd_mode=
 || return 1
> > +=C2=A0=C2=A0=C2=A0=C2=A0require_binaries setfont loadkeys kbd_mode=
 unicode_start stty
> > tty tset reset || return 1
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0
> > =C2=A0}
> > @@ -26,6 +31,15 @@ install() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DEFAULT_FONT=3D"${i18n_default_font:-=
LatArCyrHeb-16}"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0I18N_CONF=3D"/etc/locale.conf"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VCONFIG_CONF=3D"/etc/vconsole.conf"
> > +=C2=A0=C2=A0=C2=A0=C2=A0LOCALISED_PACKAGES=3D"libc bash coreutils =
util-linux e2fsprogs
> > grep sed kbd cryptsetup"
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0if dracut_module_included "crypt"; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LOCALISED_PACKAGES=3D"${=
LOCALISED_PACKAGES} cryptsetup"
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0if dracut_module_included "crypt-gpg"; the=
n
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LOCALISED_PACKAGES=3D"${=
LOCALISED_PACKAGES} gnupg"
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
>=20
> I would create a function like "inst_i18n <prog>" which should be
> called by the individual dracut modules in their install()
> section, rather than hardcoding it here.
>=20
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# This is from 10redhat-i18n.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0findkeymap () {
> > @@ -93,7 +107,7 @@ install() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install_base() {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_multiple setf=
ont loadkeys kbd_mode stty
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_multiple setf=
ont loadkeys kbd_mode unicode_start stty
> > tty tset reset
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ! dracut_m=
odule_included "systemd"; then
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0inst ${moddir}/console_init.sh /lib/udev/console_init
> > @@ -205,11 +219,73 @@ install() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0inst_simple ${kbddir}/unimaps/${FONT_UNIMAP}.uni
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[[ ${LC_ALL} || ${=
LANG} || ${LC_MESSAGES} ]] && inst_dir
> > /usr/lib/locale
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Check if we can =
compile locale definitions
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0command -v localed=
ef > /dev/null && HAS_LOCALEDEF=3Dtrue ||
> > HAS_LOCALEDEF=3Dfalse
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LC_ALL} ] && L=
C_ALL_LOCALE=3D`echo ${LC_ALL} | awk -F.
> > '{ print $1 }'` && LC_ALL_CHARMAP=3D`echo ${LC_ALL} | awk -F. '{
> > print $2 }'`
>=20
> awk free version :)
>=20
> $ read LC_ALL_LOCALE LC_ALL_CHARMAP < <(echo ${LC_ALL//./ }); echo
> $LC_ALL_LOCALE; echo $LC_ALL_CHARMAP
> de_DE
> UTF-8
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LANG} ] && LAN=
G_LOCALE=3D`echo ${LANG} | awk -F. '{
> > print $1 }'` && LANG_CHARMAP=3D`echo ${LANG} | awk -F. '{ print $2
> > }'`
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LC_MESSAGES} ]=
 && LC_MESSAGES_LOCALE=3D`echo
> > ${LC_MESSAGES} | awk -F. '{ print $1 }'` &&
> > LC_MESSAGES_CHARMAP=3D`echo ${LC_MESSAGES} | awk -F. '{ print $2 }'=
`
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[[ -e /usr/share/i=
18n/locales/${LC_ALL_LOCALE} || -e
> > /usr/share/i18n/locales/${LANG_LOCALE} || -e
> > /usr/share/i18n/locales/${LC_MESSAGES_LOCALE} ]] &&
> > HAS_LOCALE_SOURCES=3Dtrue || HAS_LOCALE_SOURCES=3Dfalse
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[[ ${HAS_LOCALEDEF=
} =3D=3D true && ${HAS_LOCALE_SOURCES} =3D=3D
> > true ]] && CAN_BUILD_LOCALE=3Dtrue || CAN_BUILD_LOCALE=3Dfalse
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Generate locale =
definitions for LC_ALL
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[[ ${LC_ALL} && ${=
LC_ALL_LOCALE} && ${LC_ALL_CHARMAP} ]]
> > && [ ${CAN_BUILD_LOCALE} =3D=3D true ] && [ -e
> > /usr/share/i18n/locales/${LC_ALL_LOCALE} ] && localedef --
> > prefix=3D"${initdir}" -i ${LC_ALL_LOCALE} -f ${LC_ALL_CHARMAP}
> > ${LC_ALL}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Generate locale =
definitions for LANG
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[[ ${LANG} && ${LA=
NG_LOCALE} && ${LANG_CHARMAP} ]] && [
> > ${CAN_BUILD_LOCALE} =3D=3D true ] && [ -e
> > /usr/share/i18n/locales/${LANG_LOCALE} ] && localedef --
> > prefix=3D"${initdir}" -i ${LANG_LOCALE} -f ${LANG_CHARMAP} ${LANG}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Generate locale =
definitions for LC_MESSAGES
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[[ ${LC_MESSAGES} =
&& ${LC_MESSAGES_LOCALE} &&
> > ${LC_MESSAGES_CHARMAP} ]] && [ ${CAN_BUILD_LOCALE} =3D=3D true ] &&=
 [
> > -e /usr/share/i18n/locales/${LC_MESSAGES_LOCALE} ] && localedef --
> > prefix=3D"${initdir}" -i ${LC_MESSAGES_LOCALE} -f
> > ${LC_MESSAGES_CHARMAP} ${LC_MESSAGES}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# If locale defini=
tions cannot be built, but compiled
> > split definitions are
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# available, then =
install them
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LC_ALL} ] && [=
 ${CAN_BUILD_LOCALE} =3D=3D false ] && [ -d
> > /usr/lib/locale/${LC_ALL} ] && cp -prfL -t
> > "${initdir}/usr/lib/locale/" /usr/lib/locale/${LC_ALL}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LANG} ] && [ $=
{CAN_BUILD_LOCALE} =3D=3D false ] && [ -d
> > /usr/lib/locale/${LANG} ] && cp -prfL -t
> > "${initdir}/usr/lib/locale/" /usr/lib/locale/${LANG}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LC_MESSAGES} ]=
 && [ ${CAN_BUILD_LOCALE} =3D=3D false ] &&
> > [ -d /usr/lib/locale/${LC_MESSAGES} ] && cp -prfL -t
> > "${initdir}/usr/lib/locale/" /usr/lib/locale/${LC_MESSAGES}
>=20
> you really don't like "if ; then; else" :)
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Install individu=
al localisation files for core packages
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ -e /usr/share/lo=
cale/locale.alias ] && inst_simple
> > /usr/share/locale/locale.alias
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LC_ALL_LOCALE}=
 ] && inst_dir
> > /usr/share/locale/${LC_ALL_LOCALE}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LANG_LOCALE} ]=
 && inst_dir
> > /usr/share/locale/${LANG_LOCALE}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LC_MESSAGES_LO=
CALE} ] && inst_dir
> > /usr/share/locale/${LC_MESSAGES_LOCALE}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LC_ALL_LOCALE}=
 ] && LC_ALL_LOCALE_SHORT=3D`echo
> > ${LC_ALL_LOCALE} | awk -F_ '{ print $1 }'`
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LANG_LOCALE} ]=
 && LANG_LOCALE_SHORT=3D`echo
> > ${LANG_LOCALE} | awk -F_ '{ print $1 }'`
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LC_MESSAGES_LO=
CALE} ] &&
> > LC_MESSAGES_LOCALE_SHORT=3D`echo ${LC_MESSAGES_LOCALE} | awk -F_ '{
> > print $1 }'`
>=20
> please don't use backticks... use $() every time
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LC_ALL_LOCALE_=
SHORT} ] && inst_dir
> > /usr/share/locale/${LC_ALL_LOCALE_SHORT}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LANG_LOCALE_SH=
ORT} ] && inst_dir
> > /usr/share/locale/${LANG_LOCALE_SHORT}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${LC_MESSAGES_LO=
CALE_SHORT} ] && inst_dir
> > /usr/share/locale/${LC_MESSAGES_LOCALE_SHORT}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0locale_dirs=3D"${L=
C_ALL_LOCALE} ${LANG_LOCALE}
> > ${LC_MESSAGES_LOCALE} ${LC_ALL_LOCALE_SHORT} ${LANG_LOCALE_SHORT}
> > {LC_MESSAGES_LOCALE_SHORT}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for dir in ${local=
e_dirs}; do
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0[ -d /usr/share/locale/${dir} ] && for pkg in
> > ${LOCALISED_PACKAGES}; do
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for file in `find /usr/share/locale/${dir=
} -type f
> > -name "${pkg}.mo"`; do
>=20
> not expected, but this fails for files with spaces in the name
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cp -pfL --parents=
 -t "${initdir}/" ${file};
>=20
> what's wrong with "inst_simple" ?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0done
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0done
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0done
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Install some of =
the GNU libc charmap modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ -e "${initdir}/l=
ib/ld-linux.so.*" ] && LIBDIR=3Dlib ||
> > LIBDIR=3Dlib64
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst_simple /usr/$=
{LIBDIR}/gconv/ISO8859-*.so
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${UNICODE} =3D=3D=
 1 ] && inst_multiple
> > /usr/${LIBDIR}/gconv/UTF-*.so
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${UNICODE} =3D=3D=
 1 ] && inst_simple
> > /usr/${LIBDIR}/gconv/UNICODE.so
>=20
> inst_simple would not install any library deps. better add it to the
> above line
> [ ${UNICODE} =3D=3D 1 ] && inst_multiple /usr/${LIBDIR}/gconv/UNICODE=
=2Eso
> /usr/${LIBDIR}/gconv/UTF-*.so
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0command -v iconvco=
nfig > /dev/null && HAS_ICONVCONFIG=3Dtrue
> > || HAS_ICONVCONFIG=3Dfalse
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${HAS_ICONVCONFI=
G} =3D=3D true ] && [ -e
> > /usr/${LIBDIR}/gconv/gconv-modules ] && cat
> > /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*alias" | grep
> > ISO8859- > /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${HAS_ICONVCONFI=
G} =3D=3D true ] && [ ${UNICODE} =3D=3D 1 ] && [
> > -e /usr/${LIBDIR}/gconv/gconv-modules ] && cat
> > /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*alias" | grep
> > UTF- >> /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${HAS_ICONVCONFI=
G} =3D=3D true ] && [ ${UNICODE} =3D=3D 1 ] && [
> > -e /usr/${LIBDIR}/gconv/gconv-modules ] && cat
> > /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*alias" | grep
> > UNICODE >> /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${HAS_ICONVCONFI=
G} =3D=3D true ] && [ -e
> > /usr/${LIBDIR}/gconv/gconv-modules ] && cat
> > /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*module" | grep
> > ISO8859- | grep INTERNAL >> /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${HAS_ICONVCONFI=
G} =3D=3D true ] && [ ${UNICODE} =3D=3D 1 ] && [
> > -e /usr/${LIBDIR}/gconv/gconv-modules ] && cat
> > /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*module" | grep
> > UTF- | grep INTERNAL >> /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${HAS_ICONVCONFI=
G} =3D=3D true ] && [ ${UNICODE} =3D=3D 1 ] && [
> > -e /usr/${LIBDIR}/gconv/gconv-modules ] && cat
> > /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*module" | grep
> > UNICODE | grep INTERNAL >> /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${HAS_ICONVCONFI=
G} =3D=3D true ] && [ -e /tmp/gconv-modules
> > ] && inst /tmp/gconv-modules /usr/${LIBDIR}/gconv/gconv-modules &&
> > rm -f /tmp/gconv-modules
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${HAS_ICONVCONFI=
G} =3D=3D true ] && iconvconfig --
> > prefix=3D"${initdir}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ ${HAS_ICONVCONFI=
G} =3D=3D false ] && [ -e
> > /usr/${LIBDIR}/gconv/gconv-modules.cache ] && inst_simple
> > /usr/${LIBDIR}/gconv/gconv-modules.cache
>=20
> why no "if command -v iconvconfig >/dev/null; then ... else ... fi"
> ??
>=20
> no need for " cat <file> | grep <pattern> " use "grep <pattern>
> <file>" directly
>=20
> why grep | grep ?? why not:
>=20
> grep -E "^[[:space:]]*alias.*ISO8859-" /usr/${LIBDIR}/gconv/gconv-
> modules
>=20
>=20
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if dracut_mod=
ule_included "systemd" && [[ -f ${I18N_CONF}
> > ]]; then
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0inst_simple ${I18N_CONF}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0mksubdirs ${initdir}${I18N_CONF}
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0print_vars LANG LC_ALL LC_MESSAGES >>
> > ${initdir}${I18N_CONF}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if dracut_mod=
ule_included "systemd" && [[ -f
> > ${VCONFIG_CONF} ]]; then
> > diff -pruN dracut-git-orig/modules.d/10i18n/parse-i18n.sh dracut-
> > git-10i18n-add-support-for-custom-locale-
> > definitions/modules.d/10i18n/parse-i18n.sh
> > --- dracut-git-orig/modules.d/10i18n/parse-i18n.sh	2016-04-
> > 20 14:11:02.825944933 +0200
> > +++ dracut-git-10i18n-add-support-for-custom-locale-
> > definitions/modules.d/10i18n/parse-i18n.sh	2016-04-19
> > 02:26:46.617644187 +0200
> > @@ -23,11 +23,13 @@ inst_key_val /etc/vconsole.conf FONT_UNI
> > =C2=A0inst_key_val /etc/vconsole.conf UNICODE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A01
> > rd.vconsole.font.unicode UNICODE vconsole.unicode
> > =C2=A0inst_key_val /etc/vconsole.conf EXT_KEYMAP=C2=A0=C2=A0''
> > rd.vconsole.keymap.ext=C2=A0=C2=A0=C2=A0EXT_KEYMAP
> > =C2=A0
> > -inst_key_val /etc/locale.conf=C2=A0=C2=A0=C2=A0LANG=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0''
> > rd.locale.LANG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0LANG
> > -inst_key_val /etc/locale.conf=C2=A0=C2=A0=C2=A0LC_ALL=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0''
> > rd.locale.LC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0LC_ALL
> > -
> > +inst_key_val /etc/locale.conf=C2=A0=C2=A0=C2=A0LANG=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0''
> > rd.locale.LANG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LANG
> > +inst_key_val /etc/locale.conf=C2=A0=C2=A0=C2=A0LC_ALL=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0''
> > rd.locale.LC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0LC_ALL
> > +inst_key_val /etc/locale.conf=C2=A0=C2=A0=C2=A0LC_MESSAGES=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0''
> > rd.locale.LC_MESSAGES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
LC_MESSAGES
> > +=C2=A0
> > =C2=A0if [ -f /etc/locale.conf ]; then
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0. /etc/locale.conf
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0export LANG
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0export LC_ALL
> > +=C2=A0=C2=A0=C2=A0=C2=A0export LC_MESSAGES
> > =C2=A0fi
> > diff -pruN dracut-git-orig/modules.d/10i18n/README dracut-git-
> > 10i18n-add-support-for-custom-locale-
> > definitions/modules.d/10i18n/README
> > --- dracut-git-orig/modules.d/10i18n/README	2016-04-20
> > 14:11:02.826944946 +0200
> > +++ dracut-git-10i18n-add-support-for-custom-locale-
> > definitions/modules.d/10i18n/README	2016-04-19
> > 02:26:46.617644187 +0200
> > @@ -65,6 +65,7 @@ I'm leaving it in case...=C2=A0=C2=A0The followin=
g
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LANG
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LC_ALL
> > +=C2=A0=C2=A0=C2=A0=C2=A0LC_MESSAGES
> > =C2=A0
> > =C2=A0If UNICODE variable is not provided, script indicates if UTF-=
8
> > should be
> > =C2=A0used on the basis of LANG value (if it ends with ".utf8" or
> > similar).
> > diff -pruN dracut-git-orig/modules.d/99base/bashrc dracut-git-
> > 10i18n-add-support-for-custom-locale-
> > definitions/modules.d/99base/bashrc
> > --- dracut-git-orig/modules.d/99base/bashrc	1970-01-01
> > 01:00:00.000000000 +0100
> > +++ dracut-git-10i18n-add-support-for-custom-locale-
> > definitions/modules.d/99base/bashrc	2016-04-20
> > 14:22:39.804711030 +0200
> > @@ -0,0 +1,9 @@
> > +# /etc/bashrc
> > +
> > +# Load locale settings
> > +if [ -f /etc/locale.conf ]; then
> > +=C2=A0=C2=A0. /etc/locale.conf
> > +=C2=A0=C2=A0[ -n "${LANG}" ] && export LANG || unset LANG
> > +=C2=A0=C2=A0[ -n "${LC_ALL}" ] && export LC_ALL || unset LC_ALL
> > +=C2=A0=C2=A0[ -n "${LC_MESSAGES}" ] && export LC_MESSAGES || unset
> > LC_MESSAGES
> > +fi
> > diff -pruN dracut-git-orig/modules.d/99base/init.sh dracut-git-
> > 10i18n-add-support-for-custom-locale-
> > definitions/modules.d/99base/init.sh
> > --- dracut-git-orig/modules.d/99base/init.sh	2016-04-20
> > 14:11:02.826944946 +0200
> > +++ dracut-git-10i18n-add-support-for-custom-locale-
> > definitions/modules.d/99base/init.sh	2016-04-20
> > 14:02:01.578137511 +0200
> > @@ -8,6 +8,8 @@
> > =C2=A0
> > =C2=A0export -p > /tmp/export.orig
> > =C2=A0
> > +[ -f /etc/locale.conf ] && . /etc/locale.conf
> > +
> > =C2=A0NEWROOT=3D"/sysroot"
> > =C2=A0[ -d $NEWROOT ] || mkdir -p -m 0755 $NEWROOT
> > =C2=A0
> > @@ -323,7 +325,7 @@ for i in $(export -p); do
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i=3D${i%%=3D*}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ -z "$i" ] && continue
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case $i in
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0root|PATH|HOME|TER=
M|PS4|RD_*)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0root|PATH|HOME|TER=
M|PS4|RD_*|LANG|LC_*)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0:;;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0unset "$i";;
> > diff -pruN dracut-git-orig/modules.d/99base/module-setup.sh dracut-
> > git-10i18n-add-support-for-custom-locale-
> > definitions/modules.d/99base/module-setup.sh
> > --- dracut-git-orig/modules.d/99base/module-setup.sh	2016-
> > 04-20 14:11:02.827944958 +0200
> > +++ dracut-git-10i18n-add-support-for-custom-locale-
> > definitions/modules.d/99base/module-setup.sh	2016-04-19
> > 02:26:46.619644212 +0200
> > @@ -26,6 +26,10 @@ install() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(ln -s bash "=
${initdir}/bin/sh" || :)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0if dracut_module_included "i18n"; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inst ${moddir}/bashrc /e=
tc/bashrc
> > +=C2=A0=C2=A0=C2=A0=C2=A0fi
> > +
>=20
> maybe only check if bash installed and maybe use /etc/profile to be
> shell agnostic
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#add common users in /etc/passwd, it =
will be used by nfs/ssh
> > currently
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grep '^root:' "$initdir/etc/passwd" 2=
>/dev/null ||
> > echo=C2=A0=C2=A0'root:x:0:0::/root:/bin/sh' >> "$initdir/etc/passwd=
"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grep '^nobody:' /etc/passwd >> "$init=
dir/etc/passwd"
> > --
--=20
This message contains confidential information intended only for the us=
e
of the addressee(s). If you are not the intended recipient, please
contact the sender by return e-mail and destroy all copies of the
original message.
