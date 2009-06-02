From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] add iSCSI module
Date: Tue,  2 Jun 2009 13:41:41 +0200
Message-ID: <1243942901-5474-2-git-send-email-harald@redhat.com>
References: <1243942901-5474-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243942901-5474-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/95iscsi/check              |   11 +++
 modules.d/95iscsi/install            |    8 ++
 modules.d/95iscsi/iscsi-netroot.sh   |   13 ++++
 modules.d/95iscsi/iscsiroot          |  121 ++++++++++++++++++++++++++++++++++
 modules.d/95iscsi/parse-iscsiroot.sh |   37 ++++++++++
 test/TEST-30-ISCSI/Makefile          |   10 +++
 test/TEST-30-ISCSI/create-root.sh    |   34 ++++++++++
 test/TEST-30-ISCSI/cryptroot-ask     |    6 ++
 test/TEST-30-ISCSI/hard-off.sh       |    2 +
 test/TEST-30-ISCSI/test.sh           |   68 +++++++++++++++++++
 10 files changed, 310 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/95iscsi/check
 create mode 100755 modules.d/95iscsi/install
 create mode 100755 modules.d/95iscsi/iscsi-netroot.sh
 create mode 100755 modules.d/95iscsi/iscsiroot
 create mode 100755 modules.d/95iscsi/parse-iscsiroot.sh
 create mode 100644 test/TEST-30-ISCSI/Makefile
 create mode 100755 test/TEST-30-ISCSI/create-root.sh
 create mode 100755 test/TEST-30-ISCSI/cryptroot-ask
 create mode 100755 test/TEST-30-ISCSI/hard-off.sh
 create mode 100755 test/TEST-30-ISCSI/test.sh

