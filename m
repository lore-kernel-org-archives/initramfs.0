From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Patch] btrfs: fix two bugs in module-setup.sh
Date: Mon, 30 Jan 2012 17:58:55 +0800
Message-ID: <1327917535-31293-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ABKusXcNBufEuZLn+NgbX+WmWJLu+9byV4f3qO/nKlI=;
        b=W/4PxC2ZApYC+KjpxxSJZfXYeTrxVGL8bLct0VARctHxHCFHfGxK6kngIlfix8XtW0
         w9/DVgTsW43zHY5ImHDD27DnNbS7J6whO1+LkxVdnusIqLOmk7T+lL/hHDEydUXN+MCh
         LCfEd65k6J/N8TmL4SdJyYtaHfqLs/E7zthSc=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

First, $host_fs_types is an array.
Second, use strstr to match btrfs type.

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
diff --git a/modules.d/90btrfs/module-setup.sh b/modules.d/90btrfs/module-setup.sh
index a141dda..135abc6 100755
--- a/modules.d/90btrfs/module-setup.sh
+++ b/modules.d/90btrfs/module-setup.sh
@@ -13,8 +13,8 @@ check() {
 
     [[ $hostonly ]] || [[ $mount_needs ]] && {
         local _found
-        for fs in $host_fs_types; do
-            [[ "$fs" = "|btrfs" ]] && _found="1"
+        for fs in ${host_fs_types[@]}; do
+            strstr "$fs" "\|btrfs" && _found="1"
         done
         [[ $_found ]] || return 1
         unset _found
