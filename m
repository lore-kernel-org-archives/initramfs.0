From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] inst_simple doesn't take '-H' parameter
Date: Mon, 21 Jul 2014 09:54:51 +0200
Message-ID: <1405929291-6523-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

It was introduced in commit 5a5758.
---
 modules.d/90lvm/module-setup.sh  | 2 +-
 modules.d/95zfcp/module-setup.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/90lvm/module-setup.sh b/modules.d/90lvm/module-setup.sh
index 2f2b64c..5073082 100755
--- a/modules.d/90lvm/module-setup.sh
+++ b/modules.d/90lvm/module-setup.sh
@@ -59,7 +59,7 @@ install() {
 
     if [[ $hostonly ]] || [[ $lvmconf = "yes" ]]; then
         if [ -f /etc/lvm/lvm.conf ]; then
-            inst_simple -H /etc/lvm/lvm.conf
+            inst_simple /etc/lvm/lvm.conf
             # FIXME: near-term hack to establish read-only locking;
             # use command-line lvm.conf editor once it is available
             sed -i -e 's/\(^[[:space:]]*\)locking_type[[:space:]]*=[[:space:]]*[[:digit:]]/\1locking_type = 4/' ${initdir}/etc/lvm/lvm.conf
diff --git a/modules.d/95zfcp/module-setup.sh b/modules.d/95zfcp/module-setup.sh
index 9526caa..b96ccd2 100755
--- a/modules.d/95zfcp/module-setup.sh
+++ b/modules.d/95zfcp/module-setup.sh
@@ -31,6 +31,6 @@ install() {
     inst_rules 56-zfcp.rules
 
     if [[ $hostonly ]]; then
-        inst_simple -H /etc/zfcp.conf
+        inst_simple /etc/zfcp.conf
     fi
 }
-- 
2.0.0
