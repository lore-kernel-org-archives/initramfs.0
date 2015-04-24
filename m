From: Radek Vykydal <rvykydal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Fix typo in rd.live.overlay.size setting
Date: Fri, 24 Apr 2015 12:33:06 +0200
Message-ID: <1429871586-25877-1-git-send-email-rvykydal@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/90dmsquash-live/dmsquash-live-root.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index b632f6a..0e7e42e 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -27,7 +27,7 @@ getargbool 0 rd.live.overlay.reset -d -y reset_overlay && reset_overlay="yes"
 getargbool 0 rd.live.overlay.readonly -d -y readonly_overlay && readonly_overlay="--readonly" || readonly_overlay=""
 overlay=$(getarg rd.live.overlay -d overlay)
 getargbool 0 rd.writable.fsimg -d -y writable_fsimg && writable_fsimg="yes"
-overlay_size=$(getarg rd.live.overlay.size=)
+overlay_size=$(getarg rd.live.overlay.size)
 [ -z "$overlay_size" ] && overlay_size=512
 
 getargbool 0 rd.live.overlay.thin && thin_snapshot="yes"
-- 
1.9.3
