From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut-logger: convertion to kernel console log level for kmsg
Date: Tue, 15 Mar 2011 21:16:37 +0100
Message-ID: <1300220197-6838-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut-logger |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/dracut-logger b/dracut-logger
index 43cc18e..0978d58 100755
--- a/dracut-logger
+++ b/dracut-logger
@@ -192,6 +192,38 @@ _lvl2syslogpri() {
     esac
 }
 
+## @brief Converts dracut-logger numeric level to kernel console log level
+#
+# @param lvl Numeric logging level in range from 1 to 6.
+# @retval 1 if @a lvl is out of range.
+# @retval 0 if @a lvl is correct.
+# @result Echoes kernel console numeric log level
+#
+# Conversion is done as follows:
+#
+# <tt>
+#   none     -> KERN_EMERG (0)
+#   FATAL(1) -> KERN_ALERT (1)
+#   none     -> KERN_CRIT (2)
+#   ERROR(2) -> KERN_ERR (3)
+#   WARN(3)  -> KERN_WARNING (4)
+#   none     -> KERN_NOTICE (5)
+#   INFO(4)  -> KERN_INFO (6)
+#   DEBUG(5) -> KERN_DEBUG (7)
+#   TRACE(6) /
+# </tt>
+_dlvl2klvl() {
+    case "$1" in
+        1) echo 1;;
+        2) echo 3;;
+        3) echo 4;;
+        4) echo 6;;
+        5) echo 7;;
+        6) echo 7;;
+        *) return 1;;
+    esac
+}
+
 ## @brief Prints to stderr and/or writes to file, to syslog and/or /dev/kmsg
 # given message with given level (priority).
 #
@@ -234,7 +266,8 @@ _do_dlog() {
     if [ $lvl -le $fileloglvl -a -w "$logfile" -a -f "$logfile" ]; then
         echo "$msg" >>"$logfile"
     fi
-    [ $lvl -le $kmsgloglvl ] && echo "[dracut[$$]] $msg" >/dev/kmsg
+    [ $lvl -le $kmsgloglvl ] && \
+        echo "<$(_dlvl2klvl $lvl)>dracut[$$] $msg" >/dev/kmsg
 }
 
 ## @brief Internal helper function for _do_dlog()
-- 
1.7.4.1
