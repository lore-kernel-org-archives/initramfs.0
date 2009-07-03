From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 02/10] output everything to /dev/kmesg and add dmesg for the emergency_shell
Date: Fri,  3 Jul 2009 18:45:12 +0200
Message-ID: <1246639520-3094-3-git-send-email-harald@redhat.com>
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

---
 modules.d/99base/init    |    9 ++++++++-
 modules.d/99base/install |    2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 701706d..b49ba21 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -7,6 +7,8 @@
 
 emergency_shell()
 {
+    exec >/dev/console 2>&1 </dev/console
+    getarg rdinitdebug || dmesg
     source_all emergency
     echo ; echo
     echo "Bug in initramfs /init detected. Dropping to a shell. Good luck!"
@@ -64,7 +66,12 @@ if [ ! -c /dev/ptmx ]; then
     fi
 fi
 
-getarg rdinitdebug && set -x
+if getarg rdinitdebug; then
+    set -x
+else
+    exec >/dev/kmsg 2>&1
+fi
+
 mkdir /dev/shm
 mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts >/dev/null 2>&1
diff --git a/modules.d/99base/install b/modules.d/99base/install
index ff15200..4ecba9c 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -1,5 +1,5 @@
 #!/bin/bash
-dracut_install mount mknod mkdir modprobe pidof sleep chroot sed ls flock cp mv
+dracut_install mount mknod mkdir modprobe pidof sleep chroot sed ls flock cp mv dmesg 
 if [ ! -e "${initdir}/bin/sh" ]; then
     dracut_install bash
     (ln -s bash "${initdir}/bin/sh" || :)
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
