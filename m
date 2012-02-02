From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/7] fix fstab-sys module check
Date: Thu, 2 Feb 2012 15:59:56 +0800
Message-ID: <20120202075956.GA12414@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

If /etc/fstab.sys does not exist installing fstab-sys module will fail.
Fix this by checking use_fstab and fstab_lines as well

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut                                |    2 +-
 modules.d/95fstab-sys/module-setup.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: dracut/dracut
===================================================================
--- dracut.orig/dracut
+++ dracut/dracut
@@ -598,7 +598,7 @@ done
 export initdir dracutbasedir dracutmodules drivers \
     fw_dir drivers_dir debug no_kernel kernel_only \
     add_drivers mdadmconf lvmconf filesystems \
-    use_fstab libdir usrlibdir fscks nofscks cttyhack \
+    use_fstab fstab_lines libdir usrlibdir fscks nofscks cttyhack \
     stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
     debug host_fs_types host_devs sshkey
 
Index: dracut/modules.d/95fstab-sys/module-setup.sh
===================================================================
--- dracut.orig/modules.d/95fstab-sys/module-setup.sh
+++ dracut/modules.d/95fstab-sys/module-setup.sh
@@ -3,7 +3,7 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 check() {
-    test -f /etc/fstab.sys
+    test -f /etc/fstab.sys || [[ -n $use_fstab  ||  -n $fstab_lines ]]
 }
 
 depends() {
