From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Recognize nodmraid and noiswmd kernel cmdline options
Date: Fri, 18 Sep 2009 09:01:09 +0200
Message-ID: <1253257269-2548-1-git-send-email-hdegoede@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Recognize nodmraid and noiswmd kernel cmdline options, for anaconda /
rc.sysinit / mkinitrd compatibility.
---
 modules.d/90dmraid/parse-dm.sh |    3 ++-
 modules.d/90mdraid/parse-md.sh |    4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/modules.d/90dmraid/parse-dm.sh b/modules.d/90dmraid/parse-dm.sh
index 07208a5..f031569 100644
--- a/modules.d/90dmraid/parse-dm.sh
+++ b/modules.d/90dmraid/parse-dm.sh
@@ -1,4 +1,5 @@
-if getarg rd_NO_DM; then
+# nodmraid for anaconda / rc.sysinit compatibility
+if getarg rd_NO_DM || getarg nodmraid; then
     info "rd_NO_DM: removing DM RAID activation"
     udevproperty rd_NO_DM=1
 fi
diff --git a/modules.d/90mdraid/parse-md.sh b/modules.d/90mdraid/parse-md.sh
index cf9298f..6e2a3bf 100644
--- a/modules.d/90mdraid/parse-md.sh
+++ b/modules.d/90mdraid/parse-md.sh
@@ -30,7 +30,9 @@ if [ -e /etc/mdadm.conf ] && ! getarg rd_NO_MDADMCONF; then
     rm -f /pre-pivot/*mdraid-cleanup.sh
 fi
 
-if getarg rd_NO_MDIMSM; then
+# noiswmd nodmraid for anaconda / rc.sysinit compatibility
+# note nodmraid really means nobiosraid, so we don't want MDIMSM then either
+if getarg rd_NO_MDIMSM || getarg noiswmd || getarg nodmraid; then
     info "rd_NO_MDIMSM: no MD RAID for imsm/isw raids"
     udevproperty rd_NO_MDIMSM=1
 fi
-- 
1.6.4.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
