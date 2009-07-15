From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 10/14] add command line parameters to specify exact actions for root assembly
Date: Wed, 15 Jul 2009 18:50:42 +0200
Message-ID: <1247676646-3837-11-git-send-email-harald@redhat.com>
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

LVM
       rd_NO_LVM
              disable LVM detection

       rd_LVM_VG=<volume group name>
              only activate the volume groups with the given name

crypto LUKS
       rd_NO_LUKS
              disable crypto LUKS detection

       rd_LUKS_UUID=<luks uuid>
              only activate the LUKS partitions with the given UUID

MD
       rd_NO_MD
              disable MD RAID detection

       rd_MD_UUID=<md uuid>
              only activate the raid sets with the given UUID

DMRAID
       rd_NO_DM
              disable DM RAID detection

       rd_DM_UUID=<dmraid uuid>
              only activate the raid sets with the given UUID
---
 dracut.8                                        |   32 +++++++++++++++++++
 modules.d/50plymouth/cryptroot-ask.sh           |   28 +++++++++++++++--
 modules.d/90crypt/cryptroot-ask.sh              |   25 ++++++++++++---
 modules.d/90crypt/install                       |    1 +
 modules.d/90crypt/parse-crypt.sh                |    6 ++++
 modules.d/90dmraid/dmraid.sh                    |   14 ++++++++-
 modules.d/90dmraid/parse-dm.sh                  |    5 +++
 modules.d/90lvm/install                         |    1 +
 modules.d/90lvm/lvm_scan.sh                     |   10 ++++--
 modules.d/90lvm/parse-lvm.sh                    |    6 ++++
 modules.d/90mdraid/61-mdadm.rules               |   21 +------------
 modules.d/90mdraid/65-md-incremental-imsm.rules |   37 +++++++++++++----------
 modules.d/90mdraid/65-md-incremental.rules      |   37 ++++++++++++++--------
 modules.d/90mdraid/install                      |   14 +++++----
 modules.d/90mdraid/mdraid_start.sh              |   13 ++++----
 modules.d/90mdraid/parse-md.sh                  |   27 ++++++++++++++++
 16 files changed, 202 insertions(+), 75 deletions(-)
 create mode 100755 modules.d/90crypt/parse-crypt.sh
 create mode 100644 modules.d/90dmraid/parse-dm.sh
 create mode 100644 modules.d/90lvm/parse-lvm.sh
 rewrite modules.d/90mdraid/61-mdadm.rules (100%)
 rewrite modules.d/90mdraid/65-md-incremental-imsm.rules (80%)
 rewrite modules.d/90mdraid/65-md-incremental.rules (78%)
 create mode 100644 modules.d/90mdraid/parse-md.sh

diff --git a/dracut.8 b/dracut.8
index 4d6ac29..e121bf5 100644
--- a/dracut.8
+++ b/dracut.8
@@ -78,6 +78,38 @@ root filesystem.
 specify e.g. \fI/dev/sda1\fR or
 \fI/dev/disk/by-path/pci-0000:00:1f.1-scsi-0:0:1:0-part1\fR
 
+.SH LVM
+.TP
+.B rd_NO_LVM
+disable LVM detection
+.TP
+.B rd_LVM_VG=<volume group name>
+only activate the volume groups with the given name
+
+.SH crypto LUKS
+.TP
+.B rd_NO_LUKS
+disable crypto LUKS detection
+.TP
+.B rd_LUKS_UUID=<luks uuid>
+only activate the LUKS partitions with the given UUID
+
+.SH MD
+.TP
+.B rd_NO_MD
+disable MD RAID detection
+.TP
+.B rd_MD_UUID=<md uuid>
+only activate the raid sets with the given UUID
+
+.SH DMRAID
+.TP
+.B rd_NO_DM
+disable DM RAID detection
+.TP
+.B rd_DM_UUID=<dmraid uuid>
+only activate the raid sets with the given UUID
+
 .SH DHCP
 .TP
 .B root=dhcp
diff --git a/modules.d/50plymouth/cryptroot-ask.sh b/modules.d/50plymouth/cryptroot-ask.sh
index 2d0f357..75c6550 100755
--- a/modules.d/50plymouth/cryptroot-ask.sh
+++ b/modules.d/50plymouth/cryptroot-ask.sh
@@ -9,13 +9,33 @@
 # we already asked for this device
 [ -f /tmp/cryptroot-asked-$2 ] && exit 0
 
