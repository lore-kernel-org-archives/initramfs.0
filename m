From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 5/6] mkinitrd-dracut.sh: Also allow -d to specify the root_fs and -s dummy
Date: Fri, 27 Sep 2013 20:18:59 +0200
Message-ID: <1380305940-64410-6-git-send-email-trenn@suse.de>
References: <1380305940-64410-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380305940-64410-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

-d is the SUSE mkinitrd version option to pass the rootfs.
-s is to enable splash which may not be needed, but some callers rely on it,
not to return an error.

Make this wrapper compatible to it.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 mkinitrd-dracut.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
index eeb6dda..f7b53f1 100755
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -124,7 +124,7 @@ while (($# > 0)); do
         --preload) read_arg modname "$@" || shift $?
             basicmodules="$basicmodules $modname";;
         --image-version) img_vers=yes;;
-        --rootfs) read_arg rootfs "$@" || shift $?
+        --rootfs|-d) read_arg rootfs "$@" || shift $?
             dracut_args="${dracut_args} --filesystems $rootfs";;
         --nocompress) dracut_args="$dracut_args --no-compress";;
         --help) usage -n;;
@@ -151,6 +151,7 @@ while (($# > 0)); do
         --looppath*) ;;
         --dsdt*) ;;
         --bootchart) ;;
+	-s) ;;
 	--quiet|-q) quiet=1;;
 	-b) read_arg boot_dir "$@" || shift $?
 	    if [ ! -d $boot_dir ];then
-- 
1.7.6.1
