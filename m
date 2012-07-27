From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] add comment for getargbool()
Date: Fri, 27 Jul 2012 13:12:28 -0400
Message-ID: <1343409149-26884-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I always forget how getargbool works. Add a comment documenting it.
---
 modules.d/99base/dracut-lib.sh |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 2eb1224..3a7be9a 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -145,6 +145,13 @@ getarg() {
     return 1
 }
 
+# getargbool <defaultval> <args...>
+# False if "getarg <args...>" returns "0", "no", or "off".
+# True if getarg returns any other non-empty string.
+# If not found, assumes <defaultval> - usually 0 for false, 1 for true.
+# example: getargbool 0 rd.info
+#   true: rd.info, rd.info=1, rd.info=xxx
+#   false: rd.info=0, rd.info=off, rd.info not present (default val is 0)
 getargbool() {
     local _b
     unset _b
-- 
1.7.10.4
