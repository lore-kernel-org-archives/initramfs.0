From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] lvm/module-setup.sh: do not hardcode udevdir path
Date: Tue, 20 May 2014 15:25:18 +0400
Message-ID: <E1WmiPL-0001QQ-Oe@puleglot.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Message-Id:To:Subject:Date:From; bh=GIuS65lb3nF1Evh3iFc2hcplGKfGtrqzUmGb6qUGnkk=;
	b=XPjzXcdJslqlkFzfVQDn7m8KYD0chPI5j7nST//WBT76wMwnQ2rklgK5OZFQqzyTrsMXeTNKGPK6yhz3c4H8qKKX5nCYfazFkop4bYn+uGpE3InSH/Rx7X//ErLATA/N9r7cIYwVHs0YFHuDfRVxqVJ8Nj2a8mKOlJ/95mVp5Eg=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Do not hardcode udevdir path. Also make sed nicer and fix the
check for existence of 69-dm-lvm-metad.rules
---
 modules.d/90lvm/module-setup.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/modules.d/90lvm/module-setup.sh b/modules.d/90lvm/module-setup.sh
index 5b810b9..529b795 100755
--- a/modules.d/90lvm/module-setup.sh
+++ b/modules.d/90lvm/module-setup.sh
@@ -80,13 +80,17 @@ install() {
     inst_rules 11-dm-lvm.rules 69-dm-lvm-metad.rules
 
     # Do not run lvmetad update via pvscan in udev rule  - lvmetad is not running yet in dracut!
-    if [[ -f ${initdir}/lib/udev/rules.d/69-dm-lvm-metad.rules ]] && \
-        grep -q SYSTEMD_WANTS ${initdir}/lib/udev/rules.d/69-dm-lvm-metad.rules; then
-        sed -i -e 's/^ENV{SYSTEMD_ALIAS}=.*/# No LVM pvscan in dracut - lvmetad is not running yet/' ${initdir}/lib/udev/rules.d/69-dm-lvm-metad.rules
-        sed -i -e 's/^ENV{ID_MODEL}=.*//' ${initdir}/lib/udev/rules.d/69-dm-lvm-metad.rules
-        sed -i -e 's/^ENV{SYSTEMD_WANTS}=.*//' ${initdir}/lib/udev/rules.d/69-dm-lvm-metad.rules
-    else
-        sed -i -e 's/.*lvm pvscan.*/# No LVM pvscan for in dracut - lvmetad is not running yet/' ${initdir}/lib/udev/rules.d/69-dm-lvm-metad.rules
+    if [[ -f ${initdir}${udevdir}/rules.d/69-dm-lvm-metad.rules ]]; then
+        if grep -q SYSTEMD_WANTS ${initdir}${udevdir}/rules.d/69-dm-lvm-metad.rules; then
+            sed -i \
+                -e 's/^ENV{SYSTEMD_ALIAS}=.*/# No LVM pvscan in dracut - lvmetad is not running yet/' \
+                -e 's/^ENV{ID_MODEL}=.*//' \
+                -e 's/^ENV{SYSTEMD_WANTS}=.*//' \
+                ${initdir}${udevdir}/rules.d/69-dm-lvm-metad.rules
+        else
+            sed -i -e 's/.*lvm pvscan.*/# No LVM pvscan for in dracut - lvmetad is not running yet/' \
+                ${initdir}${udevdir}/rules.d/69-dm-lvm-metad.rules
+        fi
     fi
 
     # Gentoo ebuild for LVM2 prior to 2.02.63-r1 doesn't install above rules
-- 
1.8.5.5
