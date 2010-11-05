From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] resume: merge uswsusp module into resume
Date: Fri,  5 Nov 2010 18:29:26 +0300
Message-ID: <1288970966-3652-1-git-send-email-arvidjaar@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=UUsPRL7OZG9D5J0NPfF/YNlAyED1wePhunlDIaUwQmk=;
        b=AUAq3JAtb/nX/kJ7yRE5sQvVRslGSCgWqia0y7qLdADgPRTc/3frhcWF65hel1Vg9k
         LjwHAJEKDv3cKewY2NKoSl8OaLMGxO/Sf19pN49RuA5KS9RVmj6jI8rJXkA0dyDHgrW1
         WX5XcenGybYQ5E9q+iRsCerIkXNLZOb/No6mk=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

uswsusp almost completely duplicates resume; merge them.

Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/95resume/install            |   10 ++++++++++
 modules.d/95resume/parse-resume.sh    |    6 ++++++
 modules.d/95resume/resume-genrules.sh |   24 ++++++++++++++++++++++++
 modules.d/95resume/resume.sh          |   11 +++++++++++
 modules.d/95uswsusp/check             |    5 -----
 modules.d/95uswsusp/install           |   14 --------------
 modules.d/95uswsusp/parse-uswsusp.sh  |   23 -----------------------
 modules.d/95uswsusp/resume-uswsusp.sh |   16 ----------------
 8 files changed, 51 insertions(+), 58 deletions(-)

diff --git a/modules.d/95resume/install b/modules.d/95resume/install
index 779d076..330a3ea 100755
--- a/modules.d/95resume/install
+++ b/modules.d/95resume/install
@@ -2,6 +2,16 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
+# Optional uswsusp support
+for bin in /usr/sbin/resume /usr/lib/suspend/resume
+do
+    [[ -x "${bin}" ]] && {
+        inst "${bin}" /usr/sbin/resume
+        [[ -f /etc/suspend.conf ]] && inst /etc/suspend.conf
+        break 
+    }
+done
+
 inst_hook cmdline 10 "$moddir/parse-resume.sh"
 inst_hook pre-udev 30 "$moddir/resume-genrules.sh"
 inst_hook mount 10 "$moddir/resume.sh"
diff --git a/modules.d/95resume/parse-resume.sh b/modules.d/95resume/parse-resume.sh
index 2c7661f..90db4a7 100755
--- a/modules.d/95resume/parse-resume.sh
+++ b/modules.d/95resume/parse-resume.sh
@@ -16,3 +16,9 @@ case "$resume" in
     UUID=*) \
         resume="/dev/disk/by-uuid/${resume#UUID=}" ;;
 esac
