From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] Update and slightly refactor compression handling.
Date: Sat, 19 Mar 2011 10:48:19 -0500 (CDT)
Message-ID: <71417f80994fec215a884b94d86b8579e5a1b63d.1300549698.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:from:subject:to:x-mailer:date;
        bh=bSziBPsLiq7YtUZXhrX/YyqwMznQA0IMbZnoCZSJZVg=;
        b=xGv/4FsXEbivAVNVpxkJck7t3Udi8Sk18fbiZXc0kxyCPDOBLvpQgSgEDE5ytURf56
         tGNuXyk2IalBiXs2JQ75YOMdN4RCkY2zVZanyflGKB8GRAA0ModPkePvf47f7N3zzYjS
         qga6FpJvpJKJB4z3Wq5CkpDx09GAye8StyyCc=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This adds a --compress= option along with xz support for 2.6.38 and above.
---
 dracut       |   34 ++++++++++++++++++++++++++--------
 dracut.8.xml |   25 ++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/dracut b/dracut
index 2ae7f8c..eae7af9 100755
--- a/dracut
+++ b/dracut
@@ -96,6 +96,13 @@ Creates initial ramdisk images for preloading modules
   --lzma                Compress the generated initramfs using lzma.
                          Make sure your kernel has lzma support compiled in, 
                          otherwise you will not be able to boot.
+  --xz                  Compress the generated initramfs using xz.
+                         Make sure that your kernel has xz support compiled
+                         in, otherwise you will not be able to boot.
+  --compress [COMPRESSION] Compress the generated initramfs with the
+                         passed compression program.  Make sure your kernel
+                         knows how to decompress the generated initramfs, 
+                         otherwise you will not be able to boot.
   --no-compress         Do not compress the generated initramfs.  This will
                          override any other compression options.
   --list-modules        List all available dracut modules.
@@ -195,6 +202,9 @@ while (($# > 0)); do
         -c|--conf)     read_arg conffile             "$@" || shift;;
         --confdir)     read_arg confdir              "$@" || shift;;
         -L|--stdlog)   read_arg stdloglvl_l          "$@" || shift;;
+        -I|--install)  read_arg install_items        "$@" || shift;;
+        --fwdir)       read_arg fw_dir_l             "$@" || shift;;
+        --compress)    read_arg compress             "$@" || shift;;
         -f|--force)    force=yes;;
         --kernel-only) kernel_only="yes"; no_kernel="no";;
         --no-kernel)   kernel_only="no"; no_kernel="yes";;
@@ -212,14 +222,11 @@ while (($# > 0)); do
         --fstab)       use_fstab_l="yes" ;;
         -h|--help)     usage; exit 1 ;;
         -i|--include)  push include_src "$2"; push include_target "$3"; shift 2;;
-        --bzip2)       [[ $compress != cat ]] && compress="bzip2 -9";;
-        --lzma)        [[ $compress != cat ]] && compress="lzma -9";;
-        --xz)          [[ $compress != cat ]] && compress="xz -9";;
-        --no-compress) compress="cat";;
-        --gzip)        if [[ $compress != cat ]]; then
-            type pigz > /dev/null 2>&1 && compress="pigz -9" || \
-                compress="gzip -9"
-            fi;;
+        --bzip2)       compress="bzip2";;
+        --lzma)        compress="lzma";;
+        --xz)          compress="xz";;
+        --no-compress) _no_compress="cat";;
+        --gzip)        compress="gzip";;
         --list-modules)
             do_list="yes";
             ;;
@@ -241,6 +248,17 @@ if ! [[ $kernel ]] || [[ $kernel = "unset" ]]; then
 fi
 [[ $outfile ]] || outfile="/boot/initramfs-$kernel.img"
 
+case $compress in
+    bzip2) compress="bzip -9";;
+    lzma)  compress="lzma -9";;
+    xz)    compress="xz --check=crc32 --lzma2=dict=1MiB";;
+    gzip)  type pigz > /dev/null 2>&1 && compress="pigz -9" || \
+                                         compress="gzip -9";;
+esac
+if [[ $_no_compress = "cat" ]]; then
+    compress="cat"
+fi
+
 PATH=/sbin:/bin:/usr/sbin:/usr/bin
 export PATH
 
diff --git a/dracut.8.xml b/dracut.8.xml
index ad74da0..b51004a 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -353,7 +353,7 @@ TARGET directory in the final initramfs. If SOURCE is a file, it will be install
           </term>
           <listitem>
             <para>Compress the generated initramfs using gzip.
-     This will be done by default, unless another compression option or --no-compress is passed.</para>
+     This will be done by default, unless another compression option or --no-compress is passed. Equivalent to "--compress=gzip -9"</para>
           </listitem>
         </varlistentry>
         <varlistentry>
@@ -363,7 +363,7 @@ TARGET directory in the final initramfs. If SOURCE is a file, it will be install
           <listitem>
             <para>Compress the generated initramfs using bzip2.
      <warning>
-                <para>Make sure your kernel has bzip2 decompression support compiled in, otherwise you will not be able to boot.</para>
+                <para>Make sure your kernel has bzip2 decompression support compiled in, otherwise you will not be able to boot. Equivalent to "--compress=bzip2"</para>
               </warning></para>
           </listitem>
         </varlistentry>
@@ -374,12 +374,31 @@ TARGET directory in the final initramfs. If SOURCE is a file, it will be install
           <listitem>
             <para>Compress the generated initramfs using lzma.
      <warning>
-                <para>Make sure your kernel has lzma decompression support compiled in, otherwise you will not be able to boot.</para>
+                <para>Make sure your kernel has lzma decompression support compiled in, otherwise you will not be able to boot. Equivalent to "--compress=lzma -9"</para>
               </warning></para>
           </listitem>
         </varlistentry>
         <varlistentry>
           <term>
+            <option>--xz</option>
+          </term>
+          <listitem>
+            <para>Compress the generated initramfs using xz.
+     <warning>
+                <para>Make sure your kernel has xz decompression support compiled in, otherwise you will not be able to boot. Equivalent to "--compress=xz --check=crc32 --lzma2=dict=1MiB"</para>
+              </warning></para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <option>--compress&nbsp;<replaceable>&lt;compressor&gt;</replaceable></option>
+          </term>
+          <listitem>
+            <para>Compress the generated initramfs using the passed compression program.  If you pass it just the name of a compression program, it will call that program with known-working arguments.  If you pass a quoted string with arguments, it will be called with exactly those arguments.  Depending on what you pass, this may result in an initramfs that the kernel cannot decompress.</para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
             <option>--no-compress</option>
           </term>
           <listitem>
-- 
1.7.4.1
