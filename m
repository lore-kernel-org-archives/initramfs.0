From: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] network: dhcp before parsing specified dns through cmdline
Date: Tue, 26 Apr 2016 18:05:10 +0800
Message-ID: <1461665111-7385-1-git-send-email-xlpang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kdump-team-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

I met a problem when passing kdump dns to dracut via "nameserver=x.x.x.x",
the dns I provided didn't appear in the "/etc/resolv.conf".

After some debugging, found that when setup dhcp DNS, in setup_interface() 
and setup_interface6(), it has:
    echo "search $search $domain" > /tmp/net.$netif.resolv.conf

So if "$search $domain" isn't NULL(this is ture in my kdump environment),
the dns contents(that is, dns1, dns2, nameserver) in "ifup" before dhcp 
will be discarded.

This patch addresses it by handling dhcp first. In fact this is also the
way the NetworkManager in 1st kernel works.

Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/ifup.sh | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 7c179bd..702b8dc 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -321,16 +321,16 @@ fi
 ip=$(getarg ip)
 
 if [ -z "$NO_AUTO_DHCP" ] && [ -z "$ip" ]; then
-    for s in $(getargs nameserver); do
-        [ -n "$s" ] || continue
-        echo nameserver $s >> /tmp/net.$netif.resolv.conf
-    done
-
     if [ "$netroot" = "dhcp6" ]; then
         do_dhcp -6
     else
         do_dhcp -4
     fi
+
+    for s in $(getargs nameserver); do
+        [ -n "$s" ] || continue
+        echo nameserver $s >> /tmp/net.$netif.resolv.conf
+    done
 fi
 
 
@@ -355,17 +355,6 @@ for p in $(getargs ip=); do
     # If this option isn't directed at our interface, skip it
     [ -n "$dev" ] && [ "$dev" != "$netif" ] && continue
 
-    # setup nameserver
-    for s in "$dns1" "$dns2" $(getargs nameserver); do
-        [ -n "$s" ] || continue
-        echo nameserver $s >> /tmp/net.$netif.resolv.conf
-    done
-
-    # Store config for later use
-    for i in ip srv gw mask hostname macaddr mtu dns1 dns2; do
-        eval '[ "$'$i'" ] && echo '$i'="$'$i'"'
-    done > /tmp/net.$netif.override
-
     for autoopt in $(str_replace "$autoconf" "," " "); do
         case $autoopt in
             dhcp|on|any)
@@ -381,6 +370,17 @@ for p in $(getargs ip=); do
     done
     ret=$?
 
+    # setup nameserver
+    for s in "$dns1" "$dns2" $(getargs nameserver); do
+        [ -n "$s" ] || continue
+        echo nameserver $s >> /tmp/net.$netif.resolv.conf
+    done
+
+    # Store config for later use
+    for i in ip srv gw mask hostname macaddr mtu dns1 dns2; do
+        eval '[ "$'$i'" ] && echo '$i'="$'$i'"'
+    done > /tmp/net.$netif.override
+
     if [ $ret -eq 0 ]; then
         > /tmp/net.${netif}.up
 
-- 
1.8.3.1
