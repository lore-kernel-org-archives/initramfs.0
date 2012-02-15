From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] wait_for_if_up fix
Date: Wed, 15 Feb 2012 14:40:27 +0800
Message-ID: <20120215064027.GA30110@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

wait_for_if_up will always return 0, fix it by change to use =~ to
check if link state is up

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 6b70adf..85d4925 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -385,7 +385,7 @@ wait_for_if_up() {
     local cnt=0
     while [ $cnt -lt 200 ]; do
         li=$(ip link show $1)
-        [ -z "${li##*state UP*}" ] && return 0
+        [[ "$li" =~ "state UP" ]] && return 0
         sleep 0.1
         cnt=$(($cnt+1))
     done
-- 
1.7.7.5
