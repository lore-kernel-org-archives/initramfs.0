From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 1/3] gen-mod-lists: create lists of modules that may talk
	to a root device
Date: Thu, 05 Feb 2009 15:49:15 -0700
Message-ID: <20090205224915.18610.86035.stgit@dwillia2-linux.ch.intel.com>
References: <20090205224808.18610.14957.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090205224808.18610.14957.stgit-p8uTFz9XbKjBPTuBivz2/GFmcEqAMTzPQQ4Iyu8u01E@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: neilb-l3A5Bk7waGM@public.gmane.org, jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org

notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org:
	The idea is that we don't want to include every single module,
	but we want to include every module that might define a block
	device to boot from, or a network device to network boot from.
	Having it in the upstream kernel would be helpful, although how
	it's generated now is obviously a hack.

	Doing it at runtime in dracut would work, but would be obviously
	slow.

This is a temporary hack to duplicate this functionality from the
Fedora kernel srpm in dracut.

Also added "raid" modules.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 gen-mod-lists |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100755 gen-mod-lists

diff --git a/gen-mod-lists b/gen-mod-lists
new file mode 100755
index 0000000..13999d7
--- /dev/null
+++ b/gen-mod-lists
@@ -0,0 +1,34 @@
+#!/bin/bash
+
+# Copied from from kernel.spec (kernel-2.6.27.12-78.2.8.fc9.src.rpm)
+# Creates /lib/modules/$KernelVer/modules.{block,networking,raid}
+
+KernelVer=$1
+[ -n $KernelVer ] && KernelVer=$(uname -r)
+
+if [ ! -d /lib/modules/$KernelVer ]; then
+	echo "error: could not find /lib/modules/$KernelVer"
+	exit 1
+fi
+
+find /lib/modules/$KernelVer -name "*.ko" -type f >modnames
+
+# Generate a list of modules for block and networking.
+
+fgrep /drivers/ modnames | xargs --no-run-if-empty nm -upA |
+sed -n 's,^.*/\([^/]*\.ko\):  *U \(.*\)$,\1 \2,p' > drivers.undef
+
+collect_modules_list()
+{
+  sed -r -n -e "s/^([^ ]+) \\.?($2)\$/\\1/p" drivers.undef |
+  LC_ALL=C sort -u > /lib/modules/$KernelVer/modules.$1
+}
+
+collect_modules_list networking \
+                     'register_netdev|ieee80211_register_hw|usbnet_probe'
+collect_modules_list block \
+                     'ata_scsi_ioctl|scsi_add_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register'
+
+# mdraid modules, could be made part of 'block'
+collect_modules_list raid \
+                     'register_md_personality'

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
