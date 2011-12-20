From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/6] nfs: fix regex patterns in check()
Date: Tue, 20 Dec 2011 14:10:00 +0800
Message-ID: <1324361401-6908-6-git-send-email-amwang@redhat.com>
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

Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/95nfs/module-setup.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/95nfs/module-setup.sh b/modules.d/95nfs/module-setup.sh
index 641d917..6778f28 100755
--- a/modules.d/95nfs/module-setup.sh
+++ b/modules.d/95nfs/module-setup.sh
@@ -9,9 +9,9 @@ check() {
 
     [[ $hostonly ]] || [[ $mount_needs ]] && {
         for fs in ${host_fs_types[@]}; do
-            strstr "$fs" "|nfs"  && return 0
-            strstr "$fs" "|nfs3" && return 0
-            strstr "$fs" "|nfs4" && return 0
+            strstr "$fs" "\|nfs"  && return 0
+            strstr "$fs" "\|nfs3" && return 0
+            strstr "$fs" "\|nfs4" && return 0
         done
         return 255
     }
-- 
1.7.7.4
