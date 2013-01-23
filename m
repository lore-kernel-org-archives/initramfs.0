From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/6] dm/md: Only include UUIDs once in the command line.
Date: Wed, 23 Jan 2013 20:15:01 +0000
Message-ID: <1358972106-2395-2-git-send-email-colin@mageia.org>
References: <1358972106-2395-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358972106-2395-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

This shouldn't really cause any problems, but it's nice to be neat.

Also make the lvm check more efficient when running in kernel_only mode.
---
 modules.d/90dmraid/module-setup.sh | 7 +++++--
 modules.d/90lvm/module-setup.sh    | 6 +++---
 modules.d/90mdraid/module-setup.sh | 7 +++++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/modules.d/90dmraid/module-setup.sh b/modules.d/90dmraid/module-setup.sh
index eb949dc..c3bddb7 100755
--- a/modules.d/90dmraid/module-setup.sh
+++ b/modules.d/90dmraid/module-setup.sh
@@ -3,7 +3,7 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 check() {
-    local _rootdev
+    local _rootdev _activated
     # if we don't have dmraid installed on the host system, no point
     # in trying to support it in the initramfs.
     type -P dmraid >/dev/null || return 1
@@ -32,7 +32,10 @@ check() {
 
         [[ ${DM_NAME} ]] || return 1
         if ! [[ $kernel_only ]]; then
-            echo " rd.dm.uuid=${DM_NAME} " >> "${initdir}/etc/cmdline.d/90dmraid.conf"
+            if ! strstr " ${_activated[*]} " " ${DM_NAME} "; then
+                echo " rd.dm.uuid=${DM_NAME} " >> "${initdir}/etc/cmdline.d/90dmraid.conf"
+                push _activated "${DM_NAME}"
+            fi
         fi
         return 0
     }
diff --git a/modules.d/90lvm/module-setup.sh b/modules.d/90lvm/module-setup.sh
index cefd3e9..a537b1a 100755
--- a/modules.d/90lvm/module-setup.sh
+++ b/modules.d/90lvm/module-setup.sh
@@ -12,11 +12,11 @@ check() {
         eval $(udevadm info --query=property --name=/dev/block/$1|egrep '(DM_VG_NAME|DM_LV_NAME|DM_UDEV_DISABLE_DISK_RULES_FLAG)=')
         [[ "$DM_UDEV_DISABLE_DISK_RULES_FLAG" = "1" ]] && return 1
         [[ ${DM_VG_NAME} ]] && [[ ${DM_LV_NAME} ]] || return 1
-        if ! strstr " ${_activated[*]} " " ${DM_VG_NAME}/${DM_LV_NAME} "; then
-            if ! [[ $kernel_only ]]; then
+        if ! [[ $kernel_only ]]; then
+            if ! strstr " ${_activated[*]} " " ${DM_VG_NAME}/${DM_LV_NAME} "; then
                 echo " rd.lvm.lv=${DM_VG_NAME}/${DM_LV_NAME} " >> "${initdir}/etc/cmdline.d/90lvm.conf"
+                push _activated "${DM_VG_NAME}/${DM_LV_NAME}"
             fi
-            push _activated "${DM_VG_NAME}/${DM_LV_NAME}"
         fi
         return 0
     }
diff --git a/modules.d/90mdraid/module-setup.sh b/modules.d/90mdraid/module-setup.sh
index 3b5620c..116b822 100755
--- a/modules.d/90mdraid/module-setup.sh
+++ b/modules.d/90mdraid/module-setup.sh
@@ -3,7 +3,7 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 check() {
-    local _rootdev
+    local _rootdev _activated
     # No mdadm?  No mdraid support.
     type -P mdadm >/dev/null || return 1
 
@@ -21,7 +21,10 @@ check() {
 
         [[ ${MD_UUID} ]] || return 1
         if ! [[ $kernel_only ]]; then
-            echo " rd.md.uuid=${MD_UUID} " >> "${initdir}/etc/cmdline.d/90mdraid.conf"
+            if ! strstr " ${_activated[*]} " " ${MD_UUID} "; then
+                echo " rd.md.uuid=${MD_UUID} " >> "${initdir}/etc/cmdline.d/90mdraid.conf"
+                push _activated "${MD_UUID}"
+            fi
         fi
         return 0
     }
-- 
1.8.1
