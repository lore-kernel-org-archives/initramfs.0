From: Lidong Zhong <lzhong-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH] dracut-lib.sh: typo fix
Date: Mon, 15 Jun 2015 16:56:19 +0800
Message-ID: <1434358579-11674-1-git-send-email-lzhong@suse.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Signed-off-by: Lidong Zhong <lzhong-IBi9RG/b67k@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 6498f9d..08110cc 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -313,7 +313,7 @@ getargs() {
     _args="$@"
     set --
     for _i in $_args; do
-        if [ "$i" = "-d" ]; then
+        if [ "$_i" = "-d" ]; then
             _deprecated=1
             continue
         fi
-- 
1.8.1.4
