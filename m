From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH v2 2/2]: dracut: 10i18n: support default loadkeys/setfont
 data paths using symbolic links
Date: Fri, 15 Apr 2016 13:06:45 +0200
Message-ID: <1460718405.2616.14.camel@trentalancia.net>
References: <1460387675.2670.21.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460387675.2670.21.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Avoid keymap/font not found error when loadkeys/setfont
are compiled with the default data directory path.

Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
---
 modules.d/10i18n/module-setup.sh |    7 +++++++
 1 file changed, 7 insertions(+)

--- dracut-038/modules.d/10i18n/module-setup.sh 2016-04-15 12:58:46.105952161 +0200
+++ dracut-038-10i18n-create-usr-share-symlinks-v2/modules.d/10i18n/module-setup.sh     2016-04-15 12:59:06.874241231 +0200
@@ -100,6 +100,13 @@ install() {
             inst_rules ${moddir}/10-console.rules
             inst_hook cmdline 20 "${moddir}/parse-i18n.sh"
         fi
+
+        if [[ ${kbddir} != "/usr/share" ]]; then
+            inst_dir /usr/share
+            for _src in $(eval echo {${KBDSUBDIRS}}); do
+                [ ! -e "${initdir}/usr/share/${_src}" ] && ln -s "${kbddir}/${_src}" "${initdir}/usr/share/${_src}"
+            done
+        fi
     }

     install_all_kbd() {
