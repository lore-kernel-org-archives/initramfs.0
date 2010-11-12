From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/3] 90crypt: probe for keydev asynchronously; changed kernel arg
Date: Fri, 12 Nov 2010 10:21:49 +0100
Message-ID: <1289553710-7568-2-git-send-email-aidecoe@aidecoe.name>
References: <1289553710-7568-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289553710-7568-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

New kernel argument syntax for LUKS-keydev is introduced:

  rd.luks.key=<key_path>[:<key_dev>[:<luks_dev>]]

Unfolding <key_dev> in BNF:

  <key_dev> ::= "UUID=" <uuid> | "LABEL=" <label> | <kname>

Where <kname> matches following regular expression:

  ^/dev/.*

<kname> need to be a character device and not a symlink for now.

For every rd.luks.key argument udev rule is created.  That rule runs
test to check whether matching device contains <key_path>.  If it does
it's applied to matching <luks_dev>.
---
 modules.d/90crypt/crypt-lib.sh     |  119 ++++++++++++++++++++++++++++++++++++
 modules.d/90crypt/cryptroot-ask.sh |   79 ++++++------------------
 modules.d/90crypt/install          |    5 ++
 modules.d/90crypt/parse-crypt.sh   |    8 +--
 modules.d/90crypt/parse-keydev.sh  |   41 ++++++++++++
 modules.d/90crypt/probe-keydev.sh  |   15 +++++
 6 files changed, 201 insertions(+), 66 deletions(-)
 create mode 100644 modules.d/90crypt/crypt-lib.sh
 create mode 100644 modules.d/90crypt/parse-keydev.sh
 create mode 100755 modules.d/90crypt/probe-keydev.sh

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-lib.sh
new file mode 100644
index 0000000..eee60fb
--- /dev/null
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -0,0 +1,119 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+. /lib/dracut-lib.sh
+
+# Try to mount specified device (by path, by UUID or by label) and check
+# the path with 'test'.
+#
+# example:
+# test_dev -f LABEL="nice label" /some/file1
+test_dev() {
+    local test_op=$1; local dev="$2"; local f="$3"
+    local ret=1; local mount_point=$(mkuniqdir /mnt testdev)
+    local path
+
+    [ -n "$dev" -a -n "$*" ] || return 1
+    [ -d "$mount_point" ] || die 'Mount point does not exist!'
+
+    if mount -r "$dev" "$mount_point" >/dev/null 2>&1; then
+        test $test_op "${mount_point}/${f}"
+        ret=$?
+        umount "$mount_point"
+    fi
+
+    rmdir "$mount_point"
+
+    return $ret
+}
+
+# Get kernel name for given device.  Device may be the name too (then the same
+# is returned), a symlink (full path), UUID (prefixed with "UUID=") or label
+# (prefixed with "LABEL=").  If just a beginning of the UUID is specified or
+# even an empty, function prints all device names which UUIDs match - every in
+# single line.
+#
+# NOTICE: The name starts with "/dev/".
+#
+# Example:
+#   devnames UUID=123
+# May print:
+#   /dev/dm-1
+#   /dev/sdb1
+#   /dev/sdf3
+devnames() {
+    local dev="$1"; local d; local names
+
+    case "$dev" in
+    UUID=*)
+        dev="$(foreach_uuid_until '! blkid -U $___' "${dev#UUID=}")" \
+            && return 255
+        [ -z "$dev" ] && return 255
+        ;;
+    LABEL=*) dev="$(blkid -L "${dev#LABEL=}")" || return 255 ;;
+    /dev/?*) ;;
+    *) return 255 ;;
+    esac
+
+    for d in $dev; do
+        names="$names
+$(readlink -e -q "$d")" || return 255
+    done
+
+    echo "${names#
+}"
+}
+
+# match_dev devpattern dev
+#
+# Returns true if 'dev' matches 'devpattern'.  Both 'devpattern' and 'dev' are
+# expanded to kernel names and then compared.  If name of 'dev' is on list of
+# names of devices matching 'devpattern', the test is positive.  'dev' and
+# 'devpattern' may be anything which function 'devnames' recognizes.
+#
+# If 'devpattern' is empty or '*' then function just returns true.
+#
+# Example:
+#   match_dev UUID=123 /dev/dm-1
+# Returns true if /dev/dm-1 UUID starts with "123".
+match_dev() {
+    [ -z "$1" -o "$1" = '*' ] && return 0
+    local devlist; local dev
+
+    devlist="$(devnames "$1")" || return 255
+    dev="$(devnames "$2")" || return 255
+
+    strstr "
+$devlist
+" "
+$dev
+"
+}
+
+# getkey keysfile for_dev
+#
+# Reads file <keysfile> produced by probe-keydev and looks for first line to
+# which device <for_dev> matches.  The successful result is printed in format
+# "<keydev>|<keypath>".  When nothing found, just false is returned.
+#
+# Example:
+#   getkey /tmp/luks.keys /dev/sdb1
+# May print:
+#   /dev/sdc1|/keys/some.key
+getkey() {
+    local keys_file="$1"; local for_dev="$2"
+    local luks_dev; local key_dev; local key_path
+
+    [ -z "$keys_file" -o -z "$for_dev" ] && die 'getkey: wrong usage!'
+    [ -f "$keys_file" ] || return 1
+
+    while IFS='|' read luks_dev key_dev key_path; do
+        if match_dev "$luks_dev" "$for_dev"; then
+            echo "${key_dev}|${key_path}"
+            return 0
+        fi
+    done < "$keys_file"
+
+    return 1
+}
diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 6c3acb6..bb8e81e 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -14,7 +14,7 @@
 # load dm_crypt if it is not already loaded
 [ -d /sys/module/dm_crypt ] || modprobe dm_crypt
 
