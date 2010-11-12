From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 91f4d45f93f067ac3de3d38c62bed84e5075932d
Date: Fri, 12 Nov 2010 13:12:25 +0000
Message-ID: <E1PGtQh-0003ar-Fg@sfp-scmshell-2.v30.ch3.sourceforge.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  91f4d45f93f067ac3de3d38c62bed84e5075932d (commit)
       via  c7e72136b2d1c345d850ba7149557b71336fb7a2 (commit)
       via  8844cd6b6cac908d7f81460838e3106af77d61a8 (commit)
       via  ccb0ab73485baf5ff9e65729435bc599f96945e8 (commit)
      from  5023964844530eebef6fb779320b09472ef1d8d7 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 91f4d45f93f067ac3de3d38c62bed84e5075932d
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Fri Nov 12 14:11:33 2010 +0100

    crypt: change /tmp/luks.keys seperator from "|" to ":"
   =20
    Do it like on the kernel command line, so we only have one forbidde=
n
    character.

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-l=
ib.sh
index eee60fb..9083aca 100644
--- a/modules.d/90crypt/crypt-lib.sh
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -95,12 +95,12 @@ $dev
 #
 # Reads file <keysfile> produced by probe-keydev and looks for first l=
ine to
 # which device <for_dev> matches.  The successful result is printed in=
 format
-# "<keydev>|<keypath>".  When nothing found, just false is returned.
+# "<keydev>:<keypath>".  When nothing found, just false is returned.
 #
 # Example:
 #   getkey /tmp/luks.keys /dev/sdb1
 # May print:
