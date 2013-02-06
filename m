From: Florian Feldhaus <florian.feldhaus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] update documentation with information on the libdirs parameter
Date: Wed, 6 Feb 2013 16:28:54 +0000 (UTC)
Message-ID: <loom.20130206T172434-197@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

As promised in the thread "Dracut fails to install libraries on Debian / Ubuntu 
systems", here is a patch to update the documentation with information on the 
libdirs parameter.

[PATCH]
diff --git a/dracut.8.asc b/dracut.8.asc
index da7f327..d4e67bf 100644
--- a/dracut.8.asc
+++ b/dracut.8.asc
@@ -215,10 +215,13 @@ example:
     specify additional directories, where to look for firmwares. This parameter
     can be specified multiple times.
 
+**--libdirs** _<dir>[:<dir>...]++_::
+    specify additional directories, where to look for libraries. This
+    parameter can be specified multiple times.
+
 **--kernel-cmdline <parameters>**::
     specify default kernel command line parameters
 
-
 **--kernel-only**::
     only install kernel drivers and firmware files
 
diff --git a/dracut.conf.5.asc b/dracut.conf.5.asc
index e545451..53df706 100644
--- a/dracut.conf.5.asc
+++ b/dracut.conf.5.asc
@@ -58,6 +58,9 @@ line are not interpreted.
 *fw_dir+=*" :__<dir>__[:__<dir>__ ...] "::
     Specify additional directories, where to look for firmwares, separated by :
 
+*libdirs+=*" :__<dir>__[:__<dir>__ ...] "::
+    Specify additional directories, where to look for libraries, separated by :
+
 *install_items+=*" __<file>__[ __<file>__ ...] "::
     Specify additional files to include in the initramfs, separated by spaces.
 
diff --git a/dracut.sh b/dracut.sh
index cfd10a1..9d04dc6 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -87,6 +87,8 @@ Creates initial ramdisk images for preloading modules
                         modules
   --fwdir [DIR]         Specify additional directories, where to look for
                         firmwares, separated by :
+  --libdirs [DIR]       Specify additional directories, where to look for
+                        libraries, separated by :
   --kernel-only         Only install kernel drivers and firmware files
   --no-kernel           Do not install kernel drivers and firmware files
   --kernel-cmdline [PARAMETERS] Specify default kernel command line parameters
[END]