-. /lib/dracut-lib.sh
+. /lib/dracut-crypt-lib.sh
 
 # default luksname - luks-UUID
 luksname=$2
@@ -26,6 +26,7 @@ else
     device="$1"
 fi
 
+# TODO: improve to support what cmdline does
 if [ -f /etc/crypttab ] && getargbool 1 rd.luks.crypttab -n rd_NO_CRYPTTAB; then
     while read name dev rest; do
         # ignore blank lines and comments
@@ -54,72 +55,30 @@ if [ -f /etc/crypttab ] && getargbool 1 rd.luks.crypttab -n rd_NO_CRYPTTAB; then
 fi
 
 #
-# Search key on external devices
-#
-
-# Try to mount device specified by UUID and probe for existence of any of
-# the paths.  On success return 0 and print "<uuid> <first-existing-path>",
-# otherwise return 1.
-# Function leaves mount point created.
-probe_keydev() {
-    local uuid="$1"; shift; local keypaths="$*"
-    local ret=1; local mount_point=/mnt/keydev
-    local path
-
-    [ -n "${uuid}" -a -n "${keypaths}" ] || return 1
-    [ -d ${mount_point} ] || mkdir -p "${mount_point}" || return 1
-
-    if mount -r -U "${uuid}" "${mount_point}" 2>/dev/null >/dev/null; then
-        for path in ${keypaths}; do
-            if [ -f "${mount_point}/${path}" ]; then
-                echo "${uuid} ${path}"
-                ret=0
-                break
-            fi
-        done
-    fi
-
-    umount "${mount_point}" 2>/dev/null >/dev/null
-
-    return ${ret}
-}
-
-keypaths="$(getargs rd.luks.keypath rd_LUKS_KEYPATH)"
-unset keydev_uuid keypath
-
-if [ -n "$keypaths" ]; then
-    keydev_uuids="$(getargs rd.luks.keydev.uuid rd_LUKS_KEYDEV_UUID)"
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
-
-unset keypaths
-
-#
 # Open LUKS device
 #
 
 info "luksOpen $device $luksname"
 
-if [ -n "$keydev_uuid" ]; then
-    mntp=/mnt/keydev
-    mkdir -p "$mntp"
-    mount -r -U "$keydev_uuid" "$mntp"
+if [ -n "$(getarg rd.luks.key)" ]; then
+    if tmp=$(getkey /tmp/luks.keys $device); then
+        keydev="${tmp%%|*}"
+        keypath="${tmp#*|}"
+    else
+        info "No key found for $device.  Will try later."
+        /sbin/initqueue --unique --onetime --settled \
+            --name cryptroot-ask-$luksname \
+            /sbin/cryptroot-ask "$@"
+        exit 0
+    fi
+    unset tmp
+
+    mntp=$(mkuniqdir /mnt keydev)
+    mount -r "$keydev" "$mntp" || die 'Mounting rem. dev. failed!'
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
index a518bc3..12b3555 100755
--- a/modules.d/90crypt/install
+++ b/modules.d/90crypt/install
@@ -2,7 +2,12 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 inst cryptsetup 
+inst rmdir
+inst readlink
 inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
