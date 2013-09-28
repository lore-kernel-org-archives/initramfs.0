From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] mdraid/module-setup.sh: fixes for mdadm-3.2.6+
Date: Sat, 28 Sep 2013 16:32:55 +0400
Message-ID: <1380371575.4054.1.camel@home.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:Date:To:From:Subject:Message-ID; bh=+DTY3+tDZ1X76cmCOFCUH/vbPvuMCw8OucNMlW5M5OA=;
	b=J0qfjuojpenEk0PU98nENJmIe1LI4eWgDwSwKl0neLYCDz0Wdlsfi7z3yUoRAzIphH1FmPLAfGLFm0mZ/b8LAY7YywXwX26EEWzAHkc7MdPK+7z5NqyCMkPb8nxBVXOpbs85+NXRkyBsQts+lMTu/0MJ6XhjvDKC/JmAl5aXRY0=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Fix the following issues:
- mdadm-3.2.6: incremental assembly rule contain "--offroot" arg. Catch
  this variant.
- mdadm-3.3: rules was splitted into two files: 63-md-raid-arrays.rules,
  64-md-raid-assembly.rules. Install the former, omit the latter.
---
 modules.d/90mdraid/module-setup.sh | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/modules.d/90mdraid/module-setup.sh b/modules.d/90mdraid/module-setup.sh
index 5df2274..d42f0f0 100755
--- a/modules.d/90mdraid/module-setup.sh
+++ b/modules.d/90mdraid/module-setup.sh
@@ -68,11 +68,17 @@ install() {
     echo  >> "${initdir}/etc/cmdline.d/90mdraid.conf"
 
     inst_rules 64-md-raid.rules
-    # remove incremental assembly from stock rules, so they don't shadow
-    # 65-md-inc*.rules and its fine-grained controls, or cause other problems
-    # when we explicitly don't want certain components to be incrementally
-    # assembled
-    sed -i -r -e '/RUN\+?="[[:alpha:]/]*mdadm[[:blank:]]+(--incremental|-I)[[:blank:]]+(\$env\{DEVNAME\}|\$tempnode)"/d' "${initdir}${udevdir}/rules.d/64-md-raid.rules"
+    local rules_path="${initdir}${udevdir}/rules.d/64-md-raid.rules"
+    if [ -f "${rules_path}" ]; then
+        # remove incremental assembly from stock rules, so they don't shadow
+        # 65-md-inc*.rules and its fine-grained controls, or cause other problems
+        # when we explicitly don't want certain components to be incrementally
+        # assembled
+        sed -i -r -e '/RUN\+?="[[:alpha:]/]*mdadm[[:blank:]]+(--incremental|-I)[[:blank:]]+(\$env\{DEVNAME\}|\$tempnode|\$devnode)/d' "${rules_path}"
+    else
+        # omit installation of 64-md-raid-assembly.rules for the same reason
+        inst_rules 63-md-raid-arrays.rules
+    fi
 
     inst_rules "$moddir/65-md-incremental-imsm.rules"
 
-- 
1.8.1.5

