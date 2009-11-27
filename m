From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 4/6] All module scripts should have a shebang
Date: Fri, 27 Nov 2009 11:57:14 +0100
Message-ID: <1259319436-14925-5-git-send-email-philippe.seewer@bfh.ch>
References: <1259319436-14925-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259319436-14925-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/90crypt/crypt-cleanup.sh               |    1 +
 modules.d/90crypt/parse-crypt.sh                 |    1 +
 modules.d/90dmsquash-live/parse-dmsquash-live.sh |    1 +
 modules.d/90lvm/lvm-cleanup.sh                   |    1 +
 modules.d/90mdraid/mdraid-cleanup.sh             |    1 +
 modules.d/95dasd/parse-dasd.sh                   |    1 +
 modules.d/95dasd_mod/parse-dasd-mod.sh           |    1 +
 modules.d/95iscsi/mount-lun.sh                   |    1 +
 modules.d/95zfcp/parse-zfcp.sh                   |    2 +-
 modules.d/95znet/parse-ccw.sh                    |    1 +
 10 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/modules.d/90crypt/crypt-cleanup.sh b/modules.d/90crypt/crypt-cleanup.sh
index 1a47d47..3959a07 100755
--- a/modules.d/90crypt/crypt-cleanup.sh
+++ b/modules.d/90crypt/crypt-cleanup.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # close everything which is not busy
 for i in /dev/mapper/luks-*; do
     cryptsetup luksClose $i >/dev/null 2>&1
diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse-crypt.sh
index 789bbb0..5c2a94a 100755
--- a/modules.d/90crypt/parse-crypt.sh
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 if getarg rd_NO_LUKS; then
     info "rd_NO_LUKS: removing cryptoluks activation"
     rm -f /etc/udev/rules.d/70-luks.rules
diff --git a/modules.d/90dmsquash-live/parse-dmsquash-live.sh b/modules.d/90dmsquash-live/parse-dmsquash-live.sh
index 40ca016..646da36 100755
--- a/modules.d/90dmsquash-live/parse-dmsquash-live.sh
+++ b/modules.d/90dmsquash-live/parse-dmsquash-live.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # live images are specified with
 # root=live:backingdev
 
diff --git a/modules.d/90lvm/lvm-cleanup.sh b/modules.d/90lvm/lvm-cleanup.sh
index 6efd911..f0b4037 100755
--- a/modules.d/90lvm/lvm-cleanup.sh
+++ b/modules.d/90lvm/lvm-cleanup.sh
@@ -1,2 +1,3 @@
+#!/bin/sh
 # stop everything which is not busy
 lvm vgchange -a n >/dev/null 2>&1
diff --git a/modules.d/90mdraid/mdraid-cleanup.sh b/modules.d/90mdraid/mdraid-cleanup.sh
index dc3b86f..f4b7810 100755
--- a/modules.d/90mdraid/mdraid-cleanup.sh
+++ b/modules.d/90mdraid/mdraid-cleanup.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # stop everything which is not busy
 for i in /dev/md* /dev/md/*; do
     [ -b $i ] || continue
diff --git a/modules.d/95dasd/parse-dasd.sh b/modules.d/95dasd/parse-dasd.sh
index af58b31..47bcfe4 100755
--- a/modules.d/95dasd/parse-dasd.sh
+++ b/modules.d/95dasd/parse-dasd.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 for dasd_arg in $(getargs 'rd_DASD='); do
     (
         IFS=","
diff --git a/modules.d/95dasd_mod/parse-dasd-mod.sh b/modules.d/95dasd_mod/parse-dasd-mod.sh
index 023c9ad..63a7da4 100755
--- a/modules.d/95dasd_mod/parse-dasd-mod.sh
+++ b/modules.d/95dasd_mod/parse-dasd-mod.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 [ -d /etc/modprobe.d ] || mkdir /etc/modprobe.d
 
 dasd_arg=$(getarg rd_DASD_MOD=)
diff --git a/modules.d/95iscsi/mount-lun.sh b/modules.d/95iscsi/mount-lun.sh
index ff8d4d0..d0b6458 100755
--- a/modules.d/95iscsi/mount-lun.sh
+++ b/modules.d/95iscsi/mount-lun.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 if [ -z $iscsi_lun ]; then
     iscsi_lun=0
 fi
diff --git a/modules.d/95zfcp/parse-zfcp.sh b/modules.d/95zfcp/parse-zfcp.sh
index 4f502c2..7fcee87 100755
--- a/modules.d/95zfcp/parse-zfcp.sh
+++ b/modules.d/95zfcp/parse-zfcp.sh
@@ -1,4 +1,4 @@
-
+#!/bin/sh
 getarg rd_NO_ZFCPCONF && rm /etc/zfcp.conf
 
 for zfcp_arg in $(getargs 'rd_ZFCP='); do
diff --git a/modules.d/95znet/parse-ccw.sh b/modules.d/95znet/parse-ccw.sh
index c8b257f..846c853 100755
--- a/modules.d/95znet/parse-ccw.sh
+++ b/modules.d/95znet/parse-ccw.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 for ccw_arg in $(getargs 'rd_CCW='); do
     echo $ccw_arg >> /etc/ccw.conf
 done
-- 
1.6.5.3