+inst "$moddir"/probe-keydev.sh /sbin/probe-keydev
+inst_hook cmdline 10 "$moddir/parse-keydev.sh"
 inst_hook cmdline 30 "$moddir/parse-crypt.sh"
 inst_hook pre-pivot 30 "$moddir/crypt-cleanup.sh"
 inst /etc/crypttab
+inst "$moddir/crypt-lib.sh" "/lib/dracut-crypt-lib.sh"
diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse-crypt.sh
index 3baad5f..0dca0d3 100755
--- a/modules.d/90crypt/parse-crypt.sh
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -11,10 +11,6 @@ else
     } > /etc/udev/rules.d/70-luks.rules
 
     LUKS=$(getargs rd.luks.uuid rd_LUKS_UUID)
-    unset settled
-    [ -n "$(getargs rd.luks.keypath rd_LUKS_KEYPATH)" ] && \
-        [ -z "$(getargs rd.luks.keydev.uuid rd_LUKS_KEYDEV_UUID)" ] && \
-        settled='--settled'
 
     if [ -n "$LUKS" ]; then
         for luksid in $LUKS; do 
@@ -22,7 +18,7 @@ else
             {
                 printf 'ENV{ID_FS_TYPE}=="crypto_LUKS", '
                 printf 'ENV{ID_FS_UUID}=="*%s*", ' $luksid
-                printf 'RUN+="/sbin/initqueue --unique --onetime %s ' "$settled"
+                printf 'RUN+="/sbin/initqueue --unique --onetime '
                 printf -- '--name cryptroot-ask-%%k /sbin/cryptroot-ask '
                 printf '$env{DEVNAME} luks-$env{ID_FS_UUID}"\n'
             } >> /etc/udev/rules.d/70-luks.rules
@@ -35,7 +31,7 @@ else
             } >> /emergency/00-crypt.sh
         done
     else
-        echo 'ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/initqueue' $settled \
+        echo 'ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/initqueue' \
             '--unique --onetime --name cryptroot-ask-%k' \
             '/sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"' \
             >> /etc/udev/rules.d/70-luks.rules
diff --git a/modules.d/90crypt/parse-keydev.sh b/modules.d/90crypt/parse-keydev.sh
new file mode 100644
index 0000000..8712a46
--- /dev/null
+++ b/modules.d/90crypt/parse-keydev.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+if getargbool 1 rd.luks -n rd_NO_LUKS && \
+        [ -n "$(getarg rd.luks.key)" ]; then
+    exec 7>/etc/udev/rules.d/65-luks-keydev.rules
+    echo 'SUBSYSTEM!="block", GOTO="luks_keydev_end"' >&7
+    echo 'ACTION!="add|change", GOTO="luks_keydev_end"' >&7
+
+    for arg in $(getargs rd.luks.key); do
+        unset keypath keydev luksdev
+        splitsep : "$arg" keypath keydev luksdev
+
+        info "rd.luks.key: keypath='$keypath' keydev='$keydev' luksdev='$luksdev'"
+
+        if [ -z "$keypath" ]; then
+            warn 'keypath required!'
+            continue
+        fi
+
+        if [ -n "$keydev" ]; then
+            udevmatch "$keydev" >&7 || {
+                warn 'keydev incorrect!'
+                continue
+            }
+            printf ', ' >&7
+        fi
+
+        {
+            printf 'RUN+="/sbin/initqueue --unique --onetime '
+            printf -- '--name probe-keydev-%%k '
+            printf '/sbin/probe-keydev /dev/%%k %s %s"\n' \
+                "${keypath}" "${luksdev}"
+        } >&7
+    done
+    unset arg keypath keydev luksdev
+
+    echo 'LABEL="luks_keydev_end"' >&7
+    exec 7>&-
+fi
diff --git a/modules.d/90crypt/probe-keydev.sh b/modules.d/90crypt/probe-keydev.sh
new file mode 100755
index 0000000..8fdbc1a
--- /dev/null
+++ b/modules.d/90crypt/probe-keydev.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+. /lib/dracut-crypt-lib.sh
+
+
+real_keydev="$1"; keypath="$2"; luksdev="$3"
+
+[ -z "$real_keydev" -o -z "$keypath" ] && die 'probe-keydev: wrong usage!'
+[ -z "$luksdev" ] && luksdev='*'
+
+info "Probing $real_keydev for $keypath..."
+test_dev -f "$real_keydev" "$keypath" || exit 1
+
+info "Found $keypath on $real_keydev"
+echo "$luksdev|$real_keydev|$keypath" >> /tmp/luks.keys
-- 
1.7.3.2
