From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 02/11] fixed plymouth installation for plymouth-0.7.0-0.2009.05.08.1.fc11
Date: Fri, 15 May 2009 14:39:08 +0200
Message-ID: <4A0D626C.5000202@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050702020700010101080402"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------050702020700010101080402
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

---
  modules.d/50plymouth/plymouth-populate-initrd |   13 +++++++++----
  1 files changed, 9 insertions(+), 4 deletions(-)



--------------050702020700010101080402
Content-Type: text/x-patch;
 name="41fab50b5fe4a242324fd1cd4caa8079b18c17fc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="41fab50b5fe4a242324fd1cd4caa8079b18c17fc.diff"

diff --git a/modules.d/50plymouth/plymouth-populate-initrd b/modules.d/50plymouth/plymouth-populate-initrd
index e195ddc..ed05e9b 100755
--- a/modules.d/50plymouth/plymouth-populate-initrd
+++ b/modules.d/50plymouth/plymouth-populate-initrd
@@ -5,18 +5,23 @@ else
     LIBDIR="/usr/lib"
 fi
 PLYMOUTH_LOGO_FILE="/usr/share/pixmaps/system-logo-white.png"
-PLYMOUTH_PLUGIN_NAME=$(plymouth-set-default-plugin)
+PLYMOUTH_PLUGIN_NAME=$(plymouth-set-default-theme)
 
 inst /sbin/plymouthd /bin/plymouthd
 dracut_install /bin/plymouth "${LIBDIR}/plymouth/text.so" \
     "${LIBDIR}/plymouth/details.so" "${PLYMOUTH_LOGO_FILE}" \
-    /etc/system-release "${LIBDIR}/plymouth/${PLYMOUTH_PLUGIN_NAME:=text}.so"
+    /etc/system-release 
+
+if [[ -f "${LIBDIR}/plymouth/${PLYMOUTH_PLUGIN_NAME:=text}.so" ]]; then
+    dracut_install "${LIBDIR}/plymouth/${PLYMOUTH_PLUGIN_NAME:=text}.so" 
+fi
+
 mkdir -p "${initdir}/usr/share/plymouth"
 
 [[ -f ${LIBDIR}/plymouth/default.so ]] && inst ${LIBDIR}/plymouth/default.so
 
-if [[ -d /usr/share/plymouth/${PLYMOUTH_PLUGIN_NAME} ]]; then
-    for x in "/usr/share/plymouth/${PLYMOUTH_PLUGIN_NAME}"/* ; do
+if [[ -d /usr/share/plymouth/themes/${PLYMOUTH_PLUGIN_NAME} ]]; then
+    for x in "/usr/share/plymouth/themes/${PLYMOUTH_PLUGIN_NAME}"/* ; do
         [[ -f "$x" ]] || break
         inst $x
     done


--------------050702020700010101080402--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
