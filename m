From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] kernel-modules: inst modules.builtin if there's no modules.builtin.bin
Date: Fri, 22 Apr 2011 17:43:11 +0200
Message-ID: <1303486991-8133-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Also report failure if none of them exist.
---
 modules.d/90kernel-modules/module-setup.sh |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 5f0e4a7..5764bf5 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -46,5 +46,14 @@ install() {
     dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')
     inst_hook cmdline 01 "$moddir/parse-kernel.sh"
     inst_simple "$moddir/insmodpost.sh" /sbin/insmodpost.sh
-    inst "$srcmods/modules.builtin.bin" "/lib/modules/$kernel/modules.builtin.bin"
+
+    local f
+
+    for f in modules.builtin.bin modules.builtin; do
+        [[ $srcmods/$f ]] && inst "$srcmods/$f" "/lib/modules/$kernel/$f" \
+            && break
+    done || {
+        dfatal "No modules.builtin.bin and modules.builtin found!"
+        return 1
+    }
 }
-- 
1.7.5.rc1
