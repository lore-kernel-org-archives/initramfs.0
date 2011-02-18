From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Ensure rpc_pipefs is mounted
Date: Fri, 18 Feb 2011 12:24:06 +0100
Message-ID: <AANLkTin+uKkaGgepYEU9qiWJ_03DLV1JsXSHqkHKGWXK@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=oZdZE6GoKptU6wfx4o6Jp8He5k0Msk50uUzOTfwsZqc=;
        b=etj7FTxCOsMbubUU1clH+vkov+kk3Uy+FfDtCyBGBrtAaJvotxm0UqHuZ8x/6u6eJS
         t0VwDt8ile9v6f6nkbOd1dwoL2CYzmnaZMMp2ZMPCJkXuu3pJ9/QoiWhylzvwB/+Tvg+
         0iPr2hvicHAb6N//QOqLPf++86oDNT96Mv+jo=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

While on some systems (like Fedora) rpc_pipefs is mounted
automatically when sunrpc module is loaded, on Debian based systems it
needs to be mounted manually.

--- dracut-008.orig/modules.d/95nfs/nfsroot     2011-02-17
12:40:03.247151995 +0100
+++ dracut-008/modules.d/95nfs/nfsroot  2011-02-17 12:39:59.497151996 +0100
@@ -90,6 +90,9 @@
 [ -x /sbin/rpcbind ] && [ -z "$(pidof rpcbind)" ] && rpcbind

 if [ "$nfs" = "nfs4" ]; then
+    [ ! -d /var/lib/nfs/rpc_pipefs/nfs ] && \
+         mount -t rpc_pipefs rpc_pipefs /var/lib/nfs/rpc_pipefs
+
     # Start rpc.statd as mount won't let us use locks on a NFSv4
     # filesystem without talking to it. NFSv4 does locks internally,
     # rpc.lockd isn't needed
