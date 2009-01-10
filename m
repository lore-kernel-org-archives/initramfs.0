From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] Fix 'root=LABEL=/'
Date: Sat, 10 Jan 2009 14:59:11 -0500
Message-ID: <1231617553-4206-1-git-send-email-notting@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

As you can't have /dev/disk/by-label//, we need to escape the '/'
character in the same way that udev does.
---
 init |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/init b/init
index 5b94e3d..12144d2 100755
--- a/init
+++ b/init
@@ -64,7 +64,10 @@ if [ -z "$root" ]; then
   echo "Warning: no root specified"
   root="/dev/sda1"
 elif [ "${root#LABEL=}" != $root ]; then
-  root="/dev/disk/by-label/${root#LABEL=}"
+  # FIXME: may need to do more escaping here
+  l=${root#LABEL=}
+  label=${l//\//\\x2f}
+  root="/dev/disk/by-label/${label}"
 elif [ "${root#UUID=}" != $root ]; then
   root="/dev/disk/by-uuid/${root#UUID=}"
 fi
-- 
1.6.1

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
