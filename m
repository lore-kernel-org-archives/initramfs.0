From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH] dracut: add support for custom locale definitions
Date: Sat, 16 Apr 2016 00:07:30 +0200
Message-ID: <1460758050.3211.2.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Compile and install locale definitions using localedef from GNU libc. The
resulting locale definitions archive contains at most two different locale
definitions, therefore its size is relatively small.

Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
---
 modules.d/10i18n/module-setup.sh |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- dracut-044/modules.d/10i18n/module-setup.sh	2016-04-15 23:34:44.011398268 +0200
+++ dracut-044-10i18n-add-support-for-custom-locale-definitions/modules.d/10i18n/module-setup.sh	2016-04-15 23:32:05.292860621 +0200
@@ -219,6 +219,16 @@ install() {
             print_vars LC_ALL LANG >> ${initdir}${I18N_CONF}
         fi
 
+        [[ $LC_ALL || $LANG ]] && inst_dir /usr/lib/locale
+
+        # Generate locale definitions for LC_ALL
+        [ $LC_ALL ] && LC_ALL_LOCALE=`echo $LC_ALL | awk -F. '{ print $1 }'` && LC_ALL_CHARMAP=`echo $LC_ALL | awk -F. '{ print $2 }'`
+        [[ $LC_ALL && $LC_ALL_LOCALE && $LC_ALL_CHARMAP ]] && localedef --prefix="${initdir}" -i $LC_ALL_LOCALE -f $LC_ALL_CHARMAP $LC_ALL
+
+        # Generate locale definitions for LANG
+        [ $LANG ] && LANG_LOCALE=`echo $LANG | awk -F. '{ print $1 }'` && LANG_CHARMAP=`echo $LANG | awk -F. '{ print $2 }'`
+        [[ $LANG && $LANG_LOCALE && $LANG_CHARMAP ]] && localedef --prefix="${initdir}" -i $LANG_LOCALE -f $LANG_CHARMAP $LANG
+
         if dracut_module_included "systemd" && [[ -f ${VCONFIG_CONF} ]]; then
             inst_simple ${VCONFIG_CONF}
         else
