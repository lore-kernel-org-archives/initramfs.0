From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 5/9] resume: add support for labeled resume devices
Date: Mon, 1 Jun 2009 00:25:09 -0400
Message-ID: <9810ce7e38ec1ba52a9c2f5f5047ea779d1006a3.1243833882.git.dave@thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I noticed when doing the block root= parser that resume
didn't support labeled resume devices. Fix that up and
get rid of a dependency on /bin/echo in the process.

Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
---
 modules.d/95resume/install            |    1 -
 modules.d/95resume/parse-resume.sh    |    8 ++++++++
 modules.d/95resume/resume-genrules.sh |   14 ++++++++------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/modules.d/95resume/install b/modules.d/95resume/install
index 945611e..cecd2fc 100755
--- a/modules.d/95resume/install
+++ b/modules.d/95resume/install
@@ -1,5 +1,4 @@
 #!/bin/bash
-dracut_install echo
 inst_hook cmdline 10 "$moddir/parse-resume.sh"
 inst_hook pre-udev 30 "$moddir/resume-genrules.sh"
 inst_hook mount 90 "$moddir/resume.sh"
diff --git a/modules.d/95resume/parse-resume.sh b/modules.d/95resume/parse-resume.sh
index 447e151..94d7112 100755
--- a/modules.d/95resume/parse-resume.sh
+++ b/modules.d/95resume/parse-resume.sh
@@ -5,3 +5,11 @@ if resume=$(getarg resume=) && ! getarg noresume; then
 else
     unset resume
 fi
+
+case "$resume" in
+    LABEL=*)
+	resume="$(echo $resume | sed 's,/,\\x2f,g')"
+	resume="/dev/disk/by-label/${resume#LABEL=}" ;;
+    UUID=*)
+	resume="/dev/disk/by-uuid/${resume#UUID=}" ;;
+esac
diff --git a/modules.d/95resume/resume-genrules.sh b/modules.d/95resume/resume-genrules.sh
index 108c3f7..7c95715 100755
--- a/modules.d/95resume/resume-genrules.sh
+++ b/modules.d/95resume/resume-genrules.sh
@@ -1,6 +1,8 @@
-resume=$(getarg resume=) && ! getarg noresume  && {
-(
-	/bin/echo -e 'KERNEL=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
-	/bin/echo -e 'SYMLINK=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
-) >> /etc/udev/rules.d/99-resume.rules
-}
+if [ -n "$resume" ]; then
+    (
+    printf 'KERNEL=="%s", RUN+="/bin/echo %%M:%%m > /sys/power/resume"\n' \
+		${resume#/dev/}
+    printf 'SYMLINK=="%s", RUN+="/bin/echo %%M:%%m > /sys/power/resume"\n' \
+		${resume#/dev/}
+    ) >> /etc/udev/rules.d/99-resume.rules
+fi
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