-# flock against other interactive activities
-{ flock -s 9; 
-/bin/plymouth ask-for-password --prompt "$1 is password protected" --command="/sbin/cryptsetup luksOpen -T1 $1 $2"
-} 9>/.console.lock
+. /lib/dracut-lib.sh
+LUKS=$(getargs rd_LUKS_UUID=)
+ask=1
+
+if [ -n "$LUKS" ]; then
+    ask=0
+    for luks in $LUKS; do
+	if [ "${2##$luks}" != "$2" ]; then
+	    ask=1
+	fi
+    done
+fi
+
+if [ $ask -gt 0 ]; then
+    # flock against other interactive activities
+    { flock -s 9; 
+	/bin/plymouth ask-for-password \
+	    --prompt "$1 is password protected" \
+	    --command="/sbin/cryptsetup luksOpen -T1 $1 $2"
+    } 9>/.console.lock
+fi
 
 # mark device as asked
 >> /tmp/cryptroot-asked-$2
 
+unset LUKS
+unset ask
+unset luks
 exit 0
 
diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index d87c2ea..5b5d895 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -9,11 +9,26 @@
 # we already asked for this device
 [ -f /tmp/cryptroot-asked-$2 ] && exit 0
 
-# flock against other interactive activities
-{ flock -s 9; 
-    echo -n "$1 is password protected " 
-    /sbin/cryptsetup luksOpen -T1 $1 $2
-} 9>/.console.lock
+. /lib/dracut-lib.sh
+LUKS=$(getargs rd_LUKS_UUID=)
+ask=1
+
+if [ -n "$LUKS" ]; then
+    ask=0
+    for luks in $LUKS; do
+	if [ "${2##$luks}" != "$2" ]; then
+	    ask=1
+	fi
+    done
+fi
+
+if [ $ask -gt 0 ]; then
+    # flock against other interactive activities
+    { flock -s 9; 
+	echo -n "$1 is password protected " 
+	/sbin/cryptsetup luksOpen -T1 $1 $2
+    } 9>/.console.lock
+fi
 
 # mark device as asked
 >> /tmp/cryptroot-asked-$2
diff --git a/modules.d/90crypt/install b/modules.d/90crypt/install
index a3a856d..9ffe90e 100755
--- a/modules.d/90crypt/install
+++ b/modules.d/90crypt/install
@@ -3,3 +3,4 @@ inst cryptsetup
 instmods dm_crypt cbc aes sha256 xts
 inst_rules "$moddir/70-luks.rules"
 inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
+inst_hook cmdline 30 "$moddir/parse-crypt.sh"
diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse-crypt.sh
new file mode 100755
index 0000000..4a39c21
--- /dev/null
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -0,0 +1,6 @@
+initrdargs="$initrdargs rd_NO_LUKS rd_LUKS_UUID" 
+
+if getarg rd_NO_LUKS; then
+    rm -f /etc/udev/rules.d/70-luks.rules
+fi
+
diff --git a/modules.d/90dmraid/dmraid.sh b/modules.d/90dmraid/dmraid.sh
index f6cb26f..f706e57 100755
--- a/modules.d/90dmraid/dmraid.sh
+++ b/modules.d/90dmraid/dmraid.sh
@@ -2,7 +2,19 @@
 
 if $UDEV_QUEUE_EMPTY >/dev/null 2>&1; then
     [ -h "$job" ] && rm -f "$job"
+    DM_RAIDS=$(getargs rd_DM_UUID=)
     # run dmraid if udev has settled
-    dmraid -ay 
+    info "Scanning for dmraid devices $DM_RAIDS"
+    SETS=$(dmraid -c -s)
+    info "Found dmraid sets:"
+    echo $SETS|vinfo
+    for r in $DM_RAIDS; do 
+	for s in $SETS; do 
+	    if [ "${s##$r}" != "$s" ]; then
+		info "Activating $s"
+		dmraid -ay $s | vinfo
+	    fi
+	done
+    done
 fi
 
