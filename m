From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: dhclient.* files become net.* only after successful netboot
Date: Wed, 10 Jun 2009 01:03:00 -0400
Message-ID: <4A2F3E84.8070403@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090801090807020003020704"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------090801090807020003020704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Somehow the final chunk of this patch isn't working.  Isn't that part 
supposed to happen only on the occasion where netroot is successfully 
mounted?  I seem to be missing something simple here...

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

--------------090801090807020003020704
Content-Type: text/x-patch;
 name="0001-dhclient.-files-become-net.-only-after-successful.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-dhclient.-files-become-net.-only-after-successful.patch"

From 11f573d4564e34846011c8771f78ac001bc51b1c Mon Sep 17 00:00:00 2001
From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Wed, 10 Jun 2009 00:57:05 -0400
Subject: [PATCH] dhclient.* files become net.* only after successful netboot.
 This is an attempt to avoid confusing post-boot scripts by having them
 consider only net.* files.

---
 modules.d/40network/dhclient-script |    2 +-
 modules.d/40network/ifup            |    4 ++--
 modules.d/40network/netroot         |    2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 1ee78fe..8997477 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -75,7 +75,7 @@ case $reason in
 	setup_interface 
 	set | while read line; do
 	    [ "${line#new_}" = "$line" ] && continue
-	    echo "$line" >>/tmp/net.$netif.dhcpopts
+	    echo "$line" >>/tmp/dhclient.$netif.dhcpopts
 	done
 	>/tmp/net.$netif.up
 	echo online > /sys/class/net/$netif/uevent ;;
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index de459c3..9e23274 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -51,7 +51,7 @@ do_static() {
 	    hostname $hostname
     }
     [ -n "$srv" ] &&
-	echo "new_dhcp_server_identifier=$srv" > /tmp/net.$netif.dhcpopts
+	echo "new_dhcp_server_identifier=$srv" > /tmp/dhclient.$netif.dhcpopts
 
     >/tmp/net.$netif.up
     echo online > /sys/class/net/$netif/uevent
@@ -70,7 +70,7 @@ do_dhcp() {
     # /sbin/dhclient-script will mark the netif up and generate the online
     # event for nfsroot
     # XXX add -V vendor class and option parsing per kernel
-    dhclient -1 -q -R ${reqs} -pf /tmp/dhclient.$netif.pid -lf /tmp/net.$netif.lease $netif
+    dhclient -1 -q -R ${reqs} -pf /tmp/dhclient.$netif.pid -lf /tmp/dhclient.$netif.lease $netif
 }
 
 ip_to_var() {
diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index 3d03e72..c66e8ab 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -47,6 +47,8 @@ fi
 # XXX other variables to export?
 export NEWROOT
 if $handler $netif $root; then
+    cp /tmp/dhclient.$netif.lease    /tmp/net.$netif.lease
+    cp /tmp/dhclient.$netif.dhcpopts /tmp/net.$netif.dhcpopts
     >/tmp/netroot.done
 fi
 exit 0
-- 
1.6.2.2


--------------090801090807020003020704--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
