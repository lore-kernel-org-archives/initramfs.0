From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 1/6] [PATCH 1/5] Revert "Change the implementation of action_on_fail"
Date: Mon, 31 Aug 2015 10:43:15 +0800
Message-ID: <20150831024413.784687500@redhat.com>
References: <20150831024314.798498962@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=0001-Revert-Change-the-implementation-of-action_on_fail.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

This reverts commit d2765b5175663d094737d6819cc3f3df53e7a4cb.

action_on_fail is useless thus remove the commits for it one by one.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.cmdline.7.asc                               |  4 ++++
 .../98dracut-systemd/dracut-emergency.service      |  2 +-
 modules.d/98dracut-systemd/emergency.service       |  2 +-
 modules.d/99base/dracut-lib.sh                     | 28 ++++++++++++++--------
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 8c7e965..07d3a93 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -159,6 +159,10 @@ Misc
    specify the controlling terminal for the console.
    This is useful, if you have multiple "console=" arguments.
 
+**rd.action_on_fail=**_{shell|continue}_::
+   Specify the action after failure. By default it's emergency_shell.
+   'continue' means: ignore the current failure and go ahead.
+
 [[dracutkerneldebug]]
 Debug
 ~~~~~
diff --git a/modules.d/98dracut-systemd/dracut-emergency.service b/modules.d/98dracut-systemd/dracut-emergency.service
index 5a6d525..a4b81bc 100644
--- a/modules.d/98dracut-systemd/dracut-emergency.service
+++ b/modules.d/98dracut-systemd/dracut-emergency.service
@@ -13,7 +13,7 @@ DefaultDependencies=no
 After=systemd-vconsole-setup.service
 Wants=systemd-vconsole-setup.service
 Conflicts=emergency.service emergency.target
-ConditionPathExists=!/lib/dracut/no-emergency-shell
+ConditionKernelCommandLine=!action_on_fail=continue
 
 [Service]
 Environment=HOME=/
diff --git a/modules.d/98dracut-systemd/emergency.service b/modules.d/98dracut-systemd/emergency.service
index 5f1eaa2..c19fe37 100644
--- a/modules.d/98dracut-systemd/emergency.service
+++ b/modules.d/98dracut-systemd/emergency.service
@@ -12,7 +12,7 @@ Description=Emergency Shell
 DefaultDependencies=no
 After=systemd-vconsole-setup.service
 Wants=systemd-vconsole-setup.service
-ConditionPathExists=!/lib/dracut/no-emergency-shell
+ConditionKernelCommandLine=!action_on_fail=continue
 
 [Service]
 Environment=HOME=/
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 1eaf4b3..1f50e2f 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -1145,16 +1145,24 @@ emergency_shell()
 
 action_on_fail()
 {
-    if [ -f "$initdir/lib/dracut/no-emergency-shell" ]; then
-        [ "$1" = "-n" ] && shift 2
-        [ "$1" = "--shutdown" ] && shift 2
-        warn "$*"
-        warn "Not dropping to emergency shell, because $initdir/lib/dracut/no-emergency-shell exists."
-        return 0
-    fi
-
-    emergency_shell $@
-    return 1
+    local _action=$(getarg rd.action_on_fail= -d action_on_fail=)
+    case "$_action" in
+        continue)
+            [ "$1" = "-n" ] && shift 2
+            [ "$1" = "--shutdown" ] && shift 2
+            warn "$*"
+            warn "Not dropping to emergency shell, because 'action_on_fail=continue' was set on the kernel command line."
+            return 0
+            ;;
+        shell)
+            emergency_shell $@
+            return 1
+            ;;
+        *)
+            emergency_shell $@
+            return 1
+            ;;
+    esac
 }
 
 # Retain the values of these variables but ensure that they are unexported
-- 
1.8.3.1


