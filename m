From: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Revert "dracut-functions: $_x should exist, no need to test."
Date: Wed,  1 Aug 2012 11:23:42 +0800
Message-ID: <1343791422-8391-1-git-send-email-chaowang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wangchao19890207-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

This reverts commit b2d225a6698607bbcb73b6e6d12fbfc5be014102.

When there's no /sys/dev/block/$2/slaves/*/dev/ exists, $_x will
be assigned with '/sys/dev/block/$2/slaves/*/dev/', this is invalid.
That commit will lead to some warn msg like:
cat: /sys/dev/block/8:16/slaves/*/dev: No such file or directory
cat: /sys/dev/block/8:32/slaves/*/dev: No such file or directory
---
 dracut-functions.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index a299bbb..2ad8f4a 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -423,6 +423,7 @@ check_block_and_slaves() {
     fi
     [[ -d /sys/dev/block/$2/slaves ]] || return 1
     for _x in /sys/dev/block/$2/slaves/*/dev; do
+        [[ -f $_x ]] || continue
         check_block_and_slaves $1 $(cat "$_x") && return 0
     done
     return 1
-- 
1.7.11.3
