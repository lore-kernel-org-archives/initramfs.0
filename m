From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 01/10] add binutiles requirement to specfile (because of nm)
Date: Fri,  3 Jul 2009 18:45:11 +0200
Message-ID: <1246639520-3094-2-git-send-email-harald@redhat.com>
References: <1246639520-3094-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246639520-3094-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 dracut.spec |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/dracut.spec b/dracut.spec
index 7b7a224..3e33819 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -27,6 +27,7 @@ Requires: module-init-tools
 Requires: cpio
 Requires: coreutils
 Requires: findutils
+Requires: binutils
 Requires: grep
 Requires: mktemp
 Requires: mount
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
