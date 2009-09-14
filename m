From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] Document netroot=fcoe:....
Date: Mon, 14 Sep 2009 11:42:53 +0200
Message-ID: <1252921374-2798-2-git-send-email-hdegoede@redhat.com>
References: <1252921374-2798-1-git-send-email-hdegoede@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1252921374-2798-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 dracut.8 |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/dracut.8 b/dracut.8
index e9bd0d8..322f879 100644
--- a/dracut.8
+++ b/dracut.8
@@ -224,6 +224,12 @@ e.g.
 .B root=??? iscsi_firmware
 will read the iscsi parameter from the BIOS firmware
 
+.SH FCoE
+.TP
+.B netroot=fcoe:<interface|MAC>:<dcb|nodcb>
+Try to connect to a FCoE SAN through the NIC specified by <interface> or <MAC>,
+for the second argument, currently only nodcb is supported.
+
 .SH NBD
 .TP
 .B root=nbd:<server>:<port>[:<fstype>][:<mountopts>]
-- 
1.6.4.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
