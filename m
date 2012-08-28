From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] hide 'setsid --help' output in emergency_shell()
Date: Tue, 28 Aug 2012 09:43:52 -0400
Message-ID: <1346161432-5646-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

When emergency_shell() happens, it does 'setsid --help' to figure out if
the setsid binary supports the '-c' flag (to set the controlling tty).

This output shows up in the logs (and on-screen if you're using
rd.debug), which keeps confusing people looking for other problems.

Using "case" instead of "strstr" lets us avoid this.
---
 modules.d/99base/dracut-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 60b4cb1..fbe6f91 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -890,7 +890,7 @@ _emergency_shell()
             _ctty=/dev/$_ctty
         fi
         [ -c "$_ctty" ] || _ctty=/dev/tty1
-        strstr "$(setsid --help 2>/dev/null)" "ctty" && CTTY="-c"
+        case "$(/usr/bin/setsid --help 2>&1)" in *--ctty*) CTTY="--ctty";; esac
         setsid $CTTY /bin/sh -i -l 0<$_ctty 1>$_ctty 2>&1
     fi
 }
-- 
1.7.11.4
