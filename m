From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/9] dracut-logger: 'user' facility for build-time and 'daemon' for boot-time
Date: Fri, 25 Mar 2011 15:56:44 +0100
Message-ID: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut-logger |   66 ++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/dracut-logger b/dracut-logger
index ce7dbd0..7bd2a7c 100755
--- a/dracut-logger
+++ b/dracut-logger
@@ -76,9 +76,11 @@ __DRACUT_LOGGER__=1
 #   - @var kmsgloglvl - logging level to /dev/kmsg (only for boot-time)
 #   - @var logfile - log file which is used when @var fileloglvl is higher
 #   than 0
-# and one global variable @var maxloglvl which <b>must not</b> be overwritten.
-# @var maxloglvl is set by dlog_init() and holds maximum logging level of those
-# three and indicates that dlog_init() was run.
+# and two global variables: @var maxloglvl and @var syslogfacility which <b>must
+# not</b> be overwritten. Both are set by dlog_init(). @var maxloglvl holds
+# maximum logging level of those three and indicates that dlog_init() was run.
+# @var syslogfacility is set either to 'user' (when building initramfs) or
+# 'daemon' (when booting).
 #
 # Logging level set by the variable means that messages from this logging level
 # and above (FATAL is the highest) will be shown. Logging levels may be set
@@ -101,8 +103,8 @@ __DRACUT_LOGGER__=1
 #   - @var kmsgloglvl = 0 (no logging)
 #   set to 0
 #
-# @warning Function sets global variable @var maxloglvl. See file doc for
-# details.
+# @warning Function sets global variables @var maxloglvl and @syslogfacility.
+# See file doc comment for details.
 dlog_init() {
     # Skip initialization if it's already done.
     [ -n "$maxloglvl" ] && return 0
@@ -144,6 +146,15 @@ dlog_init() {
         fi
     fi
 
+    if [ $sysloglvl -gt 0 -o $kmsgloglvl -gt 0 ]; then
+        if [ -n "$dracutbasedir" ]; then
+            readonly syslogfacility=user
+        else
+            readonly syslogfacility=daemon
+        fi
+        export syslogfacility
+    fi
+
     local lvl; local maxloglvl_l=0
     for lvl in $stdloglvl $sysloglvl $fileloglvl $kmsgloglvl; do
         [ $lvl -gt $maxloglvl_l ] && maxloglvl_l=$lvl
@@ -180,7 +191,8 @@ _lvl2char() {
 # @retval 1 if @a lvl is out of range.
 # @retval 0 if @a lvl is correct.
 # @result Echoes logger priority.
-_lvl2syslogpri() {
+_lvl2syspri() {
+    printf $syslogfacility.
     case "$1" in
         1) echo crit;;
         2) echo error;;
@@ -192,7 +204,7 @@ _lvl2syslogpri() {
     esac
 }
 
-## @brief Converts dracut-logger numeric level to kernel console log level
+## @brief Converts dracut-logger numeric level to syslog log level
 #
 # @param lvl Numeric logging level in range from 1 to 6.
 # @retval 1 if @a lvl is out of range.
@@ -202,26 +214,32 @@ _lvl2syslogpri() {
 # Conversion is done as follows:
 #
 # <tt>
-#   none     -> KERN_EMERG (0)
-#   FATAL(1) -> KERN_ALERT (1)
-#   none     -> KERN_CRIT (2)
-#   ERROR(2) -> KERN_ERR (3)
-#   WARN(3)  -> KERN_WARNING (4)
-#   none     -> KERN_NOTICE (5)
-#   INFO(4)  -> KERN_INFO (6)
-#   DEBUG(5) -> KERN_DEBUG (7)
+#   FATAL(1) -> LOG_EMERG (0)
+#   none     -> LOG_ALERT (1)
+#   none     -> LOG_CRIT (2)
+#   ERROR(2) -> LOG_ERR (3)
+#   WARN(3)  -> LOG_WARNING (4)
+#   none     -> LOG_NOTICE (5)
+#   INFO(4)  -> LOG_INFO (6)
+#   DEBUG(5) -> LOG_DEBUG (7)
 #   TRACE(6) /
 # </tt>
-_dlvl2klvl() {
+#
+# @see /usr/include/sys/syslog.h
+_dlvl2syslvl() {
+    local lvl
+
     case "$1" in
-        1) echo 1;;
-        2) echo 3;;
-        3) echo 4;;
-        4) echo 6;;
-        5) echo 7;;
-        6) echo 7;;
+        1) lvl=0;;
+        2) lvl=3;;
+        3) lvl=4;;
+        4) lvl=6;;
+        5) lvl=7;;
+        6) lvl=7;;
         *) return 1;;
     esac
+
+    [ "$syslogfacility" = user ] && echo $((8+$lvl)) || echo $((24+$lvl))
 }
 
 ## @brief Prints to stderr and/or writes to file, to syslog and/or /dev/kmsg
@@ -261,13 +279,13 @@ _do_dlog() {
 
     [ $lvl -le $stdloglvl ] && echo "$msg" >&2
     if [ $lvl -le $sysloglvl ]; then
-        logger -t "dracut[$$]" -p $(_lvl2syslogpri $lvl) "$msg"
+        logger -t "dracut[$$]" -p $(_lvl2syspri $lvl) "$msg"
     fi
     if [ $lvl -le $fileloglvl -a -w "$logfile" -a -f "$logfile" ]; then
         echo "$msg" >>"$logfile"
     fi
     [ $lvl -le $kmsgloglvl ] && \
-        echo "<$(_dlvl2klvl $lvl)>dracut[$$] $msg" >/dev/kmsg
+        echo "<$(_dlvl2syslvl $lvl)>dracut[$$] $msg" >/dev/kmsg
 }
 
 ## @brief Internal helper function for _do_dlog()
-- 
1.7.4.1