-#   /dev/sdc1|/keys/some.key
+#   /dev/sdc1:/keys/some.key
 getkey() {
     local keys_file=3D"$1"; local for_dev=3D"$2"
     local luks_dev; local key_dev; local key_path
@@ -108,9 +108,9 @@ getkey() {
     [ -z "$keys_file" -o -z "$for_dev" ] && die 'getkey: wrong usage!'
     [ -f "$keys_file" ] || return 1
=20
-    while IFS=3D'|' read luks_dev key_dev key_path; do
+    while IFS=3D':' read luks_dev key_dev key_path; do
         if match_dev "$luks_dev" "$for_dev"; then
-            echo "${key_dev}|${key_path}"
+            echo "${key_dev}:${key_path}"
             return 0
         fi
     done < "$keys_file"
diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cry=
ptroot-ask.sh
index bb8e81e..5150688 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -62,8 +62,8 @@ info "luksOpen $device $luksname"
=20
 if [ -n "$(getarg rd.luks.key)" ]; then
     if tmp=3D$(getkey /tmp/luks.keys $device); then
-        keydev=3D"${tmp%%|*}"
-        keypath=3D"${tmp#*|}"
+        keydev=3D"${tmp%%:*}"
+        keypath=3D"${tmp#*:}"
     else
         info "No key found for $device.  Will try later."
         /sbin/initqueue --unique --onetime --settled \
diff --git a/modules.d/90crypt/probe-keydev.sh b/modules.d/90crypt/prob=
e-keydev.sh
index 8fdbc1a..04a0e09 100755
--- a/modules.d/90crypt/probe-keydev.sh
+++ b/modules.d/90crypt/probe-keydev.sh
@@ -12,4 +12,4 @@ info "Probing $real_keydev for $keypath..."
 test_dev -f "$real_keydev" "$keypath" || exit 1
=20
 info "Found $keypath on $real_keydev"
-echo "$luksdev|$real_keydev|$keypath" >> /tmp/luks.keys
+echo "$luksdev:$real_keydev:$keypath" >> /tmp/luks.keys
commit c7e72136b2d1c345d850ba7149557b71336fb7a2
Author: Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Date:   Fri Nov 12 10:21:50 2010 +0100

    dracut.kernel.7: updated to latest changes in 90crypt

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index 7f54e9e..bf517ea 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -318,25 +318,20 @@ This parameter can be specified multiple times.</=
para>
       </variablelist>
     </refsect2>
     <refsect2>
-      <title>crypt LUKS - experimental removable keys support</title>
-      <para>works only when plymouth module is not included</para>
+      <title>crypto LUKS - key on removable device support</title>
       <variablelist>
         <varlistentry>
           <term>
-            <envar>rd.luks.keypath=3D</envar>
-            <replaceable>&lt;path to keyfile&gt;</replaceable>
+            <envar>rd.luks.key=3D</envar>
+	    <replaceable>&lt;keypath&gt;:&lt;keydev&gt;:&lt;luksdev&gt;</repl=
aceable>
           </term>
           <listitem>
-            <para>path to keyfile inside remove device filesystem</par=
a>
-          </listitem>
-        </varlistentry>
-        <varlistentry>
-          <term>
-            <envar>rd.luks.keydev.uuid=3D</envar>
-            <replaceable>&lt;rem. device uuid&gt;</replaceable>
-          </term>
-          <listitem>
-            <para>UUID of removalbe device storing keyfile; UUID doesn=
&apos;t have to be exact just like for <envar>rd.luks.uuid</envar></par=
a>
+		  <para><replaceable>keypath</replaceable> is a path to key file to =
look for. It's REQUIRED.</para>
+		  <para><replaceable>keydev</replaceable> is a device on which key f=
ile resides. It might be kernel name of devices (should start with "/de=
v/"), UUID (prefixed with "UUID=3D") or label (prefix with "LABEL=3D").=
  You don't have to specify full UUID. Just its beginning will suffice,=
 even if its ambiguous. All matching devices will be probed. This param=
eter is recommended, but not required. If not present, all block device=
s will be probed, which may significantly increase boot time.</para>
+		  <para>If <replaceable>luksdev</replaceable> is given, the specifie=
d key will only be applied for that LUKS device. Possible values are th=
e same as for <replaceable>keydev</replaceable>. Unless you have severa=
l LUKS devices, you don't have to specify this parameter.</para>
+		  <para>The simplest usage is:</para>
+		  <programlisting>rd.luks.key=3D/foo/bar.key</programlisting>
+		  <para>As you see, you can skip colons in such case.</para>
           </listitem>
         </varlistentry>
       </variablelist>
commit 8844cd6b6cac908d7f81460838e3106af77d61a8
Author: Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Date:   Fri Nov 12 10:21:49 2010 +0100

    90crypt: probe for keydev asynchronously; changed kernel arg
   =20
    New kernel argument syntax for LUKS-keydev is introduced:
   =20
      rd.luks.key=3D<key_path>[:<key_dev>[:<luks_dev>]]
   =20
    Unfolding <key_dev> in BNF:
   =20
      <key_dev> ::=3D "UUID=3D" <uuid> | "LABEL=3D" <label> | <kname>
   =20
    Where <kname> matches following regular expression:
   =20
      ^/dev/.*
   =20
    <kname> need to be a character device and not a symlink for now.
   =20
    For every rd.luks.key argument udev rule is created.  That rule run=
s
    test to check whether matching device contains <key_path>.  If it d=
oes
    it's applied to matching <luks_dev>.

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-l=
ib.sh
new file mode 100644
index 0000000..eee60fb
--- /dev/null
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -0,0 +1,119 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+. /lib/dracut-lib.sh
+
+# Try to mount specified device (by path, by UUID or by label) and che=
ck
+# the path with 'test'.
+#
+# example:
+# test_dev -f LABEL=3D"nice label" /some/file1
+test_dev() {
+    local test_op=3D$1; local dev=3D"$2"; local f=3D"$3"
+    local ret=3D1; local mount_point=3D$(mkuniqdir /mnt testdev)
+    local path
+
+    [ -n "$dev" -a -n "$*" ] || return 1
+    [ -d "$mount_point" ] || die 'Mount point does not exist!'
+
+    if mount -r "$dev" "$mount_point" >/dev/null 2>&1; then
+        test $test_op "${mount_point}/${f}"
+        ret=3D$?
+        umount "$mount_point"
+    fi
+
+    rmdir "$mount_point"
+
+    return $ret
+}
+
+# Get kernel name for given device.  Device may be the name too (then =
the same
+# is returned), a symlink (full path), UUID (prefixed with "UUID=3D") =
or label
+# (prefixed with "LABEL=3D").  If just a beginning of the UUID is spec=
ified or
+# even an empty, function prints all device names which UUIDs match - =
every in
+# single line.
+#
+# NOTICE: The name starts with "/dev/".
+#
+# Example:
+#   devnames UUID=3D123
+# May print:
+#   /dev/dm-1
+#   /dev/sdb1
+#   /dev/sdf3
+devnames() {
+    local dev=3D"$1"; local d; local names
+
+    case "$dev" in
+    UUID=3D*)
+        dev=3D"$(foreach_uuid_until '! blkid -U $___' "${dev#UUID=3D}"=
)" \
+            && return 255
+        [ -z "$dev" ] && return 255
+        ;;
+    LABEL=3D*) dev=3D"$(blkid -L "${dev#LABEL=3D}")" || return 255 ;;
+    /dev/?*) ;;
+    *) return 255 ;;
+    esac
+
+    for d in $dev; do
+        names=3D"$names
+$(readlink -e -q "$d")" || return 255
+    done
+
+    echo "${names#
+}"
+}
+
+# match_dev devpattern dev
+#
+# Returns true if 'dev' matches 'devpattern'.  Both 'devpattern' and '=
dev' are
+# expanded to kernel names and then compared.  If name of 'dev' is on =
list of
+# names of devices matching 'devpattern', the test is positive.  'dev'=
 and