diff --git a/modules.d/90dmraid/parse-dm.sh b/modules.d/90dmraid/parse-dm.sh
new file mode 100644
index 0000000..a047d2d
--- /dev/null
+++ b/modules.d/90dmraid/parse-dm.sh
@@ -0,0 +1,5 @@
+initrdargs="$initrdargs rd_DM_UUID rd_NO_DM" 
+
+if getarg rd_NO_DM; then
+    rm /etc/udev/rules.d/61-dmraid*.rules
+fi
\ No newline at end of file
diff --git a/modules.d/90lvm/install b/modules.d/90lvm/install
index cba321b..ad5e485 100755
--- a/modules.d/90lvm/install
+++ b/modules.d/90lvm/install
@@ -7,3 +7,4 @@ else
 fi
 
 inst "$moddir/lvm_scan.sh" /sbin/lvm_scan
+inst_hook cmdline 30 "$moddir/parse-lvm.sh"
diff --git a/modules.d/90lvm/lvm_scan.sh b/modules.d/90lvm/lvm_scan.sh
index 489c7a1..81c48c0 100755
--- a/modules.d/90lvm/lvm_scan.sh
+++ b/modules.d/90lvm/lvm_scan.sh
@@ -4,12 +4,14 @@ if $UDEV_QUEUE_EMPTY >/dev/null 2>&1; then
     [ -h "$job" ] && rm -f "$job"
     # run lvm scan if udev has settled
 
