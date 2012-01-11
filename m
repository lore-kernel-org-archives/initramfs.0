From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] minor cleanups in parsing for dmsquash-live and livenet
Date: Wed, 11 Jan 2012 12:48:28 -0500
Message-ID: <1326304109-32652-2-git-send-email-wwoods@redhat.com>
References: <1326304109-32652-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1326304109-32652-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

- use wait_for_dev in livenet
- clarify log message and fix missing newline in dmsquash-live

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90dmsquash-live/parse-dmsquash-live.sh |    4 ++--
 modules.d/90livenet/parse-livenet.sh             |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/90dmsquash-live/parse-dmsquash-live.sh b/modules.d/90dmsquash-live/parse-dmsquash-live.sh
index a733144..d60db01 100755
--- a/modules.d/90dmsquash-live/parse-dmsquash-live.sh
+++ b/modules.d/90dmsquash-live/parse-dmsquash-live.sh
@@ -41,9 +41,9 @@ case "$liveroot" in
     live:/*.[Ii][Mm][Gg]|/*.[Ii][Mm][Gg])
         [ -f "${root#live:}" ] && rootok=1 ;;
 esac
-info "liveroot was $liveroot, is now $root"
+info "root was $liveroot, is now $root"
 
 # make sure that init doesn't complain
 [ -z "$root" ] && root="live"
 
-wait_for_dev /dev/mapper/live-rw
\ No newline at end of file
+wait_for_dev /dev/mapper/live-rw
diff --git a/modules.d/90livenet/parse-livenet.sh b/modules.d/90livenet/parse-livenet.sh
index 323fd4a..2e6bc4b 100755
--- a/modules.d/90livenet/parse-livenet.sh
+++ b/modules.d/90livenet/parse-livenet.sh
@@ -16,4 +16,4 @@ case "$liveurl" in
         rootok=1 ;;
 esac
 
-echo '[ -e /dev/root ]' > $hookdir/initqueue/finished/livenet.sh
+wait_for_dev /dev/root
-- 
1.7.7.5
