From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] ifcfg: write DNS1=... for nameserver= args (RHBZ#815369)
Date: Mon, 23 Apr 2012 16:25:25 -0400
Message-ID: <1335212725-20178-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If you're using a static network config, you'll want to keep your
nameservers around when NM starts. Write DNS1 (and DNS2, DNS3, etc..)
into the ifcfg file.

Thanks to Mark Hamzy <hamzy-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org> for the patch.
---
 modules.d/45ifcfg/write-ifcfg.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index c072a13..3e1d89b 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -53,6 +53,14 @@ for netif in $IFACES ; do
             echo "NETMASK=$mask"
             [ -n "$gw" ] && echo "GATEWAY=$gw"
         fi
+        namesrv=$(getargs nameserver)
+        if [ -n "$namesrv" ]; then
+            i=1
+            for n in $namesrv; do
+                echo DNS$i=$n
+                i=$(($i+1))
+            done
+        fi
     } > /tmp/ifcfg/ifcfg-$netif
 
     # bridge needs different things written to ifcfg
-- 
1.7.7.6
