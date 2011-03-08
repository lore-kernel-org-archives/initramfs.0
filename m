From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/7] Use 'btrfs' command rather than 'btrfsctl', and install btrfs driver
Date: Tue,  8 Mar 2011 18:35:15 -0500
Message-ID: <1299627317-11145-6-git-send-email-wwoods@redhat.com>
References: <1299627317-11145-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1299627317-11145-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

btrfsctl is being replaced by the btrfs command in the upstream
tools, so change accordingly. Also, if we're using the btrfs module
we should probably make sure the btrfs driver gets installed.
---
 modules.d/90btrfs/80-btrfs.rules  |    2 +-
 modules.d/90btrfs/module-setup.sh |   10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/modules.d/90btrfs/80-btrfs.rules b/modules.d/90btrfs/80-btrfs.rules
index 92c8553..7c98d98 100644
--- a/modules.d/90btrfs/80-btrfs.rules
+++ b/modules.d/90btrfs/80-btrfs.rules
@@ -2,7 +2,7 @@ SUBSYSTEM!="block", GOTO="btrfs_end"
 ACTION!="add|change", GOTO="btrfs_end"
 
 ENV{ID_FS_TYPE}=="btrfs", RUN+="/sbin/modprobe btrfs"
-ENV{ID_FS_TYPE}=="btrfs", RUN+="/sbin/btrfsctl -A $env{DEVNAME}"
+ENV{ID_FS_TYPE}=="btrfs", RUN+="/sbin/btrfs device scan $env{DEVNAME}"
 
 LABEL="btrfs_end"
 
diff --git a/modules.d/90btrfs/module-setup.sh b/modules.d/90btrfs/module-setup.sh
index 0503e1d..765d960 100755
--- a/modules.d/90btrfs/module-setup.sh
+++ b/modules.d/90btrfs/module-setup.sh
@@ -3,9 +3,9 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 check() {
-    # if we don't have btrfs (btrfsctl) installed on the host system,
+    # if we don't have btrfs installed on the host system,
     # no point in trying to support it in the initramfs.
-    type -P btrfsctl >/dev/null || return 1
+    type -P btrfs >/dev/null || return 1
 
     . $dracutfunctions
     [[ $debug ]] && set -x
@@ -27,8 +27,12 @@ depends() {
     return 0
 }
 
+installkernel() {
+    instmods btrfs
+}
+
 install() {
     inst_rules "$moddir/80-btrfs.rules"
-    dracut_install btrfsctl
+    dracut_install btrfs
 }
 
-- 
1.7.4
