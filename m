From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] dracut.sh: fix $tmpfilesdir fallback when systemd-devel is not installed.
Date: Tue,  7 Jun 2016 09:16:05 +0100
Message-ID: <20160607081605.1205-1-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

Bug introduced in 3a04bddeed in Dec 2014.
---
 dracut.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 8232fa4..a50eaff 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1260,8 +1260,8 @@ fi
     || tmpfilesdir=$(pkg-config systemd --variable=tmpfilesdir 2>/dev/null)
 
 if ! [[ -d "$tmpfilesdir" ]]; then
-    [[ -f /lib/tmpfiles.d ]] && tmpfilesdir=/lib/tmpfiles.d
-    [[ -f /usr/lib/tmpfiles.d ]] && tmpfilesdir=/usr/lib/tmpfiles.d
+    [[ -d /lib/tmpfiles.d ]] && tmpfilesdir=/lib/tmpfiles.d
+    [[ -d /usr/lib/tmpfiles.d ]] && tmpfilesdir=/usr/lib/tmpfiles.d
 fi
 
 export initdir dracutbasedir \
-- 
2.8.3
