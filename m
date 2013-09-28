From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH v2] mdraid/module-setup.sh: fixes for mdadm-3.2.6+
Date: Sun, 29 Sep 2013 01:31:01 +0400
Message-ID: <1380403861.17657.4.camel@home.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:Date:To:From:Subject:Message-ID; bh=OpUgcXBRXLdsqBpfH5avl2hVOXA9IdSQkJmEPjjN6vs=;
	b=hTHXW92UdtkEhbygY75hibf3HKixwph+0DYTtIXWHPAxqFqekmDMCPbbEmzFztjr4ACila30Nn6vVsCqzAt1elQv5GZdYY8ll2ii6uB4Io42p5Nn7qSkjhxlngkDrXzQCOnMbNvlhUwh6+Y9Tz82YDCsPwaXO4V4O7nF+WlC2SE=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

mdadm-3.2.6+:
Incremental assembly rule contains "--offroot" arg. Update
regexp to catch this variant.

mdadm-3.3+:
Rules was splitted into two files: 63-md-raid-arrays.rules
and 64-md-raid-assembly.rules. Install them both and edit
the latter.
---
 modules.d/90mdraid/module-setup.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/modules.d/90mdraid/module-setup.sh b/modules.d/90mdraid/module-setup.sh
index 5df2274..1d72f21 100755
--- a/modules.d/90mdraid/module-setup.sh
+++ b/modules.d/90mdraid/module-setup.sh
@@ -59,6 +59,7 @@ cmdline() {
 }
 
 install() {
+    local rule rule_path
     inst_multiple cat
     inst_multiple -o mdmon
     inst $(command -v partx) /sbin/partx
@@ -67,12 +68,20 @@ install() {
     cmdline  >> "${initdir}/etc/cmdline.d/90mdraid.conf"
     echo  >> "${initdir}/etc/cmdline.d/90mdraid.conf"
 
+    # <mdadm-3.3 udev rule
     inst_rules 64-md-raid.rules
+    # >=mdadm-3.3 udev rules
+    inst_rules 63-md-raid-arrays.rules 64-md-raid-assembly.rules
     # remove incremental assembly from stock rules, so they don't shadow
     # 65-md-inc*.rules and its fine-grained controls, or cause other problems
     # when we explicitly don't want certain components to be incrementally
     # assembled
-    sed -i -r -e '/RUN\+?="[[:alpha:]/]*mdadm[[:blank:]]+(--incremental|-I)[[:blank:]]+(\$env\{DEVNAME\}|\$tempnode)"/d' "${initdir}${udevdir}/rules.d/64-md-raid.rules"
+    for rule in 64-md-raid.rules 64-md-raid-assembly.rules; do
+        rule_path="${initdir}${udevdir}/rules.d/${rule}"
+        [ -f "${rule_path}" ] && sed -i -r \
+            -e '/RUN\+?="[[:alpha:]/]*mdadm[[:blank:]]+(--incremental|-I)[[:blank:]]+(\$env\{DEVNAME\}|\$tempnode|\$devnode)/d' \
+            "${rule_path}"
+    done
 
     inst_rules "$moddir/65-md-incremental-imsm.rules"
 
-- 
1.8.1.5

