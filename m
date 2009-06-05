From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [3/3] nfs: cleanup currently needs grep
Date: Fri, 05 Jun 2009 00:35:09 -0400
Message-ID: <1244176509.29842.5.camel@obelisk.thedillows.org>
References: <1244176354.29842.1.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244176354.29842.1.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

diff --git a/modules.d/95nfs/install b/modules.d/95nfs/install
index 5a96772..218c64f 100755
--- a/modules.d/95nfs/install
+++ b/modules.d/95nfs/install
@@ -2,6 +2,7 @@
 dracut_install rpcbind rpc.statd mount.nfs mount.nfs4 umount 
 dracut_install /etc/netconfig /etc/passwd /etc/services
 dracut_install rpc.idmapd /etc/idmapd.conf
+dracut_install grep
 
 instmods nfs sunrpc
 inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
