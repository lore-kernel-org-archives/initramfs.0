From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 05/10] add firmware packages to be required by the dracut-generic package
Date: Fri,  3 Jul 2009 18:45:15 +0200
Message-ID: <1246639520-3094-6-git-send-email-harald@redhat.com>
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
 dracut.spec |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/dracut.spec b/dracut.spec
index 3e33819..4fae92b 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -60,12 +60,17 @@ Requires: rpcbind nfs-utils
 Requires: iscsi-initiator-utils
 Requires: nbd
 Requires: net-tools iproute
+Requires: kernel-firmware
+Requires: ql2100-firmware
+Requires: ql2200-firmware
+Requires: ql23xx-firmware
+Requires: ql2400-firmware
+Requires: ql2500-firmware
 
 %description generic
 This package requires everything which is needed to build a generic
 all purpose initramfs.
 
-
 %prep
 %setup -q -n %{name}-%{version}%{?dashgittag}
 
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
