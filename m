From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] add apply-live-updates.sh to pre-pivot hook
Date: Mon,  1 Aug 2011 16:21:09 -0400
Message-ID: <1312230069-10674-4-git-send-email-wwoods@redhat.com>
References: <1312230069-10674-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312230069-10674-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If we're about to start a Live image (i.e. if /dev/mapper/live-rw
exists) this script will take any files found in /updates (inside the
initramfs!) and and copy them into $NEWROOT.

This allows for hotfixes to be applied to existing Live images without
rebuilding the entire image.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90dmsquash-live/apply-live-updates.sh |    7 +++++++
 modules.d/90dmsquash-live/module-setup.sh       |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/90dmsquash-live/apply-live-updates.sh

diff --git a/modules.d/90dmsquash-live/apply-live-updates.sh b/modules.d/90dmsquash-live/apply-live-updates.sh
new file mode 100755
index 0000000..dfdb404
--- /dev/null
+++ b/modules.d/90dmsquash-live/apply-live-updates.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+if [ -b /dev/mapper/live-rw ]; then
+    if [ "`echo /updates/*`" != "/updates/*" ]; then
+        echo "Applying updates to live image..."
+        /bin/cp -a /updates/* $NEWROOT
+    fi
+fi
diff --git a/modules.d/90dmsquash-live/module-setup.sh b/modules.d/90dmsquash-live/module-setup.sh
index 8ed633f..684655f 100755
--- a/modules.d/90dmsquash-live/module-setup.sh
+++ b/modules.d/90dmsquash-live/module-setup.sh
@@ -34,6 +34,7 @@ install() {
     inst_hook cmdline 30 "$moddir/parse-dmsquash-live.sh"
     inst_hook pre-udev 30 "$moddir/dmsquash-live-genrules.sh"
     inst_hook pre-udev 30 "$moddir/dmsquash-liveiso-genrules.sh"
+    inst_hook pre-pivot 20 "$moddir/apply-live-updates.sh"
     inst "$moddir/dmsquash-live-root" "/sbin/dmsquash-live-root"
     # should probably just be generally included
     inst_rules 60-cdrom_id.rules
-- 
1.7.6
