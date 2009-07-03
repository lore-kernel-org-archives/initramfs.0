From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 08/10] put back the nfs mount in the udev event
Date: Fri,  3 Jul 2009 18:45:18 +0200
Message-ID: <1246639520-3094-9-git-send-email-harald@redhat.com>
References: <1246639520-3094-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246639520-3094-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

it solves the following case:

root=/dev/nfs nfsroot=server:/path

- the server could be reachable on any interface
- any interface can get an IP by dhcp
- only one IP is allowed to mount the root
---
 modules.d/95nfs/nfsroot |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
index 5f5b08f..0add977 100755
--- a/modules.d/95nfs/nfsroot
+++ b/modules.d/95nfs/nfsroot
@@ -142,9 +142,9 @@ if [ "$nfs" = "nfs4" ]; then
     [ -z "$(pidof rpc.idmapd)" ] && rpc.idmapd
 
     # XXX Should we loop here?
-    echo mount -t nfs4 -o$options${nfslock+,$nfslock} \
-	$server:$path $NEWROOT > /mount/01-$$-nfs4.sh
-    [ -e /dev/root ] || >/dev/root
+    mount -t nfs4 -o$options${nfslock+,$nfslock} \
+	$server:$path $NEWROOT \
+	&& { [ -e /dev/root ] || >/dev/root ; }
 else
     # NFSv{2,3} doesn't support using locks as it requires a helper to transfer
     # the rpcbind state to the new root
@@ -152,7 +152,6 @@ else
         warn "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
 
     # XXX Should we loop here?
-    echo mount -t nfs -o$options${options:+,}nolock $server:$path $NEWROOT \
-        > /mount/01-$$-nfs.sh
-    [ -e /dev/root ] || >/dev/root
+    mount -t nfs -o$options${options:+,}nolock $server:$path $NEWROOT \
+	&& { [ -e /dev/root ] || >/dev/root ; }
 fi
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
