From: mwilck-IBi9RG/b67k@public.gmane.org
Subject: [PATCH 1/2] Add module "90nvdimm" for NVDIMM support
Date: Thu, 30 Jan 2020 16:18:20 +0100
Message-ID: <20200130151821.24042-1-mwilck@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Daniel Molkentin <dmolkentin-l3A5Bk7waGM@public.gmane.org>, Thomas Blume <Thomas.Blume-IBi9RG/b67k@public.gmane.org>, Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>, Kairui Song <kasong-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>

Detection of persistent memory devices works mostly out of the box
already. Only the "provider" modules for ndbus devices, which are responsible
to extract information of available NVDIMM devices and their configuration
from system firmware, are only indirectly linked into the module stack.
Examples for such modules are nfit.ko, nd_e820.ko, and virtio-pmem.ko.

Add a module that resolves these dependencies.
---
 modules.d/90nvdimm/module-setup.sh | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 modules.d/90nvdimm/module-setup.sh

diff --git a/modules.d/90nvdimm/module-setup.sh b/modules.d/90nvdimm/module-setup.sh
new file mode 100755
index 0000000..98913a4
--- /dev/null
+++ b/modules.d/90nvdimm/module-setup.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+
+# called by dracut
+check() {
+    if [[ ! $hostonly ]]; then
+        return 0
+    fi
+    [[ $DRACUT_KERNEL_MODALIASES && -f "$DRACUT_KERNEL_MODALIASES" ]] && \
+        grep -q libnvdimm "$DRACUT_KERNEL_MODALIASES" && return 0
+    return 255
+}
+
+# called by dracut
+depends() {
+    return 0
+}
+
+# called by dracut
+installkernel() {
+    # Directories to search for NVDIMM "providers" (firmware drivers)
+    # These modules call "nvdimm_bus_register()".
+    local _provider_dirs='=drivers/nvdimm =drivers/acpi =arch/powerpc'
+
+    #instmods() will take care of hostonly
+    dracut_instmods -o -s nvdimm_bus_register $_provider_dirs
+}
+
+# called by dracut
+install() {
+    inst /usr/bin/ndctl
+}
-- 
2.25.0

