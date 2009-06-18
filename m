From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] resume from any suspend partition
Date: Thu, 18 Jun 2009 10:23:21 +0200
Message-ID: <1245313401-4185-2-git-send-email-harald@redhat.com>
References: <1245313401-4185-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245313401-4185-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

If not "noresume" is specified and no explicit "resume=" given, try to resume
from any partition with type "suspend"
---
 modules.d/95resume/resume-genrules.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/modules.d/95resume/resume-genrules.sh b/modules.d/95resume/resume-genrules.sh
index 13b91a5..5ff4efe 100755
--- a/modules.d/95resume/resume-genrules.sh
+++ b/modules.d/95resume/resume-genrules.sh
@@ -5,4 +5,7 @@ if [ -n "$resume" ]; then
     printf "SYMLINK==\"%s\", RUN+=\"/bin/sh -c 'echo %%M:%%m > /sys/power/resume'\"\n" \
 		${resume#/dev/}
     ) >> /etc/udev/rules.d/99-resume.rules
+elif  ! getarg noresume; then
+    echo "SUBSYSTEM==\"block\", ACTION==\"add\", ENV{ID_FS_TYPE}==\"suspend\", RUN+=\"/bin/sh -c 'echo %M:%m > /sys/power/resume'\"" \
+    >> /etc/udev/rules.d/99-resume.rules
 fi
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
