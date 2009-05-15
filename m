From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 04/11] add derror(), dinfo() and dwarning()
Date: Fri, 15 May 2009 14:39:24 +0200
Message-ID: <4A0D627C.9000206@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030905050905060000080007"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initram >> \"initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org\"" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------030905050905060000080007
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

---
  dracut-functions |   32 +++++++++++++++++++++++---------
  1 files changed, 23 insertions(+), 9 deletions(-)



--------------030905050905060000080007
Content-Type: text/x-patch;
 name="6fac46910c79337e1e46d338197b02893d723510.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="6fac46910c79337e1e46d338197b02893d723510.diff"

diff --git a/dracut-functions b/dracut-functions
index 2c98785..6839ba9 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -28,6 +28,18 @@ IF_dynamic=""
 # Generic substring function.  If $2 is in $1, return 0.
 strstr() { [[ ! ${1#*$2*} = $1 ]]; }
 
+dwarning() {
+    echo "W: $@" >&2
+}
+
+dinfo() {
+    echo "I: $@" >&2
+}
+
+derror() {
+    echo "E: $@" >&2
+}
+
 # $1 = file to copy to ramdisk
 # $2 (optional) Name for the file on the ramdisk
 # Location of the image dir is assumed to be $initdir
@@ -38,7 +50,7 @@ inst_simple() {
     src=$1 target="${initdir}${2:-$1}"
     [[ -f $target ]] && return 0
     mkdir -p "${target%/*}"
-    echo "Installing $src" >&2
+    dinfo "Installing $src" 
     cp -fL "$src" "$target"
 }
 
@@ -82,9 +94,9 @@ inst_binary() {
     ldd $bin 2>/dev/null | while read line; do
 	[[ $line = 'not a dynamic executable' ]] && return 1
 	[[ $line =~ not\ found ]] &&{
-	    echo "Missing a shared library required by $bin." >&2
-	    echo "Run \"ldd $bin\" to find out what it is." >&2
-	    echo "dracut cannot create an initrd." >&2
+	    derror "Missing a shared library required by $bin."
+	    derror "Run \"ldd $bin\" to find out what it is."
+	    derror "dracut cannot create an initrd."
 	    exit 1
 	} 
 	[[ $line =~ ([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*) ]] || continue
@@ -152,7 +164,7 @@ inst_rules() {
 # Same args as above.
 inst() {
     if (($# != 1 && $# != 2 )); then
-        echo "dracut error: inst only takes 1 or 2 arguments"
+        derror "inst only takes 1 or 2 arguments"
 	exit 1
     fi
     for x in inst_symlink inst_script inst_binary inst_simple; do
@@ -166,12 +178,12 @@ inst() {
 # All hooks should be POSIX/SuS compliant, they will be sourced by init.
 inst_hook() {
     [[ -f $3 ]] || {
-	echo "Cannot install a hook ($3) that does not exist." >&2
-	echo "Aborting initrd creation." >&2
+	derror "Cannot install a hook ($3) that does not exist."
+	derror "Aborting initrd creation."
 	exit 1
     }
     strstr "$hookdirs" "$1" || {
-	echo "No such hook type $1. Aborting initrd creation." >&2
+	derror "No such hook type $1. Aborting initrd creation." 
 	exit 1
     }
     inst_simple "$3" "/${1}/${2}${3##*/}"
@@ -183,7 +195,7 @@ dracut_install() {
             shift 
             continue
         fi
-        echo "Failed to install $1" >&2 ; exit 1
+        derror "Failed to install $1"; exit 1
     done
 }
 
@@ -226,6 +238,8 @@ instmods() {
     for fw in $(/sbin/modinfo -F firmware $mod 2>/dev/null); do
         if [ -f /lib/firmware/$fw ]; then
             inst_simple "/lib/firmware/$fw"
+	else
+	    dwarning "Possible missing firmware /lib/firmware/${fw} for module $(basename ${mod} .ko)"
         fi
     done
 } 


--------------030905050905060000080007--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
