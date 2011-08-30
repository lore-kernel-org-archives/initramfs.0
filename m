From: Leho Kraav <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] 90crypt: recognize .img as loop key container
Date: Tue, 30 Aug 2011 16:36:29 +0300
Message-ID: <1314711391-7149-2-git-send-email-leho@kraav.com>
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
 modules.d/90crypt/crypt-lib.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-lib.sh
index 69f14d0..75b74a8 100755
--- a/modules.d/90crypt/crypt-lib.sh
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -214,6 +214,14 @@ readkey() {
                 die "No GPG support to decrypt '$keypath' on '$keydev'."
             fi
             ;;
+        img)
+            if [ -f /lib/dracut-crypt-loop-lib.sh ]; then
+                . /lib/dracut-crypt-loop-lib.sh
+                loop_decrypt "$mntp" "$keypath" "$keydev" "$device"
+            else
+                die "No loop file support to decrypt '$keypath' on '$keydev'."
+            fi
+            ;;
         *) cat "$mntp/$keypath" ;;
     esac
 
-- 
1.7.6
