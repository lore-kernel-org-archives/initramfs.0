From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 19/33] Restore original IFS value
Date: Thu, 20 Nov 2014 15:56:54 +0100
Message-ID: <1416495428-36978-20-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

Whenever the IFS setting is modified it needs to be restored to
its original value. Otherwise it'll lead to unexpected results.

References: bnc#883770

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/90kernel-modules/insmodpost.sh   | 2 ++
 modules.d/90kernel-modules/parse-kernel.sh | 4 ++++
 modules.d/95iscsi/module-setup.sh          | 6 ++++--
 modules.d/98systemd/dracut-pre-udev.sh     | 4 ++++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/modules.d/90kernel-modules/insmodpost.sh b/modules.d/90kernel-modules/insmodpost.sh
index 4362f0a..b4bcdd0 100755
--- a/modules.d/90kernel-modules/insmodpost.sh
+++ b/modules.d/90kernel-modules/insmodpost.sh
@@ -4,9 +4,11 @@
 
 for modlist in $(getargs rd.driver.post -d rdinsmodpost=); do
     (
+        OLDIFS="$IFS"
         IFS=,
         for m in $modlist; do
             modprobe $m
         done
+        IFS="$OLDIFS"
     )
 done
diff --git a/modules.d/90kernel-modules/parse-kernel.sh b/modules.d/90kernel-modules/parse-kernel.sh
index cbe7c85..81f7131 100755
--- a/modules.d/90kernel-modules/parse-kernel.sh
+++ b/modules.d/90kernel-modules/parse-kernel.sh
@@ -11,10 +11,12 @@ fi
 
 for i in $(getargs rd.driver.pre -d rdloaddriver=); do
     (
+        OLDIFS="$IFS"
         IFS=,
         for p in $i; do
             modprobe $p 2>&1 | vinfo
         done
+        IFS="$OLDIFS"
     )
 done
 
@@ -23,10 +25,12 @@ done
 
 for i in $(getargs rd.driver.blacklist -d rdblacklist=); do
     (
+        OLDIFS="$IFS"
         IFS=,
         for p in $i; do
             echo "blacklist $p" >>  $_modprobe_d/initramfsblacklist.conf
         done
+        IFS="$OLDIFS"
     )
 done
 
diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
index 9975e59..f551c49 100755
--- a/modules.d/95iscsi/module-setup.sh
+++ b/modules.d/95iscsi/module-setup.sh
@@ -29,16 +29,18 @@ check() {
 }
 
 get_ibft_mod() {
-    local ibft_mac=$1
+    local ibft_mac=$1 IFS
     # Return the iSCSI offload module for a given MAC address
     iscsiadm -m iface | while read iface_name iface_desc ; do
+        OLDIFS="$IFS"
         IFS=$','
         set -- $iface_desc
+        IFS="$OLDIFS"
         if [ "$ibft_mac" = "$2" ] ; then
             echo $1
             return 0
         fi
-        unset IFS
+        
     done
 }
 
diff --git a/modules.d/98systemd/dracut-pre-udev.sh b/modules.d/98systemd/dracut-pre-udev.sh
index ca13048..b2be0e0 100755
--- a/modules.d/98systemd/dracut-pre-udev.sh
+++ b/modules.d/98systemd/dracut-pre-udev.sh
@@ -24,10 +24,12 @@ fi
 
 for i in $(getargs rd.driver.pre -d rdloaddriver=); do
     (
+        OLDIFS="$IFS"
         IFS=,
         for p in $i; do
             modprobe $p 2>&1 | vinfo
         done
+        IFS="$OLDIFS"
     )
 done
 
@@ -36,10 +38,12 @@ done
 
 for i in $(getargs rd.driver.blacklist -d rdblacklist=); do
     (
+        OLDIFS="$IFS"
         IFS=,
         for p in $i; do
             echo "blacklist $p" >>  $_modprobe_d/initramfsblacklist.conf
         done
+        IFS="$OLDIFS"
     )
 done
 
-- 
1.8.5.2
