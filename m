From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 01/14] dracut-lib add getargs()
Date: Wed, 15 Jul 2009 18:50:33 +0200
Message-ID: <1247676646-3837-2-git-send-email-harald@redhat.com>
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

getargs returns a space seperated list with all values found for a key
on the kernel command line
---
 modules.d/99base/dracut-lib.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 96ecbb0..a26949c 100644
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -8,6 +8,20 @@ getarg() {
     return 1
 }
 
+getargs() {
+    local o line found
+    [ "$CMDLINE" ] || read CMDLINE </proc/cmdline;
+    for o in $CMDLINE; do
+	[ "$o" = "$1" ] && return 0
+	if [ "${o%%=*}" = "${1%=}" ]; then
+	    echo -n "${o#*=} "; 
+	    found=1;
+	fi
+    done
+    [ -n "$found" ] && return 0
+    return 1
+}
+
 source_all() {
     local f
     [ "$1" ] && [  -d "/$1" ] || return
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
