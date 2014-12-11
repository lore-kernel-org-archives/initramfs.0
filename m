From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 40/42] Don't create lots of empty cmdline files for hostonly-cmdline case
Date: Thu, 11 Dec 2014 15:46:31 +0100
Message-ID: <1418309193-11208-41-git-send-email-trenn@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>

From: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>

This aligns other places piping cmdline() output to cmdline.d files
with the earlier fix for 95rootfs-block.

Signed-off-by: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/90crypt/module-setup.sh  | 4 ++--
 modules.d/90dmraid/module-setup.sh | 4 ++--
 modules.d/90lvm/module-setup.sh    | 4 ++--
 modules.d/90mdraid/module-setup.sh | 4 ++--
 modules.d/95resume/module-setup.sh | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/modules.d/90crypt/module-setup.sh b/modules.d/90crypt/module-setup.sh
index 37ae859..ea1e340 100755
--- a/modules.d/90crypt/module-setup.sh
+++ b/modules.d/90crypt/module-setup.sh
@@ -50,8 +50,8 @@ cmdline() {
 install() {
 
     if [[ $hostonly_cmdline == "yes" ]]; then
-        cmdline >> "${initdir}/etc/cmdline.d/90crypt.conf"
-        echo >> "${initdir}/etc/cmdline.d/90crypt.conf"
+        local _cryptconf=$(cmdline)
+        [[ $_cryptconf ]] && printf "%s\n" "$_cryptconf" >> "${initdir}/etc/cmdline.d/90crypt.conf"
     fi
 
     inst_multiple cryptsetup rmdir readlink umount
diff --git a/modules.d/90dmraid/module-setup.sh b/modules.d/90dmraid/module-setup.sh
index 508598b..044e01f 100755
--- a/modules.d/90dmraid/module-setup.sh
+++ b/modules.d/90dmraid/module-setup.sh
@@ -64,8 +64,8 @@ install() {
     local _i
 
     if [[ $hostonly_cmdline == "yes" ]]; then
-        cmdline >> "${initdir}/etc/cmdline.d/90dmraid.conf"
-        echo >> "${initdir}/etc/cmdline.d/90dmraid.conf"
+        local _raidconf=$(cmdline)
+        [[ $_raidconf ]] && printf "%s\n" "$_raidconf" >> "${initdir}/etc/cmdline.d/90dmraid.conf"
     fi
 
     inst_multiple dmraid
diff --git a/modules.d/90lvm/module-setup.sh b/modules.d/90lvm/module-setup.sh
index 5515ac0..592a2e2 100755
--- a/modules.d/90lvm/module-setup.sh
+++ b/modules.d/90lvm/module-setup.sh
@@ -53,8 +53,8 @@ install() {
     inst lvm
 
     if [[ $hostonly_cmdline == "yes" ]]; then
-        cmdline >> "${initdir}/etc/cmdline.d/90lvm.conf"
-        echo >> "${initdir}/etc/cmdline.d/90lvm.conf"
+        local _lvmconf=$(cmdline)
+        [[ $_lvmconf ]] && printf "%s\n" "$_lvmconf" >> "${initdir}/etc/cmdline.d/90lvm.conf"
     fi
 
     inst_rules "$moddir/64-lvm.rules"
diff --git a/modules.d/90mdraid/module-setup.sh b/modules.d/90mdraid/module-setup.sh
index ce3394a..747ea8a 100755
--- a/modules.d/90mdraid/module-setup.sh
+++ b/modules.d/90mdraid/module-setup.sh
@@ -71,8 +71,8 @@ install() {
     inst $(command -v mdadm) /sbin/mdadm
 
     if [[ $hostonly_cmdline == "yes" ]]; then
-        cmdline  >> "${initdir}/etc/cmdline.d/90mdraid.conf"
-        echo  >> "${initdir}/etc/cmdline.d/90mdraid.conf"
+        local _raidconf=$(cmdline)
+        [[ $_raidconf ]] && printf "%s\n" "$_raidconf" >> "${initdir}/etc/cmdline.d/90mdraid.conf"
     fi
 
     # <mdadm-3.3 udev rule
diff --git a/modules.d/95resume/module-setup.sh b/modules.d/95resume/module-setup.sh
index 1ddb6e4..dfd4350 100755
--- a/modules.d/95resume/module-setup.sh
+++ b/modules.d/95resume/module-setup.sh
@@ -29,8 +29,8 @@ install() {
     local _bin
 
     if [[ $hostonly_cmdline == "yes" ]]; then
-        cmdline  >> "${initdir}/etc/cmdline.d/95resume.conf"
-        echo  >> "${initdir}/etc/cmdline.d/95resume.conf"
+	local _resumeconf=$(cmdline)
+	[[ $_resumeconf ]] && printf "%s\n" "$_resumeconf" >> "${initdir}/etc/cmdline.d/95resume.conf"
     fi
 
     # Optional uswsusp support
-- 
1.8.5.2
