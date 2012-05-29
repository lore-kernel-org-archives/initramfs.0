From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [BUGFIX Patch] fix a wrong usage of vinfo in init.sh
Date: Tue, 29 May 2012 16:06:54 +0800
Message-ID: <1338278814-8603-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

vinfo() reads input from stdin, not from arguments.

This is a regression introduced by:

	commit 982d59afea5eac202c8a47f09d06d240af753a24
	Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
	Date:   Tue May 22 14:52:36 2012 +0200

	    drop 10rpmversion module and introduce /etc/initrd-release


Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index b8736ec..1146a86 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -90,7 +90,7 @@ else
 fi
 
 [ -f /etc/initrd-release ] && . /etc/initrd-release
-[ -n "$VERSION" ] && vinfo "dracut-$VERSION"
+[ -n "$VERSION" ] && echo "dracut-$VERSION" | vinfo
 
 source_conf /etc/conf.d
 
