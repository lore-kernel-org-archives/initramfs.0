From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH v7] dracut: add support for custom locale definitions
Date: Wed, 20 Apr 2016 15:04:51 +0200
Message-ID: <1461157491.11229.3.camel@trentalancia.net>
References: <1460758050.3211.2.camel@trentalancia.net>
	 <5711D4E7.9070705@gmail.com> <1460815966.4296.13.camel@trentalancia.net>
	 <57127BC9.70103@gmail.com> <1460835143.3201.10.camel@trentalancia.net>
	 <1460837622.3201.14.camel@trentalancia.net>
	 <1460838269.3201.18.camel@trentalancia.net>
	 <1461026208.2262.1.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461026208.2262.1.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Compile and install locale definitions using localedef from GNU libc or,
if locale definitions cannot be compiled but are available on the system
as split definitions, just install them.

The resulting locale definitions archive contains at most two different
locale definitions, therefore its size is relatively small.

Add support for localised messages from core packages (LC_MESSAGES).

Add support for non-latin fonts using Unicode (tested successfully with
Greek, Hebrew and Cyrillic).

This revised version fixes several issues in the initial patch (including
the possibility to build locale definitions). Thanks to Andrei Borzenkov
for reviewing the initial patch and providing useful suggestions.

Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
---
 modules.d/10i18n/README          |    1
 modules.d/10i18n/console_init.sh |   24 +++++++++++
 modules.d/10i18n/module-setup.sh |   82 +++++++++++++++++++++++++++++++++++++--
 modules.d/10i18n/parse-i18n.sh   |    8 ++-
 modules.d/99base/bashrc          |    9 ++++
 modules.d/99base/init.sh         |    4 +
 modules.d/99base/module-setup.sh |    4 +
 7 files changed, 125 insertions(+), 7 deletions(-)

diff -pruN dracut-git-orig/modules.d/10i18n/console_init.sh dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/10i18n/console_init.sh
--- dracut-git-orig/modules.d/10i18n/console_init.sh	2016-04-20 14:11:02.824944921 +0200
+++ dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/10i18n/console_init.sh	2016-04-20 14:01:51.452010155 +0200
@@ -74,6 +74,28 @@ devname=${dev#/dev/}
     exit 1
 }
 
+shopt -q -s nocasematch
+if [[ ${UNICODE} ]]
+then
+    if [[ ${UNICODE} = YES || ${UNICODE} = 1 ]]
+    then
+        UNICODE=1
+    elif [[ ${UNICODE} = NO || ${UNICODE} = 0 ]]
+    then
+        UNICODE=0
+    else
+        UNICODE=''
+    fi
+fi
+if [[ ! ${UNICODE} && ${LANG} =~ .*\.UTF-?8 ]]
+then
+    UNICODE=1
+fi
+shopt -q -u nocasematch
+
+[[ ${UNICODE} == 1 && ${FONT} && ! ${FONT_MAP} ]] && [ -x /usr/bin/unicode_start ] && /usr/bin/unicode_start ${FONT}
+[[ ${UNICODE} == 1 && ${FONT} && ${FONT_MAP} ]] && [ -x /usr/bin/unicode_start ] && /usr/bin/unicode_start ${FONT} ${FONT_MAP}
+
 dev_open ${dev}
 
 for fd in 6 7; do
@@ -89,5 +111,7 @@ set_terminal ${dev}
 set_font ${dev}
 set_keymap
 
+reset
+
 dev_close
 
diff -pruN dracut-git-orig/modules.d/10i18n/module-setup.sh dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/10i18n/module-setup.sh
--- dracut-git-orig/modules.d/10i18n/module-setup.sh	2016-04-20 14:11:02.825944933 +0200
+++ dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/10i18n/module-setup.sh	2016-04-20 14:44:39.610119250 +0200
@@ -1,10 +1,15 @@
 #!/bin/bash
 
