From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] use by-uuid firstly in get_persistent_dev
Date: Mon, 24 Sep 2012 10:16:26 +0800
Message-ID: <20120924021626.GA4603@dhcp-16-143.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

For devices with filesystem, udev /dev/disk/by-uuid/* links are always
reliable. So improve the get_persistent_dev() by using by-uuid/* firstly,
and fallback to use by-id/*

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
+    for i in /dev/disk/by-uuid/* /dev/disk/by-id/*; do
         _tmp=$(udevadm info --query=name --name="$i" 2>/dev/null)
         if [ "$_tmp" = "$_dev" ]; then
             echo $i
