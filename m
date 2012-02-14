From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/9] 40network: add net-lib.sh
Date: Tue, 14 Feb 2012 12:38:02 -0500
Message-ID: <1329241090-26908-2-git-send-email-wwoods@redhat.com>
References: <1329241090-26908-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329241090-26908-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

net-lib.sh is a library of useful functions for network stuff.

More things may get added/moved here in the future.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/module-setup.sh |    1 +
 modules.d/40network/net-lib.sh      |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/40network/net-lib.sh

diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index ef7818a..2f4d93d 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -76,6 +76,7 @@ install() {
     inst "$moddir/ifup" "/sbin/ifup"
     inst "$moddir/netroot" "/sbin/netroot"
     inst "$moddir/dhclient-script" "/sbin/dhclient-script"
+    inst "$moddir/net-lib.sh" "/lib/net-lib.sh"
     inst_simple "$moddir/dhclient.conf" "/etc/dhclient.conf"
     inst_hook pre-udev 50 "$moddir/ifname-genrules.sh"
     inst_hook pre-udev 60 "$moddir/net-genrules.sh"
diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
new file mode 100644
index 0000000..0ed80b8
--- /dev/null
+++ b/modules.d/40network/net-lib.sh
@@ -0,0 +1,33 @@
+#!/bin/bash
+
+get_ip() {
+    local iface="$1" ip=""
+    ip=$(ip -o -f inet addr show $iface)
+    ip=${ip%%/*}
+    ip=${ip##* }
+}
+
+iface_for_remote_addr() {
+    set -- $(ip -o route get to $1)
+    echo $5
+}
+
+iface_for_mac() {
+    local interface="" mac="$(echo $1 | tr '[:upper:]' '[:lower:]')"
+    for interface in /sys/class/net/*; do
+        if [ $(cat $interface/address) = "$mac" ]; then
+            echo ${interface##*/}
+        fi
+    done
+}
+
+iface_has_link() {
+    local interface="$1" flags=""
+    [ -n "$interface" ] || return 2
+    interface="/sys/class/net/$interface"
+    [ -d "$interface" ] || return 2
+    flags=$(cat $interface/flags)
+    echo $(($flags|0x41)) > $interface/flags # 0x41: IFF_UP|IFF_RUNNING
+    [ "$(cat $interface/carrier)" = 1 ] || return 1
+    # XXX Do we need to reset the flags here? anaconda never bothered..
+}
-- 
1.7.7.6
