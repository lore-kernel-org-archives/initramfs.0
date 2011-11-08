From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] 99base/init: avoid using cp -t
Date: Tue,  8 Nov 2011 21:11:40 +0000 (GMT)
Message-ID: <20111108211140.3E57D9D401E@zog.reactivated.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

-t is not supported by busybox's cp.

Signed-off-by: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
---
 modules.d/99base/init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 36b2152..e0e2630 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -133,7 +133,7 @@ fi
 if ! ismounted /run; then
     mkdir -m 0755 /newrun
     mount -t tmpfs -o mode=0755,nosuid,nodev tmpfs /newrun >/dev/null 2>&1
-    cp -a -t /newrun /run/*
+    cp -a /run/* /newrun
     mount --move /newrun /run
     rm -fr /newrun
 fi
-- 
1.7.7
