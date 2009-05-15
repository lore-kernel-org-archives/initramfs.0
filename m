From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 01/11] do not run dhclient, if no net device found
Date: Fri, 15 May 2009 14:38:58 +0200
Message-ID: <4A0D6262.5070008@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000501040706020501090204"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "init >> \"initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org\"" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------000501040706020501090204
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

---
  modules.d/40network/run-dhclient.sh |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)



--------------000501040706020501090204
Content-Type: text/x-patch;
 name="e7b6ed13796581f4881c2a42c198d314375d4f9c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="e7b6ed13796581f4881c2a42c198d314375d4f9c.diff"

diff --git a/modules.d/40network/run-dhclient.sh b/modules.d/40network/run-dhclient.sh
index afab037..a98e01d 100755
--- a/modules.d/40network/run-dhclient.sh
+++ b/modules.d/40network/run-dhclient.sh
@@ -1,8 +1,9 @@
 #!/bin/sh
 for i in /net.*.dhcp; do
+    [ "$dev" = "/net.*.dhcp" ] && break
     dev=${i#net.}; dev=${i%.dhcp}
     [ -f "/net.$dev.up" ] && continue
     dhclient -1 -q $dev &
 done
 wait
-    
\ No newline at end of file
+    


--------------000501040706020501090204--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
