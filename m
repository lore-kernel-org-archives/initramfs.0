From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Debian multiarch support
Date: Tue, 10 Apr 2012 15:14:38 +0200
Message-ID: <CAGEveXr7G+5_rcuHUWBrg-rAQ1y6wU2ozVy2yBbQuo3PYdx3Mw@mail.gmail.com>
References: <CAGEveXprJz33cnna8PDQE7eyNUw1S-RDYtyZY405STOH7FfswA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mKEZjgHLmpZcNDC5k/7F8mxEK4Y57EoueGPWjgoSPbA=;
        b=Yo/qhoGtAvTndrKmEY5gwQmLdWqLfTblfjGXS04SueMlZKKDtyfTnSLYTijuWVa+uV
         tqyuzvs+MtwDyBV/sTJGqKvqe15s1wTJIqBzl7vk94J420Sfo1BCrkMIq0gOFMn7eXea
         X1mi8uUYE2LhI5omRwSezRniGfFVoZ0o4sF3+g2pjKgqLxQEGLZvSkt+lFMw4IT28fik
         Mwi1Ii0Z2uNs+xABt49P/YFVLXCs462G/KH2NWoiF+J5FPM5kMjjXtHNYW0yB/LDosym
         j4D9dAVjG/tYXGtgRpOOjUD/R+Rpsu/njCE6tAo3wCfql28WL+gYHoahdJeMkMgYq6Z6
         1QYw==
In-Reply-To: <CAGEveXprJz33cnna8PDQE7eyNUw1S-RDYtyZY405STOH7FfswA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thomas Lange <lange-jNDFPZUTrfRKC+uPiMyuu7CDI8haxt8Z@public.gmane.org>

