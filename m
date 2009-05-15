From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 06/11] change file descriptor for flock locking
Date: Fri, 15 May 2009 14:39:39 +0200
Message-ID: <4A0D628B.5030801@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050309040908090500000303"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------050309040908090500000303
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


dash does not like filedescriptors > 9
---
  modules.d/90crypt/cryptroot-ask.sh |    6 +++---
  modules.d/99base/init              |    5 +----
  2 files changed, 4 insertions(+), 7 deletions(-)



--------------050309040908090500000303
Content-Type: text/x-patch;
 name="b6e0fea80c4aef66421af74dc1d29154cdae0264.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="b6e0fea80c4aef66421af74dc1d29154cdae0264.diff"

diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 499f586..48cc0f7 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 
 [ -b /dev/mapper/$2 ] && exit 0
-(
-	flock -s 200
+{
+	flock -s 9
 	/sbin/cryptsetup luksOpen -T1 $1 $2 </dev/console >/dev/console 2>&1
-) 200>/.console.lock
+} 9>/.console.lock
 
diff --git a/modules.d/99base/init b/modules.d/99base/init
index fbfad05..ce26de6 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -79,10 +79,7 @@ while :; do
 
     sleep 0.5
     i=$(($i+1))
-    (
-    	flock -s 200
-	[ $i -gt 20 ] && emergency_shell
-    ) 200>/.console_lock
+    { flock -s 9 ; [ $i -gt 20 ] && emergency_shell; } 9>/.console_lock
 done
 
 # pre pivot scripts are sourced just before we switch over to the new root.


--------------050309040908090500000303--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
