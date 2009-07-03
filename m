From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 07/10] fail iscsiroot, if iscsistart fails
Date: Fri,  3 Jul 2009 18:45:17 +0200
Message-ID: <1246639520-3094-8-git-send-email-harald@redhat.com>
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
 modules.d/95iscsi/iscsiroot |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
index 316d8f4..b7e3cf8 100755
--- a/modules.d/95iscsi/iscsiroot
+++ b/modules.d/95iscsi/iscsiroot
@@ -130,7 +130,7 @@ iscsistart -i $iscsi_initiator -t $iscsi_target_name	\
     ${iscsi_username+-u $iscsi_username} \
     ${iscsi_password+-w $iscsi_password} \
     ${iscsi_in_username+-U $iscsi_in_username} \
-    ${iscsi_in_password+-W $iscsi_in_password}
+    ${iscsi_in_password+-W $iscsi_in_password} || exit 1
 
 # now we have a root filesystem somewhere in /dev/sda*
 # let the normal block handler handle root=
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
