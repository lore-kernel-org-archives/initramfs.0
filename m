From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] base: Don't wait for swap devices in host-only mode.
Date: Fri, 15 May 2015 14:53:40 +0100
Message-ID: <1431698021-16626-2-git-send-email-colin@mageia.org>
References: <1431698021-16626-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431698021-16626-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

The only reason we add swap devices to host-only mode (added in
dd5875499ece9dbc90e10eafd0073ee15d0c86a4) is to allow us to process
resume= arguments passed on the kernel command line when the swap
partition lives on something slightly more complex than a normal
partion (e.g. in an LVM or RAID setup).

By adding the device to host_devs, the necessary LVM and RAID hooks
are added and thus the underlying storage will be initialised OK, and
the 95resume module handles the waiting for the device (via udev rules
creating the /dev/resume symlink).

So ultimately, we do not need to hard-code the waiting for the swap
devices into the initramfs at build time as the waiting part can be
dynamic.

This makes things more resiliant to swap partitions disappearing and
being reformatted etc.

Inspired by a patch by Martin Whitaker on Mageia bug:
https://bugs.mageia.org/show_bug.cgi?id=12305
---
 dracut.sh                        | 6 ++++--
 modules.d/99base/module-setup.sh | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 6215b36..ec48015 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1223,7 +1223,9 @@ if [[ $hostonly ]]; then
                     done < /etc/crypttab
                 fi
 
-                push_host_devs "$(readlink -f "$dev")"
+                _dev="$(readlink -f "$dev")"
+                push_host_devs "$_dev"
+                push swap_devs "$_dev"
                 break
             done < /etc/fstab
         done < /proc/swaps
@@ -1334,7 +1336,7 @@ export initdir dracutbasedir \
     omit_drivers mdadmconf lvmconf root_dev \
     use_fstab fstab_lines libdirs fscks nofscks ro_mnt \
     stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
-    debug host_fs_types host_devs sshkey add_fstab \
+    debug host_fs_types host_devs swap_devs sshkey add_fstab \
     DRACUT_VERSION udevdir prefix filesystems drivers \
     systemdutildir systemdsystemunitdir systemdsystemconfdir \
     host_modalias host_modules hostonly_cmdline loginstall \
diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index fd65cdf..bbc68ba 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -103,6 +103,14 @@ install() {
 
                 for _dev in ${host_devs[@]}; do
                     [[ "$_dev" == "$root_dev" ]] && continue
+
+                    # We only actually wait for real devs - swap is only needed
+                    # for resume and udev rules generated when parsing resume=
+                    # argument take care of the waiting for us
+                    for _dev2 in ${swap_devs[@]}; do
+                      [[ "$_dev" == "$_dev2" ]] && continue 2
+                    done
+
                     _pdev=$(get_persistent_dev $_dev)
 
                     case "$_pdev" in
-- 
2.3.2