+# 'devpattern' may be anything which function 'devnames' recognizes.
+#
+# If 'devpattern' is empty or '*' then function just returns true.
+#
+# Example:
+#   match_dev UUID=3D123 /dev/dm-1
+# Returns true if /dev/dm-1 UUID starts with "123".
+match_dev() {
+    [ -z "$1" -o "$1" =3D '*' ] && return 0
+    local devlist; local dev
+
+    devlist=3D"$(devnames "$1")" || return 255
+    dev=3D"$(devnames "$2")" || return 255
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
+# Reads file <keysfile> produced by probe-keydev and looks for first l=
ine to
+# which device <for_dev> matches.  The successful result is printed in=
 format
+# "<keydev>|<keypath>".  When nothing found, just false is returned.
+#
+# Example:
+#   getkey /tmp/luks.keys /dev/sdb1
+# May print:
+#   /dev/sdc1|/keys/some.key
+getkey() {
+    local keys_file=3D"$1"; local for_dev=3D"$2"
+    local luks_dev; local key_dev; local key_path
+
+    [ -z "$keys_file" -o -z "$for_dev" ] && die 'getkey: wrong usage!'
+    [ -f "$keys_file" ] || return 1
+
+    while IFS=3D'|' read luks_dev key_dev key_path; do
+        if match_dev "$luks_dev" "$for_dev"; then
+            echo "${key_dev}|${key_path}"
+            return 0
+        fi
+    done < "$keys_file"
+
+    return 1
+}
diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cry=
ptroot-ask.sh
index 6c3acb6..bb8e81e 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -14,7 +14,7 @@
 # load dm_crypt if it is not already loaded
 [ -d /sys/module/dm_crypt ] || modprobe dm_crypt
=20
-. /lib/dracut-lib.sh
+. /lib/dracut-crypt-lib.sh
=20
 # default luksname - luks-UUID
 luksname=3D$2
@@ -26,6 +26,7 @@ else
     device=3D"$1"
 fi
=20
+# TODO: improve to support what cmdline does
 if [ -f /etc/crypttab ] && getargbool 1 rd.luks.crypttab -n rd_NO_CRYP=
TTAB; then
     while read name dev rest; do
         # ignore blank lines and comments
@@ -54,72 +55,30 @@ if [ -f /etc/crypttab ] && getargbool 1 rd.luks.cry=
pttab -n rd_NO_CRYPTTAB; then
 fi
=20
 #
-# Search key on external devices
-#
-
-# Try to mount device specified by UUID and probe for existence of any=
 of
-# the paths.  On success return 0 and print "<uuid> <first-existing-pa=
th>",
-# otherwise return 1.
-# Function leaves mount point created.
-probe_keydev() {
-    local uuid=3D"$1"; shift; local keypaths=3D"$*"
-    local ret=3D1; local mount_point=3D/mnt/keydev
-    local path
-
-    [ -n "${uuid}" -a -n "${keypaths}" ] || return 1
-    [ -d ${mount_point} ] || mkdir -p "${mount_point}" || return 1
-
-    if mount -r -U "${uuid}" "${mount_point}" 2>/dev/null >/dev/null; =
then
-        for path in ${keypaths}; do
-            if [ -f "${mount_point}/${path}" ]; then
-                echo "${uuid} ${path}"
-                ret=3D0
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
-keypaths=3D"$(getargs rd.luks.keypath rd_LUKS_KEYPATH)"
-unset keydev_uuid keypath
-
-if [ -n "$keypaths" ]; then
-    keydev_uuids=3D"$(getargs rd.luks.keydev.uuid rd_LUKS_KEYDEV_UUID)=
"
-    [ -n "$keydev_uuids" ] || {
-        warn 'No UUID of device storing LUKS key specified.'
-        warn 'It is recommended to set rd_LUKS_KEYDEV_UUID.'
-        warn 'Performing scan of *all* devices accessible by UUID...'
-    }
-    tmp=3D$(foreach_uuid_until "probe_keydev \$full_uuid $keypaths" \
-        $keydev_uuids) && {
-        keydev_uuid=3D"${tmp%% *}"
-        keypath=3D"${tmp#* }"
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
=20
 info "luksOpen $device $luksname"
=20
-if [ -n "$keydev_uuid" ]; then
-    mntp=3D/mnt/keydev
-    mkdir -p "$mntp"
-    mount -r -U "$keydev_uuid" "$mntp"
+if [ -n "$(getarg rd.luks.key)" ]; then
+    if tmp=3D$(getkey /tmp/luks.keys $device); then
+        keydev=3D"${tmp%%|*}"
+        keypath=3D"${tmp#*|}"
+    else
+        info "No key found for $device.  Will try later."
+        /sbin/initqueue --unique --onetime --settled \
+            --name cryptroot-ask-$luksname \
+            /sbin/cryptroot-ask "$@"
+        exit 0
+    fi
+    unset tmp
+
+    mntp=3D$(mkuniqdir /mnt keydev)
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
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
 # ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
 inst cryptsetup=20
+inst rmdir
+inst readlink
 inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
+inst "$moddir"/probe-keydev.sh /sbin/probe-keydev
+inst_hook cmdline 10 "$moddir/parse-keydev.sh"
 inst_hook cmdline 30 "$moddir/parse-crypt.sh"
 inst_hook pre-pivot 30 "$moddir/crypt-cleanup.sh"
 inst /etc/crypttab
+inst "$moddir/crypt-lib.sh" "/lib/dracut-crypt-lib.sh"
diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse=
-crypt.sh
index 3baad5f..0dca0d3 100755
--- a/modules.d/90crypt/parse-crypt.sh
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -11,10 +11,6 @@ else
     } > /etc/udev/rules.d/70-luks.rules
=20
     LUKS=3D$(getargs rd.luks.uuid rd_LUKS_UUID)
-    unset settled
-    [ -n "$(getargs rd.luks.keypath rd_LUKS_KEYPATH)" ] && \
-        [ -z "$(getargs rd.luks.keydev.uuid rd_LUKS_KEYDEV_UUID)" ] &&=
 \
-        settled=3D'--settled'
=20
     if [ -n "$LUKS" ]; then
         for luksid in $LUKS; do=20
@@ -22,7 +18,7 @@ else
             {
                 printf 'ENV{ID_FS_TYPE}=3D=3D"crypto_LUKS", '
                 printf 'ENV{ID_FS_UUID}=3D=3D"*%s*", ' $luksid
-                printf 'RUN+=3D"/sbin/initqueue --unique --onetime %s =
' "$settled"
+                printf 'RUN+=3D"/sbin/initqueue --unique --onetime '
                 printf -- '--name cryptroot-ask-%%k /sbin/cryptroot-as=
k '
                 printf '$env{DEVNAME} luks-$env{ID_FS_UUID}"\n'
             } >> /etc/udev/rules.d/70-luks.rules
@@ -35,7 +31,7 @@ else
             } >> /emergency/00-crypt.sh
         done
     else
-        echo 'ENV{ID_FS_TYPE}=3D=3D"crypto_LUKS", RUN+=3D"/sbin/initqu=
eue' $settled \
+        echo 'ENV{ID_FS_TYPE}=3D=3D"crypto_LUKS", RUN+=3D"/sbin/initqu=
eue' \
             '--unique --onetime --name cryptroot-ask-%k' \
             '/sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"'=
 \
             >> /etc/udev/rules.d/70-luks.rules
diff --git a/modules.d/90crypt/parse-keydev.sh b/modules.d/90crypt/pars=
e-keydev.sh
new file mode 100644
index 0000000..8712a46
--- /dev/null
+++ b/modules.d/90crypt/parse-keydev.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 sts=3D4 et filetype=3Dsh
+
+if getargbool 1 rd.luks -n rd_NO_LUKS && \
+        [ -n "$(getarg rd.luks.key)" ]; then
+    exec 7>/etc/udev/rules.d/65-luks-keydev.rules
+    echo 'SUBSYSTEM!=3D"block", GOTO=3D"luks_keydev_end"' >&7
+    echo 'ACTION!=3D"add|change", GOTO=3D"luks_keydev_end"' >&7
+
+    for arg in $(getargs rd.luks.key); do
+        unset keypath keydev luksdev
+        splitsep : "$arg" keypath keydev luksdev
+
+        info "rd.luks.key: keypath=3D'$keypath' keydev=3D'$keydev' luk=
sdev=3D'$luksdev'"
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
+            printf 'RUN+=3D"/sbin/initqueue --unique --onetime '
+            printf -- '--name probe-keydev-%%k '
+            printf '/sbin/probe-keydev /dev/%%k %s %s"\n' \
+                "${keypath}" "${luksdev}"
+        } >&7
+    done
+    unset arg keypath keydev luksdev
+
+    echo 'LABEL=3D"luks_keydev_end"' >&7
+    exec 7>&-
+fi
diff --git a/modules.d/90crypt/probe-keydev.sh b/modules.d/90crypt/prob=
e-keydev.sh
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
+real_keydev=3D"$1"; keypath=3D"$2"; luksdev=3D"$3"
+
+[ -z "$real_keydev" -o -z "$keypath" ] && die 'probe-keydev: wrong usa=
ge!'
+[ -z "$luksdev" ] && luksdev=3D'*'
+
+info "Probing $real_keydev for $keypath..."
+test_dev -f "$real_keydev" "$keypath" || exit 1
+
+info "Found $keypath on $real_keydev"
+echo "$luksdev|$real_keydev|$keypath" >> /tmp/luks.keys
commit ccb0ab73485baf5ff9e65729435bc599f96945e8
Author: Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Date:   Fri Nov 12 10:21:48 2010 +0100

    99base/dracut-lib.sh: 5 new functions & 1 modified
   =20
    New:
      str_starts, str_replace
      funiq - print new unique file name
      mkuniqdir - create and print new unique dir
      splitsep - splits given string 'str' with separator 'sep' into va=
