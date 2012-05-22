From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] do emergency_shell in die() if rd.debug=1
Date: Tue, 22 May 2012 18:16:12 -0400
Message-ID: <1337724972-6545-2-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If I said 'rd.debug=1' I should get to debug the system before it dies,
right?
---
 modules.d/99base/dracut-lib.sh |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 19aceb8..ef50af8 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -307,6 +307,7 @@ die() {
     } >> $hookdir/emergency/01-die.sh
 
     > /run/initramfs/.die
+    emergency_shell
     exit 1
 }
 
@@ -825,7 +826,6 @@ emergency_shell()
     warn $@
     source_hook "$hook"
     echo
-    [ -e /run/initramfs/.die ] && exit 1
     if getargbool 1 rd.shell -y rdshell || getarg rd.break rdbreak; then
         echo "Dropping to debug shell."
         echo
@@ -849,6 +849,7 @@ emergency_shell()
         # cause a kernel panic
         exit 1
     fi
+    [ -e /run/initramfs/.die ] && exit 1
 }
 
 # Retain the values of these variables but ensure that they are unexported
-- 
1.7.10.1
