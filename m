From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/4] Use glob for libdir when installing multipath libraries.
Date: Tue, 24 Nov 2009 14:52:55 -0500
Message-ID: <1259092378-14143-2-git-send-email-pjones@redhat.com>
References: <1259092378-14143-1-git-send-email-pjones@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259092378-14143-1-git-send-email-pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Use "/lib*/" not "/lib/" so it works when they're in /lib/multipath as
well as when they're in /lib64/multipath
---
 modules.d/90multipath/install |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/modules.d/90multipath/install b/modules.d/90multipath/install
index 9552918..d20ea38 100755
--- a/modules.d/90multipath/install
+++ b/modules.d/90multipath/install
@@ -11,8 +11,9 @@ for f in  \
     /sbin/xdrgetuid \
     /sbin/xdrgetprio \
     /etc/xdrdevices.conf \
-    /lib/libmultipath*  \
-    /lib/multipath/* ;do 
+    /lib*/libmultipath* \
+    /lib*/multipath/*
+    	;do
     inst $f
 done
 
-- 
1.6.5.2
