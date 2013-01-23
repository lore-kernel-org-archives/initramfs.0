From: Kevin Yung <kevin.yung-QSbsa4wbOXo@public.gmane.org>
Subject: Patch
Date: Wed, 23 Jan 2013 22:51:45 +0000 (UTC)
Message-ID: <loom.20130123T233541-297@post.gmane.org>
References: <loom.20130123T230308-855@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--- ifup.sh.org 2013-01-21 17:46:19.000000000 +1100
+++ ifup.sh.new 2013-01-24 09:50:46.000000000 +1100
@@ -17,6 +17,8 @@

 # $netif reads easier than $1
 netif=$1
+use_bridge='false'
+use_vlan='false'

 # enslave this interface to bond?
 if [ -e /tmp/bond.info ]; then
@@ -46,6 +48,7 @@
                 : # We need to really setup bond (recursive call)
             else
                 netif="$bridgename"
+                use_bridge='true'
             fi
         fi
     done
@@ -58,6 +61,7 @@
             : # We need to really setup bond (recursive call)
         else
             netif="$vlanname"
+            use_vlan='true'
         fi
     fi
 fi
@@ -256,6 +260,7 @@
     fi
 fi

+
 # Specific configuration, spin through the kernel command line
 # looking for ip= lines
 for p in $(getargs ip=); do
@@ -264,7 +269,9 @@
     [ "$autoconf" = "ibft" ] && continue

     # If this option isn't directed at our interface, skip it
-    [ -n "$dev" ] && [ "$dev" != "$netif" ] && continue
+    [ -n "$dev" ] && [ "$dev" != "$netif" ] && \
+    [ "$use_bridge" != 'true' ] && \
+    [ "$use_vlan" != 'true' ] && continue

     # Store config for later use
     for i in ip srv gw mask hostname macaddr; do
