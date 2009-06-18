From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/7] also resume from "swsuspend" partitions
Date: Thu, 18 Jun 2009 15:26:15 +0200
Message-ID: <1245331581-2453-2-git-send-email-harald@redhat.com>
References: <1245331581-2453-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245331581-2453-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/95resume/resume-genrules.sh |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/modules.d/95resume/resume-genrules.sh b/modules.d/95resume/resume-genrules.sh
index 5ff4efe..002a304 100755
--- a/modules.d/95resume/resume-genrules.sh
+++ b/modules.d/95resume/resume-genrules.sh
@@ -1,11 +1,15 @@
 if [ -n "$resume" ]; then
-    (
+    {
     printf "KERNEL==\"%s\", RUN+=\"/bin/sh -c 'echo %%M:%%m > /sys/power/resume'\"\n" \
-		${resume#/dev/}
+		${resume#/dev/};
     printf "SYMLINK==\"%s\", RUN+=\"/bin/sh -c 'echo %%M:%%m > /sys/power/resume'\"\n" \
-		${resume#/dev/}
-    ) >> /etc/udev/rules.d/99-resume.rules
+		${resume#/dev/};
+    } >> /etc/udev/rules.d/99-resume.rules
 elif  ! getarg noresume; then
-    echo "SUBSYSTEM==\"block\", ACTION==\"add\", ENV{ID_FS_TYPE}==\"suspend\", RUN+=\"/bin/sh -c 'echo %M:%m > /sys/power/resume'\"" \
-    >> /etc/udev/rules.d/99-resume.rules
+    {
+    echo "SUBSYSTEM==\"block\", ACTION==\"add\", ENV{ID_FS_TYPE}==\"suspend\"," \
+         " RUN+=\"/bin/sh -c 'echo %M:%m > /sys/power/resume'\"";
+    echo "SUBSYSTEM==\"block\", ACTION==\"add\", ENV{ID_FS_TYPE}==\"swsuspend\"," \
+         " RUN+=\"/bin/sh -c 'echo %M:%m > /sys/power/resume'\"";
+    } >> /etc/udev/rules.d/99-resume.rules
 fi
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
