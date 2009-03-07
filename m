From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] add /check for dmraim module
Date: Sat, 7 Mar 2009 12:24:07 +0100
Message-ID: <49B25957.4030104@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

With the /check infrastucture in place, dmraid is missing a check file.


Patch is built on top of Harald Hoyers merge tree
(git://git.surfsite.org/pub/git/dracut.git)

---
diff --git a/modules.d/90dmraid/check b/modules.d/90dmraid/check
new file mode 100755
index 0000000..632c28b
--- /dev/null
+++ b/modules.d/90dmraid/check
@@ -0,0 +1,3 @@
+#!/bin/sh
+grep -q '^dm_mod' /proc/modules || exit 1
+awk '/^dm_mod/ {if ($3 > 0) exit 0; else exit 1;}' /proc/modules
\ No newline at end of file
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
