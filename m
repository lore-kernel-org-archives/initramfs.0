From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 2/9] NFS testing: add forgotten hard-off hook
Date: Sat,  6 Jun 2009 05:23:23 -0400
Message-ID: <a0e0d37270b045de293d389535148527c6114bce.1244279679.git.dave@thedillows.org>
References: <cover.1244279679.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
In-Reply-To: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
References: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

---
 test/TEST-20-NFS/hard-off.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100755 test/TEST-20-NFS/hard-off.sh

diff --git a/test/TEST-20-NFS/hard-off.sh b/test/TEST-20-NFS/hard-off.sh
new file mode 100755
index 0000000..92dd304
--- /dev/null
+++ b/test/TEST-20-NFS/hard-off.sh
@@ -0,0 +1,2 @@
+#!/bin/sh
+poweroff -f
\ No newline at end of file
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
