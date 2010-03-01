From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] Fix boot with user suspend and no resume= kernel argument
Date: Mon, 01 Mar 2010 21:10:26 +0300
Message-ID: <20100301181026.16229.93268.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Mandriva bug https://qa.mandriva.com/show_bug.cgi?id=57924. Check
if dracut got resume= argument before calling /usr/sbin/resume

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 modules.d/95uswsusp/resume-uswsusp.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/modules.d/95uswsusp/resume-uswsusp.sh b/modules.d/95uswsusp/resume-uswsusp.sh
index 9b18567..ce0e3d2 100755
--- a/modules.d/95uswsusp/resume-uswsusp.sh
+++ b/modules.d/95uswsusp/resume-uswsusp.sh
@@ -8,4 +8,6 @@ case "$splash" in
     ;;
 esac
 
-/usr/sbin/resume $a_splash "$resume"
+if [ -n "$resume" ]; then
+    /usr/sbin/resume $a_splash "$resume"
+fi