+    VGS=$(getargs rd_LVM_VG=)
+
     [ -d /etc/lvm ] || mkdir -p /etc/lvm
     # build a list of devices to scan
     lvmdevs=$(
 	for f in /tmp/.lvm_scan-*; do
 	    [ -e "$f" ] || continue
-	    echo ${f##/tmp/.lvm_scan-}
+	    echo -n "${f##/tmp/.lvm_scan-} "
 	done
 	)
     {
@@ -19,10 +21,12 @@ if $UDEV_QUEUE_EMPTY >/dev/null 2>&1; then
 	    printf '"a|^/dev/%s$|", ' $dev;
 	done;
 	echo '"r/.*/" ]';
+	echo 'types = [ "blkext", 1024 ]'
 	echo '}';	  
     } > /etc/lvm/lvm.conf
 
-    lvm vgscan
-    lvm vgchange -ay
+    info "Scanning devices $lvmdevs for LVM volume groups $VGS"
+    lvm vgscan 2>&1 | vinfo
+    lvm vgchange -ay $VGS 2>&1 | vinfo
 fi
 
diff --git a/modules.d/90lvm/parse-lvm.sh b/modules.d/90lvm/parse-lvm.sh
new file mode 100644
index 0000000..00dba38
--- /dev/null
+++ b/modules.d/90lvm/parse-lvm.sh
@@ -0,0 +1,6 @@
+initrdargs="$initrdargs rd_NO_LVM rd_LVM_VG" 
+
+if getarg rd_NO_LVM; then
+    rm -f /etc/udev/rules.d/64-lvm*.rules
+fi
+
diff --git a/modules.d/90mdraid/61-mdadm.rules b/modules.d/90mdraid/61-mdadm.rules
dissimilarity index 100%
index 23c5baf..87becdc 100644
--- a/modules.d/90mdraid/61-mdadm.rules
+++ b/modules.d/90mdraid/61-mdadm.rules
@@ -1,20 +1 @@
-# This file causes block devices with Linux RAID (mdadm) signatures to
-# automatically cause mdadm to be run.
-# See udev(8) for syntax
-
-SUBSYSTEM!="block", GOTO="raid_end"
-ACTION!="add|change", GOTO="raid_end"
-KERNEL=="md/*", GOTO="raid_end"
-
-KERNEL=="md*", IMPORT{program}="vol_id --export $tempnode"
-ENV{ID_FS_TYPE}=="linux_raid_member", \
-    TEST!="/tmp/.mdraid_start-%k", \
-    RUN+="/sbin/mdadm -I $env{DEVNAME}", \
-    RUN+="/bin/sh -c '>/tmp/.mdraid_start-%k; /bin/ln -s /sbin/mdraid_start /initqueue/mdraid_start.sh'"
-
-ENV{ID_FS_TYPE}=="linux_raid_member", \
-    TEST!="/tmp/.mdraid_start-%k", \
-    ATTR{partition}!="?*", \
-    RUN+="/sbin/partx -d $env{DEVNAME}"
-
-LABEL="raid_end"
+SUBSYSTEM=="block", ACTION=="add|change", KERNEL=="md[0-9]*|md_d[0-9]*|md/*", IMPORT{program}="vol_id --export $tempnode"
diff --git a/modules.d/90mdraid/65-md-incremental-imsm.rules b/modules.d/90mdraid/65-md-incremental-imsm.rules
dissimilarity index 80%
index edef6b0..f6efb56 100644
--- a/modules.d/90mdraid/65-md-incremental-imsm.rules
+++ b/modules.d/90mdraid/65-md-incremental-imsm.rules
@@ -1,16 +1,21 @@
-# This file causes block devices with Linux RAID (mdadm) signatures to
-# automatically cause mdadm to be run.
-# See udev(8) for syntax
-
-SUBSYSTEM=="block", ACTION=="add", \
-        ENV{ID_FS_TYPE}=="linux_raid_member|isw_raid_member", \
-        TEST!="/tmp/.mdraid_start-%k", \
-	IMPORT{program}="/sbin/mdadm --examine --export $tempnode", \
-	RUN+="/sbin/mdadm -I --no-degraded $env{DEVNAME}", \
-	RUN+="/bin/sh -c '>/tmp/.mdraid_start-%k; /bin/ln -s /sbin/mdraid_start /initqueue/mdraid_start.sh'"
-
-SUBSYSTEM=="block", ACTION=="add", \
-        ENV{ID_FS_TYPE}=="linux_raid_member|isw_raid_member", \
-        TEST!="/tmp/.mdraid_start-%k", \
-	ATTR{partition}!="?*", \
-	RUN+="/sbin/partx -d $env{DEVNAME}"
+# This file causes block devices with Linux RAID (mdadm) signatures to
+# automatically cause mdadm to be run.
+# See udev(8) for syntax
+
+ACTION!="add", GOTO="md_inc_end"
+SUBSYSTEM!="block", GOTO="md_inc_end"
+ENV{ID_FS_TYPE}!="linux_raid_member|isw_raid_member", GOTO="md_inc_end"
+
+TEST=="/tmp/.mdraid_start-%k", GOTO="md_inc_end"
+
+IMPORT{program}="/sbin/mdadm --examine --export $tempnode"
+
+# UUID CHECK
+
+LABEL="do_md_inc"
+
+RUN+="/sbin/mdadm -I --no-degraded $env{DEVNAME}", RUN+="/bin/sh -c '>/tmp/.mdraid_start-%k; /bin/ln -s /sbin/mdraid_start /initqueue/mdraid_start.sh'"
+
+ATTR{partition}!="?*", RUN+="/sbin/partx -d $env{DEVNAME}"
+
+LABEL="md_inc_end"
diff --git a/modules.d/90mdraid/65-md-incremental.rules b/modules.d/90mdraid/65-md-incremental.rules
dissimilarity index 78%
index f679c4b..38e7654 100644
--- a/modules.d/90mdraid/65-md-incremental.rules
+++ b/modules.d/90mdraid/65-md-incremental.rules
@@ -1,14 +1,23 @@
-# This file causes block devices with Linux RAID (mdadm) signatures to
-# automatically cause mdadm to be run.
-# See udev(8) for syntax
-
-SUBSYSTEM=="block", ACTION=="add", ENV{ID_FS_TYPE}=="linux_raid_member", \
-        TEST!="/tmp/.mdraid_start-%k", \
-	IMPORT{program}="/sbin/mdadm --examine --export $tempnode", \
-	RUN+="/sbin/mdadm -I $env{DEVNAME}", \
-	RUN+="/bin/sh -c '>/tmp/.mdraid_start-%k; /bin/ln -s /sbin/mdraid_start /initqueue/mdraid_start.sh'"
-
-SUBSYSTEM=="block", ACTION=="add", ENV{ID_FS_TYPE}=="linux_raid_member", \
-        TEST!="/tmp/.mdraid_start-%k", \
-	ATTR{partition}!="?*", \
-	RUN+="/sbin/partx -d $env{DEVNAME}"
+# This file causes block devices with Linux RAID (mdadm) signatures to
+# automatically cause mdadm to be run.
+# See udev(8) for syntax
+
+ACTION!="add", GOTO="md_inc_end"
+SUBSYSTEM!="block", GOTO="md_inc_end"
+ENV{ID_FS_TYPE}!="linux_raid_member", GOTO="md_inc_end"
+
+TEST=="/tmp/.mdraid_start-%k", GOTO="md_inc_end"
+
+IMPORT{program}="/sbin/mdadm --examine --export $tempnode"
+
+# UUID CHECK
+
+LABEL="do_md_inc"
+
+RUN+="/sbin/mdadm -I --no-degraded $env{DEVNAME}"
+
+RUN+="/bin/sh -c '>/tmp/.mdraid_start-%k; /bin/ln -s /sbin/mdraid_start /initqueue/mdraid_start.sh'"
+
+ATTR{partition}!="?*", RUN+="/sbin/partx -d $env{DEVNAME}"
+
+LABEL="md_inc_end"
diff --git a/modules.d/90mdraid/install b/modules.d/90mdraid/install
index 0391957..9c29f77 100755
--- a/modules.d/90mdraid/install
+++ b/modules.d/90mdraid/install
@@ -12,14 +12,16 @@ instmods =drivers/md
 if [ -x /lib/udev/vol_id ]; then
     inst_rules "$moddir/61-mdadm.rules"
 else
-    if mdadm -Q -e imsm /dev/null &> /dev/null; then
-        inst_rules "$moddir/65-md-incremental-imsm.rules"
-    else
-        inst_rules "$moddir/65-md-incremental.rules"
-    fi
     inst_rules 64-md-raid.rules
 fi
 
+if mdadm -Q -e imsm /dev/null &> /dev/null; then
+    inst_rules "$moddir/65-md-incremental-imsm.rules"
+else
+    inst_rules "$moddir/65-md-incremental.rules"
+fi
+
+
 [ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf /etc/mdadm.conf
 [ -f /etc/mdadm.conf ] && inst /etc/mdadm.conf
 if [ -x  /sbin/mdmon ] ; then
@@ -28,4 +30,4 @@ if [ -x  /sbin/mdmon ] ; then
 fi 
 
 inst "$moddir/mdraid_start.sh" /sbin/mdraid_start
-inst grep
+inst_hook cmdline 30 "$moddir/parse-md.sh"
diff --git a/modules.d/90mdraid/mdraid_start.sh b/modules.d/90mdraid/mdraid_start.sh
index 7293ded..b63709c 100755
--- a/modules.d/90mdraid/mdraid_start.sh
+++ b/modules.d/90mdraid/mdraid_start.sh
@@ -3,15 +3,16 @@
 if $UDEV_QUEUE_EMPTY >/dev/null 2>&1; then
     [ -h "$job" ] && rm -f "$job"
     # run mdadm if udev has settled
-    mdadm -IRs
+    info "Assembling MD RAID arrays"
+
     # and activate any containers
     for md in /dev/md?*; do
         case $md in
-            /dev/md*p*) ;;
-            *)
-                if mdadm --export --detail $md | grep -q container; then
-                    mdadm -IR $md
-                fi
+	    /dev/md*p*) ;;
+	    *)
+		info "Starting MD RAID array $md"
+                mdadm -R $md 2>&1 | vinfo
+                mdadm -IR $md 2>&1 | vinfo
         esac
     done
 fi
