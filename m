From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] split out nfs rpc process startup
Date: Mon, 30 Jan 2012 14:43:50 +0800
Message-ID: <20120130064350.GA7114@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

fstab-sys will mount nonroot nfs as well, so we need to split the necessary
code from netroot for fstab-sys use.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95nfs/module-setup.sh |    1 +
 modules.d/95nfs/nfs-start-rpc   |   22 ++++++++++++++++++++++
 modules.d/95nfs/nfsroot         |   16 ++--------------
 3 files changed, 25 insertions(+), 14 deletions(-)

Index: dracut/modules.d/95nfs/module-setup.sh
===================================================================
--- dracut.orig/modules.d/95nfs/module-setup.sh
+++ dracut/modules.d/95nfs/module-setup.sh
@@ -59,6 +59,7 @@ install() {
     inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"
     inst_hook pre-pivot 99 "$moddir/nfsroot-cleanup.sh"
     inst "$moddir/nfsroot" "/sbin/nfsroot"
+    inst "$moddir/nfs-start-rpc" "/sbin/nfs-start-rpc"
     mkdir -m 0755 -p "$initdir/var/lib/nfs/rpc_pipefs"
     mkdir -m 0755 -p "$initdir/var/lib/rpcbind"
     mkdir -m 0755 -p "$initdir/var/lib/nfs/statd/sm"
Index: dracut/modules.d/95nfs/nfs-start-rpc
===================================================================
--- /dev/null
+++ dracut/modules.d/95nfs/nfs-start-rpc
@@ -0,0 +1,22 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+nfsstart() {
+    # Start rpcbind or rpcbind
+    # FIXME occasionally saw 'rpcbind: fork failed: No such device' -- why?
+    command -v portmap >/dev/null && [ -z "$(pidof portmap)" ] && portmap
+    command -v rpcbind >/dev/null && [ -z "$(pidof rpcbind)" ] && rpcbind
+
+    if [ "$1" = "nfs4" ]; then
+        [ ! -d /var/lib/nfs/rpc_pipefs/nfs ] && \
+             mount -t rpc_pipefs rpc_pipefs /var/lib/nfs/rpc_pipefs
+
+        # Start rpc.statd as mount won't let us use locks on a NFSv4
+        # filesystem without talking to it. NFSv4 does locks internally,
+        # rpc.lockd isn't needed
+        [ -z "$(pidof rpc.statd)" ] && rpc.statd
+
+        [ -z "$(pidof rpc.idmapd)" ] && rpc.idmapd
+    fi
+}
Index: dracut/modules.d/95nfs/nfsroot
===================================================================
--- dracut.orig/modules.d/95nfs/nfsroot
+++ dracut/modules.d/95nfs/nfsroot
@@ -84,22 +84,10 @@ getarg rw && nfsrw=rw
 
 options=${options:+$options,}$nfsrw
 
-# Start rpcbind or rpcbind
-# FIXME occasionally saw 'rpcbind: fork failed: No such device' -- why?
-command -v portmap >/dev/null && [ -z "$(pidof portmap)" ] && portmap
-command -v rpcbind >/dev/null && [ -z "$(pidof rpcbind)" ] && rpcbind
+. /sbin/nfs-start-rpc
+nfsstart $nfs
 
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
