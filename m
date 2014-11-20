From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 03/33] 00warpclock: Set correct timezone
Date: Thu, 20 Nov 2014 15:56:38 +0100
Message-ID: <1416495428-36978-4-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

Add module for setting correct timezone.
References: bnc#830060

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/00warpclock/module-setup.sh | 25 +++++++++++++++++++++++++
 modules.d/00warpclock/warpclock.sh    |  9 +++++++++
 2 files changed, 34 insertions(+)
 create mode 100755 modules.d/00warpclock/module-setup.sh
 create mode 100755 modules.d/00warpclock/warpclock.sh

diff --git a/modules.d/00warpclock/module-setup.sh b/modules.d/00warpclock/module-setup.sh
new file mode 100755
index 0000000..6bd7abd
--- /dev/null
+++ b/modules.d/00warpclock/module-setup.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+# called by dracut
+check() {
+    # hwclock does not exist on S390(x), bail out silently then
+    local _arch=$(uname -m)
+    [ "$_arch" = "s390" -o "$_arch" = "s390x" ] && return 1
+
+    [ -e /etc/localtime -a -e /etc/adjtime ] || return 1
+    require_binaries /sbin/hwclock || return 1
+}
+
+# called by dracut
+depends() {
+    return 0
+}
+
+# called by dracut
+install() {
+    inst /usr/share/zoneinfo/UTC
+    inst /etc/localtime
+    inst /etc/adjtime
+    inst_hook pre-trigger 00 "$moddir/warpclock.sh"
+    inst /sbin/hwclock
+}
diff --git a/modules.d/00warpclock/warpclock.sh b/modules.d/00warpclock/warpclock.sh
new file mode 100755
index 0000000..f64818c
--- /dev/null
+++ b/modules.d/00warpclock/warpclock.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+if test -e /etc/adjtime ; then
+    while read line ; do
+	if test "$line" = LOCAL ; then
+	    hwclock --systz
+	fi
+    done < /etc/adjtime
+fi
-- 
1.8.5.2
