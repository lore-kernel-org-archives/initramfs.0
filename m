From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] Make compression do The Right Thing based on what is in the config files.
Date: Sat, 19 Mar 2011 10:48:19 -0500 (CDT)
Message-ID: <61fa46d8914c16cd86bcfc2bde7f65df1f4422aa.1300549698.git.victor.lowther@gmail.com>
References: <71417f80994fec215a884b94d86b8579e5a1b63d.1300549698.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:in-reply-to:references:from:subject
         :to:x-mailer:date;
        bh=cw/ZyNIciaH8YbQghr2HcXVC8Ntqhp96LaoRQvR98zI=;
        b=r2EDLjoQOB86nPhb1T1uaXu0/Wg34pW3Kid+KlMu5mGF3iSbUmo3clJGie93g78XTN
         A2fHiiz5R3PfZ7lD98YY033UOCZz5mExPBPFwHnvdaJLo5I15S8R5IlqOYwhj9FoPvlC
         Z7kjeEb/BQA1LvIJZQuCB/GDanPH1F82rV1z8=
In-Reply-To: <71417f80994fec215a884b94d86b8579e5a1b63d.1300549698.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 dracut |   36 +++++++++++++++++++-----------------
 1 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/dracut b/dracut
index eae7af9..cbf7343 100755
--- a/dracut
+++ b/dracut
@@ -204,7 +204,7 @@ while (($# > 0)); do
         -L|--stdlog)   read_arg stdloglvl_l          "$@" || shift;;
         -I|--install)  read_arg install_items        "$@" || shift;;
         --fwdir)       read_arg fw_dir_l             "$@" || shift;;
-        --compress)    read_arg compress             "$@" || shift;;
+        --compress)    read_arg compress_l           "$@" || shift;;
         -f|--force)    force=yes;;
         --kernel-only) kernel_only="yes"; no_kernel="no";;
         --no-kernel)   kernel_only="no"; no_kernel="yes";;
@@ -222,11 +222,11 @@ while (($# > 0)); do
         --fstab)       use_fstab_l="yes" ;;
         -h|--help)     usage; exit 1 ;;
         -i|--include)  push include_src "$2"; push include_target "$3"; shift 2;;
-        --bzip2)       compress="bzip2";;
-        --lzma)        compress="lzma";;
-        --xz)          compress="xz";;
-        --no-compress) _no_compress="cat";;
-        --gzip)        compress="gzip";;
+        --bzip2)       compress_l="bzip2";;
+        --lzma)        compress_l="lzma";;
+        --xz)          compress_l="xz";;
+        --no-compress) _no_compress_l="cat";;
+        --gzip)        compress_l="gzip";;
         --list-modules)
             do_list="yes";
             ;;
@@ -248,17 +248,6 @@ if ! [[ $kernel ]] || [[ $kernel = "unset" ]]; then
 fi
 [[ $outfile ]] || outfile="/boot/initramfs-$kernel.img"
 
-case $compress in
-    bzip2) compress="bzip -9";;
-    lzma)  compress="lzma -9";;
-    xz)    compress="xz --check=crc32 --lzma2=dict=1MiB";;
-    gzip)  type pigz > /dev/null 2>&1 && compress="pigz -9" || \
-                                         compress="gzip -9";;
-esac
-if [[ $_no_compress = "cat" ]]; then
-    compress="cat"
-fi
-
 PATH=/sbin:/bin:/usr/sbin:/usr/bin
 export PATH
 
@@ -358,9 +347,22 @@ fi
 [[ $dracutbasedir ]] || dracutbasedir=/usr/share/dracut
 [[ $fw_dir ]] || fw_dir=/lib/firmware
 [[ $do_strip ]] || do_strip=no
+[[ $compress_l ]] && compress=$compress_l
 # eliminate IFS hackery when messing with fw_dir
 fw_dir=${fw_dir//:/ }
 
+# handle compression options.
+case $compress in
+    bzip2) compress="bzip -9";;
+    lzma)  compress="lzma -9";;
+    xz)    compress="xz --check=crc32 --lzma2=dict=1MiB";;
+    gzip)  type pigz > /dev/null 2>&1 && compress="pigz -9" || \
+                                         compress="gzip -9";;
+esac
+if [[ $_no_compress_l = "cat" ]]; then
+    compress="cat"
+fi
+
 [[ $hostonly = yes ]] && hostonly="-h"
 [[ $hostonly != "-h" ]] && unset hostonly
 [[ $compress ]] || compress="gzip -9"
-- 
1.7.4.1
