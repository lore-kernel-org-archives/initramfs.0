From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Docs update
Date: Thu, 19 Feb 2009 00:21:18 -0500
Message-ID: <499CEC4E.6060003@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010803060101030207020600"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------010803060101030207020600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Lame update to the docs is attached.  I suppose you really don't want 
patches attached, but how can I do it in the message body without 
thunderbird screwing up the formatting?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

--------------010803060101030207020600
Content-Type: text/x-patch;
 name="0002-Docs-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-Docs-update.patch"

From b4fcacbbaf82670479f32b2922ca0d2993feca69 Mon Sep 17 00:00:00 2001
From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Thu, 19 Feb 2009 00:16:19 -0500
Subject: Docs update

---
 HACKING |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/HACKING b/HACKING
index e9efe09..73815c1 100644
--- a/HACKING
+++ b/HACKING
@@ -15,7 +15,26 @@ like to customize the list of modules copied in, edit /etc/dracut.conf
 and set
   modules="foo bar baz"
 
-
 Requirements:
 * udev
-* nash (for switchroot until we get in util-linux)
+
+Manifest of Dracut Source
+=========================
+dracut
+This script generates the initramfs image.
+
+init
+This script runs during boot of the generated initramfs image.
+
+modules/
+This directory contains scriptlets that are run during initramfs generation 
+in alphanumeric filename order.
+
+hooks/
+This directory contains scriptlets to be installed in the initramfs image.
+
+Development Tips
+================
+* ./dracut -l allows you to run dracut in local mode, meaning it gets files to 
+  include from the current source directory.  This is handy to use dracut
+  without installing it, or test it directly from the source tree.
-- 
1.6.0.6


--------------010803060101030207020600--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
