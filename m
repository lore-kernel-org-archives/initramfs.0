From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] improve get_persistent_name function
Date: Fri, 28 Sep 2012 15:19:04 +0800
Message-ID: <20120928071904.GA10435@localhost.localdomain>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

For devices with filesystem, udev /dev/disk/by-uuid/* links are usually 
reliable. So improve the get_persistent_dev() by using by-uuid/* firstly,
and fallback to use by-id/*

An exception is multipath devices, child and top layer device may have
same uuid. As dm devices maintain /dev/mapper/* as persistent names, just
do not doing converting for them.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut-functions.sh |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- dracut.orig/dracut-functions.sh
+++ dracut/dracut-functions.sh
@@ -242,10 +242,13 @@ fi
 get_persistent_dev() {
     local i _tmp _dev
 
+    # /dev/mapper/* suppose to be persistent
+    [[ $1 =~ /dev/mapper ]] && echo $1 && return
+
     _dev=$(udevadm info --query=name --name="$1" 2>/dev/null)
     [ -z "$_dev" ] && return
 
-    for i in /dev/disk/by-id/*; do
+    for i in /dev/disk/by-uuid/* /dev/disk/by-id/*; do
         _tmp=$(udevadm info --query=name --name="$i" 2>/dev/null)
         if [ "$_tmp" = "$_dev" ]; then
             echo $i
