From: Mei Liu <liumbj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [dracut PATCH] Add awk and getopt as dependencies of znetconf
Date: Tue, 10 Nov 2015 12:34:24 +0800
Message-ID: <1447130064-8391-1-git-send-email-liumbj@linux.vnet.ibm.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mei Liu <liumbj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

znetconf command is part of s390utils-base package. It depends on
awk and getopt.

This patch is used to fix the following error:

dracut:/#
znetconf -c

/usr/sbin/znetconf: line 70: awk: command not found
/usr/sbin/znetconf: line 1138: getopt: command not found

Signed-off-by: Mei Liu <liumbj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 modules.d/80cms/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/80cms/module-setup.sh b/modules.d/80cms/module-setup.sh
index c99f236..daa64d1 100755
--- a/modules.d/80cms/module-setup.sh
+++ b/modules.d/80cms/module-setup.sh
@@ -25,7 +25,7 @@ install() {
     inst_script "$moddir/cmsifup.sh" /sbin/cmsifup
     inst_multiple /etc/cmsfs-fuse/filetypes.conf /etc/udev/rules.d/99-fuse.rules /etc/fuse.conf \
         cmsfs-fuse fusermount ulockmgr_server bash insmod rmmod cat normalize_dasd_arg sed \
-        $(rpm -ql s390utils-base)
+        $(rpm -ql s390utils-base) awk getopt
 
     inst_libdir_file "gconv/*"
     #inst /usr/lib/locale/locale-archive
-- 
1.9.3
