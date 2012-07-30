From: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut-functions: $_x should exist, no need to test.
Date: Mon, 30 Jul 2012 11:56:29 +0800
Message-ID: <1343620589-10139-1-git-send-email-chaowang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wangchao19890207-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Signed-off-by: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut-functions.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 9242204..04b4c7a 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -423,7 +423,6 @@ check_block_and_slaves() {
     fi
     [[ -d /sys/dev/block/$2/slaves ]] || return 1
     for _x in /sys/dev/block/$2/slaves/*/dev; do
-        [[ -f $_x ]] || continue
         check_block_and_slaves $1 $(cat "$_x") && return 0
     done
     return 1
-- 
1.7.11.3
