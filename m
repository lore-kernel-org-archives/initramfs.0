From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 09/12] kernel-network-modules: Don't include qemu network modules without reason
Date: Thu, 12 May 2016 20:03:33 +0200
Message-ID: <1463076216-410-10-git-send-email-trenn@suse.com>
References: <1463076216-410-1-git-send-email-trenn@suse.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463076216-410-1-git-send-email-trenn-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.blume-IBi9RG/b67k@public.gmane.org, pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org, hare-IBi9RG/b67k@public.gmane.org, fvogt-IBi9RG/b67k@public.gmane.org, trenn-IBi9RG/b67k@public.gmane.org

From: Fabian Vogt <fvogt-IBi9RG/b67k@public.gmane.org>

virtio-net without other network tools does not make sense
and causes various bugs, like:
https://bugzilla.suse.com/show_bug.cgi?id=960669
This patch merges 90qemu-net into 90-kernel-network-modules.

Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/90kernel-network-modules/module-setup.sh | 25 ++++++++++++++++++++
 modules.d/90qemu-net/module-setup.sh               | 27 ----------------------
 2 files changed, 25 insertions(+), 27 deletions(-)
 delete mode 100755 modules.d/90qemu-net/module-setup.sh

diff --git a/modules.d/90kernel-network-modules/module-setup.sh b/modules.d/90kernel-network-modules/module-setup.sh
index 11fbab9..b2c3547 100755
--- a/modules.d/90kernel-network-modules/module-setup.sh
+++ b/modules.d/90kernel-network-modules/module-setup.sh
@@ -10,6 +10,25 @@ depends() {
     return 0
 }
 
+running_in_qemu() {
+    if type -P systemd-detect-virt >/dev/null 2>&1; then
+        vm=$(systemd-detect-virt --vm 2>&1)
+        (($? != 0)) && return 255
+        [[ $vm = "qemu" ]] && return 0
+        [[ $vm = "kvm" ]] && return 0
+        [[ $vm = "bochs" ]] && return 0
+    fi
+
+    for i in /sys/class/dmi/id/*_vendor; do
+        [[ -f $i ]] || continue
+        read vendor < $i
+        [[  "$vendor" == "QEMU" ]] && return 0
+        [[  "$vendor" == "Bochs" ]] && return 0
+    done
+
+    return 255
+}
+
 # called by dracut
 installkernel() {
     # Include wired net drivers, excluding wireless
@@ -30,6 +49,12 @@ installkernel() {
         =drivers/net/ethernet \
         ecb arc4 bridge stp llc ipv6 bonding 8021q af_packet virtio_net
     hostonly="" instmods iscsi_ibft crc32c iscsi_boot_sysfs
+
+    if running_in_qemu; then
+        hostonly='' instmods virtio_net e1000 8139cp pcnet32 e100 ne2k_pci
+    else
+        return 0
+    fi
 }
 
 # called by dracut
diff --git a/modules.d/90qemu-net/module-setup.sh b/modules.d/90qemu-net/module-setup.sh
deleted file mode 100755
index 58f1233..0000000
--- a/modules.d/90qemu-net/module-setup.sh
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/bash
-
-# called by dracut
-check() {
-    if type -P systemd-detect-virt >/dev/null 2>&1; then
-        vm=$(systemd-detect-virt --vm >/dev/null 2>&1)
-        (($? != 0)) && return 255
-        [[ $vm = "qemu" ]] && return 0
-        [[ $vm = "kvm" ]] && return 0
-        [[ $vm = "bochs" ]] && return 0
-    fi
-
-    for i in /sys/class/dmi/id/*_vendor; do
-        [[ -f $i ]] || continue
-        read vendor < $i
-        [[  "$vendor" == "QEMU" ]] && return 0
-        [[  "$vendor" == "Bochs" ]] && return 0
-    done
-
-    return 255
-}
-
-# called by dracut
-installkernel() {
-    # qemu specific modules
-    hostonly='' instmods virtio_net e1000 8139cp pcnet32 e100 ne2k_pci
-}
-- 
2.1.4