diff --git a/modules.d/95iscsi/check b/modules.d/95iscsi/check
new file mode 100755
index 0000000..d5f0912
--- /dev/null
+++ b/modules.d/95iscsi/check
@@ -0,0 +1,11 @@
+#!/bin/sh
+# We depend on network modules being loaded
+[ "$1" = "-d" ] && echo network
+
+# If hostonly was requested, fail the check if we are not actually
+# booting from root.
+#[ "$1" = "-h" ] && ! egrep -q '/ /dev/nbd[0-9]*' /proc/mounts && exit 1
+
+# If our prerequisites are not met, fail anyways.
+which iscsistart hostname >/dev/null 2>&1 || exit 1
+exit 0
diff --git a/modules.d/95iscsi/install b/modules.d/95iscsi/install
new file mode 100755
index 0000000..4f93c62
--- /dev/null
+++ b/modules.d/95iscsi/install
@@ -0,0 +1,8 @@
+#!/bin/bash
+
+inst iscsistart 
+inst hostname
+inst_hook cmdline 90 "$moddir/parse-iscsiroot.sh"
+inst_hook netroot 90 "$moddir/iscsi-netroot.sh"
+inst "$moddir/iscsiroot" "/sbin/iscsiroot"
+instmods iscsi_tcp crc32c
diff --git a/modules.d/95iscsi/iscsi-netroot.sh b/modules.d/95iscsi/iscsi-netroot.sh
new file mode 100755
index 0000000..4f02239
--- /dev/null
+++ b/modules.d/95iscsi/iscsi-netroot.sh
@@ -0,0 +1,13 @@
+if [ "$root" = "dhcp" ]; then
+    if [ -n "$new_root_path" -a -z "${new_root_path%%iscsi:*}" ]; then
+	root="$new_root_path"
+    fi
+fi
+
+if [ -z "${root%iscsi:*}" ]; then
+    handler=/sbin/iscsiroot
+fi
+
+if getarg iscsiroot >/dev/null; then
+    handler=/sbin/iscsiroot
+fi
diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
new file mode 100755
index 0000000..11585e1
--- /dev/null
+++ b/modules.d/95iscsi/iscsiroot
@@ -0,0 +1,121 @@
+#!/bin/sh
+
+. /lib/dracut-lib
+
+PATH=$PATH:/sbin:/usr/sbin
+
+# XXX needs error handling like ifup/dhclient-script
+
+if getarg rdnetdebug; then
+    exec > /tmp/iscsiroot.$1.$$.out
+    exec 2>> /tmp/iscsiroot.$1.$$.out
+    set -x
+fi
+
+exec > /dev/console
+exec 2>/dev/console
+set -x
+
+# read static conf settings
+for conf in conf/conf.d/*; do
+	[ -f ${conf} ] && . ${conf}
+done
+
+# root is in the form root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+netif="$1"
+root="$2"
+
+
+if [ $root = ${root#iscsi:} ]; then
+	root=$(getarg iscsiroot)
+else
+	root=${root#iscsi:}
+fi
+
+if getarg iscsi_firmware >/dev/null; then
+	modprobe iscsi_tcp
+	modprobe crc32c
+	iscsistart -b
+else
+	OLDIFS="$IFS"
+	IFS=:
+	set $root
+
+	iscsi_target_ip=$1; shift
+	iscsi_protocol=$1; shift # ignored
+	iscsi_target_port=$1; shift
+	iscsi_lun=$1; shift
+	iscsi_target_name=$*
+	IFS="$OLDIFS"
+
+	# override conf settings by command line options
+	arg=$(getarg iscsi_initiator)
+	[ -n "$arg" ] && iscsi_initiator=$arg
+	arg=$(getarg iscsi_initiator)
+	[ -n "$arg" ] && iscsi_target_name=$arg
+	arg=$(getarg iscsi_target_ip)
+	[ -n "$arg" ] && iscsi_target_ip=$arg
+	arg=$(getarg iscsi_target_port)
+	[ -n "$arg" ] && iscsi_target_port=$arg
+	arg=$(getarg iscsi_target_group)
+	[ -n "$arg" ] && iscsi_target_group=$arg
+	arg=$(getarg iscsi_username)
+	[ -n "$arg" ] && iscsi_username=$arg
+	arg=$(getarg iscsi_password)
+	[ -n "$arg" ] && iscsi_password=$arg
+	arg=$(getarg iscsi_in_username)
+	[ -n "$arg" ] && iscsi_in_username=$arg
+	arg=$(getarg iscsi_in_password)
+	[ -n "$arg" ] && iscsi_in_password=$arg
+
+	getarg ro && iscsirw=ro
+	getarg rw && iscsirw=rw
+	fsopts=${fsopts+$fsopts,}${iscsirw}
+
+	modprobe iscsi_tcp
+	modprobe crc32c
+
+	if [ -z $iscsi_initiator ]; then
+		[ -f /etc/initiatorname.iscsi ] && . /etc/initiatorname.iscsi
+		[ -f /etc/iscsi/initiatorname.iscsi ] && . /etc/iscsi/initiatorname.iscsi
+		iscsi_initiator=$InitiatorName
+	fi
+
+	if [ -z $iscsi_target_port ]; then
+		iscsi_target_port=3260
+	fi
+
+	if [ -z $iscsi_target_group ]; then
+		iscsi_target_group=1
+	fi
+
+	if [ -z $iscsi_initiator ]; then
+		[ -f /tmp/net.$netif.dhcpopts ] && . /tmp/net.$netif.dhcpopts
+		hostname=$new_host_name
+		[ -z "$hostname" ] && hostname=arpa.in-addr.$new_ip_address
+		OLDIFS="$IFS"
+		IFS=.
+		unset revname
+		for i in $hostname; do 
+			revname=${i}${revname+.$revname}
+		done
+		IFS="$OLDIFS"
+		iscsi_initiator=iqn.2009-01.$revname
+	fi
+
+	echo "InitiatorName='$iscsi_initiator'" > /dev/.initiatorname.iscsi
+
+	# FIXME $iscsi_lun?? $iscsi_protocol??
+
+	iscsistart -i $iscsi_initiator -t $iscsi_target_name	\
+		   -g $iscsi_target_group -a $iscsi_target_ip	\
+		   -p $iscsi_target_port \
+		   ${iscsi_username+-u $iscsi_username} \
+	           ${iscsi_password+-w $iscsi_password} \
+	           ${iscsi_in_username+-U $iscsi_in_username} \
+	           ${iscsi_in_password+-W $iscsi_in_password}
+	# now we have a root filesystem somewhere in /dev/sda*
+	# let the normal block handler handle root=
+fi
+
+exit 0
diff --git a/modules.d/95iscsi/parse-iscsiroot.sh b/modules.d/95iscsi/parse-iscsiroot.sh
new file mode 100755
index 0000000..16fa0f6
--- /dev/null
+++ b/modules.d/95iscsi/parse-iscsiroot.sh
@@ -0,0 +1,37 @@
+# XXX actually we could, if we move to root=XXX and netroot=XXX, then
+# you could do root=LABEL=/ iscsiroot=XXX, or netroot=iscsi:XXX
+#
+#
+# Preferred format:
+#       root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+#
+# Legacy formats:
+#       iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+#	root=dhcp iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+#	root=iscsi iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+#       root=??? iscsi_initiator= iscsi_target_name= iscsi_target_ip= iscsi_target_port= iscsi_target_group= iscsi_username= iscsi_password= iscsi_in_username= iscsi_in_password=
+#       root=??? iscsi_firmware
+
+exec >/dev/console
+exec 2>/dev/console
+
+set -x
+
+case "$root" in
+    iscsi|dhcp|'')
+	if getarg iscsiroot= > /dev/null; then
+	    root=iscsi:$(getarg iscsiroot=)
+	fi
+	;;
+esac
+
+if [ "${root%%:*}" = "iscsi" ]; then
+    # XXX validate options here?
+    # XXX generate udev rules?
+    rootok=1
+    netroot=iscsi
+fi
+
+if getarg iscsiroot; then
+	netroot=iscsi
+fi
diff --git a/test/TEST-30-ISCSI/Makefile b/test/TEST-30-ISCSI/Makefile
new file mode 100644
index 0000000..2ef573d
--- /dev/null
+++ b/test/TEST-30-ISCSI/Makefile
@@ -0,0 +1,10 @@
+all:
+	make -C ../.. all
+	@basedir=../.. testdir=../ ./test.sh --all
+setup:
+	make -C ../.. all
+	@basedir=../.. testdir=../ ./test.sh --setup
+clean:
+	@basedir=../.. testdir=../ ./test.sh --clean
+run:
+	@basedir=../.. testdir=../ ./test.sh --run
diff --git a/test/TEST-30-ISCSI/create-root.sh b/test/TEST-30-ISCSI/create-root.sh
new file mode 100755
index 0000000..2dc9a59
--- /dev/null
+++ b/test/TEST-30-ISCSI/create-root.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# don't let udev and this script step on eachother's toes
+for x in 63-luks.rules 64-lvm.rules 70-mdadm.rules 99-mount-rules; do
+    > "/etc/udev/rules.d/$x"
+done
+udevadm control --reload-rules
+# save a partition at the beginning for future flagging purposes
+sfdisk -C 640 -H 2 -S 32 -L /dev/sda <<EOF
+,1
+,213
+,213
+,213
+EOF
+mdadm --create /dev/md0 --run --auto=yes --level=5 --raid-devices=3 /dev/sda2 /dev/sda3 /dev/sda4
+# wait for the array to finish initailizing, otherwise this sometimes fails
+# randomly.
+mdadm -W /dev/md0
+echo -n test >keyfile
+cryptsetup -q luksFormat /dev/md0 /keyfile
+echo "The passphrase is test"
+cryptsetup luksOpen /dev/md0 dracut_crypt_test </keyfile && \
+lvm pvcreate -ff  -y /dev/mapper/dracut_crypt_test && \
+lvm vgcreate dracut /dev/mapper/dracut_crypt_test && \
+lvm lvcreate -l 100%FREE -n root dracut && \
+lvm vgchange -ay && \
+mke2fs /dev/dracut/root && \
+mkdir -p /sysroot && \
+mount /dev/dracut/root /sysroot && \
+cp -a -t /sysroot /source/* && \
+umount /sysroot && \
+lvm lvchange -a n /dev/dracut/root && \
+cryptsetup luksClose /dev/mapper/dracut_crypt_test && \
+echo "dracut-root-block-created" >/dev/sda1
+poweroff -f
diff --git a/test/TEST-30-ISCSI/cryptroot-ask b/test/TEST-30-ISCSI/cryptroot-ask
new file mode 100755
index 0000000..db27c5b
--- /dev/null
+++ b/test/TEST-30-ISCSI/cryptroot-ask
@@ -0,0 +1,6 @@
+#!/bin/sh
+
+[ -b /dev/mapper/$2 ] && exit 0
+echo -n test >/keyfile
+/sbin/cryptsetup luksOpen $1 $2 </keyfile
+
diff --git a/test/TEST-30-ISCSI/hard-off.sh b/test/TEST-30-ISCSI/hard-off.sh
new file mode 100755
index 0000000..92dd304
--- /dev/null
+++ b/test/TEST-30-ISCSI/hard-off.sh
@@ -0,0 +1,2 @@
+#!/bin/sh
+poweroff -f
\ No newline at end of file
diff --git a/test/TEST-30-ISCSI/test.sh b/test/TEST-30-ISCSI/test.sh
new file mode 100755
index 0000000..e4fe2fd
--- /dev/null
+++ b/test/TEST-30-ISCSI/test.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+TEST_DESCRIPTION="root filesystem on an encrypted LVM PV over ISCSI"
+
+test_run() {
+    $testdir/run-qemu -m 512M -nographic  -net nic,vlan=0,macaddr=52:54:00:12:34:FE -net tap,vlan=0,ifname=vnet2 \
+	-kernel /boot/vmlinuz-$(uname -r) \
+	-append "root=/dev/dracut/root rw quiet console=ttyS0,115200n81 iscsiroot=192.168.2.2::::iqn.2004-04.com.qnap:TS-439:iSCSI.test.8CCAFA ip=dhcp" \
+	-initrd initramfs.testing
+    #grep -m 1 -q dracut-root-block-success root.ext2 || return 1
+}
+
+test_setup() {
+
+    kernel=$(uname -r)
+    # Create what will eventually be our root filesystem onto an overlay
+    (
+	initdir=overlay/source
+	. $basedir/dracut-functions
+	dracut_install sh df free ls shutdown poweroff stty cat ps ln ip route \
+	    /lib/terminfo/l/linux mount dmesg ifconfig dhclient mkdir cp ping dhclient 
+	inst "$basedir/modules.d/40network/dhclient-script" "/sbin/dhclient-script"
+	inst "$basedir/modules.d/40network/ifup" "/sbin/ifup"
+	dracut_install grep
+	inst $testdir/test-init /sbin/init
+	find_binary plymouth >/dev/null && dracut_install plymouth
+	(cd "$initdir"; mkdir -p dev sys proc etc var/run tmp )
+    )
+ 
+    # second, install the files needed to make the root filesystem
+    (
+	initdir=overlay
+	. $basedir/dracut-functions
+	dracut_install sfdisk mke2fs poweroff cp umount 
+	inst_simple ./create-root.sh /pre-mount/01create-root.sh
+    )
+ 
+    # create an initramfs that will create the target root filesystem.
+    # We do it this way so that we do not risk trashing the host mdraid
+    # devices, volume groups, encrypted partitions, etc.
+    $basedir/dracut -l --verbose -i overlay / \
+	-m "dash crypt lvm mdraid udev-rules base rootfs-block iscsi network" \
+	-d "ata_piix ext2 sd_mod" \
+	-f initramfs.makeroot || return 1
+    rm -rf overlay
+    # Invoke KVM and/or QEMU to actually create the target filesystem.
+    $testdir/run-qemu  -m 512M -nographic -net nic,vlan=0,macaddr=52:54:00:12:34:FE -net tap,vlan=0,ifname=vnet2  \
+	-kernel "/boot/vmlinuz-$kernel" \
+	-append "root=/dev/dracut/root iscsiroot=192.168.2.2::::iqn.2004-04.com.qnap:TS-439:iSCSI.test.8CCAFA ip=dhcp rw rootfstype=ext2 console=ttyS0,115200n81 quiet" \
+	-initrd initramfs.makeroot  || return 1
+
+    (
+	initdir=overlay
+	. $basedir/dracut-functions
+	dracut_install poweroff shutdown
+	inst ./cryptroot-ask /sbin/cryptroot-ask
+    )
+    sudo $basedir/dracut -l -i overlay / \
+	-m "dash crypt lvm mdraid udev-rules base rootfs-block iscsi" \
+	-d "ata_piix ext2 sd_mod" \
+	-f initramfs.testing || return 1
+}
+
+test_cleanup() {
+    rm -fr overlay mnt
+    rm -f root.ext2 initramfs.makeroot initramfs.testing
+}
+
+. $testdir/test-functions
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
