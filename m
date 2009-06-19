From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 08/13] manpage iSCSI update
Date: Fri, 19 Jun 2009 13:05:46 +0200
Message-ID: <1245409551-30493-9-git-send-email-harald@redhat.com>
References: <1245409551-30493-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245409551-30493-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 dracut.8 |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/dracut.8 b/dracut.8
index 5258925..0ceccff 100644
--- a/dracut.8
+++ b/dracut.8
@@ -110,12 +110,20 @@ associated fields.
 
 http://tools.ietf.org/html/rfc4173
 
+If the root partition is not specified using \fBroot=\fR, one of the partitions found 
+with label \fBROOT\fR or \fB/\fR will be used to boot from.
+
 .TP
-.B root=??? iscsiroot=...
+.B root=??? netroot=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+e.g. root=LABEL=ROOT netroot=root=LABEL=ROOT netroot=iscsi:192.168.50.1::::iqn.2009-06.dracut:target0
+
 .TP
 .B root=??? iscsi_initiator= iscsi_target_name= iscsi_target_ip= iscsi_target_port= iscsi_target_group= iscsi_username=  iscsi_password= iscsi_in_username= iscsi_in_password=
+these variables can also be put in a file in /conf/conf.d/, which will be sourced
+
 .TP
 .B root=??? iscsi_firmware
+will read the iscsi parameter from the BIOS firmware
 
 .SH NBD
 .TP
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
