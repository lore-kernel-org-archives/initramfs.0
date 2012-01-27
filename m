From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Patch] invoke kill-dhclient.sh and kernel-cleanup.sh later
Date: Fri, 27 Jan 2012 22:54:03 +0800
Message-ID: <1327676043-18431-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=BSGWaZQiO61gozwzWoLX67RHg20OxkA3QXI8lR15m5U=;
        b=wwQsz4Ip2cDuYk8QaUWQ0Kq2H6bWIY2zhtwUwZYvWGo/Zyl0L99sipQlV/s3X9Mz7e
         G7NQHoJl/ItHWliCi2ipxUkmtmWEDykQnaV/KktdJwADGzgVRf23UtyYeMEtvgTf2MUn
         LmOCgfx9BZYmxMeP2THMbERfKD6fhzlqwtDbY=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

In kdump module, we install our kdump hook in pre-pivot,
for kdump over network, we also need network modules, e.g. nfs module,
so kernel modules can't be cleaned before that. Invoke these two cleanup
scripts as late as possible.

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index ef7818a..fa61994 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -84,7 +84,7 @@ install() {
     inst_hook cmdline 97 "$moddir/parse-bridge.sh"
     inst_hook cmdline 98 "$moddir/parse-ip-opts.sh"
     inst_hook cmdline 99 "$moddir/parse-ifname.sh"
-    inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
+    inst_hook pre-pivot 97 "$moddir/kill-dhclient.sh"
 
     _arch=$(uname -m)
 
diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 88f0e2d..e81476c 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -75,7 +75,7 @@ install() {
         inst_simple "$i"
     done
     inst_hook cmdline 01 "$moddir/parse-kernel.sh"
-    inst_hook pre-pivot 20 "$moddir/kernel-cleanup.sh"
+    inst_hook pre-pivot 98 "$moddir/kernel-cleanup.sh"
     inst_simple "$moddir/insmodpost.sh" /sbin/insmodpost.sh
 
     for _f in modules.builtin.bin modules.builtin; do
