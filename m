From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dmsquash-live: fix log message about root/liveroot
Date: Wed, 12 Oct 2011 22:49:35 -0400
Message-ID: <1318474175-2059-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/90dmsquash-live/parse-dmsquash-live.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90dmsquash-live/parse-dmsquash-live.sh b/modules.d/90dmsquash-live/parse-dmsquash-live.sh
index 6e0db29..5cbcd2c 100755
--- a/modules.d/90dmsquash-live/parse-dmsquash-live.sh
+++ b/modules.d/90dmsquash-live/parse-dmsquash-live.sh
@@ -41,7 +41,7 @@ case "$liveroot" in
     live:/*.[Ii][Mm][Gg]|/*.[Ii][Mm][Gg])
         [ -f "${root#live:}" ] && rootok=1 ;;
 esac
-info "root was $root, liveroot is now $liveroot"
+info "liveroot was $liveroot, is now $root"
 
 # make sure that init doesn't complain
 [ -z "$root" ] && root="live"
-- 
1.7.6.4
