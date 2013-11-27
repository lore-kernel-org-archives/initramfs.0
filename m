From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 07/10] Fixup keymap setting for openSUSE
Date: Wed, 27 Nov 2013 16:44:18 +0100
Message-ID: <1385567061-13247-8-git-send-email-hare@suse.de>
References: <1385567061-13247-1-git-send-email-hare@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385567061-13247-1-git-send-email-hare-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

openSUSE is using compressed keymaps.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/10i18n/module-setup.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/modules.d/10i18n/module-setup.sh b/modules.d/10i18n/module-setup.sh
index 0741c64..f07b148 100755
--- a/modules.d/10i18n/module-setup.sh
+++ b/modules.d/10i18n/module-setup.sh
@@ -161,6 +161,9 @@ install() {
         # Gentoo user may have KEYMAP set to something like "-u pl2",
         KEYMAP=${KEYMAP#-* }
 
+        # openSUSE user may have KEYMAP set to something like ".gz"
+        KEYMAP=${KEYMAP/.gz/}
+
         # KEYTABLE is a bit special - it defines base keymap name and UNICODE
         # determines whether non-UNICODE or UNICODE version is used
 
-- 
1.8.1.4
