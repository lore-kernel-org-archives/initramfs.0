From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 48/50] Shift some functionality around, make modules maskable.
Date: Mon, 16 Feb 2009 14:07:20 -0500
Message-ID: <200902161907.n1GJ7KEQ028976@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=f04dc5f31235a440c745836118697223f6f3d3f1
Commit:     f04dc5f31235a440c745836118697223f6f3d3f1
Parent:     f4fff04ef1e985ddb7bd83b8abb2a92d9a43fac5
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:43:26 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 48/50] Shift some functionality around, make modules maskable.
    
    Most of our functionality is now in scripts that we source rather than in the
    main dracut script.
---
 dracut               |    9 ++++++---
 dracut-functions     |   20 ++++++++++++++++----
 modules/90crypt      |    3 ++-
 modules/90lvm        |    3 ++-
 modules/95udev-rules |    8 +++++---
 modules/99base       |    3 +--
 6 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/dracut b/dracut
index fa3aafa..1378268 100755
--- a/dracut
+++ b/dracut
@@ -51,9 +51,12 @@ for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do
     mkdir -p "$initdir/$d"; 
 done
 
-# source any third-party package provided modules
-for f in "$dsrc/modules"/*; do
-    [[ -x $f ]] && . "$f"
+# source all our modules
+for f in "$dsrc/modules"/*[^~]; do
+    mod=${f##*/}; mod=${mod#[0-9][0-9]}
+    if [[ $dracutmodules = all ]] || strstr "$dracutmodules" "$mod"; then 
+	[[ -x $f ]] && . "$f"
+    fi
 done
 
 ## final stuff that has to happen
diff --git a/dracut-functions b/dracut-functions
index b410034..1923b26 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -25,6 +25,8 @@
 IF_RTLD=""
 IF_dynamic=""
 
+strstr() { [[ ! ${1#*$2*} = $1 ]]; }
+
 # $1 = file to copy to ramdisk
 # $2 (optional) Name for the file on the ramdisk
 # Location of the image dir is assumed to be $initdir
@@ -69,14 +71,16 @@ inst_binary() {
     [[ -f $initdir$target ]] && return 0
     # I love bash!
     while read line; do
-	[[ $line =~ '([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*|not found)' ]] || continue
-	FILE=${BASH_REMATCH[1]}
-        [[ $FILE = 'not found' ]] && {
+	[[ $line = 'not a dynamic executable' ]] && return 1
+	[[ $line =~ 'not found' ]] &&{
 	    echo "Missing a shared library required by $bin." >&2
 	    echo "Run \"ldd $bin\" to find out what it is." >&2
 	    echo "dracut cannot create an initrd." >&2
 	    exit 1
-	}
+	} 
+	[[ $line =~ '([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*)' ]] || continue
+	FILE=${BASH_REMATCH[1]}
+	[[ -f ${initdir}$FILE ]] && continue
 	# see if we are loading an optimized version of a shared lib.
 	[[ $FILE =~ '^(/lib[^/]*).*' ]] && {
             TLIBDIR=${BASH_REMATCH[1]}
@@ -115,6 +119,14 @@ inst_symlink() {
     inst "$realsrc" && ln -s "$realsrc" "$target"
 }
 
+# udev rules always get installed in the same place, so
+# create a function to install them to make life simpler.
+inst_rules() { 
+    for rule in "$@"; do 
+	inst_simple "$rule" "/lib/udev/rules.d/${rule##*/}"
+    done
+}
+
 # general purpose installation function
 # Same args as above.
 inst() {
diff --git a/modules/90crypt b/modules/90crypt
index e4f1876..e8f9269 100755
--- a/modules/90crypt
+++ b/modules/90crypt
@@ -1,2 +1,3 @@
 #!/bin/bash
-inst cryptsetup
\ No newline at end of file
+inst cryptsetup
+inst_rules "$dsrc/rules.d/63-luks.rules"
\ No newline at end of file
diff --git a/modules/90lvm b/modules/90lvm
index d75062a..315fbb8 100755
--- a/modules/90lvm
+++ b/modules/90lvm
@@ -1,2 +1,3 @@
 #!/bin/bash
-inst lvm
\ No newline at end of file
+inst lvm
+inst_rules "$dsrc/rules.d/64-lvm.rules"
\ No newline at end of file
diff --git a/modules/95udev-rules b/modules/95udev-rules
index 50a69f8..9801e7e 100755
--- a/modules/95udev-rules
+++ b/modules/95udev-rules
@@ -3,6 +3,8 @@
 # ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
 # of the rules we want so that we just copy those in would be best
 mkdir -p "$initdir/lib/udev/rules.d"
-for rule in /lib/udev/rules.d/10-console* /lib/udev/rules.d/40-redhat* /lib/udev/rules.d/50* /lib/udev/rules.d/60-persistent-storage.rules /lib/udev/rules.d/61*edd* /lib/udev/rules.d/64* /lib/udev/rules.d/80* /lib/udev/rules.d/95* $rulesdir/*.rules ; do
-  inst "$rule" "/lib/udev/rules.d/${rule##*/}"
-done
+dracut_install udevd udevadm /lib/udev/*_id /lib/udev/console_*
+inst_rules /lib/udev/rules.d/10-console* /lib/udev/rules.d/40-redhat* \
+    /lib/udev/rules.d/50* /lib/udev/rules.d/60-persistent-storage.rules \
+    /lib/udev/rules.d/61*edd* /lib/udev/rules.d/64* /lib/udev/rules.d/80* \
+    /lib/udev/rules.d/95*
\ No newline at end of file
diff --git a/modules/99base b/modules/99base
index c47f62b..e1c699b 100755
--- a/modules/99base
+++ b/modules/99base
@@ -1,6 +1,5 @@
 #!/bin/bash
-dracut_install mount mknod mkdir modprobe udevd udevadm pidof sleep \
-	       chroot echo sed sh ls /lib/udev/vol_id /lib/udev/console_init
+dracut_install mount mknod mkdir modprobe pidof sleep chroot echo sed sh ls
 
 # install our scripts and hooks
 inst "$initfile" "/init"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
