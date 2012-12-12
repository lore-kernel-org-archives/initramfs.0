From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 1/6 v3] Move wait for if functions to net lib
Date: Wed, 12 Dec 2012 12:23:21 +0800
Message-ID: <20121212042613.066368951@redhat.com>
References: <20121212042320.618863612@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=patch1
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

net-lib.sh are created for net related functions, move the wait_for_if* to
net-lib.sh naturally.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/dhclient-script.sh |    1 +
 modules.d/40network/net-lib.sh         |   23 +++++++++++++++++++++++
 modules.d/95fcoe/fcoe-up.sh            |    1 +
 modules.d/99base/dracut-lib.sh         |   23 -----------------------
 4 files changed, 25 insertions(+), 23 deletions(-)

--- dracut.orig/modules.d/99base/dracut-lib.sh
+++ dracut/modules.d/99base/dracut-lib.sh
@@ -481,29 +481,6 @@ else
     }
 fi
 
-wait_for_if_up() {
-    local cnt=0
-    local li
-    while [ $cnt -lt 200 ]; do
-        li=$(ip -o link show up dev $1)
-        [ -n "$li" ] && return 0
-        sleep 0.1
-        cnt=$(($cnt+1))
-    done
-    return 1
-}
-
-wait_for_route_ok() {
-    local cnt=0
-    while [ $cnt -lt 200 ]; do
-        li=$(ip route show)
-        [ -n "$li" ] && [ -z "${li##*$1*}" ] && return 0
-        sleep 0.1
-        cnt=$(($cnt+1))
-    done
-    return 1
-}
-
 # root=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
 # root=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
 nfsroot_to_var() {
--- dracut.orig/modules.d/40network/net-lib.sh
+++ dracut/modules.d/40network/net-lib.sh
@@ -322,3 +322,26 @@ parse_ifname_opts() {
     esac
 
 }
+
+wait_for_if_up() {
+    local cnt=0
+    local li
+    while [ $cnt -lt 200 ]; do
+        li=$(ip -o link show up dev $1)
+        [ -n "$li" ] && return 0
+        sleep 0.1
+        cnt=$(($cnt+1))
+    done
+    return 1
+}
+
+wait_for_route_ok() {
+    local cnt=0
+    while [ $cnt -lt 200 ]; do
+        li=$(ip route show)
+        [ -n "$li" ] && [ -z "${li##*$1*}" ] && return 0
+        sleep 0.1
+        cnt=$(($cnt+1))
+    done
+    return 1
+}
--- dracut.orig/modules.d/40network/dhclient-script.sh
+++ dracut/modules.d/40network/dhclient-script.sh
@@ -51,6 +51,7 @@ PATH=/usr/sbin:/usr/bin:/sbin:/bin
 export PS4="dhclient.$interface.$$ + "
 exec >>/run/initramfs/loginit.pipe 2>>/run/initramfs/loginit.pipe
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+type ip_to_var >/dev/null 2>&1 || . /lib/net-lib.sh
 
 # We already need a set netif here
 netif=$interface
--- dracut.orig/modules.d/95fcoe/fcoe-up.sh
+++ dracut/modules.d/95fcoe/fcoe-up.sh
@@ -16,6 +16,7 @@ PATH=/usr/sbin:/usr/bin:/sbin:/bin
 export PS4="fcoe-up.$1.$$ + "
 exec >>/run/initramfs/loginit.pipe 2>>/run/initramfs/loginit.pipe
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+type ip_to_var >/dev/null 2>&1 || . /lib/net-lib.sh
 
 netif=$1
 dcb=$2
