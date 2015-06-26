From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 6/8] Install /etc/sysconfig/console to see specific fonts
Date: Fri, 26 Jun 2015 16:55:55 +0200
Message-ID: <1435330557-17685-7-git-send-email-trenn@suse.de>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435330557-17685-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Werner Fink <werner-l3A5Bk7waGM@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

From: Werner Fink <werner-l3A5Bk7waGM@public.gmane.org>

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/10i18n/module-setup.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/modules.d/10i18n/module-setup.sh b/modules.d/10i18n/module-setup.sh
index 9439875..398d02b 100755
--- a/modules.d/10i18n/module-setup.sh
+++ b/modules.d/10i18n/module-setup.sh
@@ -219,6 +219,10 @@ install() {
             print_vars KEYMAP EXT_KEYMAPS UNICODE FONT FONT_MAP FONT_UNIMAP >> ${initdir}${VCONFIG_CONF}
         fi
 
+        if dracut_module_included "systemd" && [[ -f /etc/sysconfig/console ]]; then
+            inst_simple /etc/sysconfig/console
+        fi
+
         return 0
     }
 
-- 
2.1.4
