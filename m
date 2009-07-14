From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] Make Intel BIOS raid use mdraid instead of dmraid when mdadm 3.0 is available
Date: Tue, 14 Jul 2009 22:24:42 +0200
Message-ID: <1247603083-3513-2-git-send-email-hdegoede@redhat.com>
References: <1247603083-3513-1-git-send-email-hdegoede@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247603083-3513-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Intel BIOS raid is being shifted from dmraid to mdraid because mdraid offers
more features. So if an imsm metadata capable mdadm is present use mdraid
instead of dmraid for isw_raid_member's

This patch also adds code to mdraid_start.sh so that the raidsets
inside the imsm containers get started once udev is done probing
(doing this earlier leads to potentially degraded use of the sets and
 an unwanted resync).
---
 modules.d/90dmraid/61-dmraid-imsm.rules         |   15 +++++++++++++++
 modules.d/90dmraid/install                      |    6 +++++-
 modules.d/90mdraid/65-md-incremental-imsm.rules |   10 ++++++++++
 modules.d/90mdraid/install                      |    8 ++++++--
 modules.d/90mdraid/mdraid_start.sh              |   11 ++++++++++-
 5 files changed, 46 insertions(+), 4 deletions(-)
 create mode 100644 modules.d/90dmraid/61-dmraid-imsm.rules
 create mode 100644 modules.d/90mdraid/65-md-incremental-imsm.rules

diff --git a/modules.d/90dmraid/61-dmraid-imsm.rules b/modules.d/90dmraid/61-dmraid-imsm.rules
new file mode 100644
index 0000000..e06ea3f
--- /dev/null
+++ b/modules.d/90dmraid/61-dmraid-imsm.rules
@@ -0,0 +1,15 @@
+# This file causes block devices with Linux RAID (mdadm) signatures to
+# automatically cause mdadm to be run.
+# See udev(8) for syntax
+
+SUBSYSTEM!="block", GOTO="dm_end"
+ACTION!="add|change", GOTO="dm_end"
+
+ENV{ID_FS_TYPE}=="linux_raid_member", GOTO="dm_end"
+ENV{ID_FS_TYPE}=="isw_raid_member", GOTO="dm_end"
+
+ENV{ID_FS_TYPE}=="*_raid_member", \
+    TEST!="/tmp/.dmraid_scan-%k", \
+    RUN+="/bin/sh -c '>/tmp/.dmraid_scan-%k; /bin/ln -fs /sbin/dmraid_scan /initqueue/dmraid_scan.sh'"
+
+LABEL="dm_end"
diff --git a/modules.d/90dmraid/install b/modules.d/90dmraid/install
index fadaf0f..d8aca57 100755
--- a/modules.d/90dmraid/install
+++ b/modules.d/90dmraid/install
@@ -2,4 +2,8 @@
 dracut_install dmraid
 inst "$moddir/dmraid.sh" /sbin/dmraid_scan
 inst_rules 64-md-raid.rules
-inst_rules "$moddir/61-dmraid.rules"
+if [ ! -x /lib/udev/vol_id ] && mdadm -Q -e imsm /dev/null &> /dev/null; then
+    inst_rules "$moddir/61-dmraid-imsm.rules"
+else
+    inst_rules "$moddir/61-dmraid.rules"
+fi
diff --git a/modules.d/90mdraid/65-md-incremental-imsm.rules b/modules.d/90mdraid/65-md-incremental-imsm.rules
new file mode 100644
index 0000000..7dcdf33
--- /dev/null
+++ b/modules.d/90mdraid/65-md-incremental-imsm.rules
@@ -0,0 +1,10 @@
+# This file causes block devices with Linux RAID (mdadm) signatures to
+# automatically cause mdadm to be run.
+# See udev(8) for syntax
+
+SUBSYSTEM=="block", ACTION=="add", \
+        ENV{ID_FS_TYPE}=="linux_raid_member|isw_raid_member", \
+        TEST!="/tmp/.mdraid_start-%k", \
+	IMPORT{program}="/sbin/mdadm --examine --export $tempnode", \
+	RUN+="/sbin/mdadm -I --no-degraded $env{DEVNAME}", \
+	RUN+="/bin/sh -c '>/tmp/.mdraid_start-%k; /bin/ln -s /sbin/mdraid_start /initqueue/mdraid_start.sh'"
diff --git a/modules.d/90mdraid/install b/modules.d/90mdraid/install
index eef6567..0391957 100755
--- a/modules.d/90mdraid/install
+++ b/modules.d/90mdraid/install
@@ -12,7 +12,11 @@ instmods =drivers/md
 if [ -x /lib/udev/vol_id ]; then
     inst_rules "$moddir/61-mdadm.rules"
 else
-    inst_rules "$moddir/65-md-incremental.rules"
+    if mdadm -Q -e imsm /dev/null &> /dev/null; then
+        inst_rules "$moddir/65-md-incremental-imsm.rules"
+    else
+        inst_rules "$moddir/65-md-incremental.rules"
+    fi
     inst_rules 64-md-raid.rules
 fi
 
@@ -24,4 +28,4 @@ if [ -x  /sbin/mdmon ] ; then
 fi 
 
 inst "$moddir/mdraid_start.sh" /sbin/mdraid_start
-
+inst grep
diff --git a/modules.d/90mdraid/mdraid_start.sh b/modules.d/90mdraid/mdraid_start.sh
index 3475b7e..7293ded 100755
--- a/modules.d/90mdraid/mdraid_start.sh
+++ b/modules.d/90mdraid/mdraid_start.sh
@@ -4,5 +4,14 @@ if $UDEV_QUEUE_EMPTY >/dev/null 2>&1; then
     [ -h "$job" ] && rm -f "$job"
     # run mdadm if udev has settled
     mdadm -IRs
+    # and activate any containers
+    for md in /dev/md?*; do
+        case $md in
+            /dev/md*p*) ;;
+            *)
+                if mdadm --export --detail $md | grep -q container; then
+                    mdadm -IR $md
+                fi
+        esac
+    done
 fi
-
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
