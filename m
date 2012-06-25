From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 3/4] dracut-lib.sh: Use "$*" instead of "$@" in warn, info, and so on...
Date: Mon, 25 Jun 2012 18:32:02 +0200
Message-ID: <1340641923-14477-3-git-send-email-aidecoe@aidecoe.name>
References: <1340641923-14477-1-git-send-email-aidecoe@aidecoe.name>
 <1340641923-14477-2-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340641923-14477-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

"$@" might cause some uneccessary word breaking.
---
 modules.d/99base/dracut-lib.sh |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 5dc3fbd..e63f3f0 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -297,12 +297,12 @@ source_conf() {
 
 die() {
     {
-        echo "<24>dracut: FATAL: $@";
+        echo "<24>dracut: FATAL: $*";
         echo "<24>dracut: Refusing to continue";
     } > /dev/kmsg
 
     {
-        echo "warn dracut: FATAL: \"$@\"";
+        echo "warn dracut: FATAL: \"$*\"";
         echo "warn dracut: Refusing to continue";
     } >> $hookdir/emergency/01-die.sh
 
@@ -327,25 +327,25 @@ if [ ! -x /lib/systemd/systemd ]; then
 
     warn() {
         check_quiet
-        echo "<28>dracut Warning: $@" > /dev/kmsg
-        echo "dracut Warning: $@" >&2
+        echo "<28>dracut Warning: $*" > /dev/kmsg
+        echo "dracut Warning: $*" >&2
     }
 
     info() {
         check_quiet
-        echo "<30>dracut: $@" > /dev/kmsg
+        echo "<30>dracut: $*" > /dev/kmsg
         [ "$DRACUT_QUIET" != "yes" ] && \
-            echo "dracut: $@"
+            echo "dracut: $*"
     }
 
 else
 
     warn() {
-        echo "Warning: $@" >&2
+        echo "Warning: $*" >&2
     }
 
     info() {
-        echo "$@"
+        echo "$*"
     }
 
 fi
@@ -827,7 +827,7 @@ emergency_shell()
     fi
 
     echo ; echo
-    warn $@
+    warn "$*"
     source_hook "$hook"
     echo
 
-- 
1.7.8.6
