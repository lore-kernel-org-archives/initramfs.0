From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/2] 90crypt: rem. key-media - support for labels and normal dev names
Date: Mon,  4 Oct 2010 00:44:46 +0200
Message-ID: <1286145886-16322-2-git-send-email-aidecoe@aidecoe.name>
References: <1286145886-16322-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286145886-16322-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

90crypt: scan for devices several times instead of just once

The patch introduces support for labels and normal dev names for
removable media storing key for LUKS.  Previously only UUID was
possible.  rd_LUKS_KEYDEV_UUID changes to rd_LUKS_KEYDEV which takes dev
names as in /etc/fstab (e.g.: rd_LUKS_KEYDEV=LABEL=boot).

It also fixes problem with devices not discovered on time by retrying
(for default 3 times with incrementing sleep period) the scan.

probe_keydev informs now which device it checks.

Moreover code (the rem. dev. part) is refactorized.
---
 dracut.kernel.7.xml                |   13 ++--
 modules.d/90crypt/cryptroot-ask.sh |  108 +++++++++++++++++++++++-------------
 modules.d/90crypt/install          |    1 +
 3 files changed, 77 insertions(+), 45 deletions(-)

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index 0dc1ce8..8c0ae6c 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -324,25 +324,24 @@ This parameter can be specified multiple times.</para>
       </variablelist>
     </refsect2>
     <refsect2>
-      <title>crypt LUKS - experimental removable keys support</title>
-      <para>works only when plymouth module is not included</para>
+      <title>crypt LUKS - keys on removable device</title>
       <variablelist>
         <varlistentry>
           <term>
             <envar>rd_LUKS_KEYPATH=</envar>
-            <replaceable>&lt;path to keyfile&gt;</replaceable>
+            <replaceable>&lt;path&gt;</replaceable>
           </term>
           <listitem>
-            <para>path to keyfile inside remove device filesystem</para>
+            <para>Path to keyfile inside removable device filesystem. May be specified multiple times - all paths will be checked.</para>
           </listitem>
         </varlistentry>
         <varlistentry>
           <term>
-            <envar>rd_LUKS_KEYDEV_UUID=</envar>
-            <replaceable>&lt;rem. device uuid&gt;</replaceable>
+            <envar>rd_LUKS_KEYDEV=</envar>
+            <replaceable>&lt;device&gt;</replaceable>
           </term>
           <listitem>
-            <para>UUID of removalbe device storing keyfile; UUID doesn&apos;t have to be exact just like for <envar>rd_LUKS_UUID</envar></para>
+            <para>Device storing keyfile.  It might be normal path (/dev/sdc1) or label (LABEL="Linux boot") or UUID.  UUID doesn't have to be exact just like for <envar>rd_LUKS_UUID</envar>.  <envar>rd_LUKS_KEYDEV</envar> isn't required.  If not specified all devices accessible by UUID will be probed for keys listed in <envar>rd_LUKS_KEYPATH</envar>s.</para>
           </listitem>
         </varlistentry>
       </variablelist>
diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 45b5fe7..75f4bbc 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -57,54 +57,87 @@ fi
 # Search key on external devices
 #
 
-# Try to mount device specified by UUID and probe for existence of any of
-# the paths.  On success return 0 and print "<uuid> <first-existing-path>",
-# otherwise return 1.
-# Function leaves mount point created.
+# Try to mount specified device (by path, by UUID or by label) and probe for
+# existence of any of the paths.  On success return 0 and print
+# "<device>\t<first-existing-path>", otherwise return 1.
+#
+# probe_keydev LABEL="LUKS keys" /test.key /keys/test.key
 probe_keydev() {
-    local uuid="$1"; shift; local keypaths="$*"
-    local ret=1; local mount_point=/mnt/keydev
+    local dev="$1"; shift
+    local ret=1; local mount_point=$(mkuniqdir /mnt keydev)
     local path
 
-    [ -n "${uuid}" -a -n "${keypaths}" ] || return 1
-    [ -d ${mount_point} ] || mkdir -p "${mount_point}" || return 1
+    [ -n "${dev}" -a -n "$*" ] || return 1
+    [ -d "${mount_point}" ] || die 'Mount point does not exist!'
 
-    if mount -r -U "${uuid}" "${mount_point}" 2>/dev/null >/dev/null; then
-        for path in ${keypaths}; do
+    info "cryptroot-ask: Probing ${dev}..."
+    if mount -r "${dev}" "${mount_point}" >/dev/null 2>&1; then
+        for path in "$@"; do
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
+# Search LUKS key for encrypted device.
+#
+# func. args:
+#   $1 = encrypted device
+#   $2 = tries (optional; default is 3)
+#
+# kernel cmdline args:
+#   rd_LUKS_KEYPATH
+#   rd_LUKS_KEYDEV
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
@@ -112,14 +145,13 @@ unset keypaths
 
 info "luksOpen $device $luksname"
 
-if [ -n "$keydev_uuid" ]; then
-    mntp=/mnt/keydev
-    mkdir -p "$mntp"
-    mount -r -U "$keydev_uuid" "$mntp"
+if [ -n "$keydev" ]; then
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
-- 
1.7.3
