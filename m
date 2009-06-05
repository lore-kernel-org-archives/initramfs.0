From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Make kill-dhclient.sh more readable
Date: Fri, 5 Jun 2009 11:45:01 +0200
Message-ID: <4A28E91D.1000006@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Checking for existing file is more readable than string comparison

---
diff --git a/modules.d/40network/kill-dhclient.sh b/modules.d/40network/kill-dhclient.sh
index 19f258a..fcebd32 100755
--- a/modules.d/40network/kill-dhclient.sh
+++ b/modules.d/40network/kill-dhclient.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
 
 for f in /tmp/dhclient.*.pid; do
-    [ "$f" != "/tmp/dhclient.*.pid" ] && kill $(cat $f)
+    [ -e $f ] && kill $(cat $f)
 done

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
