From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] dracut: add team device support
Date: Thu, 13 Dec 2012 22:30:25 +0800
Message-ID: <1355409025-23767-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>

V2: merge patch 2/2
    fix active-backup mode by adding slaves one by one
    sync with the latest teamd
    improve the comments
    wait for team ports to come up
    install /etc/libnl/classid too

This patch adds the initial support for team device [1].
A new cmdline team= is introduced for it.

Note, currently we don't support stacked devices
on/under team, it is tricky and can be added on request.

1. http://www.libteam.org/

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
Signed-off-by: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.cmdline.7.asc                |    4 +++
 modules.d/40network/ifup.sh         |   31 ++++++++++++++++++++++++
 modules.d/40network/module-setup.sh |    6 ++++-
 modules.d/40network/net-genrules.sh |    5 ++++
 modules.d/40network/parse-team.sh   |   44 +++++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 1 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 4ab77a6..ab0468a 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -420,6 +420,10 @@ interface name. Better name it "bootnet" or "bluesocket".
     then its values should be separated by semicolon.
     Bond without parameters assumes bond=bond0:eth0,eth1:mode=balance-rr
 
+**team =_<teammaster>_:_<teamslaves>_**::
+    Setup team device <teammaster> on top of <teamslaves>.
+    <teamslaves> is a comma-separated list of physical (ethernet) interfaces.
+
 **bridge=_<bridgename>_:_<ethnames>_**::
     Setup bridge <bridgename> with <ethnames>. <ethnames> is a comma-separated
     list of physical (ethernet) interfaces. Bridge without parameters assumes bridge=br0:eth0
diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 70bc161..576e276 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -28,6 +28,15 @@ if [ -e /tmp/bond.info ]; then
     done
 fi
 
+if [ -e /tmp/team.info ]; then
+    . /tmp/team.info
+    for slave in $teamslaves ; do
+        if [ "$netif" = "$slave" ] ; then
+            netif=$teammaster
+        fi
+    done
+fi
+
 # bridge this interface?
 if [ -e /tmp/bridge.info ]; then
     . /tmp/bridge.info
@@ -167,6 +176,28 @@ if [ -e /tmp/bond.info ]; then
     fi
 fi
 
+if [ -e /tmp/team.info ]; then
+    . /tmp/team.info
+    if [ "$netif" = "$teammaster" ] && [ ! -e /tmp/net.$teammaster.up ] ; then
+        # We shall only bring up those _can_ come up
+        # in case of some slave is gone in active-backup mode
+        working_slaves=""
+        for slave in $teamslaves ; do
+            ip link set $slave up 2>/dev/null
+            if wait_for_if_up $slave; then
+                working_slaves+="$slave "
+            fi
+        done
+        # Do not add slaves now
+        teamd -d -U -n -f /etc/teamd/$teammaster.conf
+        for slave in $working_slaves; do
+            # team requires the slaves to be down before joining team
+            ip link set $slave down
+            teamdctl $teammaster port add $slave
+        done
+        ip link set $teammaster up
+    fi
+fi
 
 # XXX need error handling like dhclient-script
 
diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index da0f447..524fefb 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -64,7 +64,8 @@ installkernel() {
     { find_kernel_modules_by_path drivers/net; if [ "$_arch" = "s390" -o "$_arch" = "s390x" ]; then find_kernel_modules_by_path drivers/s390/net; fi; } \
         | net_module_filter | instmods
 
-    instmods =drivers/net/phy ecb arc4 bridge stp llc ipv6 bonding 8021q af_packet virtio_net
+    #instmods() will take care of hostonly
+    instmods =drivers/net/phy ecb arc4 bridge stp llc ipv6 bonding 8021q af_packet virtio_net =drivers/net/team
 }
 
 install() {
@@ -72,6 +73,8 @@ install() {
     dracut_install ip arping dhclient sed
     dracut_install -o ping ping6
     dracut_install -o brctl
+    dracut_install -o teamd teamdctl teamnl
+    inst_simple /etc/libnl/classid
     inst_script "$moddir/ifup.sh" "/sbin/ifup"
     inst_script "$moddir/netroot.sh" "/sbin/netroot"
     inst_script "$moddir/dhclient-script.sh" "/sbin/dhclient-script"
@@ -82,6 +85,7 @@ install() {
     inst_hook cmdline 91 "$moddir/dhcp-root.sh"
     inst_hook cmdline 95 "$moddir/parse-vlan.sh"
     inst_hook cmdline 96 "$moddir/parse-bond.sh"
+    inst_hook cmdline 96 "$moddir/parse-team.sh"
     inst_hook cmdline 97 "$moddir/parse-bridge.sh"
     inst_hook cmdline 98 "$moddir/parse-ip-opts.sh"
     inst_hook cmdline 99 "$moddir/parse-ifname.sh"
diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index d2197ff..50e223d 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -34,6 +34,11 @@ fi
         IFACES+=" ${bondslaves%% *}"
     fi
 
+    if [ -e /tmp/team.info ]; then
+        . /tmp/team.info
+        IFACES+=" ${teamslaves}"
+    fi
+
     if [ -e /tmp/vlan.info ]; then
         . /tmp/vlan.info
         IFACES+=" $phydevice"
diff --git a/modules.d/40network/parse-team.sh b/modules.d/40network/parse-team.sh
new file mode 100755
index 0000000..318c0e1
--- /dev/null
+++ b/modules.d/40network/parse-team.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+#
+# Format:
+#       team=<teammaster>:<teamslaves>
+#
+#       teamslaves is a comma-separated list of physical (ethernet) interfaces
+#
+
+# return if team already parsed
+[ -n "$teammaster" ] && return
+
+# Check if team parameter is valid
+if getarg team= >/dev/null ; then
+    :
+fi
+
+parseteam() {
+    local v=${1}:
+    set --
+    while [ -n "$v" ]; do
+        set -- "$@" "${v%%:*}"
+        v=${v#*:}
+    done
+
+    unset teammaster teamslaves
+    case $# in
+    2)  teammaster=$1; teamslaves=$(str_replace "$2" "," " ") ;;
+    *)  die "team= requires two parameters" ;;
+    esac
+}
+
+unset teammaster teamslaves
+
+if getarg team>/dev/null; then
+    # Read team= parameters if they exist
+    team="$(getarg team=)"
+    if [ ! "$team" = "team" ]; then
+        parseteam "$(getarg team=)"
+    fi
+
+    echo "teammaster=$teammaster" > /tmp/team.info
+    echo "teamslaves=\"$teamslaves\"" >> /tmp/team.info
+    return
+fi
