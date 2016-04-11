From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH 2/2]: dracut: 10i18n: support default loadkeys/setfont data
 paths using symbolic links
Date: Mon, 11 Apr 2016 17:14:35 +0200
Message-ID: <1460387675.2670.21.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Avoid keymap/font not found error when loadkeys/setfont
are compiled with the default data directory path.

Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
---
=C2=A0modules.d/10i18n/module-setup.sh |=C2=A0=C2=A0=C2=A0=C2=A07 +++++=
++
=C2=A01 file changed, 7 insertions(+)

--- dracut-038/modules.d/10i18n/module-setup.sh	2014-06-30 12:03:12.000=
000000 +0200
+++ dracut-038-10i18n-create-usr-share-symlinks/modules.d/10i18n/module=
-setup.sh	2016-04-11 16:56:45.046582794 +0200
@@ -102,6 +102,13 @@ install() {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0inst_rules ${moddir}/10-console.rules
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0inst_hook cmdline 20 "${moddir}/parse-i18n.sh"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
+
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [[ ${kbddir} !=3D "=
/usr/share" ]]; then
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
inst_dir "/usr/share"
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
for _src in $(eval echo {${KBDSUBDIRS}}); do
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ln -s "${kbddir}/${_src}" "${initdir}/usr/share=
/${_src}"
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
done
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install_all_kbd() {
