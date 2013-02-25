From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 1/2] move memory usage tracing output to stderr
Date: Mon, 25 Feb 2013 14:38:15 +0800
Message-ID: <20130225064007.527029731@redhat.com>
References: <20130225063814.423057451@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=mem-trace-stderr.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

memory usage tracing outputs are debug info, so it should be moved to
stderr instead of stdout.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- dracut.orig/modules.d/99base/dracut-lib.sh
+++ dracut/modules.d/99base/dracut-lib.sh
@@ -1029,7 +1029,7 @@ make_trace_mem()
     msg="$1"
     shift
     if [ -n "$DEBUG_MEM_LEVEL" ] && [ "$DEBUG_MEM_LEVEL" -gt 0 ]; then
-        make_trace show_memstats $DEBUG_MEM_LEVEL "[debug_mem]" "$msg" "$@"
+        make_trace show_memstats $DEBUG_MEM_LEVEL "[debug_mem]" "$msg" "$@" >&2
     fi
 }
 
