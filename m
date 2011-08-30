From: Leho Kraav <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] 91crypt-loop: use initqueue for cleanup strategy
Date: Tue, 30 Aug 2011 16:36:31 +0300
Message-ID: <1314711391-7149-4-git-send-email-leho@kraav.com>
References: <1314711391-7149-1-git-send-email-leho@kraav.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1314711391-7149-1-git-send-email-leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/90crypt/crypt-lib.sh           |    3 +++
 modules.d/91crypt-loop/crypt-loop-lib.sh |    5 +++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-lib.sh
index b04512f..3095774 100755
--- a/modules.d/90crypt/crypt-lib.sh
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -225,6 +225,9 @@ readkey() {
             if [ -f /lib/dracut-crypt-loop-lib.sh ]; then
                 . /lib/dracut-crypt-loop-lib.sh
                 loop_decrypt "$mntp" "$keypath" "$keydev" "$device"
+                initqueue --onetime --finished --unique --name "crypt-loop-cleanup-99-$(basename $mntp)" \
+                    $(command -v umount) "$mntp; " $(command -v rmdir) "$mntp"
+                return 0
             else
                 die "No loop file support to decrypt '$keypath' on '$keydev'."
             fi
diff --git a/modules.d/91crypt-loop/crypt-loop-lib.sh b/modules.d/91crypt-loop/crypt-loop-lib.sh
index 63a553c..6774e7d 100644
--- a/modules.d/91crypt-loop/crypt-loop-lib.sh
+++ b/modules.d/91crypt-loop/crypt-loop-lib.sh
@@ -32,6 +32,11 @@ loop_decrypt() {
             --tty-echo-off
 
         [ -b $key ] || die "Tried setting it up, but keyfile block device was still not found!" 
+
+        initqueue --onetime --finished --unique --name "crypt-loop-cleanup-10-$(basename $key)" \
+            $(command -v cryptsetup) "luksClose $key"
+        initqueue --onetime --finished --unique --name "crypt-loop-cleanup-20-$(basename $loopdev)" \
+            $(command -v losetup) "-d $loopdev"
     else
         info "Existing keyfile found, re-using it for $device"
     fi
-- 
1.7.6
