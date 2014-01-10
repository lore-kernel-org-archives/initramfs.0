From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek-wrcVdnn0TatmR6Xm/wNWPw@public.gmane.org>
Subject: [PATCH] resume: fix double escaping in printf
Date: Fri, 10 Jan 2014 11:51:24 -0500
Message-ID: <1389372684-26465-1-git-send-email-zbyszek@in.waw.pl>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek-wrcVdnn0TatmR6Xm/wNWPw@public.gmane.org>

https://bugzilla.redhat.com/show_bug.cgi?id=1045704
---
 modules.d/95resume/parse-resume.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/95resume/parse-resume.sh b/modules.d/95resume/parse-resume.sh
index 8682a03..44c62dd 100755
--- a/modules.d/95resume/parse-resume.sh
+++ b/modules.d/95resume/parse-resume.sh
@@ -59,10 +59,10 @@ if ! getarg noresume; then
             fi
             printf -- "KERNEL==\"%s\", " ${resume#/dev/};
             printf -- "ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\","
-            printf -- "%s" " RUN+=\"/sbin/initqueue --finished --unique --name 00resume echo %%M:%%m > /sys/power/resume\"\n"
+            printf -- " RUN+=\"/sbin/initqueue --finished --unique --name 00resume echo %%M:%%m > /sys/power/resume\"\n"
             printf -- "SYMLINK==\"%s\", " ${resume#/dev/};
-            printf -- "%s" "ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\","
-            printf -- "%s" " RUN+=\"/sbin/initqueue --finished --unique --name 00resume echo %%M:%%m  > /sys/power/resume\"\n"
+            printf -- "ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\","
+            printf -- " RUN+=\"/sbin/initqueue --finished --unique --name 00resume echo %%M:%%m  > /sys/power/resume\"\n"
         } >> /etc/udev/rules.d/99-resume.rules
 
         printf '[ -e "%s" ] && { ln -s "%s" /dev/resume; rm -f -- "$job" "%s/initqueue/timeout/resume.sh"; }\n' \
-- 
1.8.4.2
