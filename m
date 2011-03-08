From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/7] Fix bash logic typo/buglet ([ condition ] & expression)
Date: Tue,  8 Mar 2011 18:35:11 -0500
Message-ID: <1299627317-11145-2-git-send-email-wwoods@redhat.com>
References: <1299627317-11145-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1299627317-11145-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/90dmsquash-live/dmsquash-live-root |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
index d4ba839..e7c9626 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root
+++ b/modules.d/90dmsquash-live/dmsquash-live-root
@@ -26,7 +26,7 @@ getargbool 0 rd.live.overlay.readonly -y readonly_overlay && readonly_overlay="-
 overlay=$(getarg rd.live.overlay overlay)
 
 # FIXME: we need to be able to hide the plymouth splash for the check really
-[ -e $livedev ] & fs=$(blkid -s TYPE -o value $livedev)
+[ -e $livedev ] && fs=$(blkid -s TYPE -o value $livedev)
 if [ "$fs" = "iso9660" -o "$fs" = "udf" ]; then
     check="yes"
 fi
-- 
1.7.4
