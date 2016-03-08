From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V4 dracut 1/3] watchdog: Do not add hooks if systemd module is included
Date: Tue,  8 Mar 2016 14:14:35 +0530
Message-ID: <cedf132fdff3071a864565207c1a96484042d58f.1457425628.git.panand@redhat.com>
References: <cover.1457425628.git.panand@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1457425628.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <cover.1457425628.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
References: <cover.1457425628.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

When systemd is present, let it manage watchdog feed.

Signed-off-by: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/04watchdog/module-setup.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/modules.d/04watchdog/module-setup.sh b/modules.d/04watchdog/module-setup.sh
index 576c589c198d..7ec757aec032 100755
--- a/modules.d/04watchdog/module-setup.sh
+++ b/modules.d/04watchdog/module-setup.sh
@@ -12,6 +12,11 @@ depends() {
 
 # called by dracut
 install() {
+    # Do not add watchdog hooks if systemd module is included
+    # In that case, systemd will manage watchdog kick
+    if dracut_module_included "systemd"; then
+	    return
+    fi
     inst_hook cmdline   00 "$moddir/watchdog.sh"
     inst_hook cmdline   50 "$moddir/watchdog.sh"
     inst_hook pre-trigger 00 "$moddir/watchdog.sh"
-- 
2.5.0
