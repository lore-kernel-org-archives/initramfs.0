From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 08/11] fall back to filesystem type "auto"
Date: Fri, 15 May 2009 14:39:58 +0200
Message-ID: <4A0D629E.9000603@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080906050406010308090905"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------080906050406010308090905
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

---
  modules.d/95rootfs-block-udev/parse-root-opts.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)



--------------080906050406010308090905
Content-Type: text/x-patch;
 name="9b1581051f00bda19f999b8f777f3c55463aa1fa.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="9b1581051f00bda19f999b8f777f3c55463aa1fa.diff"

diff --git a/modules.d/95rootfs-block-udev/parse-root-opts.sh b/modules.d/95rootfs-block-udev/parse-root-opts.sh
index 473c34d..77aed55 100755
--- a/modules.d/95rootfs-block-udev/parse-root-opts.sh
+++ b/modules.d/95rootfs-block-udev/parse-root-opts.sh
@@ -22,6 +22,6 @@ else
     getarg rw && rflags=rw || rflags=ro
 fi
 
-fstype="$(getarg rootfstype=)" && fstype="-t ${fstype}"
+fstype="$(getarg rootfstype=)" && fstype="-t ${fstype}" || fstype="-t auto"
 
 export fstype rflags root


--------------080906050406010308090905--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
