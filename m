From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/4] Bring up multipath devices that are configured in multipath.conf.
Date: Tue, 24 Nov 2009 14:52:58 -0500
Message-ID: <1259092378-14143-5-git-send-email-pjones@redhat.com>
References: <1259092378-14143-1-git-send-email-pjones@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259092378-14143-1-git-send-email-pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

This brings up multipath devices which are configured in multipath.conf
as we find them.
---
 modules.d/90multipath/14-multipath-scan.rules |    9 +++++++++
 modules.d/90multipath/install                 |    3 +++
 modules.d/90multipath/multipath-scan.sh       |   16 ++++++++++++++++
 3 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/90multipath/14-multipath-scan.rules
 create mode 100644 modules.d/90multipath/multipath-scan.sh

diff --git a/modules.d/90multipath/14-multipath-scan.rules b/modules.d/90multipath/14-multipath-scan.rules
new file mode 100644
index 0000000..fcb8173
--- /dev/null
+++ b/modules.d/90multipath/14-multipath-scan.rules
@@ -0,0 +1,9 @@
+# scan for multipath devices
+SUBSYSTEM!="block", GOTO="end_mpath_scan"
+KERNEL!="sd*", GOTO="end_mpath_scan"
+PROGRAM=="/bin/sh -c 'for i in //holders/dm-[0-9]*; do [ -e 9429i ] && exit 0; done; exit 1;' ", GOTO="end_mpath_scan"
+RUN+="/sbin/modprobe dm-multipath"
+RUN+="/bin/echo 'queuing multipath scan'"
+RUN+="/sbin/initqueue --settled --onetime --unique --name=mpscan /sbin/multipath-scan"
+RUN+="/bin/sh -c '>/tmp/.multipath-scan-%k;'"
+LABEL="end_mpath_scan"
diff --git a/modules.d/90multipath/install b/modules.d/90multipath/install
index 52d69f5..9662848 100755
--- a/modules.d/90multipath/install
+++ b/modules.d/90multipath/install
@@ -22,3 +22,6 @@ done
 inst_hook pre-trigger 02 "$moddir/multipathd.sh"
 inst_hook pre-pivot   02 "$moddir/multipathd-stop.sh"
 inst_rules 40-multipath.rules
+
+inst "$moddir/multipath-scan.sh" /sbin/multipath-scan
+inst_rules "$moddir/14-multipath-scan.rules"
diff --git a/modules.d/90multipath/multipath-scan.sh b/modules.d/90multipath/multipath-scan.sh
new file mode 100644
index 0000000..0e1d3f2
--- /dev/null
+++ b/modules.d/90multipath/multipath-scan.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+# scan for multipaths if udev has settled
+
+. /lib/dracut-lib.sh
+
+[ -d /etc/multipath ] || mkdir -p /etc/multipath
+mpdevs=$(
+    for f in /tmp/.multipath-scan-* ; do
+        [ -e "$f" ] || continue
+        echo -n "${f##/tmp/.multipath-scan-} "
+    done
+)
+
+[ -e /etc/multipath.conf ] || exit 1
+multipath ${mpdevs}
-- 
1.6.5.2
