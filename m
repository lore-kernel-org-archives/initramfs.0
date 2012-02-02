From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/7] add nobody group for rpc.idmapd
Date: Thu, 2 Feb 2012 15:59:59 +0800
Message-ID: <20120202075959.GA12416@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Add nobody group due to rpc.idmapd will fail to startup without nobody group

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95nfs/module-setup.sh |    1 +
 1 file changed, 1 insertion(+)

--- dracut.orig/modules.d/95nfs/module-setup.sh	2012-02-02 15:40:25.000000000 +0800
+++ dracut/modules.d/95nfs/module-setup.sh	2012-02-02 15:41:01.214407426 +0800
@@ -69,6 +69,7 @@ install() {
     egrep '^rpc:' /etc/passwd >> "$initdir/etc/passwd"
     egrep '^rpcuser:' /etc/passwd >> "$initdir/etc/passwd"
     #type -P nologin >/dev/null && dracut_install nologin
+    egrep '^nobody:' /etc/group >> "$initdir/etc/group"
     egrep '^rpc:' /etc/group >> "$initdir/etc/group"
 
     # rpc user needs to be able to write to this directory to save the warmstart