+# Updated: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
+#
+#  Added full localisation support (including message-based
+#  program localisation and support for non-latin charsets)
+
 # called by dracut
 check() {
     [[ "$mount_needs" ]] && return 1
 
-    require_binaries setfont loadkeys kbd_mode || return 1
+    require_binaries setfont loadkeys kbd_mode unicode_start stty tty tset reset || return 1
 
     return 0
 }
@@ -26,6 +31,15 @@ install() {
     DEFAULT_FONT="${i18n_default_font:-LatArCyrHeb-16}"
     I18N_CONF="/etc/locale.conf"
     VCONFIG_CONF="/etc/vconsole.conf"
+    LOCALISED_PACKAGES="libc bash coreutils util-linux e2fsprogs grep sed kbd cryptsetup"
+
+    if dracut_module_included "crypt"; then
+       LOCALISED_PACKAGES="${LOCALISED_PACKAGES} cryptsetup"
+    fi
+
+    if dracut_module_included "crypt-gpg"; then
+       LOCALISED_PACKAGES="${LOCALISED_PACKAGES} gnupg"
+    fi
 
     # This is from 10redhat-i18n.
     findkeymap () {
@@ -93,7 +107,7 @@ install() {
     }
 
     install_base() {
-        inst_multiple setfont loadkeys kbd_mode stty
+        inst_multiple setfont loadkeys kbd_mode unicode_start stty tty tset reset
 
         if ! dracut_module_included "systemd"; then
             inst ${moddir}/console_init.sh /lib/udev/console_init
@@ -205,11 +219,73 @@ install() {
             inst_simple ${kbddir}/unimaps/${FONT_UNIMAP}.uni
         fi
 
+        [[ ${LC_ALL} || ${LANG} || ${LC_MESSAGES} ]] && inst_dir /usr/lib/locale
+
+        # Check if we can compile locale definitions
+        command -v localedef > /dev/null && HAS_LOCALEDEF=true || HAS_LOCALEDEF=false
+        [ ${LC_ALL} ] && LC_ALL_LOCALE=`echo ${LC_ALL} | awk -F. '{ print $1 }'` && LC_ALL_CHARMAP=`echo ${LC_ALL} | awk -F. '{ print $2 }'`
+        [ ${LANG} ] && LANG_LOCALE=`echo ${LANG} | awk -F. '{ print $1 }'` && LANG_CHARMAP=`echo ${LANG} | awk -F. '{ print $2 }'`
+        [ ${LC_MESSAGES} ] && LC_MESSAGES_LOCALE=`echo ${LC_MESSAGES} | awk -F. '{ print $1 }'` && LC_MESSAGES_CHARMAP=`echo ${LC_MESSAGES} | awk -F. '{ print $2 }'`
+        [[ -e /usr/share/i18n/locales/${LC_ALL_LOCALE} || -e /usr/share/i18n/locales/${LANG_LOCALE} || -e /usr/share/i18n/locales/${LC_MESSAGES_LOCALE} ]] && HAS_LOCALE_SOURCES=true || HAS_LOCALE_SOURCES=false
+        [[ ${HAS_LOCALEDEF} == true && ${HAS_LOCALE_SOURCES} == true ]] && CAN_BUILD_LOCALE=true || CAN_BUILD_LOCALE=false
+
+        # Generate locale definitions for LC_ALL
+        [[ ${LC_ALL} && ${LC_ALL_LOCALE} && ${LC_ALL_CHARMAP} ]] && [ ${CAN_BUILD_LOCALE} == true ] && [ -e /usr/share/i18n/locales/${LC_ALL_LOCALE} ] && localedef --prefix="${initdir}" -i ${LC_ALL_LOCALE} -f ${LC_ALL_CHARMAP} ${LC_ALL}
+
+        # Generate locale definitions for LANG
+        [[ ${LANG} && ${LANG_LOCALE} && ${LANG_CHARMAP} ]] && [ ${CAN_BUILD_LOCALE} == true ] && [ -e /usr/share/i18n/locales/${LANG_LOCALE} ] && localedef --prefix="${initdir}" -i ${LANG_LOCALE} -f ${LANG_CHARMAP} ${LANG}
+
+        # Generate locale definitions for LC_MESSAGES
+        [[ ${LC_MESSAGES} && ${LC_MESSAGES_LOCALE} && ${LC_MESSAGES_CHARMAP} ]] && [ ${CAN_BUILD_LOCALE} == true ] && [ -e /usr/share/i18n/locales/${LC_MESSAGES_LOCALE} ] && localedef --prefix="${initdir}" -i ${LC_MESSAGES_LOCALE} -f ${LC_MESSAGES_CHARMAP} ${LC_MESSAGES}
+
+        # If locale definitions cannot be built, but compiled split definitions are
+        # available, then install them
+        [ ${LC_ALL} ] && [ ${CAN_BUILD_LOCALE} == false ] && [ -d /usr/lib/locale/${LC_ALL} ] && cp -prfL -t "${initdir}/usr/lib/locale/" /usr/lib/locale/${LC_ALL}
+        [ ${LANG} ] && [ ${CAN_BUILD_LOCALE} == false ] && [ -d /usr/lib/locale/${LANG} ] && cp -prfL -t "${initdir}/usr/lib/locale/" /usr/lib/locale/${LANG}
+        [ ${LC_MESSAGES} ] && [ ${CAN_BUILD_LOCALE} == false ] && [ -d /usr/lib/locale/${LC_MESSAGES} ] && cp -prfL -t "${initdir}/usr/lib/locale/" /usr/lib/locale/${LC_MESSAGES}
+
+        # Install individual localisation files for core packages
+        [ -e /usr/share/locale/locale.alias ] && inst_simple /usr/share/locale/locale.alias
+        [ ${LC_ALL_LOCALE} ] && inst_dir /usr/share/locale/${LC_ALL_LOCALE}
+        [ ${LANG_LOCALE} ] && inst_dir /usr/share/locale/${LANG_LOCALE}
+        [ ${LC_MESSAGES_LOCALE} ] && inst_dir /usr/share/locale/${LC_MESSAGES_LOCALE}
+        [ ${LC_ALL_LOCALE} ] && LC_ALL_LOCALE_SHORT=`echo ${LC_ALL_LOCALE} | awk -F_ '{ print $1 }'`
+        [ ${LANG_LOCALE} ] && LANG_LOCALE_SHORT=`echo ${LANG_LOCALE} | awk -F_ '{ print $1 }'`
+        [ ${LC_MESSAGES_LOCALE} ] && LC_MESSAGES_LOCALE_SHORT=`echo ${LC_MESSAGES_LOCALE} | awk -F_ '{ print $1 }'`
+        [ ${LC_ALL_LOCALE_SHORT} ] && inst_dir /usr/share/locale/${LC_ALL_LOCALE_SHORT}
+        [ ${LANG_LOCALE_SHORT} ] && inst_dir /usr/share/locale/${LANG_LOCALE_SHORT}
+        [ ${LC_MESSAGES_LOCALE_SHORT} ] && inst_dir /usr/share/locale/${LC_MESSAGES_LOCALE_SHORT}
+
+        locale_dirs="${LC_ALL_LOCALE} ${LANG_LOCALE} ${LC_MESSAGES_LOCALE} ${LC_ALL_LOCALE_SHORT} ${LANG_LOCALE_SHORT} {LC_MESSAGES_LOCALE_SHORT}"
+        for dir in ${locale_dirs}; do
+            [ -d /usr/share/locale/${dir} ] && for pkg in ${LOCALISED_PACKAGES}; do
+                for file in `find /usr/share/locale/${dir} -type f -name "${pkg}.mo"`; do
+                    cp -pfL --parents -t "${initdir}/" ${file};
+                done
+            done
+        done
+
+        # Install some of the GNU libc charmap modules
+        [ -e "${initdir}/lib/ld-linux.so.*" ] && LIBDIR=lib || LIBDIR=lib64
+        inst_simple /usr/${LIBDIR}/gconv/ISO8859-*.so
+        [ ${UNICODE} == 1 ] && inst_multiple /usr/${LIBDIR}/gconv/UTF-*.so
+        [ ${UNICODE} == 1 ] && inst_simple /usr/${LIBDIR}/gconv/UNICODE.so
+        command -v iconvconfig > /dev/null && HAS_ICONVCONFIG=true || HAS_ICONVCONFIG=false
+        [ ${HAS_ICONVCONFIG} == true ] && [ -e /usr/${LIBDIR}/gconv/gconv-modules ] && cat /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*alias" | grep ISO8859- > /tmp/gconv-modules
+        [ ${HAS_ICONVCONFIG} == true ] && [ ${UNICODE} == 1 ] && [ -e /usr/${LIBDIR}/gconv/gconv-modules ] && cat /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*alias" | grep UTF- >> /tmp/gconv-modules
+        [ ${HAS_ICONVCONFIG} == true ] && [ ${UNICODE} == 1 ] && [ -e /usr/${LIBDIR}/gconv/gconv-modules ] && cat /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*alias" | grep UNICODE >> /tmp/gconv-modules
+        [ ${HAS_ICONVCONFIG} == true ] && [ -e /usr/${LIBDIR}/gconv/gconv-modules ] && cat /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*module" | grep ISO8859- | grep INTERNAL >> /tmp/gconv-modules
+        [ ${HAS_ICONVCONFIG} == true ] && [ ${UNICODE} == 1 ] && [ -e /usr/${LIBDIR}/gconv/gconv-modules ] && cat /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*module" | grep UTF- | grep INTERNAL >> /tmp/gconv-modules
+        [ ${HAS_ICONVCONFIG} == true ] && [ ${UNICODE} == 1 ] && [ -e /usr/${LIBDIR}/gconv/gconv-modules ] && cat /usr/${LIBDIR}/gconv/gconv-modules | grep "^[\t\ ]*module" | grep UNICODE | grep INTERNAL >> /tmp/gconv-modules
+        [ ${HAS_ICONVCONFIG} == true ] && [ -e /tmp/gconv-modules ] && inst /tmp/gconv-modules /usr/${LIBDIR}/gconv/gconv-modules && rm -f /tmp/gconv-modules
+        [ ${HAS_ICONVCONFIG} == true ] && iconvconfig --prefix="${initdir}"
+        [ ${HAS_ICONVCONFIG} == false ] && [ -e /usr/${LIBDIR}/gconv/gconv-modules.cache ] && inst_simple /usr/${LIBDIR}/gconv/gconv-modules.cache
+
         if dracut_module_included "systemd" && [[ -f ${I18N_CONF} ]]; then
             inst_simple ${I18N_CONF}
         else
             mksubdirs ${initdir}${I18N_CONF}
-            print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
+            print_vars LANG LC_ALL LC_MESSAGES >> ${initdir}${I18N_CONF}
         fi
 
         if dracut_module_included "systemd" && [[ -f ${VCONFIG_CONF} ]]; then
diff -pruN dracut-git-orig/modules.d/10i18n/parse-i18n.sh dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/10i18n/parse-i18n.sh
--- dracut-git-orig/modules.d/10i18n/parse-i18n.sh	2016-04-20 14:11:02.825944933 +0200
+++ dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/10i18n/parse-i18n.sh	2016-04-19 02:26:46.617644187 +0200
@@ -23,11 +23,13 @@ inst_key_val /etc/vconsole.conf FONT_UNI
 inst_key_val /etc/vconsole.conf UNICODE      1 rd.vconsole.font.unicode UNICODE vconsole.unicode
 inst_key_val /etc/vconsole.conf EXT_KEYMAP  '' rd.vconsole.keymap.ext   EXT_KEYMAP
 
-inst_key_val /etc/locale.conf   LANG        '' rd.locale.LANG           LANG
-inst_key_val /etc/locale.conf   LC_ALL      '' rd.locale.LC_ALL         LC_ALL
-
+inst_key_val /etc/locale.conf   LANG              '' rd.locale.LANG               LANG
+inst_key_val /etc/locale.conf   LC_ALL            '' rd.locale.LC_ALL             LC_ALL
+inst_key_val /etc/locale.conf   LC_MESSAGES       '' rd.locale.LC_MESSAGES        LC_MESSAGES
+ 
 if [ -f /etc/locale.conf ]; then
     . /etc/locale.conf
     export LANG
     export LC_ALL
+    export LC_MESSAGES
 fi
diff -pruN dracut-git-orig/modules.d/10i18n/README dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/10i18n/README
--- dracut-git-orig/modules.d/10i18n/README	2016-04-20 14:11:02.826944946 +0200
+++ dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/10i18n/README	2016-04-19 02:26:46.617644187 +0200
@@ -65,6 +65,7 @@ I'm leaving it in case...  The following
 
     LANG
     LC_ALL
+    LC_MESSAGES
 
 If UNICODE variable is not provided, script indicates if UTF-8 should be
 used on the basis of LANG value (if it ends with ".utf8" or similar).
diff -pruN dracut-git-orig/modules.d/99base/bashrc dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/99base/bashrc
--- dracut-git-orig/modules.d/99base/bashrc	1970-01-01 01:00:00.000000000 +0100
+++ dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/99base/bashrc	2016-04-20 14:22:39.804711030 +0200
@@ -0,0 +1,9 @@
+# /etc/bashrc
+
+# Load locale settings
+if [ -f /etc/locale.conf ]; then
+  . /etc/locale.conf
+  [ -n "${LANG}" ] && export LANG || unset LANG
+  [ -n "${LC_ALL}" ] && export LC_ALL || unset LC_ALL
+  [ -n "${LC_MESSAGES}" ] && export LC_MESSAGES || unset LC_MESSAGES
+fi
diff -pruN dracut-git-orig/modules.d/99base/init.sh dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/99base/init.sh
--- dracut-git-orig/modules.d/99base/init.sh	2016-04-20 14:11:02.826944946 +0200
+++ dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/99base/init.sh	2016-04-20 14:02:01.578137511 +0200
@@ -8,6 +8,8 @@
 
 export -p > /tmp/export.orig
 
+[ -f /etc/locale.conf ] && . /etc/locale.conf
+
 NEWROOT="/sysroot"
 [ -d $NEWROOT ] || mkdir -p -m 0755 $NEWROOT
 
@@ -323,7 +325,7 @@ for i in $(export -p); do
     i=${i%%=*}
     [ -z "$i" ] && continue
     case $i in
-        root|PATH|HOME|TERM|PS4|RD_*)
+        root|PATH|HOME|TERM|PS4|RD_*|LANG|LC_*)
             :;;
         *)
             unset "$i";;
diff -pruN dracut-git-orig/modules.d/99base/module-setup.sh dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/99base/module-setup.sh
--- dracut-git-orig/modules.d/99base/module-setup.sh	2016-04-20 14:11:02.827944958 +0200
+++ dracut-git-10i18n-add-support-for-custom-locale-definitions/modules.d/99base/module-setup.sh	2016-04-19 02:26:46.619644212 +0200
@@ -26,6 +26,10 @@ install() {
         (ln -s bash "${initdir}/bin/sh" || :)
     fi
 
+    if dracut_module_included "i18n"; then
+       inst ${moddir}/bashrc /etc/bashrc
+    fi
+
     #add common users in /etc/passwd, it will be used by nfs/ssh currently
     grep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/root:/bin/sh' >> "$initdir/etc/passwd"
     grep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
