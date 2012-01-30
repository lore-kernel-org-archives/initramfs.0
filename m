From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] deal with nfs in fstab-sys
Date: Mon, 30 Jan 2012 14:44:51 +0800
Message-ID: <20120130064451.GA7125@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If we need to mount nonroot nfs in fstab we also need to launch rpc processes
Add nfs-start-rpc code, also do not check and fsck $_dev in this case

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95fstab-sys/mount-sys.sh |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: dracut/modules.d/95fstab-sys/mount-sys.sh
===================================================================
--- dracut.orig/modules.d/95fstab-sys/mount-sys.sh
+++ dracut/modules.d/95fstab-sys/mount-sys.sh
@@ -11,12 +11,17 @@ fstab_mount() {
     info "Mounting from $1"
     while read _dev _mp _fs _opts _dump _pass _rest; do
         [ -z "${_dev%%#*}" ] && continue # Skip comment lines
-        if [ ! -e "$_dev" ]; then
-            warn "Device $_dev doesn't exist, skipping mount."
-            continue
-        fi
-        if [ "$_pass" -gt 0 ] && ! strstr "$_opts" _netdev; then
-            fsck_single "$_dev" "$_fs"
+        if [[ ! "$_fs" =~ "nfs" ]]; then
+            if [ ! -e "$_dev" ]; then
+                warn "Device $_dev doesn't exist, skipping mount."
+                continue
+            fi
+            if [ "$_pass" -gt 0 ] && ! strstr "$_opts" _netdev; then
+                fsck_single "$_dev" "$_fs"
+            fi
+        else
+            . /sbin/nfs-start-rpc
+            nfsstart $_fs
         fi
         _fs=$(det_fs "$_dev" "$_fs")
         info "Mounting $_dev"
