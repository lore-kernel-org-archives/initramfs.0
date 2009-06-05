From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Don't use absolute path for ip, does not always work
Date: Fri, 5 Jun 2009 16:36:03 +0200
Message-ID: <4A292D53.9080603@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

---
diff --git a/modules.d/40network/dhclient-script 
b/modules.d/40network/dhclient-script
index 1ee78fe..d283762 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -69,7 +69,7 @@ setup_interface() {

  case $reason in
      PREINIT)
-       run /sbin/ip link set $netif up
+       run ip link set $netif up
         ;;
      BOUND)
         setup_interface
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
