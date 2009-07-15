From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 07/14] remove partitions from raid devices before they are used for something else
Date: Wed, 15 Jul 2009 18:50:39 +0200
Message-ID: <1247676646-3837-8-git-send-email-harald@redhat.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/90dmraid/61-dmraid-imsm.rules         |    6 ++++++
 modules.d/90dmraid/61-dmraid.rules              |    5 +++++
 modules.d/90dmraid/dmraid.sh                    |    2 +-
 modules.d/90mdraid/61-mdadm.rules               |    5 +++++
 modules.d/90mdraid/65-md-incremental-imsm.rules |    6 ++++++
 modules.d/90mdraid/65-md-incremental.rules      |    5 +++++
 6 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/modules.d/90dmraid/61-dmraid-imsm.rules b/modules.d/90dmraid/61-dmraid-imsm.rules
index 3b3eb7f..6bcf052 100644
--- a/modules.d/90dmraid/61-dmraid-imsm.rules
+++ b/modules.d/90dmraid/61-dmraid-imsm.rules
@@ -12,4 +12,10 @@ ENV{ID_FS_TYPE}=="*_raid_member", \
     TEST!="/tmp/.dmraid_scan-%k", \
     RUN+="/bin/sh -c '>/tmp/.dmraid_scan-%k; /bin/ln -fs /sbin/dmraid_scan /initqueue/dmraid_scan.sh'"
 
+
+ENV{ID_FS_TYPE}=="*_raid_member", \
+    TEST!="/tmp/.dmraid_scan-%k", \
+    ATTR{partition}!="?*", \
+    RUN+="/sbin/partx -d $env{DEVNAME}"
+
 LABEL="dm_end"
diff --git a/modules.d/90dmraid/61-dmraid.rules b/modules.d/90dmraid/61-dmraid.rules
index c4c1717..7a5f9af 100644
--- a/modules.d/90dmraid/61-dmraid.rules
+++ b/modules.d/90dmraid/61-dmraid.rules
@@ -11,4 +11,9 @@ ENV{ID_FS_TYPE}=="*_raid_member", \
     TEST!="/tmp/.dmraid_scan-%k", \
     RUN+="/bin/sh -c '>/tmp/.dmraid_scan-%k; /bin/ln -fs /sbin/dmraid_scan /initqueue/dmraid_scan.sh'"
 
+ENV{ID_FS_TYPE}=="*_raid_member", \
+    TEST!="/tmp/.dmraid_scan-%k", \
+    ATTR{partition}!="?*", \
+    RUN+="/sbin/partx -d $env{DEVNAME}"
+
 LABEL="dm_end"
diff --git a/modules.d/90dmraid/dmraid.sh b/modules.d/90dmraid/dmraid.sh
index 4a14722..f6cb26f 100755
--- a/modules.d/90dmraid/dmraid.sh
+++ b/modules.d/90dmraid/dmraid.sh
@@ -3,6 +3,6 @@
 if $UDEV_QUEUE_EMPTY >/dev/null 2>&1; then
     [ -h "$job" ] && rm -f "$job"
     # run dmraid if udev has settled
-    dmraid -ay -Z
+    dmraid -ay 
 fi
 
diff --git a/modules.d/90mdraid/61-mdadm.rules b/modules.d/90mdraid/61-mdadm.rules
index 18b1627..23c5baf 100644
--- a/modules.d/90mdraid/61-mdadm.rules
+++ b/modules.d/90mdraid/61-mdadm.rules
@@ -12,4 +12,9 @@ ENV{ID_FS_TYPE}=="linux_raid_member", \
     RUN+="/sbin/mdadm -I $env{DEVNAME}", \
     RUN+="/bin/sh -c '>/tmp/.mdraid_start-%k; /bin/ln -s /sbin/mdraid_start /initqueue/mdraid_start.sh'"
 
+ENV{ID_FS_TYPE}=="linux_raid_member", \
+    TEST!="/tmp/.mdraid_start-%k", \
+    ATTR{partition}!="?*", \
+    RUN+="/sbin/partx -d $env{DEVNAME}"
+
 LABEL="raid_end"
diff --git a/modules.d/90mdraid/65-md-incremental-imsm.rules b/modules.d/90mdraid/65-md-incremental-imsm.rules
index 7dcdf33..edef6b0 100644
--- a/modules.d/90mdraid/65-md-incremental-imsm.rules
+++ b/modules.d/90mdraid/65-md-incremental-imsm.rules
@@ -8,3 +8,9 @@ SUBSYSTEM=="block", ACTION=="add", \
 	IMPORT{program}="/sbin/mdadm --examine --export $tempnode", \
 	RUN+="/sbin/mdadm -I --no-degraded $env{DEVNAME}", \
 	RUN+="/bin/sh -c '>/tmp/.mdraid_start-%k; /bin/ln -s /sbin/mdraid_start /initqueue/mdraid_start.sh'"
+
+SUBSYSTEM=="block", ACTION=="add", \
+        ENV{ID_FS_TYPE}=="linux_raid_member|isw_raid_member", \
+        TEST!="/tmp/.mdraid_start-%k", \
+	ATTR{partition}!="?*", \
+	RUN+="/sbin/partx -d $env{DEVNAME}"
diff --git a/modules.d/90mdraid/65-md-incremental.rules b/modules.d/90mdraid/65-md-incremental.rules
index 203b1c9..f679c4b 100644
--- a/modules.d/90mdraid/65-md-incremental.rules
+++ b/modules.d/90mdraid/65-md-incremental.rules
@@ -7,3 +7,8 @@ SUBSYSTEM=="block", ACTION=="add", ENV{ID_FS_TYPE}=="linux_raid_member", \
 	IMPORT{program}="/sbin/mdadm --examine --export $tempnode", \
 	RUN+="/sbin/mdadm -I $env{DEVNAME}", \
 	RUN+="/bin/sh -c '>/tmp/.mdraid_start-%k; /bin/ln -s /sbin/mdraid_start /initqueue/mdraid_start.sh'"
+
+SUBSYSTEM=="block", ACTION=="add", ENV{ID_FS_TYPE}=="linux_raid_member", \
+        TEST!="/tmp/.mdraid_start-%k", \
+	ATTR{partition}!="?*", \
+	RUN+="/sbin/partx -d $env{DEVNAME}"
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
