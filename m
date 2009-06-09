From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: /dev/.initramfs copy state before switch_root
Date: Tue, 9 Jun 2009 09:37:28 +0200
Message-ID: <4A2E1138.9050600@bfh.ch>
References: <4A2D8242.40205@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A2D8242.40205-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Warren Togami wrote:
[snip]
> * net.<interface name>.lease is written containing the DHCP lease, 
> because dcbw asked for this for NetworkManager.  Your own tools could 
> choose to do something with it or not.

By the way, why not do this:
---
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index de459c3..8280b73 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -70,7 +70,7 @@ do_dhcp() {
     # /sbin/dhclient-script will mark the netif up and generate the online
     # event for nfsroot
     # XXX add -V vendor class and option parsing per kernel
-    dhclient -1 -q -R ${reqs} -pf /tmp/dhclient.$netif.pid -lf /tmp/net.$netif.lease $netif
+    dhclient -1 -q -R ${reqs} -pf /tmp/dhclient.$netif.pid -lf /dev/.initramfs/net.$netif.lease $netif
 }
 
 ip_to_var() {
diff --git a/modules.d/99base/init b/modules.d/99base/init
index fb1a604..eab923e 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -35,6 +35,7 @@ mknod /dev/null c 1 3
 mknod /dev/ptmx c 5 2
 mknod /dev/console c 5 1
 mkdir /dev/pts
+mkdir /dev/.initramfs/
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts >/dev/null 2>&1
 
 # run scriptlets to parse the command line
@@ -139,7 +140,6 @@ for x in "$@"; do
 done
 
 # Copy state
-mkdir /dev/.initramfs/
 if getarg rdcopystate; then
     cp /tmp/* /dev/.initramfs/ >/dev/null 2>&1
 else
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
