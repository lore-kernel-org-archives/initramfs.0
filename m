From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH] 99fs-lib: export FSTAB_FILE before fsck call
Date: Tue,  6 Sep 2011 01:22:15 +0200
Message-ID: <1315264935-20369-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/99fs-lib/fs-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/99fs-lib/fs-lib.sh b/modules.d/99fs-lib/fs-lib.sh
index f7b20dd..fdd3304 100755
--- a/modules.d/99fs-lib/fs-lib.sh
+++ b/modules.d/99fs-lib/fs-lib.sh
@@ -179,10 +179,10 @@ fsck_batch() {
         info "    $_dev"
     done
 
+    export FSTAB_FILE
     _out="$(fsck -M -T "$@" -- -a)"
     _ret=$?
 
-    export FSTAB_FILE
     fsck_tail
 
     return $_ret
-- 
1.7.5.3
