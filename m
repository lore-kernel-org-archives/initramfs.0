From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] udev-rules: add 80-net-setup-link.rules and .link files
Date: Mon, 3 Mar 2014 21:49:28 +0400
Message-ID: <E1WKXL5-0000nX-FT@secretive.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Message-Id:To:Subject:Date:From; bh=JUw9VMLUUwNt1cKkt9CxASeMT1Pff2ixteWIoR9LcMI=;
	b=BWOqJb68s3/aNUAph+kITMxean7bXcD9/iyd9jTlVnjC8VHZLCZGDQoaAMNchimlisHe+aDH3f/GH7V9KRWRjHytWn5ImESGBaIRF/l3+uJYlMsi6Hlft9HksQ6TTaYrW+FuAUIcB4451ViQneUskyG+g7+vZyEO4+qNZiGiXPU=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

With systemd >= 209 these file are required for predictable network interface
names
---
 modules.d/95udev-rules/module-setup.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/modules.d/95udev-rules/module-setup.sh b/modules.d/95udev-rules/module-setup.sh
index 584d5c8..2d36712 100755
--- a/modules.d/95udev-rules/module-setup.sh
+++ b/modules.d/95udev-rules/module-setup.sh
@@ -32,7 +32,8 @@ install() {
         60-pcmcia.rules \
         50-udev.rules 95-late.rules \
         50-firmware.rules \
-        75-net-description.rules 80-net-name-slot.rules \
+        75-net-description.rules \
+        80-net-name-slot.rules 80-net-setup-link.rules \
         "$moddir/59-persistent-storage.rules" \
         "$moddir/61-persistent-storage.rules"
 
@@ -42,6 +43,13 @@ install() {
     # eudev rules
     inst_rules 80-drivers-modprobe.rules
 
+    for _i in \
+        ${systemdutildir}/network/*.link \
+        ${hostonly:+/etc/systemd/network/*.link} \
+        ; do
+        [[ -e "$_i" ]] && inst "$_i"
+    done
+
     {
         for i in cdrom tape dialout floppy; do
             if ! egrep -q "^$i:" "$initdir/etc/group" 2>/dev/null; then
-- 
1.8.3.2
