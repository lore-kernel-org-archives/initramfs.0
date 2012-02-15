From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] livenet: avoid spurious error message / wait_for_dev
Date: Wed, 15 Feb 2012 13:36:09 -0500
Message-ID: <1329330969-19350-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If the user didn't request a livenet boot, don't print an error
and don't do wait_for_dev.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90livenet/parse-livenet.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/modules.d/90livenet/parse-livenet.sh b/modules.d/90livenet/parse-livenet.sh
index a255f41..39aa40c 100755
--- a/modules.d/90livenet/parse-livenet.sh
+++ b/modules.d/90livenet/parse-livenet.sh
@@ -15,10 +15,8 @@ if get_url_handler "$liveurl" >/dev/null; then
     netroot="livenet:$liveurl"
     root="livenet" # quiet complaints from init
     rootok=1
-else
-    info "livenet: no url handler for $liveurl"
+    wait_for_dev /dev/root
 fi
-wait_for_dev /dev/root
 
 for url in $(getargs updates= live.updates=); do
     [ -z "$netroot" ] && netroot=skip
-- 
1.7.7.6
