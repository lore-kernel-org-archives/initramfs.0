From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Both --drivers and --debug cannot be -d.  Make --debug into
 -b.
Date: Tue, 19 May 2009 15:47:50 -0400
Message-ID: <4A130CE6.1040607@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

 From b6407a1d62af65ec5a8ba8632f4d63c1cb9874d0 Mon Sep 17 00:00:00 2001
From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Tue, 19 May 2009 15:44:37 -0400
Subject: [PATCH] Both --drivers and --debug cannot be -d.  Make --debug into -b.

---
  dracut |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 109d8e8..48e002d 100755
--- a/dracut
+++ b/dracut
@@ -21,7 +21,7 @@ Creates initial ramdisk images for preloading modules
    -d, --drivers [LIST]  Specify a space-separated list of kernel modules to
                           include in the initramfs
    -h, --help            This message
-  -d, --debug           Output debug information of the build process
+  -b, --debug           Output debug information of the build process
    -v, --verbose         Verbose output during the build process
    -c, --conf [FILE]     Specify configuration file to use.
                           Default: /etc/dracut.conf
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
