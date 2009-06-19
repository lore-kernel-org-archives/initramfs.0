From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 04/13] do not poweroff in TEST-10-RAID if rdinitdebug is set
Date: Fri, 19 Jun 2009 13:05:42 +0200
Message-ID: <1245409551-30493-5-git-send-email-harald@redhat.com>
References: <1245409551-30493-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245409551-30493-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 test/TEST-10-RAID/hard-off.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/TEST-10-RAID/hard-off.sh b/test/TEST-10-RAID/hard-off.sh
index 92dd304..85fd849 100755
--- a/test/TEST-10-RAID/hard-off.sh
+++ b/test/TEST-10-RAID/hard-off.sh
@@ -1,2 +1,2 @@
 #!/bin/sh
-poweroff -f
\ No newline at end of file
+getarg rdinitdebug || poweroff -f
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
