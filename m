From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [RFC] 90crypt: key on rem. device enhancements
Date: Fri, 24 Sep 2010 23:18:07 +0200
Message-ID: <4c9e7c0d.d39ccc0a.676a.684a@mx.google.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 

Hi,

I'm doing some major modification of crypt module.  Here's what I've
done.  If that's OK, I'll send cleaned up patch with docs update.  Any
remarks at this point are appreciated.


99base/dracut-lib.sh: new func.: do_mount, funiq, mkuniqdir

90crypt/cryptroot-ask.sh: new func.: search_key_for

The patch introduces support for labels and normal dev names for
removable media storing key for LUKS.  Previously only UUID was
possible.  rd_LUKS_KEYDEV_UUID changes to rd_LUKS_KEYDEV which takes dev
names as in /etc/fstab (e.g.: rd_LUKS_KEYDEV=LABEL=boot).

It also fixes problem with devices not discovered on time by retrying
(for default 3 times with incrementing sleep period) the scan.

probe_keydev informs which device it checks.

Moreover code (the rem. dev. part) is refactorized.
---
 modules.d/90crypt/cryptroot-ask.sh |   98 ++++++++++++++++++----------
 modules.d/90crypt/install          |    1 +
 modules.d/99base/dracut-lib.sh     |  123 ++++++++++++++++++++++++++++++++++--
 3 files changed, 182 insertions(+), 40 deletions(-)

diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 45b5fe7..1d89aff 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -58,53 +58,82 @@ fi
 #
 
 # Try to mount device specified by UUID and probe for existence of any of
-# the paths.  On success return 0 and print "<uuid> <first-existing-path>",
+# the paths.  On success return 0 and print "<uuid>\t<first-existing-path>",
 # otherwise return 1.
-# Function leaves mount point created.
+#
+# $1 = dev
+# $2 = keypaths
 probe_keydev() {
-    local uuid="$1"; shift; local keypaths="$*"
-    local ret=1; local mount_point=/mnt/keydev
+    local dev="$1"; shift; local keypaths="$*"
+    local ret=1; local mount_point=$(mkuniqdir /mnt keydev)
     local path
 
-    [ -n "${uuid}" -a -n "${keypaths}" ] || return 1
-    [ -d ${mount_point} ] || mkdir -p "${mount_point}" || return 1
+    [ -n "${dev}" -a -n "${keypaths}" ] || return 1
+    [ -d "${mount_point}" ] || die 'Mount point does not exist!'
 
-    if mount -r -U "${uuid}" "${mount_point}" 2>/dev/null >/dev/null; then
+    info "cryptroot-ask: Probing ${dev}..."
+    if do_mount -q "${dev}" "${mount_point}"; then
         for path in ${keypaths}; do
             if [ -f "${mount_point}/${path}" ]; then
-                echo "${uuid} ${path}"
+                echo "${dev}	${path}"
                 ret=0
                 break
             fi
         done
+
+        umount "${mount_point}"
     fi
 
-    umount "${mount_point}" 2>/dev/null >/dev/null
+    rmdir "${mount_point}"
 
     return ${ret}
 }
 
-keypaths="$(getargs rd_LUKS_KEYPATH)"
-unset keydev_uuid keypath
-
-if [ -n "$keypaths" ]; then
-    keydev_uuids="$(getargs rd_LUKS_KEYDEV_UUID)"
-    [ -n "$keydev_uuids" ] || {
-        warn 'No UUID of device storing LUKS key specified.'
-        warn 'It is recommended to set rd_LUKS_KEYDEV_UUID.'
-        warn 'Performing scan of *all* devices accessible by UUID...'
-    }
-    tmp=$(foreach_uuid_until "probe_keydev \$full_uuid $keypaths" \
-        $keydev_uuids) && {
-        keydev_uuid="${tmp%% *}"
-        keypath="${tmp#* }"
-    } || {
-        warn "Key for $device not found."
-    }
-    unset tmp keydev_uuids
-fi
+# $1 = encrypted device
+# $2 = tries (optional; default is 3)
+# rd_LUKS_KEYPATH
+# rd_LUKS_KEYDEV
+#
+# returns 0 if search succeeded
+# returns 1 if search failed
+# returns 2 if search skipped (when rd_LUKS_KEYPATH not specified)
+search_key_for() {
+    local device="$1"; local tries="$2"
+    local keypaths="$(getargs rd_LUKS_KEYPATH)"; local keydevs
+
+    if [ -n "$keypaths" ]; then
+        keydevs="$(getargs rd_LUKS_KEYDEV)"
+        [ -n "$keydevs" ] || {
+            warn 'No device storing LUKS key specified.'
+            warn 'It is recommended to set rd_LUKS_KEYDEV (best by UUID).'
+            warn 'Performing scan of *all* devices accessible by UUID...'
+        }
+
+        { [ -z "$2" ] || [ $2 -lt 1 ]; } && tries=3
+        local i=0
+        while [ $i -lt 3 ]; do
+            sleep $i
+            # following outputs "$keydev\t$keypath" (on success only)
+            foreach_dev_until "probe_keydev \$___ $keypaths" $keydevs && \
+                    return 0
+            warn "Key for $device not found.  Trying again..."
+            i=$(($i+1))
+        done
+
+        return 1
+    fi
+
+    return 2
+}
+
+mkdir -p /mnt
+
+tmp=$(search_key_for $device) && {
+    keydev="${tmp%%	*}"
+    keypath="${tmp#*	}"
+}
+unset tmp
 
