From: =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Subject: [PATCH] install ctcm network module on s390
Date: Fri,  2 Mar 2012 11:41:37 +0100
Message-ID: <1330684897-5687-1-git-send-email-dan@danny.cz>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The ctcm module is not loaded automagically because it doesn't pass the
"ether_type_trans" test in 40net/module-setup.sh, so load it explicitly.
---
 modules.d/95znet/module-setup.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/modules.d/95znet/module-setup.sh b/modules.d/95znet/module-setup.sh
index fbb79aa..b354947 100755
--- a/modules.d/95znet/module-setup.sh
+++ b/modules.d/95znet/module-setup.sh
@@ -13,6 +13,10 @@ depends() {
     return 0
 }
 
+installkernel() {
+    instmods ctcm
+}
+
 install() {
     inst_hook cmdline 30 "$moddir/parse-ccw.sh"
     inst /lib/udev/ccw_init
-- 
1.7.7.6
