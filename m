From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Add a check file for multipath.
Date: Fri, 22 Jan 2010 10:56:40 -0500
Message-ID: <1264175800-6870-1-git-send-email-pjones@redhat.com>
References: <4B59CAA9.3030301@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B59CAA9.3030301-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

If multipath isn't installed, don't use it.  If we're in hostonly mode,
only install the multipath module if it's used for / .  Otherwise, if
the user was dumb enough to install it, they get it during bootup.
---
 modules.d/90multipath/check |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/90multipath/check

diff --git a/modules.d/90multipath/check b/modules.d/90multipath/check
new file mode 100755
index 0000000..d0cad4c
--- /dev/null
+++ b/modules.d/90multipath/check
@@ -0,0 +1,27 @@
+#!/bin/bash
+
+# if there's no multipath binary, no go.
+which multipath >/dev/null 2>&1 || exit 1
+
+[[ $1 = -d ]] && exit 0
+
+. $dracutfunctions
+[[ $debug ]] && set -x
+
+is_mpath() {
+    [ -e /sys/dev/block/$1/dm/uuid ] || return 1
+    [[ $(cat /sys/dev/block/$1/dm/uuid) =~ ^mpath- ]] && return 0
+    return 1
+}
+
+# If we're in hostonly mode, do mpath if we appear to be using it for /
+if [[ $hostonly ]]; then
+    rootdev=$(find_root_block_device)
+    if [[ $rootdev ]]; then
+        check_block_and_slaves is_mpath "$rootdev" && exit 0
+    fi
+    exit 1
+fi
+
+# the user installed it, they get it...
+exit 0
-- 
1.6.5.2
