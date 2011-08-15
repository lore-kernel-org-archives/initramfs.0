From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] fix live crash with livenet installed
Date: Mon, 15 Aug 2011 11:10:59 -0400
Message-ID: <1313421059-32151-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

parse-livenet.sh shouldn't mess with $root unless it finds a valid URL.
---
 modules.d/90livenet/parse-livenet.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90livenet/parse-livenet.sh b/modules.d/90livenet/parse-livenet.sh
index 78fc906..323fd4a 100755
--- a/modules.d/90livenet/parse-livenet.sh
+++ b/modules.d/90livenet/parse-livenet.sh
@@ -12,8 +12,8 @@ liveurl="${liveurl#live:}"
 case "$liveurl" in
     http://*|https://*|ftp://*)
         netroot="livenet:$liveurl"
+        root="livenet" # quiet complaints from init
         rootok=1 ;;
 esac
 
-root="livenet" # quiet complaints from init
 echo '[ -e /dev/root ]' > $hookdir/initqueue/finished/livenet.sh
-- 
1.7.6
