From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] Provide infrastructure to include udev hwdb files.
Date: Tue, 12 Nov 2013 10:38:59 +0100
Message-ID: <1384249140-20683-2-git-send-email-colin@mageia.org>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384249140-20683-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

This is needed to provide keyboard support for some models of
keyboard which have now been converted over to the new format.
---
 dracut-functions.sh | 29 +++++++++++++++++++++++++++++
 dracut.sh           |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 2872516..6ca6444 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -926,6 +926,35 @@ prepare_udev_rules() {
     done
 }
 
+# udev hwdb files always get installed in the same place, so
+# create a function to install them to make life simpler.
+inst_hwdb() {
+    local _target=/etc/udev/hwdb.d _hwdb _found
+
+    #inst_dir "${udevdir}/hwdb.d"
+    #inst_dir "$_target"
+    for _hwdb in "$@"; do
+        if [ "${_hwdb#/}" = "$_hwdb" ]; then
+            for r in ${udevdir}/hwdb.d ${hostonly:+/etc/udev/hwdb.d}; do
+                if [[ -e $r/$_hwdb ]]; then
+                    _found="$r/$_hwdb"
+                    inst_simple "$_found"
+                fi
+            done
+        fi
+        [[ $_found ]] || dinfo "Skipping udev hwdb: $_hwdb"
+    done
+}
+
+consolidate_hwdb() {
+    if [[ -d "${initdir}/etc/udev/hwdb.d" || -d "${initdir}/${udevdir}/hwdb.d" ]]; then
+        dinfo "*** Consolidating udev hwdb ***"
+        udevadm hwdb --root="${initdir}" --update
+        rm -rf "${initdir}/etc/udev/hwdb.d" "${initdir}/${udevdir}/hwdb.d"
+    fi
+}
+
+
 # install function specialized for hooks
 # $1 = type of hook, $2 = hook priority (lower runs first), $3 = hook
 # All hooks should be POSIX/SuS compliant, they will be sourced by init.
diff --git a/dracut.sh b/dracut.sh
index 03472ba..9711907 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1370,6 +1370,9 @@ if [[ $acpi_override = yes ]] && [[ -d $acpi_table_dir ]]; then
 fi
 
 rm -f -- "$outfile"
+
+consolidate_hwdb
+
 dinfo "*** Creating image file ***"
 if [[ $create_early_cpio = yes ]]; then
     # The microcode blob is _before_ the initramfs blob, not after
-- 
1.8.4.2
