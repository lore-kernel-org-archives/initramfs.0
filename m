From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/7] Avoid generating udev rules for master interfaces
Date: Tue, 22 May 2012 15:48:23 +0800
Message-ID: <1337672903-1643-7-git-send-email-amwang@redhat.com>
References: <1337672903-1643-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337672903-1643-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Vlan/bridge/bonding device has the same mac address with its underlying
physical device, if we generate udev rules for vlan NIC too,
its physical device name will be override.

This looks a little ugly, but I can't find any better way to handle this.

Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/40network/ifname-genrules.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/ifname-genrules.sh b/modules.d/40network/ifname-genrules.sh
index e188c88..89621a2 100755
--- a/modules.d/40network/ifname-genrules.sh
+++ b/modules.d/40network/ifname-genrules.sh
@@ -8,9 +8,15 @@ if ! getarg ifname= >/dev/null ; then
 fi
 
 {
+    [ -e /tmp/vlan.info ] && source /tmp/vlan.info
+    [ -e /tmp/bridge.info ] && source /tmp/bridge.info
+    [ -e /tmp/bond.info ] && source /tmp/bond.info
     for p in $(getargs ifname=); do
         parse_ifname_opts $p
-        printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", ATTR{type}=="1", NAME="%s"\n' "$ifname_mac" "$ifname_if"
+        #Hack: vlan, bridge, bonding devices may have the same mac address with its physical device
+        if [ "$ifname_if" != "$vlanname" ] && [ "$ifname_if" != "$bridgename" ] && [ "$ifname_if" != "$bondname" ]; then
+            printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", ATTR{type}=="1", NAME="%s"\n' "$ifname_mac" "$ifname_if"
+        fi
     done
 
     # Rename non named interfaces out of the way for named ones.
-- 
1.7.7.6
