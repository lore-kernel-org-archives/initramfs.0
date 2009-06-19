From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 09/13] add rdblacklist command line parameter
Date: Fri, 19 Jun 2009 13:05:47 +0200
Message-ID: <1245409551-30493-10-git-send-email-harald@redhat.com>
References: <1245409551-30493-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245409551-30493-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/99base/install            |    1 +
 modules.d/99base/parse-blacklist.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/99base/parse-blacklist.sh

diff --git a/modules.d/99base/install b/modules.d/99base/install
index 06cf6db..4bf5301 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -14,4 +14,5 @@ else
 fi
 inst "$moddir/dracut-lib" "/lib/dracut-lib"
 inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
+inst_hook cmdline 20 "$moddir/parse-blacklist.sh"
 inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
diff --git a/modules.d/99base/parse-blacklist.sh b/modules.d/99base/parse-blacklist.sh
new file mode 100755
index 0000000..9c0a9e0
--- /dev/null
+++ b/modules.d/99base/parse-blacklist.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+if getarg rdblacklist= >/dev/null ; then
+    [ "$CMDLINE" ] || read CMDLINE < /proc/cmdline
+    for p in $CMDLINE; do
+        [ -n "${p%rdblacklist=*}" ] && continue
+
+        echo "blacklist ${p#rdblacklist=}" >> /etc/modprobe.d/initramfsblacklist.conf
+    done
+fi
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
