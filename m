From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/5] Even more dracut functionality
Date: Wed, 11 Feb 2009 15:41:56 -0800 (PST)
Message-ID: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=SrrvDfym337eA+P9Rv/ZMOkmVY+m1TnpmHIdnYd53y4=;
        b=lW6mFyRvPyDnXR4P0Vqkui1o1IRRJThksrvdsUBky2koq5gDIrp1YNAEOpiTbK6Q66
         1PpCNUUvt637cc7AyfRCDoi+lpqcFcBCBG2RxAm1VJYbVJBb7rsPRSI1PHHSFOhUidb2
         27vXhqA94cR4CXDkSGaQLChE/Uq9d2B+VwKdQ=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Some more functionality -- no more hardcoded executable locations in the
dracut script, usind ldd to find library dependencies instead of eu-readelf,
and so on.

These patches are on the even-more-functionality branch at 
http://git.fnordovax.org/dracut, and apply on top of the other two patch series.

--

dracut will now search for files in the usual binary locations if a
 full path is not passed to the inst function.

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
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
