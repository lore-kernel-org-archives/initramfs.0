From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 9/9] skiproot - script for network setup without network root
Date: Tue, 14 Feb 2012 12:38:10 -0500
Message-ID: <1329241090-26908-10-git-send-email-wwoods@redhat.com>
References: <1329241090-26908-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329241090-26908-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This allows you to set up the network for non-netroot things (like
fetching updates for live images, etc).

The other parse-*.sh script can set 'netroot=skip', and anything that
should happen when the network comes up can be put into the 'netroot'
hook, something like this:

  echo "fetch-liveupdate $update_url" >> $hookdir/netroot/liveupdates.sh

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/module-setup.sh |    1 +
 modules.d/40network/skiproot        |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/40network/skiproot

diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index 2f4d93d..a224bc5 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -75,6 +75,7 @@ install() {
     dracut_install -o brctl ifenslave
     inst "$moddir/ifup" "/sbin/ifup"
     inst "$moddir/netroot" "/sbin/netroot"
+    inst "$moddir/skiproot" "/sbin/skiproot"
     inst "$moddir/dhclient-script" "/sbin/dhclient-script"
     inst "$moddir/net-lib.sh" "/lib/net-lib.sh"
     inst_simple "$moddir/dhclient.conf" "/etc/dhclient.conf"
diff --git a/modules.d/40network/skiproot b/modules.d/40network/skiproot
new file mode 100755
index 0000000..86793c7
--- /dev/null
+++ b/modules.d/40network/skiproot
@@ -0,0 +1,14 @@
+#!/bin/bash
+# skiproot - a netroot handler that doesn't do anything.
+#
+# useful if you want the network up for non-root things (like fetching
+# updates, kickstarts, drivers, etc.) but you're not actually using a
+# network root device.
+#
+# Your other parse-*.sh script should set "netroot=skip", and anything
+# that you want to happen when the network comes up should be put into
+# the "netroot" hook, e.g.:
+#echo "fetch-liveupdate $updateurl" > $hookdir/netroot/fetch-updates.sh
+
+# do nothing!
+true
-- 
1.7.7.6
