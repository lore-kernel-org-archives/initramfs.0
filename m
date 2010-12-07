From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 8082a0946e5702217d9b04f8d67287ebd4958da6
Date: Tue,  7 Dec 2010 14:26:41 +0000
Message-ID: <E1PPyVC-0002QC-FL@sfp-scmshell-1.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  8082a0946e5702217d9b04f8d67287ebd4958da6 (commit)
       via  79799c954f52e8cef9f19a84e2bcc46f6379df04 (commit)
       via  1b434f1ba9f8d54e051d86f974d5158a00e8c4df (commit)
      from  3003cfdf9ef5f8d9c2305ea085fa69392c36c071 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 8082a0946e5702217d9b04f8d67287ebd4958da6
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Dec 6 16:20:43 2010 +0100

    multipath/install: install the complete /etc/multipath directory
    
    Resolves: rhbz#630911

diff --git a/modules.d/90multipath/install b/modules.d/90multipath/install
index a48d6c6..57ac690 100755
--- a/modules.d/90multipath/install
+++ b/modules.d/90multipath/install
@@ -12,7 +12,7 @@ for f in  \
     /sbin/xdrgetprio \
     /etc/xdrdevices.conf \
     /etc/multipath.conf \
-    /etc/multipath/wwids \
+    /etc/multipath/* \
     "$libdir"/libmultipath* "$libdir"/multipath/*; do
     [ -e "$f" ] && inst "$f"
 done
commit 79799c954f52e8cef9f19a84e2bcc46f6379df04
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Dec 6 16:18:54 2010 +0100

    mkinitrd-dracut.sh: add "--force"
    
    Resolves: rhbz#626389

diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
index d395e92..8114fe2 100644
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -48,7 +48,7 @@ while (($# > 0)); do
             echo "mkinitrd: dracut compatibility wrapper"
             exit 0;;
         -v|--verbose) dracut_args="${dracut_args} -v";;
-        -f) dracut_args="${dracut_args} -f";;
+        -f|--force) dracut_args="${dracut_args} -f";;
         --preload) read_args modname "$@" || shift
             basicmodules="$basicmodules $modname";;
         --image-version) img_vers=yes;;
commit 1b434f1ba9f8d54e051d86f974d5158a00e8c4df
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Dec 6 16:05:37 2010 +0100

    mdraid/parse-md.sh: create new rules, then mv to old one
    
    If udevd is already running, then we should assemble the new rules files
    in a seperate file first, before calling it *.rules
    
    Resolves: rhbz#595096

diff --git a/modules.d/90mdraid/parse-md.sh b/modules.d/90mdraid/parse-md.sh
index 309c5dd..e0bce8b 100755
--- a/modules.d/90mdraid/parse-md.sh
+++ b/modules.d/90mdraid/parse-md.sh
@@ -10,7 +10,6 @@ else
     if [ -n "$MD_UUID" ]; then
         for f in /etc/udev/rules.d/65-md-incremental*.rules; do
             [ -e "$f" ] || continue
-            mv $f ${f}.bak 
             while read line; do 
                 if [ "${line%%UUID CHECK}" != "$line" ]; then
                     for uuid in $MD_UUID; do
@@ -20,8 +19,8 @@ else
                 else
                     echo $line; 
                 fi
-            done < ${f}.bak > $f
-            rm ${f}.bak 
+            done < "${f}" > "${f}.new"
+            mv "${f}.new" "$f" 
         done
     fi
 fi
-----------------------------------------------------------------------

Summary of changes:
 mkinitrd-dracut.sh             |    2 +-
 modules.d/90mdraid/parse-md.sh |    5 ++---
 modules.d/90multipath/install  |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)


-- 
dracut - Initramfs generator using udev
