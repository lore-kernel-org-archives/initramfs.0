From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 14/14] dracut-lib: if "quiet" is specified, do not print info() to console
Date: Wed, 15 Jul 2009 18:50:46 +0200
Message-ID: <1247676646-3837-15-git-send-email-harald@redhat.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/99base/dracut-lib.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index aa808a7..a57780a 100644
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -48,8 +48,10 @@ warn() {
 }
 
 info() {
+    [ "$DRACUT_QUIET" ] || DRACUT_QUIET="x$(getarg quiet)"
     echo "<6>dracut: $@" > /dev/kmsg
-    echo "dracut: $@" > /dev/console
+    [ "$DRACUT_QUIET" != "xquiet" ] && \
+	echo "dracut: $@" > /dev/console
 }
 
 vinfo() {
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