+
+if splash=$(getarg splash=); then
+    export splash
+else
+    unset splash
+fi
diff --git a/modules.d/95resume/resume-genrules.sh b/modules.d/95resume/resume-genrules.sh
index ce880a5..d7c5b64 100755
--- a/modules.d/95resume/resume-genrules.sh
+++ b/modules.d/95resume/resume-genrules.sh
@@ -1,6 +1,15 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
+case "$splash" in
+    quiet )
+        a_splash="-P splash=y"
+    ;;
+    * )
+        a_splash="-P splash=n"
+    ;;
+esac
+
 if [ -n "$resume" ]; then
     {
         printf "KERNEL==\"%s\", ACTION==\"add|change\", SYMLINK+=\"/dev/resume\"\n" \
@@ -10,6 +19,12 @@ if [ -n "$resume" ]; then
     } >> /dev/.udev/rules.d/99-resume-link.rules
 
     {
+        if [ -x /usr/sbin/resume ]; then
+            printf "KERNEL==\"%s\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\", RUN+=\"/usr/sbin/resume %s '%s'\"\n" \
+                ${resume#/dev/} "$a_splash" "$resume";
+            printf "SYMLINK==\"%s\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\", RUN+=\"/usr/sbin/resume %s '%s'\"\n" \
+                ${resume#/dev/} "$a_splash" "$resume";
+        fi
         printf "KERNEL==\"%s\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\", RUN+=\"/bin/sh -c 'echo %%M:%%m > /sys/power/resume'\"\n" \
             ${resume#/dev/};
         printf "SYMLINK==\"%s\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\", RUN+=\"/bin/sh -c 'echo %%M:%%m > /sys/power/resume'\"\n" \
@@ -21,8 +36,17 @@ if [ -n "$resume" ]; then
 
     echo '[ -e /dev/resume ]' > /initqueue-finished/resume.sh
 
+    {
+        printf '[ -e /dev/resume ] || '
+        printf 'warn "resume device "%s" not found"\n' "$resume"
+    } >> /emergency/00-resume.sh
+
+
 elif ! getarg noresume; then
     {
+        if [ -x /usr/sbin/resume ]; then
+            printf "SUBSYSTEM==\"block\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\", RUN+=\"/usr/sbin/resume %s '\$tempnode'\"\n" "$a_splash"
+        fi
         echo "SUBSYSTEM==\"block\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\"," \
             " RUN+=\"/bin/sh -c 'echo %M:%m > /sys/power/resume'\"";
     } >> /etc/udev/rules.d/99-resume.rules
diff --git a/modules.d/95resume/resume.sh b/modules.d/95resume/resume.sh
index ee55414..943d9e5 100755
--- a/modules.d/95resume/resume.sh
+++ b/modules.d/95resume/resume.sh
@@ -3,6 +3,17 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 [ -s /.resume -a -b "$resume" ] && {
+    # First try user level resume; it offers splash etc
+    case "$splash" in
+        quiet )
+            a_splash="-P splash=y"
+        ;;
+        * )
+            a_splash="-P splash=n"
+        ;;
+    esac
+    [ -x /usr/sbin/resume ] && /usr/sbin/resume $a_splash "$resume"
+
     # parsing the output of ls is Bad, but until there is a better way...
     ls -lH "$resume" | ( 
         read x x x x maj min x;
diff --git a/modules.d/95uswsusp/check b/modules.d/95uswsusp/check
deleted file mode 100755
index 3df4e4e..0000000
--- a/modules.d/95uswsusp/check
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
-# ex: ts=8 sw=4 sts=4 et filetype=sh
-
-[ -x /usr/sbin/resume ] || [ -x /usr/lib/suspend/resume ]
diff --git a/modules.d/95uswsusp/install b/modules.d/95uswsusp/install
deleted file mode 100755
index 61b8edd..0000000
--- a/modules.d/95uswsusp/install
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/bash
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
-# ex: ts=8 sw=4 sts=4 et filetype=sh
-
-for bin in /usr/sbin/resume /usr/lib/suspend/resume
-do
-    [ -x "${bin}" ] && break 
-done
-
-inst "${bin}" /usr/sbin/resume
-[ -f /etc/suspend.conf ] && inst /etc/suspend.conf
-
-inst_hook cmdline 10 "$moddir/parse-uswsusp.sh"
-inst_hook mount 10 "$moddir/resume-uswsusp.sh"
diff --git a/modules.d/95uswsusp/parse-uswsusp.sh b/modules.d/95uswsusp/parse-uswsusp.sh
deleted file mode 100755
index ac18b09..0000000
--- a/modules.d/95uswsusp/parse-uswsusp.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
-# ex: ts=8 sw=4 sts=4 et filetype=sh
-
-if resume=$(getarg resume=) && ! getarg noresume; then 
-    export resume
-else
-    unset resume
-fi
-
-case "$resume" in
-    LABEL=*) \
-        resume="$(echo $resume | sed 's,/,\\x2f,g')"
-        resume="/dev/disk/by-label/${resume#LABEL=}" ;;
-    UUID=*) \
-        resume="/dev/disk/by-uuid/${resume#UUID=}" ;;
-esac
-
-if splash=$(getarg rd.splash= splash=); then
-    export splash
-else
-    unset splash
-fi
diff --git a/modules.d/95uswsusp/resume-uswsusp.sh b/modules.d/95uswsusp/resume-uswsusp.sh
deleted file mode 100755
index e8d3b70..0000000
--- a/modules.d/95uswsusp/resume-uswsusp.sh
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
-# ex: ts=8 sw=4 sts=4 et filetype=sh
-
-case "$splash" in
-    quiet )
-        a_splash="-P splash=y"
-        ;;
-    * )
-        a_splash="-P splash=n"
-        ;;
-esac
-
-if [ -n "$resume" ]; then
-    /usr/sbin/resume $a_splash "$resume"
-fi
-- 
tg: (0872b27..) upstream/01-merge-resume (depends on: upstream/rootdev)
