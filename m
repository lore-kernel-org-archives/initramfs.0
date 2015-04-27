From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 1/4] Remove 98integrity's dependency on selinux
Date: Mon, 27 Apr 2015 18:24:11 -0400
Message-ID: <1430173454-3665-1-git-send-email-zohar@linux.vnet.ibm.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

Loading the EVM key(s) is not dependent on selinux.  Remove
the dependency.
---
 modules.d/98integrity/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/98integrity/module-setup.sh b/modules.d/98integrity/module-setup.sh
index a838664..2d4d2ed 100755
--- a/modules.d/98integrity/module-setup.sh
+++ b/modules.d/98integrity/module-setup.sh
@@ -7,7 +7,7 @@ check() {
 
 # called by dracut
 depends() {
-    echo masterkey securityfs selinux
+    echo masterkey securityfs
     return 0
 }
 
-- 
2.1.0
