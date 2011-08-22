From: Leho Kraav <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] 90crypt: enhance crypt-lib keydev mounting
Date: Mon, 22 Aug 2011 15:39:09 +0300
Message-ID: <1314016750-9655-3-git-send-email-leho@kraav.com>
References: <1314016750-9655-1-git-send-email-leho@kraav.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1314016750-9655-1-git-send-email-leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Leho Kraav <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>

Combining $keydev and $keypath should result in a unique, re-usable keydev
mountpoint. mkuniqdir doesn't seem to have any an advantage here and lacks
reusability. Is there ever a use case where these are true:

 * there are more than one rd.luks.key=$keypath:$keydev
 * one is actually different from the other
---
 modules.d/90crypt/crypt-lib.sh |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-lib.sh
index 75b74a8..b04512f 100755
--- a/modules.d/90crypt/crypt-lib.sh
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -202,8 +202,15 @@ readkey() {
     local keydev="$2"
     local device="$3"
 
-    local mntp=$(mkuniqdir /mnt keydev)
-    mount -r "$keydev" "$mntp" || die 'Mounting rem. dev. failed!'
+    # This creates a unique single mountpoint for *, or several for explicitly
+    # given LUKS devices. It accomplishes unlocking multiple LUKS devices with
+    # a single password entry.
+    local mntp="/mnt/$(str_replace "keydev-$keydev-$keypath" '/' '-')"
+
+    if [ ! -d "$mntp" ]; then
+        mkdir "$mntp"
+        mount -r "$keydev" "$mntp" || die 'Mounting rem. dev. failed!'
+    fi
 
     case "${keypath##*.}" in
         gpg)
@@ -225,6 +232,8 @@ readkey() {
         *) cat "$mntp/$keypath" ;;
     esac
 
+    # General unmounting mechanism, modules doing custom cleanup should return earlier
+    # and install a pre-pivot cleanup hook
     umount "$mntp"
     rmdir "$mntp"
 }
-- 
1.7.6
