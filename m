From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/6] Fix get_maj_min() to follow symlink
Date: Tue, 20 Dec 2011 14:09:58 +0800
Message-ID: <1324361401-6908-4-git-send-email-amwang@redhat.com>
References: <1324361401-6908-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1324361401-6908-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Otherwise get_maj_min /dev/mapper/vg_cr0-lv_home will return 0:0.

Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 dracut-functions |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 54b1c30..618e884 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -180,7 +180,7 @@ get_fs_uuid() (
 
 get_maj_min() {
     local _dev
-    _dev=$(stat -c '$((0x%T)):$((0x%t))' "$1" 2>/dev/null)
+    _dev=$(stat -L -c '$((0x%T)):$((0x%t))' "$1" 2>/dev/null)
     _dev=$(eval "echo $_dev")
     echo $_dev
 }
-- 
1.7.7.4
