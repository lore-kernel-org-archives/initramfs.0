From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/4] 98usrmount: force mounting /usr read-only option (rd.usrmount.ro)
Date: Fri, 29 Jun 2012 13:58:18 +0200
Message-ID: <1340971101-1729-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut.cmdline.7.asc              |    5 +++++
 modules.d/98usrmount/mount-usr.sh |    9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 883223c..5669700 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -76,6 +76,11 @@ resume=UUID=3f5ad593-4546-4a94-a374-bcfb68aa11f7
 ----
 
 
+**rd.usrmount.ro**:
+    force mounting _/usr_ read-only.  Use this option if your init system
+    performs remount of _/usr_ the same as it does with rootfs.
+
+
 Misc
 ~~~~
 **rd.driver.blacklist=**_<drivername>[,<drivername>,...]_::
diff --git a/modules.d/98usrmount/mount-usr.sh b/modules.d/98usrmount/mount-usr.sh
index 92638d1..748ac01 100755
--- a/modules.d/98usrmount/mount-usr.sh
+++ b/modules.d/98usrmount/mount-usr.sh
@@ -68,8 +68,13 @@ mount_usr()
         _ret=$?
         echo $_ret >/run/initramfs/usr-fsck
         if [ $_ret -ne 255 ]; then
-            info "Mounting /usr"
-            mount "$NEWROOT/usr" 2>&1 | vinfo
+            if getargbool 0 rd.usrmount.ro; then
+                info "Mounting /usr (read-only forced)"
+                mount -r "$NEWROOT/usr" 2>&1 | vinfo
+            else
+                info "Mounting /usr"
+                mount "$NEWROOT/usr" 2>&1 | vinfo
+            fi
         fi
     fi
 }
-- 
1.7.8.6
