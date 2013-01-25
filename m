From: Kevin Yung <Kevin.Yung-QSbsa4wbOXo@public.gmane.org>
Subject: [PATCH] Set IP options on bridge and vlan interface
Date: Sat, 26 Jan 2013 02:29:24 +1100
Message-ID: <0EE37DC3-9FF1-436B-B026-35C7EC6D09BB@myob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi all,

Just to tidy up my previous emails about the patch for net boot on bridge and vlan.

I made the patch for system to boot off network on a vlan or using a bridge network.
To use vlan for net boot, you need to specify vlan and ip kernel options for the boot interface. For example,

  vlan=eth1.1:eth1 bootdev=eth1.1 ip=1.2.3.4:1.2.3.4::255.255.255.0:my-hostname:eth1:none

To use bridge for net boot, you need to specify bridge and ip kernel option for the boot interface. For example

  bridge=br1:eth1 bootdev=br1 ip=1.2.3.4:1.2.3.4::255.255.255.0:my-hostname:eth1:none

In my environment, I needs to boot machines from network within a vlan or on a bridged network.
I found curent dracut release if-up.sh script in 40network module bypass ip setting for both bridge and vlan interface.

Please see the patch I created. And please let me know if I need to tidy it up a bit more or
add additional code to handle ip settings for bridge and vlan.

[PATCH]
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

[END]

Cheers
Kevin



This email and any attachment are confidential. If you are not the intended recipient, please notify MYOB by reply email and delete this email. Please note that you must not access or use this email or any information in it. MYOB accepts no liability for viruses in this email or in any attachment to it.
