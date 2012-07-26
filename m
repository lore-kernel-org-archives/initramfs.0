From: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] 90multipath: check() - Regexp fix to match multipath partition.
Date: Thu, 26 Jul 2012 11:24:26 +0800
Message-ID: <1343273066-3493-2-git-send-email-chaowang@redhat.com>
References: <1343273066-3493-1-git-send-email-chaowang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343273066-3493-1-git-send-email-chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wangchao19890207-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

A multipath partition's uuid will be presented like:
 # cat /sys/dev/block/$_dev/dm/uuid
 part1-mpath-360060e801047103004f2c4b300000008

So in this case, change the match regexp from '^mpath-' to 'mpath-'.

Signed-off-by: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90multipath/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90multipath/module-setup.sh b/modules.d/90multipath/module-setup.sh
index 5944d25..6c96441 100755
--- a/modules.d/90multipath/module-setup.sh
+++ b/modules.d/90multipath/module-setup.sh
@@ -11,7 +11,7 @@ check() {
         local _dev
         _dev=$(get_maj_min $1)
         [ -e /sys/dev/block/$_dev/dm/uuid ] || return 1
-        [[ $(cat /sys/dev/block/$_dev/dm/uuid) =~ ^mpath- ]] && return 0
+        [[ $(cat /sys/dev/block/$_dev/dm/uuid) =~ mpath- ]] && return 0
         return 1
     }
 
-- 
1.7.11.2
