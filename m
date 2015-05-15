From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] resume: Ensure we actually wait for the /dev/resume 'device'
Date: Fri, 15 May 2015 14:53:41 +0100
Message-ID: <1431698021-16626-3-git-send-email-colin@mageia.org>
References: <1431698021-16626-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431698021-16626-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

Although various bits are in place to cancel waiting for the /dev/resume
device (actually a symlink), we don't actually ever wait for it.

Also as the udev rule may create the symlink, silence any errors from
our manual ln -s call from the settled job.
---
 modules.d/95resume/parse-resume.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/modules.d/95resume/parse-resume.sh b/modules.d/95resume/parse-resume.sh
index 9296429..3b97e51 100755
--- a/modules.d/95resume/parse-resume.sh
+++ b/modules.d/95resume/parse-resume.sh
@@ -37,6 +37,8 @@ esac
 
 if ! getarg noresume; then
     if [ -n "$resume" ]; then
+        wait_for_dev /dev/resume
+
         {
             printf "KERNEL==\"%s\", ACTION==\"add|change\", SYMLINK+=\"resume\"\n" \
                 ${resume#/dev/};
@@ -65,7 +67,7 @@ if ! getarg noresume; then
             printf -- '%s\n' ' RUN+="/sbin/initqueue --finished --unique --name 00resume echo %M:%m  > /sys/power/resume"'
         } >> /etc/udev/rules.d/99-resume.rules
 
-        printf '[ -e "%s" ] && { ln -s "%s" /dev/resume; rm -f -- "$job" "%s/initqueue/timeout/resume.sh"; }\n' \
+        printf '[ -e "%s" ] && { ln -s "%s" /dev/resume 2> /dev/null; rm -f -- "$job" "%s/initqueue/timeout/resume.sh"; }\n' \
             "$resume" "$resume" "$hookdir" >> $hookdir/initqueue/settled/resume.sh
 
         {
-- 
2.3.2
