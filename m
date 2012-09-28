From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3] improve get_persistent_name function
Date: Fri, 28 Sep 2012 17:39:35 +0800
Message-ID: <20120928093935.GA14345@localhost.localdomain>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

For devices with filesystem, udev /dev/disk/by-uuid/* links are usually 
reliable. But one exception is multipath devices, child and top layer
device may have same uuid.

As dm devices maintain /dev/mapper/* as persistent names, so converting to
/dev/mapper/* firstly then try by-uuid/* and by-id/*

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut-functions.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- dracut.orig/dracut-functions.sh
+++ dracut/dracut-functions.sh
@@ -245,7 +245,7 @@ get_persistent_dev() {
     _dev=$(udevadm info --query=name --name="$1" 2>/dev/null)
     [ -z "$_dev" ] && return
 
-    for i in /dev/disk/by-id/*; do
+    for i in /dev/mapper/* /dev/disk/by-uuid/* /dev/disk/by-id/*; do
         _tmp=$(udevadm info --query=name --name="$i" 2>/dev/null)
         if [ "$_tmp" = "$_dev" ]; then
             echo $i
