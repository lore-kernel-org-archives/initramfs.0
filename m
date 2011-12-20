From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/6] lvm: pass the correct rd.lvm.lv parameter
Date: Tue, 20 Dec 2011 14:10:01 +0800
Message-ID: <1324361401-6908-7-git-send-email-amwang@redhat.com>
References: <1324361401-6908-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1324361401-6908-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

rd.lvm.lv accepts ${DM_VG_NAME}/${DM_LV_NAME}, not ${DM_LV_NAME}.

Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/90lvm/module-setup.sh |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/modules.d/90lvm/module-setup.sh b/modules.d/90lvm/module-setup.sh
index c910f13..01bfa8a 100755
--- a/modules.d/90lvm/module-setup.sh
+++ b/modules.d/90lvm/module-setup.sh
@@ -11,16 +11,11 @@ check() {
     [[ $debug ]] && set -x
 
     check_lvm() {
-        local dev=$1
-        DM_LV_NAME=$(udevadm info --query=property --name=$dev \
-            | while read line; do
-                [[ ${line#DM_LV_NAME} = $line ]] && continue
-                eval "$line"
-                echo $DM_LV_NAME
-                break
-                done)
-        [[ ${DM_LV_NAME} ]] || continue
-        echo " rd.lvm.lv=${DM_LV_NAME} " >> "${initdir}/etc/cmdline.d/90lvm.conf"
+        unset DM_VG_NAME
+        unset DM_LV_NAME
+        eval $(udevadm info --query=property --name=$1|egrep '(DM_VG_NAME|DM_LV_NAME)=')
+        [[ ${DM_VG_NAME} ]] && [[ ${DM_LV_NAME} ]] || return
+        echo " rd.lvm.lv=${DM_VG_NAME}/${DM_LV_NAME} " >> "${initdir}/etc/cmdline.d/90lvm.conf"
     }
 
     [[ $hostonly ]] || [[ $mount_needs ]] && {
-- 
1.7.7.4
