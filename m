From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 06/14] limit the devices for which lvm vgscan will scan
Date: Wed, 15 Jul 2009 18:50:38 +0200
Message-ID: <1247676646-3837-7-git-send-email-harald@redhat.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Build the filter list and create /etc/lvm/lvm.conf for all LVM_member
devices found by udev.
---
 modules.d/90lvm/lvm_scan.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/modules.d/90lvm/lvm_scan.sh b/modules.d/90lvm/lvm_scan.sh
index cd843aa..489c7a1 100755
--- a/modules.d/90lvm/lvm_scan.sh
+++ b/modules.d/90lvm/lvm_scan.sh
@@ -3,6 +3,25 @@
 if $UDEV_QUEUE_EMPTY >/dev/null 2>&1; then
     [ -h "$job" ] && rm -f "$job"
     # run lvm scan if udev has settled
+
+    [ -d /etc/lvm ] || mkdir -p /etc/lvm
+    # build a list of devices to scan
+    lvmdevs=$(
+	for f in /tmp/.lvm_scan-*; do
+	    [ -e "$f" ] || continue
+	    echo ${f##/tmp/.lvm_scan-}
+	done
+	)
+    {
+	echo 'devices {';
+	echo -n '    filter = [ '
+	for dev in $lvmdevs; do
+	    printf '"a|^/dev/%s$|", ' $dev;
+	done;
+	echo '"r/.*/" ]';
+	echo '}';	  
+    } > /etc/lvm/lvm.conf
+
     lvm vgscan
     lvm vgchange -ay
 fi
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
