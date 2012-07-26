From: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] 95fstab-sys: Skip mounted filesystem.
Date: Thu, 26 Jul 2012 11:24:25 +0800
Message-ID: <1343273066-3493-1-git-send-email-chaowang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wangchao19890207-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Signed-off-by: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95fstab-sys/mount-sys.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/95fstab-sys/mount-sys.sh b/modules.d/95fstab-sys/mount-sys.sh
index a1e5ab1..12711a0 100755
--- a/modules.d/95fstab-sys/mount-sys.sh
+++ b/modules.d/95fstab-sys/mount-sys.sh
@@ -11,6 +11,7 @@ fstab_mount() {
     info "Mounting from $1"
     while read _dev _mp _fs _opts _dump _pass _rest; do
         [ -z "${_dev%%#*}" ] && continue # Skip comment lines
+        ismounted $_mp && continue # Skip mounted filesystem
         if [ "$_pass" -gt 0 ] && ! strstr "$_opts" _netdev; then
             fsck_single "$_dev" "$_fs" "$_opts"
         fi
-- 
1.7.11.2