-unset keypaths
 
 #
 # Open LUKS device
@@ -112,14 +141,13 @@ unset keypaths
 
 info "luksOpen $device $luksname"
 
-if [ -n "$keydev_uuid" ]; then
-    mntp=/mnt/keydev
-    mkdir -p "$mntp"
-    mount -r -U "$keydev_uuid" "$mntp"
+if [ -n "$keydev" ]; then
+    mntp=$(mkuniqdir /mnt keydev)
+    do_mount "$keydev" "$mntp" || die 'Mounting rem. dev. failed!'
     cryptsetup -d "$mntp/$keypath" luksOpen "$device" "$luksname"
     umount "$mntp"
-    rmdir -p "$mntp" 2>/dev/null
-    unset mntp keypath keydev_uuid
+    rmdir "$mntp"
+    unset mntp keypath keydev
 else
     # Prompt for password with plymouth, if installed.
     # Should we check if plymouthd is running?
diff --git a/modules.d/90crypt/install b/modules.d/90crypt/install
index a518bc3..e4dfa47 100755
--- a/modules.d/90crypt/install
+++ b/modules.d/90crypt/install
@@ -2,6 +2,7 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 inst cryptsetup 
+inst rmdir
 inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
 inst_hook cmdline 30 "$moddir/parse-crypt.sh"
 inst_hook pre-pivot 30 "$moddir/crypt-cleanup.sh"
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 627d2c5..786c7e5 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -6,6 +6,11 @@ strstr() {
     [ "${1#*$2*}" != "$1" ]
 }
 
+# returns OK if $1 contains $2 at the beginning
+strstarts() {
+    [ "${1#$2*}" != "$1" ]
+}
+
 getarg() {
     set +x 
     local o line val
@@ -286,32 +291,140 @@ ip_to_var() {
 # Evaluate command for UUIDs either given as arguments for this function or all
 # listed in /dev/disk/by-uuid.  UUIDs doesn't have to be fully specified.  If
 # beginning is given it is expanded to all matching UUIDs.  To pass full UUID
-# to your command use '${full_uuid}'.  Remember to escape '$'!
+# to your command use '$___' as a place holder.  Remember to escape '$'!
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
+# Evaluate command for every given device.  Every single device must be
+# specified either by path, by label prefixed with 'LABEL=' or UUID prefixed
+# with 'UUID='.  UUIDs are processed by 'foreach_uuid_until'.  List elements'
+# order is preserved.
+#
+# foreach_dev_until command devices
+#
+# command - command to be evaluated
+# devices - list of devices separated by space
+#
+# The function returns after *first successful evaluation* of the given command
+# with status 0.  If evaluation fails for every device, function returns with
+# status 1.
+#
+# Example:
+# foreach_dev_until "echo \$___; false" "/dev/sda1 LABEL=boot UUID=123a"
+foreach_dev_until() {
+    local cmd="$1"; shift; local devs_list="$*"
+    local dev; local ___
+
+    [ -n "${cmd}" ] || return 1
+
+    if [ -n "${devs_list}" ]; then
+        for dev in ${devs_list}; do
+            if strstarts "${dev}" 'UUID='; then
+                foreach_uuid_until -p 'UUID=' "${cmd}" "${dev#UUID=*}" && \
+                        return 0
+            else
+                [ -e "${dev}" ] || [ -e "/dev/disk/by-label/${dev#LABEL=}" ] \
+                        || continue
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
+
+# It's a wrapper around 'mount' command.  In addition to 'mount' you can specify
+# device name like "UUID=01234567-89ab-cdef-0123-4567890abcde" and
+# "LABEL=fun_label".  'do_mount' mounts device as read-only for default.  To
+# mount as writable pass '-w' option.  'mount_point' argument is required.
+#
+# do_mount [options] dev mount_point
+#
+# Extra options:
+#   -q    Suppress any output.
+#
+# Example:
+# do_mount -q -w LABEL=blah /mnt/disk
+do_mount() {
+    local args; local quiet
+
+    while [ $# -gt 2 ]; do
+        case $1 in
+            -q) quiet='2>/dev/null >/dev/null' ;;
+            -v) quiet=''; args="${args} $1" ;;
+            *) args="${args} $1" ;;
+        esac
+        shift
+    done
+
+    local dev_name="$1"; local dev="${dev_name#*=}"; local mount_point="$2"
+
+    case ${dev_name} in
+        -*) die 'do_mount - wrong usage!' ;;
+        UUID=*) args="${args} -U" ;;
+        LABEL=*) args="${args} -L" ;;
+    esac
+
+    [ -n "${dev}" -a -n "${mount_point}" ] || die 'do_mount - wrong usage!'
+
+    eval mount -r ${args} \'${dev}\' \'${mount_point}\' ${quiet}
+}
+
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
+mkuniqdir() {
+    local dir="$1"; local prefix="$2"
+    local retdir
+
+    retdir=$(funiq "${dir}" "${prefix}") || return 1
+    until mkdir "${retdir}"; do
+        retdir=$(funiq "${dir}" "${prefix}") || return 1
+    done
+
+    echo "${retdir}"
+}
-- 
1.7.3
