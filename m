From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Thu, 05 Feb 2009 15:49:20 -0700
Message-ID: <20090205224920.18610.63979.stgit@dwillia2-linux.ch.intel.com>
References: <20090205224808.18610.14957.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090205224808.18610.14957.stgit-p8uTFz9XbKjBPTuBivz2/GFmcEqAMTzPQQ4Iyu8u01E@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: neilb-l3A5Bk7waGM@public.gmane.org, jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org

External metadata support implies that metadata events are handled by a
userspace daemon.  This daemon, mdmon, needs to be started ahead of the
rootfs being mounted to handle the raid volume dirty bit.  Even if the
rootfs is mounted read-only the rootdev may still be written by
filesystem journal-playback operations.

After the rootfs is mounted to /sysroot, mdmon is restarted in the new
namespace.  The command "mdmon /proc/mdstat /sysroot" tells mdmon to
terminate any instances in the current namespace and then launch new
instances, chroot(2) to /sysroot, per container device found in
/proc/mdstat.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 dracut |   11 +++++++++--
 init   |   10 ++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index ef2ca42..513b6c6 100755
--- a/dracut
+++ b/dracut
@@ -69,13 +69,14 @@ initdir=$(mktemp -d -t initramfs.XXXXXX)
 exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /bin/kill /sbin/pidof /bin/sleep /bin/echo /usr/sbin/chroot"
 lvmexe="/sbin/lvm"
 cryptexe="/sbin/cryptsetup"
+raidexe="/sbin/mdadm /sbin/mdmon"
 # and some things that are nice for debugging
 debugexe="/bin/ls /bin/cat /bin/ln /bin/ps /bin/grep /bin/more"
 # udev things we care about
 udevexe="/lib/udev/vol_id /lib/udev/console_init"
 
 # install base files
-for binary in $exe $debugexe $udevexe $lvmexe $cryptexe ; do
+for binary in $exe $debugexe $udevexe $lvmexe $cryptexe $raidexe ; do
   inst $binary $initdir
 done
 
@@ -152,7 +153,7 @@ cp $switchroot $initdir/sbin/switch_root
 mkdir -p $initdir/etc $initdir/proc $initdir/sys $initdir/sysroot $initdir/dev/pts
 
 # FIXME: hard-coded module list of doom.
-[ -z "$modules" ] && modules="=ata =block =drm dm-crypt aes sha256 cbc"
+[ -z "$modules" ] && modules="=ata =block =drm =raid dm-crypt aes sha256 cbc"
 
 mkdir -p $initdir/lib/modules/$kernel
 # expand out module deps, etc
@@ -171,6 +172,12 @@ if [ -x /usr/libexec/plymouth/plymouth-populate-initrd ]; then
     /usr/libexec/plymouth/plymouth-populate-initrd -t "$initdir" || :
 fi
 
+# raid
+# mdadm.conf allows mdadm to disambiguate foreign arrays for some metadata types
+# check /etc and /etc/mdadm (/etc wins if both are present)
+[ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf "$initdir" /etc/mdadm.conf
+[ -f /etc/mdadm.conf ] && inst /etc/mdadm.conf "$initdir"
+
 pushd $initdir >/dev/null
 find . |cpio -H newc -o |gzip -9 > $outfile
 popd >/dev/null
diff --git a/init b/init
index 706127f..0294502 100755
--- a/init
+++ b/init
@@ -46,6 +46,13 @@ mknod /dev/tty1 c 4 1
 /sbin/udevd --daemon
 /sbin/udevadm trigger
 
+# start any defined raid arrays
+# we settle before assembling to hopefully prevent prematurely degrading arrays
+if [ -f /etc/mdadm.conf ]; then
+  /sbin/udevadm settle
+  /sbin/mdadm -Asc /etc/mdadm.conf
+fi
+
 # mount the rootfs
 NEWROOT="/sysroot"
 
@@ -110,6 +117,9 @@ kill `pidof udevd`
 
 [ -x /bin/plymouth ] && /bin/plymouth --newroot=$NEWROOT
 
+# switch any mdmon instances to newroot
+[ -f /etc/mdadm.conf ] && /sbin/mdmon /proc/mdstat $NEWROOT
+
 # FIXME: nash die die die
 exec /sbin/switch_root
 # davej doesn't like initrd bugs

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
