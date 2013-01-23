From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/6] resume: Ensure we remove the timout job when we find the resume device
Date: Wed, 23 Jan 2013 20:15:03 +0000
Message-ID: <1358972106-2395-4-git-send-email-colin@mageia.org>
References: <1358972106-2395-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358972106-2395-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

---
 modules.d/95resume/resume-genrules.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/95resume/resume-genrules.sh b/modules.d/95resume/resume-genrules.sh
index f16df8c..c542c71 100755
--- a/modules.d/95resume/resume-genrules.sh
+++ b/modules.d/95resume/resume-genrules.sh
@@ -32,8 +32,8 @@ if [ -n "$resume" ]; then
             ${resume#/dev/};
     } >> /etc/udev/rules.d/99-resume.rules
 
-    printf '[ -e "%s" ] && { ln -s "%s" /dev/resume; rm "$job"; udevadm settle; }\n' \
-        "$resume" "$resume" >> $hookdir/initqueue/settled/resume.sh
+    printf '[ -e "%s" ] && { ln -s "%s" /dev/resume; rm "$job" "%s/initqueue/timeout/resume.sh"; }\n' \
+        "$resume" "$resume" "$hookdir" >> $hookdir/initqueue/settled/resume.sh
 
     printf 'warn "Cancelling resume operation. Device not found."; cancel_wait_for_dev /dev/resume; rm "$job" "%s/initqueue/settled/resume.sh";' \
         "$hookdir" >> $hookdir/initqueue/timeout/resume.sh
-- 
1.8.1
