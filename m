From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/7] Do not use ifenslave
Date: Tue, 22 May 2012 15:48:22 +0800
Message-ID: <1337672903-1643-6-git-send-email-amwang@redhat.com>
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

ifenslave could be dropped, use the /sys interface.

Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/40network/ifup.sh         |    2 +-
 modules.d/40network/module-setup.sh |    2 +-
 modules.d/40network/parse-bond.sh   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index c03838f..1aaa1a8 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -156,7 +156,7 @@ if [ -e /tmp/bond.info ]; then
 
         for slave in $bondslaves ; do
             ip link set $slave down
-            ifenslave $bondname $slave
+            echo "+$slave" > /sys/class/net/$bondname/bonding/slaves
             ip link set $slave up
             wait_for_if_up $slave
         done
diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index f28286c..da58521 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -75,7 +75,7 @@ installkernel() {
 install() {
     local _arch _i _dir
     dracut_install ip arping tr dhclient
-    dracut_install -o brctl ifenslave
+    dracut_install -o brctl
     inst "$moddir/ifup.sh" "/sbin/ifup"
     inst "$moddir/netroot.sh" "/sbin/netroot"
     inst "$moddir/dhclient-script.sh" "/sbin/dhclient-script"
diff --git a/modules.d/40network/parse-bond.sh b/modules.d/40network/parse-bond.sh
index 5822685..933ad27 100755
--- a/modules.d/40network/parse-bond.sh
+++ b/modules.d/40network/parse-bond.sh
@@ -15,7 +15,7 @@
 
 # Check if bond parameter is valid
 if getarg bond= >/dev/null ; then
-    command -v ifenslave >/dev/null 2>&1 || die "No 'ifenslave' installed"
+    :
 fi
 
 # We translate list of slaves to space-separated here to mwke it easier to loop over them in ifup
-- 
1.7.7.6
