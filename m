From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] nfsv3 nolock does not require any daemons
Date: Tue, 19 May 2009 17:43:13 -0400
Message-ID: <4A1327F1.3020008@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

 From dbac75e142dd502057002704300a4e708af923d4 Mon Sep 17 00:00:00 2001
From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Tue, 19 May 2009 17:37:40 -0400
Subject: [PATCH] nfsv3 nolock does not require any daemons

---
  modules.d/95NFS/nfs-mount-root.sh |    1 -
  1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/modules.d/95NFS/nfs-mount-root.sh b/modules.d/95NFS/nfs-mount-root.sh
index 8f1e44e..05f831f 100755
--- a/modules.d/95NFS/nfs-mount-root.sh
+++ b/modules.d/95NFS/nfs-mount-root.sh
@@ -23,6 +23,5 @@ if [ -n "$nfsroot" ]; then
      #
      # modprobe nfs
      #
-    # start rpc.statd ??
      mount -t nfs "$nfsroot" -o nolock "$NEWROOT" && ROOTFS_MOUNTED=yes
  fi
-- 
1.6.2.2


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