diff --git a/modules.d/90mdraid/parse-md.sh b/modules.d/90mdraid/parse-md.sh
new file mode 100644
index 0000000..af89084
--- /dev/null
+++ b/modules.d/90mdraid/parse-md.sh
@@ -0,0 +1,27 @@
+initrdargs="$initrdargs rd_MD_UUID rd_NO_MD" 
+
+if $(getarg rd_NO_MD); then
+    rm /etc/udev/rules.d/65-md-incremental*.rules
+else
+    MD_UUID=$(getargs rd_MD_UUID=)
+
+    # rewrite the md rules to only process the specified raid array
+    if [ -n "$MD_UUID" ]; then
+	for f in /etc/udev/rules.d/65-md-incremental*.rules; do
+	    [ -e "$f" ] || continue
+	    mv $f ${f}.bak 
+	    while read line; do 
+		if [ "${line/UUID CHECK//}" != "$line" ]; then
+		    for uuid in $MD_UUID; do
+			printf 'ENV{MD_UUID}=="%s", GOTO="do_md_inc"\n' $uuid
+		    done;
+ 		    printf 'GOTO="md_inc_end"\n';		
+		else
+		    echo $line; 
+		fi
+	    done < ${f}.bak > $f
+	    rm ${f}.bak 
+	done
+    fi
+fi
+
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
