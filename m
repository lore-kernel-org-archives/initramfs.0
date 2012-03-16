From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] Avoid use of "export -n"
Date: Fri, 16 Mar 2012 21:11:24 +0000 (GMT)
Message-ID: <20120316211124.8FFC69D401E@zog.reactivated.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

"export -n" is a bash extension, not part of POSIX, and is hence
incompatible with the busybox shell.

This was breaking boot when the busybox module was used.

Reimplement the scope change in a few lines of standard shell code.
---
 modules.d/99base/init.sh |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index 5d51c9d..f599fae 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -263,8 +263,15 @@ else
     udevadm info --cleanup-db
 fi
 
+# Retain the values of these variables but ensure that they are unexported
+# This is a POSIX-compliant equivalent of bash's "export -n"
+for var in root rflags fstype netroot NEWROOT; do
+    eval tmp=\$$var
+    unset $var
+    [ -n "$tmp" ] && eval $var=\"$tmp\"
+done
+
 export RD_TIMESTAMP
-export -n root rflags fstype netroot NEWROOT
 set +x # Turn off debugging for this section
 # Clean up the environment
 for i in $(export -p); do
-- 
1.7.7.6
