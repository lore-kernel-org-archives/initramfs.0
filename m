From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/3] dracut-logger: make $maxloglvl public
Date: Wed, 16 Mar 2011 21:24:29 +0100
Message-ID: <1300307070-10087-2-git-send-email-aidecoe@aidecoe.name>
References: <1300307070-10087-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300307070-10087-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

$maxloglvl might be useful to check, if expensive informational
operation is going to be logged at all, before executing it.
---
 dracut-logger |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/dracut-logger b/dracut-logger
index 0978d58..830ce1c 100755
--- a/dracut-logger
+++ b/dracut-logger
@@ -76,9 +76,9 @@ __DRACUT_LOGGER__=1
 #   - @var kmsgloglvl - logging level to /dev/kmsg (only for boot-time)
 #   - @var logfile - log file which is used when @var fileloglvl is higher
 #   than 0
-# and one global internal variable @var _maxloglvl which <b>must not</b> be
-# overwritten. @_maxloglvl is set by dlog_init() and holds maximum logging level
-# of those three and indicates that dlog_init() was run.
+# and one global variable @var maxloglvl which <b>must not</b> be overwritten.
+# @var maxloglvl is set by dlog_init() and holds maximum logging level of those
+# three and indicates that dlog_init() was run.
 #
 # Logging level set by the variable means that messages from this logging level
 # and above (FATAL is the highest) will be shown. Logging levels may be set
@@ -101,11 +101,11 @@ __DRACUT_LOGGER__=1
 #   - @var kmsgloglvl = 0 (no logging)
 #   set to 0
 #
-# @warning Function sets global variable @var _maxloglvl for internal use. Don't
-# overwrite it.
+# @warning Function sets global variable @var maxloglvl. See file doc for
+# details.
 dlog_init() {
     # Skip initialization if it's already done.
-    [ -n "$_maxloglvl" ] && return 0
+    [ -n "$maxloglvl" ] && return 0
 
     local ret=0; local errmsg
 
@@ -144,12 +144,12 @@ dlog_init() {
         fi
     fi
 
-    local lvl
-    _maxloglvl=0
-    for lvl in $stdloglvl $sysloglvl $fileloglvl; do
-        [ $lvl -gt $_maxloglvl ] && _maxloglvl=$lvl
+    local lvl; local maxloglvl_l=0
+    for lvl in $stdloglvl $sysloglvl $fileloglvl $kmsgloglvl; do
+        [ $lvl -gt $maxloglvl_l ] && maxloglvl_l=$lvl
     done
-    export _maxloglvl
+    readonly maxloglvl=$maxloglvl_l
+    export maxloglvl
 
     [ -n "$errmsg" ] && derror "$errmsg"
 
@@ -251,11 +251,11 @@ _dlvl2klvl() {
 #   - @c INFO to @c info
 #   - @c DEBUG and @c TRACE both to @c debug
 _do_dlog() {
-    [ -z "$_maxloglvl" ] && return 0
+    [ -z "$maxloglvl" ] && return 0
     local lvl="$1"; shift
     local lvlc=$(_lvl2char "$lvl") || return 0
 
-    [ $lvl -le $_maxloglvl ] || return 0
+    [ $lvl -le $maxloglvl ] || return 0
 
     local msg="$lvlc: $*"
 
-- 
1.7.4.1
