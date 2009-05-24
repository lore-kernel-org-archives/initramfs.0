From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] Add infrastructure for dracut module dependency checking.
Date: Sat, 23 May 2009 22:29:44 -0700 (PDT)
Message-ID: <91424b14939cf148aa51b49c93f0476f59d5b186.1243142925.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=uhNzIotgfwYNj06yB861Oudt24QsWl1dTy++WEuoG/A=;
        b=HfVIwsrO+Q//EToalxUMI9yhT/khulj+cDeuraP+eNClalBkssO1wpW2luD050gWbl
         wYUvuRnuf93nTqANsot9/LGcwT36zbk5xU6q5VTJaKBFw7DkxbUsRX3k01AZ0wE/tDY1
         Fxaj0eGBPouh7U6T+SJQErYLVK6D2KjCONj8E=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This also eliminates --skip-missing.  Check scripts should now check
to ensure that any files and settings they will copy from the host
system actually exist when called without arguments.

The check scripts are also updated to not try to source dracut-functions
which(1) is a perfectly good way of checking if a command is on the path.
---
 dracut                   |   36 +++++---------------------------
 dracut-functions         |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 modules.d/90crypt/check  |    4 +--
 modules.d/90lvm/check    |    5 +---
 modules.d/90mdraid/check |    5 +---
 test/make-test-root      |    2 +
 6 files changed, 62 insertions(+), 41 deletions(-)

diff --git a/dracut b/dracut
index e024fa4..7ff833c 100755
--- a/dracut
+++ b/dracut
@@ -34,7 +34,6 @@ Creates initial ramdisk images for preloading modules
                          booting the local host instead of a generic host.
   -i, --include [SOURCE] [TARGET]
                         Include the files in SOURCE in the final initramfs
-  --skip-missing
 "
 }
 
@@ -51,7 +50,6 @@ while (($# > 0)); do
 	-l|--local) allowlocal="yes" ;;
 	-h|--hostonly) hostonly="-h" ;;
 	-i|--include) include_src="$2"; include_target="$3"; shift 2;;
-	--skip-missing) skipmissing="yes" ;;
 	*) break ;;
     esac
     shift
@@ -83,16 +81,13 @@ export dracutfunctions
 case $dracutmodules in
 	""|auto)
 		dracutmodules="all"
-    		skipmissing="yes"
 		;;
 	hostonly)
     		dracutmodules="all"
-    		skipmissing="yes"
     		hostonly="-h"
 		;;
 esac
 
-
 [[ $2 ]] && kernel=$2 || kernel=$(uname -r)
 [[ $1 ]] && outfile=$(readlink -f $1) || outfile="/boot/initrd-$kernel.img"
 
@@ -113,30 +108,13 @@ for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do
     mkdir -p "$initdir/$d"; 
 done
 
-# these bits are fugly, and need some cleanup.
-# Actually documenting how dracut modules work these days would be good.
-skip_missing() {
-    # $1 = location of module
-    [[ $skipmissing ]] || return 0
-    [[ -x $1/check ]] || return 0
-    "$1/check" $hostonly
-}
+# check all our modules to see if they should be sourced
+check_modules
 
