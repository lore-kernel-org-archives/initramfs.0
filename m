From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut-lib: do not use cached CMDLINE in _getcmdline
Date: Thu, 5 Sep 2013 00:10:37 +0800
Message-ID: <20130904161037.GA24055@dhcp12-158.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Cached CMDLINE doesn't work 100%. For example the following case,

1. dracut starts to run dracut-cmdline.sh. CMDLINE is cached when calling
   getarg 'rd.break=cmdline'.
2. In 92-parse-ibft.sh, ibft_to_cmdline() calls $(set_ifname ibft xx:xx..)
   multiple times in each subshell.
3. In 1st call, set_ifname() will check $(getargs ifname) and write out
   ifname=xxxx accordingly.
4. In 2nd call, set_ifname() will check $(getargs ifname) and it's wrong here.
   Because in step 3, we introduce a new cmdline arg ifname=xxx, but CMDLINE
   isn't updated. Thus we fail to get the new ifname arg.

It's doable to unset CMDLINE every time after a new cmdline arg is in. But
unset should be done in the parent process, because unset CMDLINE in a
subshell won't unset CMDLINE in its parent or sibling process. And also it's
painful to unset CMDLINE every time. In the future, functions and code
snippet could probably separate or move to other file, the unset CMDLINE could
malfunction again like this time.

So I'm thinking not to cache CMDLINE. It's doesn't hurt to re-read all the
cmdline args everytime. Because it's in initramfs, a non cached _getcmdline()
should be fast enough.

Please consider!

Thanks
WANG Chao
---
 modules.d/99base/dracut-lib.sh | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 0d5cab9..ef8c5a3 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -103,23 +103,22 @@ _getcmdline() {
     local _line
     local _i
     unset _line
-    if [ -z "$CMDLINE" ]; then
-        unset CMDLINE_ETC CMDLINE_ETC_D
-        if [ -e /etc/cmdline ]; then
-            while read -r _line; do
-                CMDLINE_ETC="$CMDLINE_ETC $_line";
-            done </etc/cmdline;
-        fi
-        for _i in /etc/cmdline.d/*.conf; do
-            [ -e "$_i" ] || continue
-            while read -r _line; do
-                CMDLINE_ETC_D="$CMDLINE_ETC_D $_line";
-            done <"$_i";
-        done
-        if [ -e /proc/cmdline ]; then
-            read -r CMDLINE </proc/cmdline;
-            CMDLINE="$CMDLINE_ETC_D $CMDLINE_ETC $CMDLINE"
-        fi
+    unset CMDLINE_ETC CMDLINE_ETC_D
+
+    if [ -e /etc/cmdline ]; then
+        while read -r _line; do
+            CMDLINE_ETC="$CMDLINE_ETC $_line";
+        done </etc/cmdline;
+    fi
+    for _i in /etc/cmdline.d/*.conf; do
+        [ -e "$_i" ] || continue
+        while read -r _line; do
+            CMDLINE_ETC_D="$CMDLINE_ETC_D $_line";
+        done <"$_i";
+    done
+    if [ -e /proc/cmdline ]; then
+        read -r CMDLINE </proc/cmdline;
+        CMDLINE="$CMDLINE_ETC_D $CMDLINE_ETC $CMDLINE"
     fi
 }
 
-- 
1.8.3.1
