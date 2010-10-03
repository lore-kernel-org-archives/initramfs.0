From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/2] 99base/dracut-lib.sh: 7 new functions & 1 modified
Date: Mon,  4 Oct 2010 00:44:45 +0200
Message-ID: <1286145886-16322-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

str_starts, str_replace
chr - decimal value to character
funiq - print new unique file name
mkuniqdir - create and print new unique dir
enc_nonprn_white - encode non-printable and white chars to '\xHH'
foreach_dev_until - evaluates command for every given device

modified:
foreach_uuid_until - use $___ as a place holder
---
 modules.d/99base/dracut-lib.sh |  142 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 627d2c5..e8a7850 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -6,6 +6,35 @@ strstr() {
     [ "${1#*$2*}" != "$1" ]
 }
 
+# returns OK if $1 contains $2 at the beginning
+str_starts() {
+    [ "${1#$2*}" != "$1" ]
+}
+
+# converts decimal value to its ASCII character representation
+# <http://mywiki.wooledge.org/BashFAQ/071>
+chr() {
+    printf \\$(($1/64*100+$1%64/8*10+$1%8))
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
 getarg() {
     set +x 
     local o line val
@@ -283,35 +312,134 @@ ip_to_var() {
     esac
 }
 
-# Evaluate command for UUIDs either given as arguments for this function or all
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
+    local retdir
+
+    retdir=$(funiq "${dir}" "${prefix}") || return 1
+    until mkdir "${retdir}" 2>/dev/null; do
+        retdir=$(funiq "${dir}" "${prefix}") || return 1
+    done
+
+    echo "${retdir}"
+}
+
+# Encodes non-printable characters and spaces in a string to their hexadecimal
+# values prefixed with '\x'.
+#
+# enc_nonprn_white str
+enc_nonprn_white() {
+    local str="$1"; local i=1
+
+    while [ $i -le 32 ]; do
+        str="$(str_replace "${str}" "$(chr $i)" \\x$(printf '%02x' $i))"
+        i=$(($i+1))
+    done
+
+    echo "${str}"
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
 
     return 1
 )
+
+# Evaluates command for every given device.  Every single device must be
+# specified either by path, by label prefixed with 'LABEL=' or UUID prefixed
+# with 'UUID='.  UUIDs are processed by 'foreach_uuid_until'.  List elements'
+# order is preserved.
+#
+# foreach_dev_until command device1 device2 ...
+#
+# The function returns after *first successful evaluation* of the given command
+# with status 0.  If evaluation fails for every device, function returns with
+# status 1.
+#
+# Example:
+# foreach_dev_until "echo \$___; false" /dev/sda1 "LABEL=Linux boot" "UUID=123a"
+foreach_dev_until() {
+    local cmd="$1"; shift
+    local dev; local ___
+
+    [ -n "${cmd}" ] || return 1
+
+    if [ -n "$*" ]; then
+        for dev; do
+            if str_starts "${dev}" 'UUID='; then
+                foreach_uuid_until -p 'UUID=' "${cmd}" "${dev#UUID=*}" && \
+                        return 0
+            else
+                [ -e "${dev}" ] || [ -e "/dev/disk/by-label/$(enc_nonprn_white\
+                        "${dev#LABEL=}")" ] || continue
+                ___="${dev}"
+                eval ${cmd} && return 0
+            fi
+        done
+    else
+        foreach_uuid_until -p 'UUID=' "${cmd}" && return 0
+    fi
+
+    return 1
+}
-- 
1.7.3