rs
      udevmatch - create udev rule match for a device
   =20
    Modified:
      foreach_uuid_until - use $___ as a place holder

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-l=
ib.sh
index 596dae2..f0c030b 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -6,6 +6,29 @@ strstr() {
     [ "${1#*$2*}" !=3D "$1" ]
 }
=20
+# returns OK if $1 contains $2 at the beginning
+str_starts() {
+    [ "${1#$2*}" !=3D "$1" ]
+}
+
+# replaces all occurrences of 'search' in 'str' with 'replacement'
+#
+# str_replace str search replacement
+#
+# example:
+# str_replace '  one two  three  ' ' ' '_'
+str_replace() {
+    local in=3D"$1"; local s=3D"$2"; local r=3D"$3"
+    local out=3D''
+
+    while strstr "${in}" "$s"; do
+        chop=3D"${in%%$s*}"
+        out=3D"${out}${chop# }$r"
+        in=3D"${in#*$s}"
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
=20
+# Splits given string 'str' with separator 'sep' into variables 'var1'=
, 'var2',
+# 'varN'.  If number of fields is less than number of variables, remai=
ning are
+# not set.  If number of fields is greater than number of variables, t=
he last
+# variable takes remaining fields.  In short - it acts similary to 're=
ad'.
+#
+# splitsep sep str var1 var2 varN
+#
+# example:
+#   splitsep ':' 'foo:bar:baz' v1 v2
+# in result:
+#   v1=3D'foo', v2=3D'bar:baz'
+#
+# TODO: ':' inside fields.
+splitsep() {
+    local sep=3D"$1"; local str=3D"$2"; shift 2
+    local tmp
+
+    while [ -n "$str" -a -n "$*" ]; do
+        tmp=3D"${str%%:*}"
+        eval "$1=3D${tmp}"
+        str=3D"${str#$tmp}"
+        str=3D"${str#:}"
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
=20
-# Evaluate command for UUIDs either given as arguments for this functi=
on or all
+# Create udev rule match for a device with its device name, or the ude=
v property
+# ID_FS_UUID or ID_FS_LABEL
+#
+# example:
+#   udevmatch LABEL=3Dboot
+# prints:
+#   ENV{ID_FS_LABEL}=3D"boot"
+#
+# TOOD: symlinks
+udevmatch() {
+    case "$1" in
+    UUID=3D????????-????-????-????-????????????|LABEL=3D*)
+        printf 'ENV{ID_FS_%s}=3D=3D"%s"' "${1%%=3D*}" "${1#*=3D}"
+        ;;
+    UUID=3D*)
+        printf 'ENV{ID_FS_UUID}=3D=3D"%s*"' "${1#*=3D}"
+        ;;
+    /dev/?*) printf 'KERNEL=3D=3D"%s"' "${1#/dev/}" ;;
+    *) return 255 ;;
+    esac
+}
+
+# Prints unique path for potential file inside specified directory.  I=
t consists
+# of specified directory, prefix and number at the end which is increm=
ented
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
+    local dir=3D"$1"; local prefix=3D"$2"
+    local i=3D0
+
+    [ -d "${dir}" ] || return 1
+
+    while [ -e "${dir}/${prefix}$i" ]; do
+        i=3D$(($i+1)) || return 1
+    done
+
+    echo "${dir}/${prefix}$i"
+}
+
+# Creates unique directory and prints its path.  It's using funiq to g=
enerate
+# path.
+#
+# mkuniqdir subdir new_dir_name
+mkuniqdir() {
+    local dir=3D"$1"; local prefix=3D"$2"
+    local retdir; local retdir_new
+
+    [ -d "${dir}" ] || mkdir -p "${dir}" || return 1
+
+    retdir=3D$(funiq "${dir}" "${prefix}") || return 1
+    until mkdir "${retdir}" 2>/dev/null; do
+        retdir_new=3D$(funiq "${dir}" "${prefix}") || return 1
+        [ "$retdir_new" =3D "$retdir" ] && return 1
+        retdir=3D"$retdir_new"
+    done
+
+    echo "${retdir}"
+}
+
+# Evaluates command for UUIDs either given as arguments for this funct=
ion or all
 # listed in /dev/disk/by-uuid.  UUIDs doesn't have to be fully specifi=
