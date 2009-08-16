From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 19/18] Modify nbd hostonly checking to use check_block_and_slaves.
Date: Sun, 16 Aug 2009 18:24:53 -0500 (CDT)
Message-ID: <1a4c4015bc85feeb9fbf95a9d1e9adfb2de8e897.1250465033.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This allows hostonly nbd checking to work in more exotic situations,
such as mdraid/dmraid/lvm/crypt on top of nbd.

---
 modules.d/95nbd/check |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/modules.d/95nbd/check b/modules.d/95nbd/check
dissimilarity index 63%
index f94d63b..1443129 100755
--- a/modules.d/95nbd/check
+++ b/modules.d/95nbd/check
@@ -1,11 +1,20 @@
-#!/bin/sh
-# We depend on network modules being loaded
-[ "$1" = "-d" ] && echo network
-
-# If hostonly was requested, fail the check if we are not actually
-# booting from root.
-[ "$1" = "-h" ] && ! egrep -q '/ /dev/nbd[0-9]*' /proc/mounts && exit 1
-
-# If our prerequisites are not met, fail anyways.
-which nbd-client >/dev/null 2>&1 || exit 1
-exit 0
+#!/bin/bash
+# We depend on network modules being loaded
+[ "$1" = "-d" ] && echo network
+
+# If our prerequisites are not met, fail.
+which nbd-client >/dev/null 2>&1 || exit 1
+
+is_nbd() { [[ -b /dev/block/$1 && $1 == 43:* ]] }
+
+. $dracutfunctions
+
+# if an nbd device is not somewhere in the chain of devices root is mounted on,
+# fail the hostonly check.
+[ "$1" = "-h" ] && {
+    rootdev=$(find_root_block_device)
+    [[ -b /dev/block/$rootdev ]] || exit 1
+    check_block_and_slaves is_nbd "$rootdev" || exit 1
+}
+
+exit 0
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
