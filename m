From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 4/4] Revert securitfs change
Date: Mon, 27 Apr 2015 18:24:14 -0400
Message-ID: <1430173454-3665-4-git-send-email-zohar@linux.vnet.ibm.com>
References: <1430173454-3665-1-git-send-email-zohar@linux.vnet.ibm.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430173454-3665-1-git-send-email-zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

Commit 5e60145 use findmnt with "--source" or "--target" broke
mounting securityfs.  This patch reverts only the securityfs
portion of the patch.
---
 modules.d/96securityfs/securityfs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/96securityfs/securityfs.sh b/modules.d/96securityfs/securityfs.sh
index 8ccb151..8e57571 100755
--- a/modules.d/96securityfs/securityfs.sh
+++ b/modules.d/96securityfs/securityfs.sh
@@ -3,6 +3,6 @@
 SECURITYFSDIR="/sys/kernel/security"
 export SECURITYFSDIR
 
-if ! findmnt --target "${SECURITYFSDIR}" >/dev/null 2>&1; then
+if ! findmnt "${SECURITYFSDIR}" >/dev/null 2>&1; then
    mount -t securityfs -o nosuid,noexec,nodev securityfs ${SECURITYFSDIR} >/dev/null 2>&1
 fi
-- 
2.1.0
