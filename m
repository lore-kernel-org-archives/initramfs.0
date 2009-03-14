From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 2/2] Add nfsroot option handler
Date: Sat, 14 Mar 2009 13:53:07 +0100
Message-ID: <49BBA8B3.6090201@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This just parses for root=/dev/nfs and then sets the correct variables 
for the mount script, which automatically uses mount.nfs

---
 modules.d/40nfsroot/check      |    5 +++++
 modules.d/40nfsroot/install    |    7 +++++++
 modules.d/40nfsroot/nfsroot.sh |   16 ++++++++++++++++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/modules.d/40nfsroot/check b/modules.d/40nfsroot/check
new file mode 100755
index 0000000..b7378c3
--- /dev/null
+++ b/modules.d/40nfsroot/check
@@ -0,0 +1,5 @@
+#!/bin/sh
+#
+# This is not a module that should be selected when we try to
+# autoconfigure the initrd 
+exit 1
diff --git a/modules.d/40nfsroot/install b/modules.d/40nfsroot/install
new file mode 100755
index 0000000..b68e5d8
--- /dev/null
+++ b/modules.d/40nfsroot/install
@@ -0,0 +1,7 @@
+#!/bin/bash
+dracut_install mount.nfs portmap
+
+instmods nfs
+
+# install our scripts and hooks
+inst_hook pre-mount 20 "$moddir/nfsroot.sh"
diff --git a/modules.d/40nfsroot/nfsroot.sh b/modules.d/40nfsroot/nfsroot.sh
new file mode 100755
index 0000000..757f162
--- /dev/null
+++ b/modules.d/40nfsroot/nfsroot.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+#
+# Parse nfsroot options, set NETBOOT to yes to enable mininm.sh and
+# start portmap for nfsmounting 
+
+getarg 'root=/dev/nfs' || continue;
+
+NETBOOT="yes"
+
+nfsroot=$(getarg 'nfsroot=')
+
+fstype="-t nfs"
+rflags=${nfsroot##*:}
+root=${nfsroot%:*}
+
+/sbin/portmap
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
