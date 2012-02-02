From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/7] do not check dev node exist for fstab-sys mounting
Date: Thu, 2 Feb 2012 16:00:11 +0800
Message-ID: <20120202080011.GA12422@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

in case nfs mounting do not check if $_dev exist

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95fstab-sys/mount-sys.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: dracut/modules.d/95fstab-sys/mount-sys.sh
===================================================================
--- dracut.orig/modules.d/95fstab-sys/mount-sys.sh
+++ dracut/modules.d/95fstab-sys/mount-sys.sh
@@ -11,7 +11,7 @@ fstab_mount() {
     info "Mounting from $1"
     while read _dev _mp _fs _opts _dump _pass _rest; do
         [ -z "${_dev%%#*}" ] && continue # Skip comment lines
-        if [ ! -e "$_dev" ]; then
+        if [[ ! "$_fs" =~ "nfs" ]] && [ ! -e "$_dev" ]; then
             warn "Device $_dev doesn't exist, skipping mount."
             continue
         fi
