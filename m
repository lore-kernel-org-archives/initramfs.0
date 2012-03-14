From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] fix "execvp: No such file or directory" in emergency_shell
Date: Wed, 14 Mar 2012 17:09:40 -0400
Message-ID: <1331759380-23807-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Older versions of setsid emit this message on stderr if you try to run
"setsid --help". Redirect it to /dev/null.
---
 modules.d/99base/dracut-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index a6c4e24..f0d426c 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -814,7 +814,7 @@ emergency_shell()
             _ctty=/dev/$_ctty
         fi
         [ -c "$_ctty" ] || _ctty=/dev/tty1
-        strstr "$(setsid --help)" "control" && CTTY="-c"
+        strstr "$(setsid --help 2>/dev/null)" "control" && CTTY="-c"
         setsid $CTTY /bin/sh -i -l 0<$_ctty 1>$_ctty 2>&1
     else
         warn "Boot has failed. To debug this issue add \"rdshell\" to the kernel command line."
-- 
1.7.7.6
