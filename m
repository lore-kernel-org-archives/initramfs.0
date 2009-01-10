From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] Fix tense.
Date: Sat, 10 Jan 2009 14:59:12 -0500
Message-ID: <1231617553-4206-2-git-send-email-notting@redhat.com>
References: <1231617553-4206-1-git-send-email-notting@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1231617553-4206-1-git-send-email-notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init b/init
index 12144d2..9b7cfe9 100755
--- a/init
+++ b/init
@@ -81,7 +81,7 @@ while [ ! -e $root ]; do
       emergency_shell
   fi
 done
-echo -e "\n\nMounted rootfs after $tries seconds"
+echo -e "\n\nMounting rootfs after $tries seconds"
 ln -s "$root" /dev/root    
 mount -o ro /dev/root $NEWROOT
 
-- 
1.6.1

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