Another solution could be searching in directories found at
/etc/ld.so.conf.d/*.conf or adding a new parameter. Here is a patch
which adds a new --libdirs parameter, and also a new inst_libdir_file
function which will try to expand metacharacters on each lib
directory:

inst_libdir_file "libdevmapper-event-lvm*.so"

Regards,

diff -urN dracut-018/dracut-functions.sh dracut-018.multi/dracut-functions.sh
--- dracut-018/dracut-functions.sh	2012-04-05 13:54:38.000000000 +0200
+++ dracut-018.multi/dracut-functions.sh	2012-04-10 14:58:35.949045189 +0200
@@ -677,6 +677,34 @@
     done
 }

+
+# inst_libdir_file [-n <pattern>] <file> [<file>...]
+# Install a <file> located on a lib directory to the initramfs image
+# -n <pattern> install non-matching files
+inst_libdir_file() {
+    if [[ "$1" == "-n" ]]; then
+        local _pattern=$1
+        shift 2
+        for _dir in $libdirs; do
+            for _i in "$@"; do
+                for _f in "$_dir"/$_i; do
+                    [[ "$_i" =~ $_pattern ]] || continue
+                    [[ -e "$_i" ]] && dracut_install "$_i"
+                done
+            done
+        done
+    else
+        for _dir in $libdirs; do
+            for _i in "$@"; do
+                for _f in "$_dir"/$_i; do
+                    [[ -e "$_f" ]] && dracut_install "$_f"
+                done
+            done
+        done
+    fi
+}
+
+
 # install function decompressing the target and handling symlinks
 # $@ = list of compressed (gz or bz2) files or symlinks pointing to such files
 #
diff -urN dracut-018/dracut.sh dracut-018.multi/dracut.sh
--- dracut-018/dracut.sh	2012-04-05 13:54:38.000000000 +0200
+++ dracut-018.multi/dracut.sh	2012-04-10 12:05:04.549845911 +0200
@@ -221,6 +221,7 @@
         --filesystems) push_arg filesystems_l        "$@" || shift;;
         -I|--install)  push_arg install_items_l      "$@" || shift;;
         --fwdir)       push_arg fw_dir_l             "$@" || shift;;
+        --libdirs)     push_arg libdirs_l            "$@" || shift;;
         --fscks)       push_arg fscks_l              "$@" || shift;;
         --add-fstab)   push_arg add_fstab_l          "$@" || shift;;
         --mount)       push_arg fstab_lines          "$@" || shift;;
@@ -400,6 +401,13 @@
     done
 fi

+if (( ${#libdirs_l[@]} )); then
+    libdirs=''
+    while pop libdirs_l val; do
+        libdirs+="$val "
+    done
+fi
+
 [[ $stdloglvl_l ]] && stdloglvl=$stdloglvl_l
 [[ ! $stdloglvl ]] && stdloglvl=4
 stdloglvl=$((stdloglvl + verbosity_mod_l))
@@ -505,14 +513,14 @@

 # Detect lib paths
 [[ $libdir ]] || for libdir in /lib64 /lib; do
-    [[ -d $libdir ]] && break
+    [[ -d $libdir ]] && libdirs+="$libdir " && break
 done || {
     dfatal 'No lib directory?!!!'
     exit 1
 }

 [[ $usrlibdir ]] || for usrlibdir in /usr/lib64 /usr/lib; do
-    [[ -d $usrlibdir ]] && break
+    [[ -d $usrlibdir ]] && libdirs+="$usrlibdir " && break
 done || dwarn 'No usr/lib directory!'

 # This is kinda legacy -- eventually it should go away.
diff -urN dracut-018/modules.d/01fips/module-setup.sh
dracut-018.multi/modules.d/01fips/module-setup.sh
--- dracut-018/modules.d/01fips/module-setup.sh	2012-04-05
13:54:38.000000000 +0200
+++ dracut-018.multi/modules.d/01fips/module-setup.sh	2012-04-07
12:52:12.307688709 +0200
@@ -34,12 +34,11 @@

     dracut_install sha512hmac rmmod insmod mount uname umount

-    for _dir in "$usrlibdir" "$libdir"; do
-        [[ -e $_dir/libsoftokn3.so ]] && \
-            dracut_install $_dir/libsoftokn3.so $_dir/libsoftokn3.chk \
-            $_dir/libfreebl3.so $_dir/libfreebl3.chk && \
-            break
-    done
+    inst_libdir_file libsoftokn3.so
+    inst_libdir_file libsoftokn3.so
+    inst_libdir_file libsoftokn3.chk
+    inst_libdir_file libfreebl3.so
+    inst_libdir_file libfreebl3.chk

     dracut_install $usrlibdir/hmaccalc/sha512hmac.hmac
     if command -v prelink >/dev/null; then
diff -urN dracut-018/modules.d/40network/module-setup.sh
dracut-018.multi/modules.d/40network/module-setup.sh
--- dracut-018/modules.d/40network/module-setup.sh	2012-04-05
13:54:38.000000000 +0200
+++ dracut-018.multi/modules.d/40network/module-setup.sh	2012-04-07
13:12:26.754623389 +0200
@@ -89,12 +89,7 @@

     _arch=$(uname -m)

-    for _dir in "$usrlibdir/tls/$_arch" "$usrlibdir/tls" "$usrlibdir/$_arch" \
-        "$usrlibdir" "$libdir"; do
-        for _i in "$_dir"/libnss_dns.so.* "$_dir"/libnss_mdns4_minimal.so.*; do
-            [ -e "$_i" ] && dracut_install "$_i"
-        done
-    done
-
+    inst_libdir_file {"tls/$_arch/",tls/,"$_arch/",}"libnss_dns.so.*"
+    inst_libdir_file {"tls/$_arch/",tls/,"$_arch/",}"libnss_mdns4_minimal.so.*"
 }

diff -urN dracut-018/modules.d/80cms/module-setup.sh
dracut-018.multi/modules.d/80cms/module-setup.sh
--- dracut-018/modules.d/80cms/module-setup.sh	2012-04-05
13:54:38.000000000 +0200
+++ dracut-018.multi/modules.d/80cms/module-setup.sh	2012-04-07
12:57:27.373147757 +0200
@@ -31,9 +31,7 @@
 	[[ -f $file ]] && inst $file
     done

-    for file in {"$usrlibdir","$libdir"}/gconv/*; do
-        [[ -f $file ]] && inst $file
-    done
+    inst_libdir_file "gconv/*"
 #inst /usr/lib/locale/locale-archive

     dracut_install cmsfs-fuse fusermount ulockmgr_server bash tr
insmod rmmod cat
diff -urN dracut-018/modules.d/90dm/module-setup.sh
dracut-018.multi/modules.d/90dm/module-setup.sh
--- dracut-018/modules.d/90dm/module-setup.sh	2012-04-05
13:54:38.000000000 +0200
+++ dracut-018.multi/modules.d/90dm/module-setup.sh	2012-04-07
12:58:04.319611365 +0200
@@ -22,9 +22,7 @@

     type -P dmeventd >/dev/null && dracut_install dmeventd

-    for _i in {"$libdir","$usrlibdir"}/libdevmapper-event.so*; do
-        [ -e "$_i" ] && dracut_install "$_i"
-    done
+    inst_libdir_file "libdevmapper-event.so*"

     inst_rules 10-dm.rules 13-dm-disk.rules 95-dm-notify.rules
     # Gentoo ebuild for LVM2 prior to 2.02.63-r1 doesn't install above rules
diff -urN dracut-018/modules.d/90dmraid/module-setup.sh
dracut-018.multi/modules.d/90dmraid/module-setup.sh
--- dracut-018/modules.d/90dmraid/module-setup.sh	2012-04-05
13:54:38.000000000 +0200
+++ dracut-018.multi/modules.d/90dmraid/module-setup.sh	2012-04-07
12:58:44.051467745 +0200
@@ -62,9 +62,7 @@
         inst_rules 64-md-raid.rules
     fi

-    for _i in {"$libdir","$usrlibdir"}/libdmraid-events*.so*; do
-        [ -e "$_i" ] && dracut_install "$_i"
-    done
+    inst_libdir_file "libdmraid-events*.so*"

     inst_rules "$moddir/61-dmraid-imsm.rules"
     #inst "$moddir/dmraid-cleanup.sh" /sbin/dmraid-cleanup
diff -urN dracut-018/modules.d/90lvm/module-setup.sh
dracut-018.multi/modules.d/90lvm/module-setup.sh
--- dracut-018/modules.d/90lvm/module-setup.sh	2012-04-05
13:54:38.000000000 +0200
+++ dracut-018.multi/modules.d/90lvm/module-setup.sh	2012-04-07
12:59:25.728296148 +0200
@@ -60,8 +60,6 @@
     inst "$moddir/lvm_scan.sh" /sbin/lvm_scan
     inst_hook cmdline 30 "$moddir/parse-lvm.sh"

-    for _i in {"$libdir","$usrlibdir"}/libdevmapper-event-lvm*.so; do
-        [ -e "$_i" ] && dracut_install "$_i"
-    done
+    inst_libdir_file "libdevmapper-event-lvm*.so"
 }

diff -urN dracut-018/modules.d/90multipath/module-setup.sh
dracut-018.multi/modules.d/90multipath/module-setup.sh
--- dracut-018/modules.d/90multipath/module-setup.sh	2012-04-05
13:54:38.000000000 +0200
+++ dracut-018.multi/modules.d/90multipath/module-setup.sh	2012-04-07
13:00:34.234532192 +0200
@@ -62,11 +62,13 @@
         /sbin/xdrgetprio \
         /etc/xdrdevices.conf \
         /etc/multipath.conf \
-        /etc/multipath/* \
-        "$libdir"/libmultipath* "$libdir"/multipath/*; do
+        /etc/multipath/*; do
         [ -e "$_f" ] && inst "$_f"
     done

+    inst_libdir_file "libmultipath*"
+    inst_libdir_file "multipath/*"
+
     inst_hook pre-trigger 02 "$moddir/multipathd.sh"
     inst_hook pre-pivot   02 "$moddir/multipathd-stop.sh"
     inst_rules 40-multipath.rules
diff -urN dracut-018/modules.d/95nfs/module-setup.sh
dracut-018.multi/modules.d/95nfs/module-setup.sh
--- dracut-018/modules.d/95nfs/module-setup.sh	2012-04-05
13:54:38.000000000 +0200
+++ dracut-018.multi/modules.d/95nfs/module-setup.sh	2012-04-07
13:03:06.822790298 +0200
@@ -54,11 +54,7 @@
     _nsslibs=${_nsslibs#|}
     _nsslibs=${_nsslibs%|}

-    for _i in {/usr,}$libdir/libnss*.so; do
-        [[ -e $_i ]] || continue
-        [[ "$_i" =~ $_nsslibs ]] || continue
-        dracut_install "$_i"
-    done
+    inst_libdir_file -n "$_nsslibs" "libnss*.so"

     inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"
     inst_hook pre-udev 99 "$moddir/nfs-start-rpc.sh"
diff -urN dracut-018/modules.d/95udev-rules/module-setup.sh
dracut-018.multi/modules.d/95udev-rules/module-setup.sh
--- dracut-018/modules.d/95udev-rules/module-setup.sh	2012-04-05
13:54:38.000000000 +0200
+++ dracut-018.multi/modules.d/95udev-rules/module-setup.sh	2012-04-07
13:03:50.168452719 +0200
@@ -74,8 +74,6 @@
     [ -f /etc/arch-release ] && \
         inst "$moddir/load-modules.sh" /lib/udev/load-modules.sh

-    for _i in {"$libdir","$usrlibdir"}/libnss_files*; do
-        [ -e "$_i" ] && dracut_install "$_i"
-    done
+    inst_libdir_file "libnss_files*"
 }

diff -urN dracut-018/modules.d/98syslog/module-setup.sh
dracut-018.multi/modules.d/98syslog/module-setup.sh
--- dracut-018/modules.d/98syslog/module-setup.sh	2012-04-05
13:54:38.000000000 +0200
+++ dracut-018.multi/modules.d/98syslog/module-setup.sh	2012-04-07
13:06:28.071361610 +0200
@@ -16,11 +16,9 @@
     local _installs
     if type -P rsyslogd >/dev/null; then
         _installs="rsyslogd"
-        for _i in {"$libdir","$usrlibdir"}/rsyslog/lmnet.so \
-            {"$libdir","$usrlibdir"}/rsyslog/imklog.so \
-            {"$libdir","$usrlibdir"}/rsyslog/imuxsock.so ; do
-            [ -e "$_i" ] && _installs="$_installs $_i"
-        done
+        inst_libdir_file rsyslog/lmnet.so
+        inst_libdir_file rsyslog/imklog.so
+        inst_libdir_file rsyslog/imuxsock.so
     elif type -P syslogd >/dev/null; then
         _installs="syslogd"
     elif type -P syslog-ng >/dev/null; then
