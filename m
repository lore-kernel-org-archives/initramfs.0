From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 5/5] 95rootfs-block/block-genrules.sh: Use > instead of >>
Date: Fri, 20 May 2011 17:09:27 +0200
Message-ID: <1305904167-14199-6-git-send-email-soltys@ziu.info>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305904167-14199-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

trivial, blocksymlink.sh shouldn't exist at this point.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/95rootfs-block/block-genrules.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/95rootfs-block/block-genrules.sh b/modules.d/95rootfs-block/block-genrules.sh
index 41a220f..4a50aac 100755
--- a/modules.d/95rootfs-block/block-genrules.sh
+++ b/modules.d/95rootfs-block/block-genrules.sh
@@ -11,7 +11,7 @@ if [ "${root%%:*}" = "block" ]; then
     } >> $UDEVRULESD/99-root.rules
 
     printf '[ -e "%s" ] && { ln -s "%s" /dev/root 2>/dev/null; rm "$job"; }\n' \
-        "${root#block:}" "${root#block:}" >> $hookdir/initqueue/settled/blocksymlink.sh
+        "${root#block:}" "${root#block:}" > $hookdir/initqueue/settled/blocksymlink.sh
 
     echo '[ -e /dev/root ]' > $hookdir/initqueue/finished/block.sh
 fi
-- 
1.7.2.1
