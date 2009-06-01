From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Include only wired ethernet drivers, explicitly exclude wireless.
Date: Mon, 01 Jun 2009 18:42:48 -0400
Message-ID: <4A245968.7060208@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Include only wired ethernet drivers, explicitly exclude wireless.
commit 9dcf9cef387f7582eb8e8d6632d768411ead3617

16150964 bytes before
12981291 bytes after
3169673  bytes savings

+# Include wired net drivers, excluding wireless
+for modname in `find "/lib/modules/$kernel/kernel/drivers" -name 
'*.ko'`; do
+  if nm -uPA $modname | grep -q eth_type_trans; then
+    if echo "$modname" | grep -q wireless; then
+      continue
+    else
+      instmods $modname
+    fi
+  fi
+done

This got rid of the pesky wireless drivers and lots of irrelevant kernel 
modules, but I subsequently discovered that it also no longer pulled in 
sunrpc.ko.  Please keep a lookout for other possible side-effects of 
this change.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