ed.  If
-# beginning is given it is expanded to all matching UUIDs.  To pass fu=
ll UUID
-# to your command use '${full_uuid}'.  Remember to escape '$'!
+# beginning is given it is expanded to all matching UUIDs.  To pass fu=
ll UUID to
+# your command use '$___' as a place holder.  Remember to escape '$'!
+#
+# foreach_uuid_until [ -p prefix ] command UUIDs
 #
-# $1 =3D command to be evaluated
-# $2 =3D list of UUIDs separated by space
+# prefix - string to put just before $___
+# command - command to be evaluated
+# UUIDs - list of UUIDs separated by space
 #
 # The function returns after *first successful evaluation* of the give=
n command
 # with status 0.  If evaluation fails for every UUID function returns =
with
 # status 1.
 #
 # Example:
-# foreach_uuid_until "mount -U \${full_uuid} /mnt; echo OK; umount /mn=
t" \
+# foreach_uuid_until "mount -U \$___ /mnt; echo OK; umount /mnt" \
 #       "01234 f512 a235567f-12a3-c123-a1b1-01234567abcb"
 foreach_uuid_until() (
     cd /dev/disk/by-uuid
=20
+    [ "$1" =3D -p ] && local prefix=3D"$2" && shift 2
     local cmd=3D"$1"; shift; local uuids_list=3D"$*"
-    local uuid; local full_uuid
+    local uuid; local full_uuid; local ___
=20
     [ -n "${cmd}" ] || return 1
=20
     for uuid in ${uuids_list:-*}; do
         for full_uuid in ${uuid}*; do
             [ -e "${full_uuid}" ] || continue
+            ___=3D"${prefix}${full_uuid}"
             eval ${cmd} && return 0
         done
     done
-----------------------------------------------------------------------

Summary of changes:
 dracut.kernel.7.xml                |   23 +++----
 modules.d/90crypt/crypt-lib.sh     |  119 ++++++++++++++++++++++++++++=
+++
 modules.d/90crypt/cryptroot-ask.sh |   79 +++++----------------
 modules.d/90crypt/install          |    5 ++
 modules.d/90crypt/parse-crypt.sh   |    8 +--
 modules.d/90crypt/parse-keydev.sh  |   41 +++++++++++
 modules.d/90crypt/probe-keydev.sh  |   15 ++++
 modules.d/99base/dracut-lib.sh     |  137 ++++++++++++++++++++++++++++=
++++++--
 8 files changed, 340 insertions(+), 87 deletions(-)
 create mode 100644 modules.d/90crypt/crypt-lib.sh
 create mode 100644 modules.d/90crypt/parse-keydev.sh
 create mode 100755 modules.d/90crypt/probe-keydev.sh


--=20
dracut - Initramfs generator using udev
