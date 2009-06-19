From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/4] add README.generic
Date: Fri, 19 Jun 2009 14:01:17 +0200
Message-ID: <1245412879-4418-3-git-send-email-harald@redhat.com>
References: <1245412879-4418-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245412879-4418-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 README.generic |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 README.generic

diff --git a/README.generic b/README.generic
new file mode 100644
index 0000000..f393e9f
--- /dev/null
+++ b/README.generic
@@ -0,0 +1,10 @@
+To build a generic initramfs, you have to install the following software packages:
+ * device-mapper
+ * cryptsetup-luks
+ * rpcbind nfs-utils 
+ * lvm2
+ * iscsi-initiator-utils
+ * nbd
+ * mdadm
+ * net-tools iproute
+
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
