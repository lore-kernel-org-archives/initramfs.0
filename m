From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut-lib.sh: fix dropped backslashes in CMDLINE
Date: Wed, 12 Oct 2011 22:48:08 -0400
Message-ID: <1318474088-1698-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The "read" shell builtin consumes backslashes, which is a problem if
your root device is something like "LABEL=Fedora\x2016".

Using "read -r" tells the shell to leave backslashes alone.
---
 modules.d/99base/dracut-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 62c3bf5..bc4d7c9 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -35,11 +35,11 @@ _getcmdline() {
     unset _line
     if [ -z "$CMDLINE" ]; then
         if [ -e /etc/cmdline ]; then
-            while read _line; do
+            while read -r _line; do
                 CMDLINE_ETC="$CMDLINE_ETC $_line";
             done </etc/cmdline;
         fi
-        read CMDLINE </proc/cmdline;
+        read -r CMDLINE </proc/cmdline;
         CMDLINE="$CMDLINE $CMDLINE_ETC"
     fi
 }
-- 
1.7.6.4
