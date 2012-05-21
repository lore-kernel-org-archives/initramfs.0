From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] add option --printsize
Date: Mon, 21 May 2012 16:37:06 +0800
Message-ID: <20120521083706.GA3040@localhost.localdomain>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Add --printsize for measuring module installed size to initramfs

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.sh |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- dracut.orig/dracut.sh	2012-05-21 16:32:17.980074395 +0800
+++ dracut/dracut.sh	2012-05-21 16:32:57.450074527 +0800
@@ -123,6 +123,7 @@ Creates initial ramdisk images for prelo
   -M, --show-modules    Print included module's name to standard output during
                          build.
   --keep                Keep the temporary initramfs for debugging purposes
+  --printsize           Print out the module install size
   --sshkey [SSHKEY]     Add ssh key to initramfs (use with ssh-client module)
 
 If [LIST] has multiple arguments, then you have to put these in quotes.
@@ -268,6 +269,7 @@ while (($# > 0)); do
                        show_modules_l="yes"
                        ;;
         --keep)        keep="yes";;
+        --printsize)   printsize="yes";;
         -*) printf "\nUnknown option: %s\n\n" "$1" >&2; usage; exit 1;;
         *)
             if ! [[ ${outfile+x} ]]; then
@@ -700,6 +702,7 @@ mods_to_load=""
 for_each_module_dir check_module
 for_each_module_dir check_mount
 
+_isize=0 #initramfs size
 modules_loaded=" "
 # source our modules.
 for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
@@ -717,6 +720,14 @@ for moddir in "$dracutbasedir/modules.d"
         fi
         mods_to_load=${mods_to_load// $_d_mod /}
         modules_loaded+="$_d_mod "
+
+        #print the module install size
+        if [ -n "$printsize" ]; then
+            _isize_new=$(du -sk ${initdir}|cut -f1)
+            _isize_delta=$(($_isize_new - $_isize))
+            echo "$_d_mod install size: ${_isize_delta}k"
+            _isize=$_isize_new
+        fi
     fi
 done
 unset moddir
