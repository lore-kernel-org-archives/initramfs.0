From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/7] split nfs rpc daemons startup script
Date: Thu, 2 Feb 2012 16:00:07 +0800
Message-ID: <20120202080007.GA12420@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

fstab-sys will mount nonroot nfs as well, so we need to split the necessary
code from nfsroot to start rpc daemon as hook script.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95nfs/module-setup.sh  |    1 +
 modules.d/95nfs/nfs-start-rpc.sh |   17 +++++++++++++++++
 modules.d/95nfs/nfsroot          |   15 ---------------
 3 files changed, 18 insertions(+), 15 deletions(-)

Index: dracut/modules.d/95nfs/module-setup.sh
===================================================================
--- dracut.orig/modules.d/95nfs/module-setup.sh
+++ dracut/modules.d/95nfs/module-setup.sh
@@ -57,6 +57,7 @@ install() {
     dracut_install $(for _i in $(ls {/usr,}$libdir/libnss*.so 2>/dev/null); do echo $_i;done | egrep "$_nsslibs")
 
     inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"
+    inst_hook pre-udev 99 "$moddir/nfs-start-rpc.sh"
     inst_hook pre-pivot 99 "$moddir/nfsroot-cleanup.sh"
     inst "$moddir/nfsroot" "/sbin/nfsroot"
     mkdir -m 0755 -p "$initdir/var/lib/nfs/rpc_pipefs"
Index: dracut/modules.d/95nfs/nfs-start-rpc.sh
===================================================================
diff --git a/modules.d/95nfs/nfs-start-rpc.sh b/modules.d/95nfs/nfs-start-rpc.sh
new file mode 100755
--- /dev/null
+++ dracut/modules.d/95nfs/nfs-start-rpc.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+# Start rpcbind or rpcbind
+# FIXME occasionally saw 'rpcbind: fork failed: No such device' -- why?
+command -v portmap >/dev/null && [ -z "$(pidof portmap)" ] && portmap
+command -v rpcbind >/dev/null && [ -z "$(pidof rpcbind)" ] && rpcbind
+
+[ ! -d /var/lib/nfs/rpc_pipefs/nfs ] && \
+    mount -t rpc_pipefs rpc_pipefs /var/lib/nfs/rpc_pipefs
+
+# Start rpc.statd as mount won't let us use locks on a NFSv4
+# filesystem without talking to it. NFSv4 does locks internally,
+# rpc.lockd isn't needed
+[ -z "$(pidof rpc.statd)" ] && rpc.statd
+[ -z "$(pidof rpc.idmapd)" ] && rpc.idmapd
Index: dracut/modules.d/95nfs/nfsroot
===================================================================
--- dracut.orig/modules.d/95nfs/nfsroot
+++ dracut/modules.d/95nfs/nfsroot
@@ -84,22 +84,7 @@ getarg rw && nfsrw=rw
 
 options=${options:+$options,}$nfsrw
 
-# Start rpcbind or rpcbind
-# FIXME occasionally saw 'rpcbind: fork failed: No such device' -- why?
-command -v portmap >/dev/null && [ -z "$(pidof portmap)" ] && portmap
-command -v rpcbind >/dev/null && [ -z "$(pidof rpcbind)" ] && rpcbind
-
 if [ "$nfs" = "nfs4" ]; then
-    [ ! -d /var/lib/nfs/rpc_pipefs/nfs ] && \
-         mount -t rpc_pipefs rpc_pipefs /var/lib/nfs/rpc_pipefs
-
-    # Start rpc.statd as mount won't let us use locks on a NFSv4
-    # filesystem without talking to it. NFSv4 does locks internally,
-    # rpc.lockd isn't needed
-    [ -z "$(pidof rpc.statd)" ] && rpc.statd
-
-    [ -z "$(pidof rpc.idmapd)" ] && rpc.idmapd
-
     # XXX Should we loop here?
     mount -t nfs4 -o$options${nfslock+,$nfslock} \
         $server:$path $NEWROOT \
