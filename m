From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 06/15] 95fcoe: start lldpad separately
Date: Fri, 21 Nov 2014 14:20:42 +0100
Message-ID: <1416576051-62838-7-git-send-email-trenn@suse.de>
References: <1416576051-62838-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416576051-62838-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

lldpad is a system-wide process, which must be started only once.
So we should be separate it from fcoe-up, as it might be called
several times.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95fcoe/fcoe-up.sh      |  8 --------
 modules.d/95fcoe/lldpad.sh       | 14 ++++++++++++++
 modules.d/95fcoe/module-setup.sh |  1 +
 3 files changed, 15 insertions(+), 8 deletions(-)
 create mode 100644 modules.d/95fcoe/lldpad.sh

diff --git a/modules.d/95fcoe/fcoe-up.sh b/modules.d/95fcoe/fcoe-up.sh
index 7f6eb1b..43a0ad5 100755
--- a/modules.d/95fcoe/fcoe-up.sh
+++ b/modules.d/95fcoe/fcoe-up.sh
@@ -30,10 +30,6 @@ netdriver=$(readlink -f /sys/class/net/$netif/device/driver)
 netdriver=${netdriver##*/}
 
 if [ "$dcb" = "dcb" ]; then
-    # Note lldpad will stay running after switchroot, the system initscripts
-    # are to kill it and start a new lldpad to take over. Data is transfered
-    # between the 2 using a shm segment
-    lldpad -d
     # wait for lldpad to be ready
     i=0
     while [ $i -lt 60 ]; do
@@ -43,10 +39,6 @@ if [ "$dcb" = "dcb" ]; then
         i=$(($i+1))
     done
 
-    # on some systems lldpad needs some time
-    # sleep until we find a better solution
-    sleep 30
-
     while [ $i -lt 60 ]; do
         dcbtool sc "$netif" dcb on && break
         info "Retrying to turn dcb on"
diff --git a/modules.d/95fcoe/lldpad.sh b/modules.d/95fcoe/lldpad.sh
new file mode 100644
index 0000000..d06a3bd
--- /dev/null
+++ b/modules.d/95fcoe/lldpad.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+
+# Note lldpad will stay running after switchroot, the system initscripts
+# are to kill it and start a new lldpad to take over. Data is transfered
+# between the 2 using a shm segment
+lldpad -d
+# wait for lldpad to be ready
+i=0
+while [ $i -lt 60 ]; do
+    lldptool -p && break
+    info "Waiting for lldpad to be ready"
+    sleep 1
+    i=$(($i+1))
+done
diff --git a/modules.d/95fcoe/module-setup.sh b/modules.d/95fcoe/module-setup.sh
index 174745a..9c67f17 100755
--- a/modules.d/95fcoe/module-setup.sh
+++ b/modules.d/95fcoe/module-setup.sh
@@ -78,6 +78,7 @@ install() {
     inst "$moddir/fcoe-up.sh" "/sbin/fcoe-up"
     inst "$moddir/fcoe-edd.sh" "/sbin/fcoe-edd"
     inst "$moddir/fcoe-genrules.sh" "/sbin/fcoe-genrules.sh"
+    inst_hook pre-trigger 03 "$moddir/lldpad.sh"
     inst_hook cmdline 99 "$moddir/parse-fcoe.sh"
     dracut_need_initqueue
 }
-- 
1.8.5.2
