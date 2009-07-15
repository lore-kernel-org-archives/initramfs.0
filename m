From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 08/14] add info() and vinfo() to dracut-lib
Date: Wed, 15 Jul 2009 18:50:40 +0200
Message-ID: <1247676646-3837-9-git-send-email-harald@redhat.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

- corrected the loglevel for warn()
- prepended with "dracut: " for kmesg to seperate from kernel messages

you can pipe to vinfo() for informational messages
---
 modules.d/99base/dracut-lib.sh |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index a26949c..aa808a7 100644
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -29,13 +29,33 @@ source_all() {
 }
 
 die() {
-    printf "<1>FATAL: $1\n" > /dev/kmsg
-    printf "<1>Refusing to continue\n" > /dev/kmsg
+    {
+        echo "<1>dracut: FATAL: $@";
+        echo "<1>dracut: Refusing to continue";
+    } > /dev/kmsg
+
+    {
+        echo "dracut: FATAL: $@";
+        echo "dracut: Refusing to continue";
+    } > /dev/console 
+    
     exit 1
 }
 
 warn() {
-    printf "<1>Warning: $1\n" > /dev/kmsg
+    echo "<4>dracut Warning: $@" > /dev/kmsg
+    echo "dracut Warning: $@" > /dev/console
+}
+
+info() {
+    echo "<6>dracut: $@" > /dev/kmsg
+    echo "dracut: $@" > /dev/console
+}
+
+vinfo() {
+    while read line; do 
+        info $line;
+    done
 }
 
 check_occurances() {
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
