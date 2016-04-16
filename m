From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH v3] dracut: 10i18n: add support for custom locale definitions
Date: Sat, 16 Apr 2016 21:32:23 +0200
Message-ID: <1460835143.3201.10.camel@trentalancia.net>
References: <1460758050.3211.2.camel@trentalancia.net>
	 <5711D4E7.9070705@gmail.com> <1460815966.4296.13.camel@trentalancia.net>
	 <57127BC9.70103@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57127BC9.70103-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Compile and install locale definitions using localedef from GNU libc. The
resulting locale definitions archive contains at most two different locale
definitions, therefore its size is relatively small.

This revised version fixes several issues in the initial patch. Thanks to
Andrei Borzenkov for reviewing it.

Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
---
 modules.d/10i18n/module-setup.sh |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- dracut-044-orig/modules.d/10i18n/module-setup.sh	2015-11-25 14:22:28.000000000 +0100
+++ dracut-044-10i18n-add-support-for-custom-locale-definitions/modules.d/10i18n/module-setup.sh	2016-04-16 21:21:53.059812954 +0200
@@ -212,6 +219,23 @@ install() {
             print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
         fi
 
+        [[ ${LC_ALL} || ${LANG} ]] && inst_dir /usr/lib/locale
+
+        command -v localedef > /dev/null && HAS_LOCALEDEF=true || HAS_LOCALEDEF=false
+
+        # Generate locale definitions for LC_ALL
+        [ ${LC_ALL} ] && LC_ALL_LOCALE=`echo ${LC_ALL} | awk -F. '{ print $1 }'` && LC_ALL_CHARMAP=`echo ${LC_ALL} | awk -F. '{ print $2 }'`
+        [[ ${LC_ALL} && ${LC_ALL_LOCALE} && ${LC_ALL_CHARMAP} ]] && [ $HAS_LOCALEDEF == true ] && localedef --prefix="${initdir}" -i ${LC_ALL_LOCALE} -f ${LC_ALL_CHARMAP} ${LC_ALL}
+
+        # Generate locale definitions for LANG
+        [ ${LANG} ] && [ ${LANG} != ${LC_ALL} ] && LANG_LOCALE=`echo ${LANG} | awk -F. '{ print $1 }'` && LANG_CHARMAP=`echo ${LANG} | awk -F. '{ print $2 }'`
+        [[ ${LANG} && ${LANG_LOCALE} && ${LANG_CHARMAP} ]] && [ ${HAS_LOCALEDEF} == true ] && localedef --prefix="${initdir}" -i ${LANG_LOCALE} -f ${LANG_CHARMAP} ${LANG}
+
+        # If localedef is not available, but compiled split definitions are,
+        # then copy them over
+        [ ${LC_ALL} ] && [ ${HAS_LOCALEDEF} == false ] && [ -d /usr/lib/locale/${LC_ALL} ] && cp -prfL -t "${initdir}/usr/lib/locale/" /usr/lib/locale/${LC_ALL}
+        [ ${LANG} ] && [ ${LANG} != ${LC_ALL} ] && [ ${HAS_LOCALEDEF} == false ] && [ -d /usr/lib/locale/${LANG} ] && cp -prfL -t "${initdir}/usr/lib/locale/" /usr/lib/locale/${LANG}
+
         if dracut_module_included "systemd" && [[ -f ${VCONFIG_CONF} ]]; then
             inst_simple ${VCONFIG_CONF}
         else
