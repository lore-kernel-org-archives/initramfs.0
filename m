From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] network: add ipcalc for netmask calculation
Date: Mon, 28 Apr 2014 17:41:50 +0800
Message-ID: <1398678111-13601-1-git-send-email-bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

If static route is supported, the route prefix need be calculated
by netmask provided by user. So add it now.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index 1df4174..dbe5205 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -72,7 +72,7 @@ installkernel() {
 # called by dracut
 install() {
     local _arch _i _dir
-    inst_multiple ip arping dhclient sed
+    inst_multiple ip arping dhclient ipcalc sed
     inst_multiple -o ping ping6
     inst_multiple -o brctl
     inst_multiple -o teamd teamdctl teamnl
-- 
1.8.5.3
