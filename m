From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 05/14] change the way init arguments are stripped from the command line
Date: Wed, 15 Jul 2009 18:50:37 +0200
Message-ID: <1247676646-3837-6-git-send-email-harald@redhat.com>
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

$initrdargs now holds all command line options we want to strip from the
command line. Command line parsers can extend this space separated list.
---
 modules.d/99base/init |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 4c90f2b..ae71763 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -203,16 +203,12 @@ for i in $(export -p); do
 done
 
 initargs=""
+initrdargs="$initrdargs console BOOT_IMAGE rdbreak rdinitdebug rdudevinfo rdudevdebug rdnetdebug rdcopystate rdshell"
+
 for x in "$@"; do
-    [ "${x%%=*}" = "console" ] && continue
-    [ "${x%%=*}" = "BOOT_IMAGE" ] && continue
-    [ "${x%%=*}" = "rdbreak" ] && continue
-    [ "${x%%=*}" = "rdinitdebug" ] && continue
-    [ "${x%%=*}" = "rdudevinfo" ] && continue
-    [ "${x%%=*}" = "rdudevdebug" ] && continue
-    [ "${x%%=*}" = "rdnetdebug" ] && continue
-    [ "${x%%=*}" = "rdcopystate" ] && continue
-    [ "${x%%=*}" = "rdshell" ] && continue
+    for s in $initrdargs; do       
+	[ "${x%%=*}" = $s ] && continue 1
+    done
     initargs="$initargs $x"
 done
 
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
