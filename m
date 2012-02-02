From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/7] source dracut-lib.sh in nfs cleanup script
Date: Thu, 2 Feb 2012 16:00:04 +0800
Message-ID: <20120202080004.GA12418@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

nfsroot-cleanup.sh need source dracut-lib.sh for function incol2

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95nfs/nfsroot-cleanup.sh |    2 ++
 1 file changed, 2 insertions(+)

Index: dracut/modules.d/95nfs/nfsroot-cleanup.sh
===================================================================
--- dracut.orig/modules.d/95nfs/nfsroot-cleanup.sh
+++ dracut/modules.d/95nfs/nfsroot-cleanup.sh
@@ -2,6 +2,8 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
+type incol2 >/dev/null 2>&1 || . /lib/dracut-lib.sh
+
 [ -f /tmp/nfs.rpc_pipefs_path ] && rpcpipefspath=`cat /tmp/nfs.rpc_pipefs_path`
 [ -z "$rpcpipefspath" ] && rpcpipefspath=var/lib/nfs/rpc_pipefs
 
