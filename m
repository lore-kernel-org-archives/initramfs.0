From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 8/9] NFS test: allow emergency shell while debugging
Date: Sat,  6 Jun 2009 05:23:29 -0400
Message-ID: <08fb7d892c248503ec65349eed49b0d50140f26c.1244279679.git.dave@thedillows.org>
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
 test/TEST-20-NFS/hard-off.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/TEST-20-NFS/hard-off.sh b/test/TEST-20-NFS/hard-off.sh
index 92dd304..85fd849 100755
--- a/test/TEST-20-NFS/hard-off.sh
+++ b/test/TEST-20-NFS/hard-off.sh
@@ -1,2 +1,2 @@
 #!/bin/sh
-poweroff -f
\ No newline at end of file
+getarg rdinitdebug || poweroff -f
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
