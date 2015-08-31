From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 2/6] [PATCH 2/5] Revert "rename kernel command line param action_on_fail
 to rd.action_on_fail"
Date: Mon, 31 Aug 2015 10:43:16 +0800
Message-ID: <20150831024413.852909639@redhat.com>
References: <20150831024314.798498962@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=0002-Revert-rename-kernel-command-line-param-action_on_fa.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

This reverts commit 391d6057908be2fe78f8084eb1b2adc27c781c0b.

action_on_fail is useless thus remove the commits for it one by one.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.cmdline.7.asc           | 2 +-
 modules.d/99base/dracut-lib.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 07d3a93..2e368ad 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -159,7 +159,7 @@ Misc
    specify the controlling terminal for the console.
    This is useful, if you have multiple "console=" arguments.
 
-**rd.action_on_fail=**_{shell|continue}_::
+**action_on_fail=**_{shell|continue}_::
    Specify the action after failure. By default it's emergency_shell.
    'continue' means: ignore the current failure and go ahead.
 
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 1f50e2f..c119018 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -1145,7 +1145,7 @@ emergency_shell()
 
 action_on_fail()
 {
-    local _action=$(getarg rd.action_on_fail= -d action_on_fail=)
+    local _action=$(getarg action_on_fail=)
     case "$_action" in
         continue)
             [ "$1" = "-n" ] && shift 2
-- 
1.8.3.1


