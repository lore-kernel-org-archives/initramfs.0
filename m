From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] ifcfg: write DNS1=... for nameserver= args (RHBZ#815369)
Date: Tue, 24 Apr 2012 12:24:21 -0400
Message-ID: <1335284661-32102-1-git-send-email-wwoods@redhat.com>
References: <4F968443.8020403@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F968443.8020403-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
 modules.d/45ifcfg/write-ifcfg.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index c072a13..4b7bd3b 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -40,6 +40,11 @@ for netif in $IFACES ; do
         echo "UUID=$uuid"
         [ -n "$macaddr" ] && echo "MACADDR=$macaddr"
         [ -n "$mtu" ] && echo "MTU=$mtu"
+        i=1
+        for ns in $(getargs nameserver); do
+            echo DNS$i=$ns
+            i=$((i+1))
+        done
         if [ -f /tmp/net.$netif.lease ]; then
             strstr "$ip" '*:*:*' &&
             echo "DHCPV6C=yes"
-- 
1.7.7.6
