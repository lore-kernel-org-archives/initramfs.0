From: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] new_dhcp_next_server is really new_next_server
Date: Tue,  4 Feb 2014 09:11:24 -0800
Message-ID: <1391533884-6634-1-git-send-email-bcl@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The variable that dhclient sets doesn't have dhcp in the name. This
could cause problems with setups where the server is not the same as the
dhcp server.
---
 modules.d/95nfs/nfs-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/95nfs/nfs-lib.sh b/modules.d/95nfs/nfs-lib.sh
index f5fc56d..9ced2e6 100755
--- a/modules.d/95nfs/nfs-lib.sh
+++ b/modules.d/95nfs/nfs-lib.sh
@@ -97,7 +97,7 @@ nfsroot_from_dhcp() {
     [ -z "$path" ] && [ "$(getarg root=)" == "/dev/nfs" ] && path=/tftpboot/%s
     [ -z "$server" ] && server=$srv
     [ -z "$server" ] && server=$new_dhcp_server_identifier
-    [ -z "$server" ] && server=$new_dhcp_next_server
+    [ -z "$server" ] && server=$new_next_server
     [ -z "$server" ] && server=${new_root_path%%:*}
 }
 
-- 
1.8.4.2
