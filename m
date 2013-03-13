From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch v2 1/3] print memdebug to stderr
Date: Wed, 13 Mar 2013 15:59:24 +0800
Message-ID: <20130313080318.507973383@redhat.com>
References: <20130313075923.845431353@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=mem-improve-1.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

memory usage tracing outputs are debug info, so it should be moved to
stderr instead of stdout.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- dracut.orig/modules.d/99base/dracut-lib.sh
+++ dracut/modules.d/99base/dracut-lib.sh
@@ -1041,7 +1041,7 @@ make_trace_mem()
     msg="$1"
     shift
     if [ -n "$DEBUG_MEM_LEVEL" ] && [ "$DEBUG_MEM_LEVEL" -gt 0 ]; then
-        make_trace show_memstats $DEBUG_MEM_LEVEL "[debug_mem]" "$msg" "$@"
+        make_trace show_memstats $DEBUG_MEM_LEVEL "[debug_mem]" "$msg" "$@" >&2
     fi
 }
 
