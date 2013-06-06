From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] base: setup correct system time and time zone in initrd
Date: Thu, 6 Jun 2013 17:56:11 +0800
Message-ID: <20130606095611.GA29287@dhcp12-158.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Currently in initrd, hardware clock is always considered to use UTC time
format and system time zone is also UTC. Thus system time isn't correct
if hw clock is localtime or we're using other time zone in real root.

To fix this, install /etc/adjtime and /etc/localtime to initrd. If not
using systemd, install /usr/sbin/hwclock for dracut init to setup system
time.

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/init.sh         |  9 +++++++++
 modules.d/99base/module-setup.sh | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index 880a2c0..c72129b 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -55,6 +55,15 @@ if ! ismounted /dev; then
     exit 1
 fi
 
+# setup system time
+if [ -f /etc/adjtime ]; then
+    if strstr "$(cat /etc/adjtime)" LOCAL; then
+        hwclock --hctosys --localtime
+    else
+        hwclock --hctosys --utc
+    fi
+fi
+
 # prepare the /dev directory
 [ ! -h /dev/fd ] && ln -s /proc/self/fd /dev/fd >/dev/null 2>&1
 [ ! -h /dev/stdin ] && ln -s /proc/self/fd/0 /dev/stdin >/dev/null 2>&1
diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index 4955b7b..77ba79c 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -28,6 +28,17 @@ install() {
     egrep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/root:/bin/sh' >> "$initdir/etc/passwd"
     egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
 
+    # install /etc/adjtime and time zone data
+    if [[ $hostonly ]]; then
+        dracut_install -o /etc/adjtime \
+                          /etc/localtime
+    fi
+
+    # Our init.sh script needs hwclock to set system time
+    if [[ $hostonly ]] && ! dracut_module_included "systemd"; then
+        dracut_install -o hwclock
+    fi
+
     # install our scripts and hooks
     inst_script "$moddir/init.sh" "/init"
     inst_script "$moddir/initqueue.sh" "/sbin/initqueue"
-- 
1.8.2.1
