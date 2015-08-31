From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 5/6] [PATCH 5/5] Revert "99fs-lib/fs-lib.sh: Let user specify the action
 after fail for fsck"
Date: Mon, 31 Aug 2015 10:43:19 +0800
Message-ID: <20150831024414.030029156@redhat.com>
References: <20150831024314.798498962@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=0005-Revert-99fs-lib-fs-lib.sh-Let-user-specify-the-actio.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

This reverts commit 679fa7ed3c0f4c827bfc6885d34f56713fe85c1e.

action_on_fail is useless thus remove the commits for it one by one.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99fs-lib/fs-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/99fs-lib/fs-lib.sh b/modules.d/99fs-lib/fs-lib.sh
index df3803d..672d027 100755
--- a/modules.d/99fs-lib/fs-lib.sh
+++ b/modules.d/99fs-lib/fs-lib.sh
@@ -5,14 +5,14 @@ type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
 fsck_ask_reboot() {
     info "note - fsck suggests reboot, if you"
     info "leave shell, booting will continue normally"
-    action_on_fail -n "(reboot ?)"
+    emergency_shell -n "(reboot ?)"
 }
 
 fsck_ask_err() {
     warn "*** An error occurred during the file system check."
     warn "*** Dropping you to a shell; the system will try"
     warn "*** to mount the filesystem(s), when you leave the shell."
-    action_on_fail -n "(Repair filesystem)"
+    emergency_shell -n "(Repair filesystem)"
 }
 
 # inherits: _ret _drv _out
-- 
1.8.3.1


