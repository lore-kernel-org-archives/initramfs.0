From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] dracut.sh: Fix variable name typo.
Date: Wed,  5 Feb 2014 10:06:51 +0000
Message-ID: <1391594811-14489-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

This caused the root_dev variable not to be set which in turn meant that
the root device was not whitelisted in 99base/module-setup.sh when injecting
compile-time devexists hooks in hostonly initrds. This ties the generated
initrd to the root fs device (typically the UUID) rather than relying solely
only the root= kernel command line.

While it is hostonly, not hardcoding e.g. UUIDs is still desirable. Any
swap partition on the host device is still added however.
---
 dracut.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut.sh b/dracut.sh
index ccff358..5267af5 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1005,7 +1005,7 @@ if [[ $hostonly ]]; then
         _bdev=$(readlink -f "/dev/block/$_dev")
         [[ -b $_bdev ]] && _dev=$_bdev
         push host_devs $_dev
-        [[ "$_mp" == "/" ]] && root_dev="$_dev"
+        [[ "$mp" == "/" ]] && root_dev="$_dev"
         push host_devs "$_dev"
     done
 
-- 
1.8.4.5
