From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] _emergency_shell: Show current working directory correctly in shell.
Date: Fri, 26 Apr 2013 15:16:19 +0800
Message-ID: <1366960579-17809-1-git-send-email-chaowang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

When dropped to emergency shell, for example, use rd.break=pre-pivot,
the PS1 won't correctly show current directory we're in:

pre-pivot:/# cd /sysroot/
pre-pivot:/#
(still shows "/")

Let's take a look at PS1 variable:

(I'm adding prefix/suffix 'x' to make it clear):
pre-pivot:/# echo x${PS1}x
xpre-pivot:/# x
(PS1 isn't dynamic)

Regarding the current dracut code, it should be:

pre-pivot:/# cd /sysroot/etc
pre-pivot:/sysroot/etc#

With this patch:

pre-pivot:/# echo x${PS1}x
xpre-pivot:${PWD}# x
(Now PS1 is dynamic, it will show the directory correctly)

I tested for both normal boot and kdump boot.

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index ae79a82..9f4bcc7 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -926,7 +926,7 @@ _emergency_shell()
     local _name="$1"
     if [ -n "$DRACUT_SYSTEMD" ]; then
         > /.console_lock
-        echo "PS1=\"$_name:\${PWD}# \"" >/etc/profile
+        echo "PS1=\"$_name:\\\${PWD}# \"" >/etc/profile
         systemctl start dracut-emergency.service
         rm -f /etc/profile
         rm -f /.console_lock
-- 
1.8.2.1