-can_source_module() {
-    # $1 = location of module
-    mod=${1##*/}; mod=${mod#[0-9][0-9]};
-    if [[ $dracutmodules != all ]]; then
-	strstr "$dracutmodules " "$mod " || return 1
-    fi
-    strstr "$omit_dracutmodules " "$mod " && return 1
-    skip_missing "$1"
-}
-
-# source all our modules
-for moddir in "$dsrc/modules.d"/*; do
-    [[ -d $moddir || -L $moddir ]] || continue
-    can_source_module "$moddir" || continue
-    [[ -x $moddir/install ]] && . "$moddir/install"
+#source our modules.
+for moddir in "$dsrc/modules.d"/[0-9][0-9]*; do
+    mod=${moddir##*/}; mod=${mod#[0-9][0-9]}
+    strstr "$mods_to_load" "$mod" && . "$moddir/install"
 done
 unset moddir
 
@@ -161,5 +139,3 @@ fi
 ( cd "$initdir"; find . |cpio -H newc -o |gzip -9 > "$outfile"; )
 
 [[ "$beverbose" = "yes" ]] && ls -lh "$outfile"
-
-:
diff --git a/dracut-functions b/dracut-functions
index 16ec7d0..6bad22c 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -200,6 +200,57 @@ dracut_install() {
     done
 }
 
+memoize() {
+    local cmd=memoize_$@ ret
+    cmd=${cmd//[^[:alnum:]]/_}
+    [[ ${!cmd} ]] && return ${!cmd}
+    "$@"
+    ret=$?
+    eval "$cmd=$ret"
+    return $ret
+}
+
+check_module_deps() {
+    local moddir dep
+    # turn a module name into a directory, if we can.
+    moddir=$(echo ${dsrc}/modules.d/??${1})
+    [[ -d $moddir && -x $moddir/install ]] || return 1
+    # if we do not have a check script, we are unconditionally included
+    if [[ -x $moddir/check ]]; then
+	memoize "$moddir/check" || return 1
+	for dep in $("$moddir/check" -d); do
+	    memoize check_module_deps "$dep" && continue
+	    dwarning "Dependency $mod failed."
+	    return 1
+	done
+    fi
+    mods_to_load+=" $1 "
+}
+
+should_source_module() {
+    local dep
+    [[ -x $1/install ]] || return 1
+    [[ -x $1/check ]] || return 0
+    "$1/check" $hostonly || return 1
+    for dep in $("$1/check" -d); do
+	memoize check_module_deps "$dep" && continue
+	dwarning "Cannot load $mod, dependencies failed."
+	return 1
+    done
+}
+
+check_modules() {
+    for moddir in "$dsrc/modules.d"/[0-9][0-9]*; do
+	local mod=${moddir##*/}; mod=${mod#[0-9][0-9]}
+	[[ -d $moddir ]] || continue
+	[[ $dracutmodules != all ]] && ! strstr "$dracutmodules" "$mod" && \
+	    continue
+	strstr "$omit_dracutmodules" "$mod" && continue
+	should_source_module "$moddir" || continue
+	mods_to_load+=" $mod "
+    done
+}
+
 # install modules, and handle installing all their dependencies as well.
 srcmods="/lib/modules/$kernel/"
 instmods() {
diff --git a/modules.d/90crypt/check b/modules.d/90crypt/check
index 7ab1acb..4189eaa 100755
--- a/modules.d/90crypt/check
+++ b/modules.d/90crypt/check
@@ -1,8 +1,6 @@
 #!/bin/sh
 
-[[ $dracutfunctions ]] && . $dracutfunctions
-
-find_binary cryptsetup >/dev/null || exit 1
+which cryptsetup >/dev/null 2>&1 || exit 1
 
 if [ "$1" = "-h" ]; then
     blkid | grep -q crypt_LUKS || exit 1
diff --git a/modules.d/90lvm/check b/modules.d/90lvm/check
index dc433d9..3b2a4c3 100755
--- a/modules.d/90lvm/check
+++ b/modules.d/90lvm/check
@@ -1,8 +1,5 @@
 #!/bin/sh
-
-[[ $dracutfunctions ]] && . $dracutfunctions
-
-find_binary lvm >/dev/null || exit 1
+which lvm >/dev/null 2>&1 || exit 1
 
 if [ "$1" = "-h" ]; then
     blkid | grep -q lvm2pv || exit 1
diff --git a/modules.d/90mdraid/check b/modules.d/90mdraid/check
index d809fb4..b533035 100755
--- a/modules.d/90mdraid/check
+++ b/modules.d/90mdraid/check
@@ -1,8 +1,5 @@
 #!/bin/sh
-
-[[ $dracutfunctions ]] && . $dracutfunctions
-
-find_binary mdadm >/dev/null || exit 1
+which mdadm >/dev/null 2>&1 || exit 1
 
 if [ "$1" = "-h" ]; then
     blkid | grep -q linux_raid || exit 1
diff --git a/test/make-test-root b/test/make-test-root
index cfc8758..e7f5276 100755
--- a/test/make-test-root
+++ b/test/make-test-root
@@ -12,6 +12,7 @@ kernel=$(uname -r)
 	/lib/terminfo/l/linux mount dmesg ifconfig dhclient mkdir cp ping dhclient 
     inst "modules.d/40network/dhclient-script" "/sbin/dhclient-script"
     inst "modules.d/40network/ifup" "/sbin/ifup"
+    
     dracut_install grep
     inst test/test-init /sbin/init
     find_binary plymouth >/dev/null && dracut_install plymouth
@@ -25,6 +26,7 @@ unset initdir
 # results in cryptsetup not being able to unlock the LVM PV.
 # Probably a bug in cryptsetup, but...
 ./dracut -l -i "$targetfs" /source \
+    -i test/overlay / \
     -m "dash kernel-modules test crypt lvm mdraid udev-rules base rootfs-block" \
     -d "ata_piix ext2 sd_mod" \
     -f test/initramfs.makeroot
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
