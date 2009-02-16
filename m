From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 41/50] dracut will now search for files in the usual binary locations if a
Date: Mon, 16 Feb 2009 14:07:06 -0500
Message-ID: <200902161907.n1GJ76s8028773@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=3359c8da847c6c5607f5d854e01ab347baa85fc4
Commit:     3359c8da847c6c5607f5d854e01ab347baa85fc4
Parent:     0f86847d63c1480e8263a66cc8bf2723862412ca
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:43:09 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 41/50] dracut will now search for files in the usual binary locations if a
---
 dracut           |    8 ++++----
 dracut-functions |   17 ++++++++++++++---
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/dracut b/dracut
index 30f0f9d..1042a0a 100755
--- a/dracut
+++ b/dracut
@@ -48,11 +48,11 @@ for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do
 done
 
 # executables that we have to have
-exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /sbin/pidof /bin/sleep /usr/sbin/chroot /bin/echo /bin/cat /bin/sed"
-lvmexe="/sbin/lvm"
-cryptexe="/sbin/cryptsetup"
+exe="bash mount mknod mkdir modprobe udevd udevadm nash pidof sleep chroot echo cat sed"
+lvmexe="lvm"
+cryptexe="cryptsetup"
 # and some things that are nice for debugging
-debugexe="/bin/ls /bin/ln /bin/ps /bin/grep /bin/more /bin/dmesg"
+debugexe="ls ln ps grep more dmesg"
 # udev things we care about
 udevexe="/lib/udev/vol_id /lib/udev/console_init"
 
diff --git a/dracut-functions b/dracut-functions
index 97ac626..52ef722 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -31,7 +31,6 @@ IF_dynamic=""
 inst_simple() {
     local src=$1 target="${initdir}${2:-$1}"
     [[ -f $target ]] && return 0
-    echo "Installing $src to $target"
     mkdir -p "${target%/*}"
     cp -fL "$src" "$target"
 }
@@ -51,7 +50,14 @@ inst_library() {
     fi
 }
 	
-	
+find_binary() {
+    local binpath="/bin /sbin /usr/bin /usr/sbin" p
+    [[ ${1##*/} = $1 ]] || { echo $1; return 0; }
+    for p in $binpath; do
+	[[ -x $p/$1 ]] && { echo "$p/$1"; return 0; }
+    done
+    return 1
+}
 
 # Same as above.
 # If the file is a binary executable, install all its
@@ -114,6 +120,7 @@ inst_symlink() {
     inst "$realsrc" && ln -s "$realsrc" "$target"
 }
 
+
 # general purpose installation function
 # Same args as above.
 # Just tries to install as a binary, a shell script, then a simple data file.
@@ -122,7 +129,11 @@ inst() {
         echo "usage: inst <file> <root> [<destination file>]"
         return 1
     fi
-    local src=$1 dest=${2:-$1}
+    local src=$(find_binary "$1") || {
+	echo "Cannot find requested file $1. Exiting."
+	exit 1
+    }
+    local dest=${2:-$src}
     for x in inst_symlink inst_script inst_binary inst_simple; do
 	$x "$src" "$dest" && return 0
     done
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
