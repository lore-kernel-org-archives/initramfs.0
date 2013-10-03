From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] mdraid/module-setup.sh: install configs from
 /etc/mdadm.conf.d
Date: Thu, 3 Oct 2013 14:54:42 +0400
Message-ID: <E1VRhgp-0000kE-7E@secretive.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Message-Id:To:Subject:Date:From; bh=K75nipgVf9Ng4V4aEhK6ih6TuyTzcikamr7w2NAVMX0=;
	b=WSyaBXhkdpaIZiiro1HyEFtlsyB5rpR6dXb2fciww9He3U8KDdL5XaAaJxFGpAYYCkJxHpR++KDOJ2xaLAMdZo4CDzMQ7Xb5oTzfMxYUCQHLzuqeSP/XaAJDNS9liXZ8wf+NkTUnIbQMOkP0mAE79qoXj7RPGl7gSe+qAmBk/cY=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

/etc/mdadm.conf.d directory is supported since mdadm-3.3
---
 modules.d/90mdraid/module-setup.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/modules.d/90mdraid/module-setup.sh b/modules.d/90mdraid/module-setup.sh
index 1d72f21..34aae1e 100755
--- a/modules.d/90mdraid/module-setup.sh
+++ b/modules.d/90mdraid/module-setup.sh
@@ -102,6 +102,14 @@ install() {
         else
             [ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf /etc/mdadm.conf
         fi
+        if [ -d /etc/mdadm.conf.d ]; then
+            local f
+            inst_dir /etc/mdadm.conf.d
+            for f in /etc/mdadm.conf.d/*.conf; do
+                [ -f "$f" ] || continue
+                inst "$f"
+            done
+        fi
     fi
 
     inst_hook pre-udev 30 "$moddir/mdmon-pre-udev.sh"
-- 
1.8.1.5
