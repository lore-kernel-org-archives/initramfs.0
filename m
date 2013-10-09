From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH 2/2] resume: remove resume-genrules.sh
Date: Wed, 9 Oct 2013 07:02:56 +0400
Message-ID: <75dabc4ca42f408d2477b14d6570be2122d9bfe0.1381324538.git.alexander@tsoy.me>
References: <6734e993a6184b487097463179c3dd75357047b2.1381324538.git.alexander@tsoy.me>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=To:Subject:Date:From:References:In-Reply-To:Message-Id; bh=4EoBaoeWrdJ1wibaAz9k66p2lX+inw9jwOIZfeiOuYU=;
	b=bLSgj/mCMMuHfc5PI3OYSbjs8GbCNSu4X9reaoyIh581E1jC508nI7CDHDtZtbze1BkhCyGz5NvcqT68j5KNPS9gWr6I/J7J2cN0NtVgsQHoZdIUdtWvQFweLZEMIIBeWsOm3ZMBzFCnXymGv69AeOtJvdOaTKqlMeHaXeZ0U5k=;
In-Reply-To: <6734e993a6184b487097463179c3dd75357047b2.1381324538.git.alexander-EP/B3+myoZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

parse-resume.sh already contains all the code from resume-genrules.sh.
Also parse-resume.sh is executed before resume-genrules.sh, so there is
no point to keep the latter.

This fixes the following error messages:
dracut-initqueue: ln: failed to create symbolic link '/dev/resume': File exists
dracut-initqueue: rm: cannot remove '/lib/dracut/hooks/initqueue/settled/resume.sh': No such file or directory
dracut-initqueue: rm: cannot remove '/lib/dracut/hooks/initqueue/timeout/resume.sh': No such file or directory
---
 modules.d/95resume/module-setup.sh    |  1 -
 modules.d/95resume/resume-genrules.sh | 51 -----------------------------------
 2 files changed, 52 deletions(-)
 delete mode 100755 modules.d/95resume/resume-genrules.sh

diff --git a/modules.d/95resume/module-setup.sh b/modules.d/95resume/module-setup.sh
index 8b37616..a172c27 100755
--- a/modules.d/95resume/module-setup.sh
+++ b/modules.d/95resume/module-setup.sh
@@ -32,7 +32,6 @@ install() {
         inst_hook cmdline 10 "$moddir/parse-resume.sh"
     else
         inst_script "$moddir/parse-resume.sh" /lib/dracut/parse-resume.sh
-        inst_hook pre-udev 30 "$moddir/resume-genrules.sh"
     fi
 
     inst_script  "$moddir/resume.sh" /lib/dracut/resume.sh
diff --git a/modules.d/95resume/resume-genrules.sh b/modules.d/95resume/resume-genrules.sh
deleted file mode 100755
index c542c71..0000000
--- a/modules.d/95resume/resume-genrules.sh
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
-# ex: ts=8 sw=4 sts=4 et filetype=sh
-
-case "$splash" in
-    quiet )
-        a_splash="-P splash=y"
-    ;;
-    * )
-        a_splash="-P splash=n"
-    ;;
-esac
-
-if [ -n "$resume" ]; then
-    {
-        printf "KERNEL==\"%s\", ACTION==\"add|change\", SYMLINK+=\"/dev/resume\"\n" \
-            ${resume#/dev/};
-        printf "SYMLINK==\"%s\", ACTION==\"add|change\", SYMLINK+=\"/dev/resume\"\n" \
-            ${resume#/dev/};
-    } >> /etc/udev/rules.d/99-resume-link.rules
-
-    {
-        if [ -x /usr/sbin/resume ]; then
-            printf "KERNEL==\"%s\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\", RUN+=\"/sbin/initqueue --finished --unique --name 00resume /usr/sbin/resume %s \'%s\'\"\n" \
-                ${resume#/dev/} "$a_splash" "$resume";
-            printf "SYMLINK==\"%s\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\", RUN+=\"/sbin/initqueue --finished --unique --name 00resume /usr/sbin/resume %s \'%s\'\"\n" \
-                ${resume#/dev/} "$a_splash" "$resume";
-        fi
-        printf "KERNEL==\"%s\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\", RUN+=\"/sbin/initqueue --finished --unique --name 00resume echo %%M:%%m > /sys/power/resume\"\n" \
-            ${resume#/dev/};
-        printf "SYMLINK==\"%s\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\", RUN+=\"/sbin/initqueue --finished --unique --name 00resume echo %%M:%%m  > /sys/power/resume\"\n" \
-            ${resume#/dev/};
-    } >> /etc/udev/rules.d/99-resume.rules
-
-    printf '[ -e "%s" ] && { ln -s "%s" /dev/resume; rm "$job" "%s/initqueue/timeout/resume.sh"; }\n' \
-        "$resume" "$resume" "$hookdir" >> $hookdir/initqueue/settled/resume.sh
-
-    printf 'warn "Cancelling resume operation. Device not found."; cancel_wait_for_dev /dev/resume; rm "$job" "%s/initqueue/settled/resume.sh";' \
-        "$hookdir" >> $hookdir/initqueue/timeout/resume.sh
-
-    wait_for_dev "/dev/resume"
-
-elif ! getarg noresume; then
-    {
-        if [ -x /usr/sbin/resume ]; then
-            printf "SUBSYSTEM==\"block\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\", RUN+=\"/sbin/initqueue --finished --unique --name 00resume /usr/sbin/resume %s \$tempnode\"\n" "$a_splash"
-        fi
-        echo "SUBSYSTEM==\"block\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\"," \
-            " RUN+=\"/sbin/initqueue --finished --unique --name 00resume echo %M:%m > /sys/power/resume\"";
-    } >> /etc/udev/rules.d/99-resume.rules
-fi
-- 
1.8.1.5
