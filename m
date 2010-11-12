From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/3] 99base/dracut-lib.sh: 5 new functions & 1 modified
Date: Fri, 12 Nov 2010 02:09:30 +0100
Message-ID: <1289524172-11173-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

New:
  str_starts, str_replace
  funiq - print new unique file name
  mkuniqdir - create and print new unique dir
  splitsep - splits given string 'str' with separator 'sep' into vars
  udevmatch - create udev rule match for a device

Modified:
  foreach_uuid_until - use $___ as a place holder
---
 modules.d/99base/dracut-lib.sh |  137 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 130 insertions(+), 7 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 596dae2..f0c030b 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -6,6 +6,29 @@ strstr() {
     [ "${1#*$2*}" != "$1" ]
 }
 
+# returns OK if $1 contains $2 at the beginning
+str_starts() {
+    [ "${1#$2*}" != "$1" ]
+}
+
+# replaces all occurrences of 'search' in 'str' with 'replacement'
+#
+# str_replace str search replacement
+#
+# example:
+# str_replace '  one two  three  ' ' ' '_'
+str_replace() {
+    local in="$1"; local s="$2"; local r="$3"
+    local out=''
+
+    while strstr "${in}" "$s"; do
+        chop="${in%%$s*}"
+        out="${out}${chop# }$r"
+        in="${in#*$s}"
+    done
+    echo "${out}${in}"
+}
+
 _getcmdline() {
     local _line
     unset _line
@@ -142,6 +165,34 @@ getoptcomma() {
     return 1
 }
 
+# Splits given string 'str' with separator 'sep' into variables 'var1', 'var2',
+# 'varN'.  If number of fields is less than number of variables, remaining are
+# not set.  If number of fields is greater than number of variables, the last
+# variable takes remaining fields.  In short - it acts similary to 'read'.
+#
+# splitsep sep str var1 var2 varN
+#
+# example:
+#   splitsep ':' 'foo:bar:baz' v1 v2
+# in result:
+#   v1='foo', v2='bar:baz'
+#
+# TODO: ':' inside fields.
+splitsep() {
+    local sep="$1"; local str="$2"; shift 2
+    local tmp
+
+    while [ -n "$str" -a -n "$*" ]; do
+        tmp="${str%%:*}"
+        eval "$1=${tmp}"
+        str="${str#$tmp}"
+        str="${str#:}"
+        shift
+    done
+
+    return 0
+}
+
 setdebug() {
     if [ -z "$RDDEBUG" ]; then
         if [ -e /proc/cmdline ]; then
@@ -337,32 +388,104 @@ ip_to_var() {
     esac
 }
 
-# Evaluate command for UUIDs either given as arguments for this function or all
+# Create udev rule match for a device with its device name, or the udev property
+# ID_FS_UUID or ID_FS_LABEL
+#
+# example:
+#   udevmatch LABEL=boot
+# prints:
+#   ENV{ID_FS_LABEL}="boot"
+#
+# TOOD: symlinks
+udevmatch() {
+    case "$1" in
+    UUID=????????-????-????-????-????????????|LABEL=*)
+        printf 'ENV{ID_FS_%s}=="%s"' "${1%%=*}" "${1#*=}"
+        ;;
+    UUID=*)
+        printf 'ENV{ID_FS_UUID}=="%s*"' "${1#*=}"
+        ;;
+    /dev/?*) printf 'KERNEL=="%s"' "${1#/dev/}" ;;
+    *) return 255 ;;
+    esac
+}
+
+# Prints unique path for potential file inside specified directory.  It consists
+# of specified directory, prefix and number at the end which is incremented
+# until non-existing file is found.
+#
+# funiq dir prefix
+#
+# example:
+# # ls /mnt
+# cdrom0 cdrom1
+#
+# # funiq /mnt cdrom
+# /mnt/cdrom2
+funiq() {
+    local dir="$1"; local prefix="$2"
+    local i=0
+
+    [ -d "${dir}" ] || return 1
+
+    while [ -e "${dir}/${prefix}$i" ]; do
+        i=$(($i+1)) || return 1
+    done
+
+    echo "${dir}/${prefix}$i"
+}
+
+# Creates unique directory and prints its path.  It's using funiq to generate
+# path.
+#
+# mkuniqdir subdir new_dir_name
+mkuniqdir() {
+    local dir="$1"; local prefix="$2"
+    local retdir; local retdir_new
+
+    [ -d "${dir}" ] || mkdir -p "${dir}" || return 1
+
+    retdir=$(funiq "${dir}" "${prefix}") || return 1
+    until mkdir "${retdir}" 2>/dev/null; do
+        retdir_new=$(funiq "${dir}" "${prefix}") || return 1
+        [ "$retdir_new" = "$retdir" ] && return 1
+        retdir="$retdir_new"
+    done
+
+    echo "${retdir}"
+}
+
+# Evaluates command for UUIDs either given as arguments for this function or all
 # listed in /dev/disk/by-uuid.  UUIDs doesn't have to be fully specified.  If
-# beginning is given it is expanded to all matching UUIDs.  To pass full UUID
-# to your command use '${full_uuid}'.  Remember to escape '$'!
+# beginning is given it is expanded to all matching UUIDs.  To pass full UUID to
+# your command use '$___' as a place holder.  Remember to escape '$'!
+#
+# foreach_uuid_until [ -p prefix ] command UUIDs
 #
-# $1 = command to be evaluated
-# $2 = list of UUIDs separated by space
+# prefix - string to put just before $___
+# command - command to be evaluated
+# UUIDs - list of UUIDs separated by space
 #
 # The function returns after *first successful evaluation* of the given command
 # with status 0.  If evaluation fails for every UUID function returns with
 # status 1.
 #
 # Example:
-# foreach_uuid_until "mount -U \${full_uuid} /mnt; echo OK; umount /mnt" \
+# foreach_uuid_until "mount -U \$___ /mnt; echo OK; umount /mnt" \
 #       "01234 f512 a235567f-12a3-c123-a1b1-01234567abcb"
 foreach_uuid_until() (
     cd /dev/disk/by-uuid
 
+    [ "$1" = -p ] && local prefix="$2" && shift 2
     local cmd="$1"; shift; local uuids_list="$*"
-    local uuid; local full_uuid
+    local uuid; local full_uuid; local ___
 
     [ -n "${cmd}" ] || return 1
 
     for uuid in ${uuids_list:-*}; do
         for full_uuid in ${uuid}*; do
             [ -e "${full_uuid}" ] || continue
+            ___="${prefix}${full_uuid}"
             eval ${cmd} && return 0
         done
     done
-- 
1.7.3.2
