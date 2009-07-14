From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] Tell the kernel to forget about partitions found on raw imsm raid disks
Date: Tue, 14 Jul 2009 22:24:43 +0200
Message-ID: <1247603083-3513-3-git-send-email-hdegoede@redhat.com>
References: <1247603083-3513-1-git-send-email-hdegoede@redhat.com>
 <1247603083-3513-2-git-send-email-hdegoede@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247603083-3513-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

When using a simple raid mirror, the kernel will find a valid partition
table on the raw disks, so partitions of the set can not only be
accessed through the mdraid subsystem but also through /dev/rawdisk#,
this is very undesirable.

This patch call a new rm_partitions utility on the raw disks of
an imsm raidset when using mdraid for it, for dmraid we have
the -Z option to dmraid, although this assumes that nothing touches
the raw partitions between the initial disk add event and dmraid running
(once udev is done probing) so it might be better to switch to
the same mechanism for dmraid too.

This patch currently assumes this new utility (code included) will become
part of udev and will live in /lib/udev, for now it is probably a good idea
to include this utility with dracut as we are doing with switch_root
---
 modules.d/90mdraid/65-md-incremental-imsm.rules |    1 +
 modules.d/90mdraid/install                      |    1 +
 rm_partitions.c                                 |   78 +++++++++++++++++++++++
 3 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100644 rm_partitions.c

diff --git a/modules.d/90mdraid/65-md-incremental-imsm.rules b/modules.d/90mdraid/65-md-incremental-imsm.rules
index 7dcdf33..9617d6d 100644
--- a/modules.d/90mdraid/65-md-incremental-imsm.rules
+++ b/modules.d/90mdraid/65-md-incremental-imsm.rules
@@ -6,5 +6,6 @@ SUBSYSTEM=="block", ACTION=="add", \
         ENV{ID_FS_TYPE}=="linux_raid_member|isw_raid_member", \
         TEST!="/tmp/.mdraid_start-%k", \
 	IMPORT{program}="/sbin/mdadm --examine --export $tempnode", \
+	RUN+="/lib/udev/rm_partitions $env{DEVNAME}", \
 	RUN+="/sbin/mdadm -I --no-degraded $env{DEVNAME}", \
 	RUN+="/bin/sh -c '>/tmp/.mdraid_start-%k; /bin/ln -s /sbin/mdraid_start /initqueue/mdraid_start.sh'"
diff --git a/modules.d/90mdraid/install b/modules.d/90mdraid/install
index 0391957..ec31e3f 100755
--- a/modules.d/90mdraid/install
+++ b/modules.d/90mdraid/install
@@ -13,6 +13,7 @@ if [ -x /lib/udev/vol_id ]; then
     inst_rules "$moddir/61-mdadm.rules"
 else
     if mdadm -Q -e imsm /dev/null &> /dev/null; then
+        dracut_install /lib/udev/rm_partitions
         inst_rules "$moddir/65-md-incremental-imsm.rules"
     else
         inst_rules "$moddir/65-md-incremental.rules"
diff --git a/rm_partitions.c b/rm_partitions.c
new file mode 100644
index 0000000..2cddda1
--- /dev/null
+++ b/rm_partitions.c
@@ -0,0 +1,78 @@
+/*
+
+# Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+#
+# Copyright 2009 Red Hat, Inc.
+#
+# This copyrighted material is made available to anyone wishing to use, modify,
+# copy, or redistribute it subject to the terms and conditions of the GNU
+# General Public License v.2.  This program is distributed in the hope that it
+# will be useful, but WITHOUT ANY WARRANTY expressed or implied, including the
+# implied warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+# See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program; if not, write to the Free Software Foundation, Inc., 51
+# Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  Any Red Hat
+# trademarks that are incorporated in the source code or documentation are not
+# subject to the GNU General Public License and may only be used or replicated
+# with the express permission of Red Hat, Inc. 
+
+*/
+#include <linux/blkpg.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+
+/* Remove the partition block devices (ie sda1) from block devices (ie sda)
+   the main purpose of this is to make things like lvm, hal and blkid
+   not try to access the partitions the kernel finds on disks which are
+   part of a BIOS-RAID set. */
+static int remove_partitions(const char *device_node)
+{
+	struct blkpg_partition part = { 0, };
+	struct blkpg_ioctl_arg io = {
+		.op = BLKPG_DEL_PARTITION,
+		.datalen = sizeof(part),
+		.data = &part,
+	};
+
+	int fd = open(device_node, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Error opening %s: %s\n", device_node,
+			strerror(errno));
+		return -1;
+	}
+
+	/* There is no way to enumerate partitions */
+	for (part.pno = 1; part.pno <= 256; part.pno++) {
+		if (ioctl(fd, BLKPG, &io) < 0 && errno != ENXIO &&
+				(part.pno < 16 || errno != EINVAL)) {
+			fprintf(stderr,
+				"Error removing part %d from %s: %s\n",
+				part.pno, device_node,
+				strerror(errno));
+			return -1;
+		}
+	}
+	return 0;
+}
+
+int main (int argc, char *argv[])
+{
+	int i;
+
+	if (argc < 2) {
+		printf("Usage: %s <disk-device-node-path> [more-disks]\n",
+			argv[0]);
+		printf("Example: \"%s /dev/sda\"\n", argv[0]);
+		return 2;
+	}
+
+	for (i = 1; i < argc; i++)
+		if (remove_partitions(argv[i]))
+			return 1;
+
+	return 0;
+}
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
