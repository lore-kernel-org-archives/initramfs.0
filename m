From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] check install files passed by cmdline
Date: Tue, 15 May 2012 14:19:57 +0800
Message-ID: <1337062797-28629-2-git-send-email-amwang@redhat.com>
References: <1337062797-28629-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337062797-28629-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

We should not trust cmdline passed by users, always
check the install files passed from cmdline. This restores
the old behaviour which was changed by:

	commit c6c6a08850c7e4ee211696895f7ca3864be85052
	Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
	Date:   Tue Feb 7 18:26:30 2012 +0100

	    add "install_items" to dracut.conf

Reported-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 dracut.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 315b965..bf9e79f 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -770,7 +770,7 @@ done
 
 if [[ $kernel_only != yes ]]; then
     for item in $install_items; do
-        dracut_install -o "$item"
+        dracut_install "$item"
     done
     unset item
 
-- 
1.7.7.6
