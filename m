From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 07/15] Enhance suse.conf and debug module example with SUSE-specific settings
Date: Fri, 21 Nov 2014 14:20:43 +0100
Message-ID: <1416576051-62838-8-git-send-email-trenn@suse.de>
References: <1416576051-62838-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416576051-62838-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org

SUSE is using specific settings for dracut, so add them
to the suse.conf.example file.

Add vi and find to the debug module add some help text to the suse.conf
file when and how to use it.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut.conf.d/suse.conf.example   | 21 +++++++++++++++++++++
 modules.d/95debug/module-setup.sh |  3 +--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/dracut.conf.d/suse.conf.example b/dracut.conf.d/suse.conf.example
index 1e7f80e..37ffd72 100644
--- a/dracut.conf.d/suse.conf.example
+++ b/dracut.conf.d/suse.conf.example
@@ -1,3 +1,24 @@
+# SUSE specifc dracut settings
+#
+# SUSE by default always builds a as small as possible initrd for performance
+# and resource reasons.
+# If you like to build a generic initrd which works on other platforms than
+# on the one dracut/mkinitrd got called comment out below setting(s).
+hostonly="yes"
+hostonly_cmdline="yes"
+
+compress="xz -0 --check=crc32 --memlimit-compress=50%"
+
 i18n_vars="/etc/sysconfig/language:RC_LANG-LANG,RC_LC_ALL-LC_ALL /etc/sysconfig/console:CONSOLE_UNICODEMAP-FONT_UNIMAP,CONSOLE_FONT-FONT,CONSOLE_SCREENMAP-FONT_MAP /etc/sysconfig/keyboard:KEYTABLE-KEYMAP"
 omit_drivers+=" i2o_scsi"
 
+# Below adds additional tools to the initrd which are not urgently necessary to
+# bring up the system, but help to debug problems.
+# See /usr/lib/dracut/modules.d/95debug/module-setup.sh which additional tools
+# are installed and add more if you need them. This specifically helps if you
+# use:
+# rd.break=[cmdline|pre-udev|pre-trigger|initqueue|pre-mount|
+# mount|pre-pivot|cleanup]
+# boot parameter or if you are forced to enter the dracut emergency shell.
+
+# add_dracutmodules+=debug
diff --git a/modules.d/95debug/module-setup.sh b/modules.d/95debug/module-setup.sh
index 625f7fb..5a9aaac 100755
--- a/modules.d/95debug/module-setup.sh
+++ b/modules.d/95debug/module-setup.sh
@@ -14,8 +14,7 @@ depends() {
 # called by dracut
 install() {
     inst_multiple -o ps grep more cat rm strace free showmount \
-        ping netstat rpcinfo vi scp ping6 ssh \
+        ping netstat rpcinfo vi scp ping6 ssh find vi \
         fsck fsck.ext2 fsck.ext4 fsck.ext3 fsck.ext4dev fsck.vfat e2fsck
-
 }
 
-- 
1.8.5.2
