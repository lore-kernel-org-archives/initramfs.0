From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] udev-rules: include *-net-*.rules only if network module is
 included
Date: Wed, 5 Mar 2014 17:07:17 +0400
Message-ID: <E1WLCB8-0001PM-6J@secretive.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Message-Id:To:Subject:Date:From; bh=PzbMOPFbxnNEkxh/aeLNi2cSnUS4/zTtBhckb63kPlc=;
	b=Frvy5wHiiNAzFfpOMdo+4j6SZ/Xai0RrG3NAoxTx3aXel5ksqPSwJg7JHMTWWpg94p2pE2Uok+82Vus5cKC0xyjNPzEjoWfuHJB4z0qIcZ5GJfSlL15umhBkDwrqgw3gH84IFQF2MEkaqcE045wGzPikg5espoon/32bM0FSjGY=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Users have a choice to disable predictable network names by creating
a symlink in /etc:
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules

However this doesn't work with non-hostonly initramfs if network drivers are
compiled into the kernel - network interfaces gets renamed by udev from
initramfs.

So if "network" module is not included in initramfs, let's rename network
interfaces during coldplug after switching root.

https://bugs.gentoo.org/show_bug.cgi?id=487184
---
 modules.d/95udev-rules/module-setup.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/modules.d/95udev-rules/module-setup.sh b/modules.d/95udev-rules/module-setup.sh
index 2d36712..199e9a3 100755
--- a/modules.d/95udev-rules/module-setup.sh
+++ b/modules.d/95udev-rules/module-setup.sh
@@ -32,8 +32,6 @@ install() {
         60-pcmcia.rules \
         50-udev.rules 95-late.rules \
         50-firmware.rules \
-        75-net-description.rules \
-        80-net-name-slot.rules 80-net-setup-link.rules \
         "$moddir/59-persistent-storage.rules" \
         "$moddir/61-persistent-storage.rules"
 
@@ -43,12 +41,16 @@ install() {
     # eudev rules
     inst_rules 80-drivers-modprobe.rules
 
-    for _i in \
-        ${systemdutildir}/network/*.link \
-        ${hostonly:+/etc/systemd/network/*.link} \
-        ; do
-        [[ -e "$_i" ]] && inst "$_i"
-    done
+    if dracut_module_included "network"; then
+        inst_rules 75-net-description.rules \
+            80-net-name-slot.rules 80-net-setup-link.rules
+        for _i in \
+            ${systemdutildir}/network/*.link \
+            ${hostonly:+/etc/systemd/network/*.link} \
+            ; do
+            [[ -e "$_i" ]] && inst "$_i"
+        done
+    fi
 
     {
         for i in cdrom tape dialout floppy; do
-- 
1.8.3.2
