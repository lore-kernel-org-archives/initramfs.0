From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] interpret 'off' as false in getargbool
Date: Wed, 11 Jan 2012 12:48:27 -0500
Message-ID: <1326304109-32652-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index e86d209..ca3bc0e 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -124,6 +124,7 @@ getargbool() {
     if [ -n "$_b" ]; then
         [ $_b = "0" ] && return 1
         [ $_b = "no" ] && return 1
+        [ $_b = "off" ] && return 1
     fi
     return 0
 }
-- 
1.7.7.5
