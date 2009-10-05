From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut.8: fix typo
Date: Mon,  5 Oct 2009 13:08:08 +0200
Message-ID: <1254740888-9794-1-git-send-email-kzak@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.8 |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/dracut.8 b/dracut.8
index fccd574..88f1901 100644
--- a/dracut.8
+++ b/dracut.8
@@ -1,12 +1,12 @@
 .TH DRACUT 8 "June 2009" "Linux"
 .SH NAME
-switch_root \- switch to another filesystem as the root of the mount tree.
+dracut \- creates an initial image used by the kernel
 .SH SYNOPSIS
 \fBdracut\fR [\fIOPTION\fR]... \fI<image>\fR  \fI<kernel-version>\fR
 
 .SH DESCRIPTION
-.B switch_root
-\fBdracut\fR creates an initial image used by the kernel for
+.B dracut
+creates an initial image used by the kernel for
 preloading the block device modules (such as IDE, SCSI or RAID)
 which are needed to access the root filesystem.
 
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
