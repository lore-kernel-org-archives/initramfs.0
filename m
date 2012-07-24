From: Leho Kraav <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] 91crypt-loop: replace basename calls with string matching
Date: Tue, 24 Jul 2012 14:57:00 +0300
Message-ID: <1343131020-12683-1-git-send-email-leho@kraav.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/90crypt/crypt-lib.sh           |    2 +-
 modules.d/91crypt-loop/crypt-loop-lib.sh |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-lib.sh
index d5caa85..d66ba88 100755
--- a/modules.d/90crypt/crypt-lib.sh
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -188,7 +188,7 @@ readkey() {
             if [ -f /lib/dracut-crypt-loop-lib.sh ]; then
                 . /lib/dracut-crypt-loop-lib.sh
                 loop_decrypt "$mntp" "$keypath" "$keydev" "$device"
-                initqueue --onetime --finished --unique --name "crypt-loop-cleanup-99-$(basename $mntp)" \
+                initqueue --onetime --finished --unique --name "crypt-loop-cleanup-99-${mntp##*/}" \
                     $(command -v umount) "$mntp; " $(command -v rmdir) "$mntp"
                 return 0
             else
diff --git a/modules.d/91crypt-loop/crypt-loop-lib.sh b/modules.d/91crypt-loop/crypt-loop-lib.sh
index 6774e7d..244b6ce 100644
--- a/modules.d/91crypt-loop/crypt-loop-lib.sh
+++ b/modules.d/91crypt-loop/crypt-loop-lib.sh
@@ -18,13 +18,13 @@ loop_decrypt() {
     local keydev="$3"
     local device="$4"
 
-    local key="/dev/mapper/$(basename $mntp)"
+    local key="/dev/mapper/${mntp##*/}"
 
     if [ ! -b $key ]; then
         info "Keyfile has .img suffix, treating it as LUKS-encrypted loop keyfile container to unlock $device"
 
         local loopdev=$(losetup -f "${mntp}/${keypath}" --show)
-        local opts="-d - luksOpen $loopdev $(basename $key)"
+        local opts="-d - luksOpen $loopdev ${key##*/}"
 
         ask_for_password \
             --cmd "cryptsetup $opts" \
@@ -33,9 +33,9 @@ loop_decrypt() {
 
         [ -b $key ] || die "Tried setting it up, but keyfile block device was still not found!" 
 
-        initqueue --onetime --finished --unique --name "crypt-loop-cleanup-10-$(basename $key)" \
+        initqueue --onetime --finished --unique --name "crypt-loop-cleanup-10-${key##*/}" \
             $(command -v cryptsetup) "luksClose $key"
-        initqueue --onetime --finished --unique --name "crypt-loop-cleanup-20-$(basename $loopdev)" \
+        initqueue --onetime --finished --unique --name "crypt-loop-cleanup-20-${loopdev##*/}" \
             $(command -v losetup) "-d $loopdev"
     else
         info "Existing keyfile found, re-using it for $device"
-- 
1.7.8.6
