From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] test: Add compatibility for different kernel configs
Date: Fri, 16 Oct 2009 11:28:04 +0200
Message-ID: <4AD83CA4.6030104@redhat.com>
References: <1255683604-10667-2-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1255683604-10667-2-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Errr... well, what if you have hda and a real sda ?


On 10/16/2009 11:00 AM, Philippe Seewer wrote:
> Some distros, including debian unstable with 2.6.30, still shop
> style ide drivers and/or have important filesystems like ext3 as
> modules.
>
> This patch ensures that all test cases work on these configurations
> by including the necessary modules and adding a simple udev rule
> file that provides /dev/sd* symlinks for the case where old style
> ide drivers are still in use.
> ---
>   test/TEST-10-RAID/99-idesymlinks.rules         |    8 ++++++++
>   test/TEST-10-RAID/test.sh                      |    6 ++++--
>   test/TEST-11-LVM/99-idesymlinks.rules          |    8 ++++++++
>   test/TEST-11-LVM/test.sh                       |    6 ++++--
>   test/TEST-12-RAID-DEG/99-idesymlinks.rules     |    8 ++++++++
>   test/TEST-12-RAID-DEG/test.sh                  |    8 +++++---
>   test/TEST-13-ENC-RAID-LVM/99-idesymlinks.rules |    8 ++++++++
>   test/TEST-13-ENC-RAID-LVM/test.sh              |    6 ++++--
>   test/TEST-14-IMSM/99-idesymlinks.rules         |    8 ++++++++
>   test/TEST-14-IMSM/create-root.sh               |    7 ++++++-
>   test/TEST-14-IMSM/test.sh                      |    6 ++++--
>   test/TEST-20-NFS/99-idesymlinks.rules          |    8 ++++++++
>   test/TEST-20-NFS/test.sh                       |    5 +++--
>   test/TEST-30-ISCSI/99-idesymlinks.rules        |    8 ++++++++
>   test/TEST-30-ISCSI/test.sh                     |    8 +++++---
>   test/TEST-40-NBD/99-idesymlinks.rules          |    8 ++++++++
>   test/TEST-40-NBD/test.sh                       |    8 +++++---
>   test/TEST-50-MULTINIC/99-idesymlinks.rules     |    8 ++++++++
>   test/TEST-50-MULTINIC/test.sh                  |    5 +++--
>   19 files changed, 115 insertions(+), 22 deletions(-)
>   create mode 100644 test/TEST-10-RAID/99-idesymlinks.rules
>   create mode 100644 test/TEST-11-LVM/99-idesymlinks.rules
>   create mode 100644 test/TEST-12-RAID-DEG/99-idesymlinks.rules
>   create mode 100644 test/TEST-13-ENC-RAID-LVM/99-idesymlinks.rules
>   create mode 100644 test/TEST-14-IMSM/99-idesymlinks.rules
>   create mode 100644 test/TEST-20-NFS/99-idesymlinks.rules
>   create mode 100644 test/TEST-30-ISCSI/99-idesymlinks.rules
>   create mode 100644 test/TEST-40-NBD/99-idesymlinks.rules
>   create mode 100644 test/TEST-50-MULTINIC/99-idesymlinks.rules
>
> diff --git a/test/TEST-10-RAID/99-idesymlinks.rules b/test/TEST-10-RAID/99-idesymlinks.rules
> new file mode 100644
> index 0000000..d557790
> --- /dev/null
> +++ b/test/TEST-10-RAID/99-idesymlinks.rules
> @@ -0,0 +1,8 @@
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hda", SYMLINK+="sda"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hda*", SYMLINK+="sda$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdb", SYMLINK+="sdb"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdb*", SYMLINK+="sdb$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdc", SYMLINK+="sdc"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdc*", SYMLINK+="sdc$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdd", SYMLINK+="sdd"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdd*", SYMLINK+="sdd$env{MINOR}"
> diff --git a/test/TEST-10-RAID/test.sh b/test/TEST-10-RAID/test.sh
> index 154e124..8bc7b44 100755
> --- a/test/TEST-10-RAID/test.sh
> +++ b/test/TEST-10-RAID/test.sh
> @@ -39,6 +39,7 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install sfdisk mke2fs poweroff cp umount
>   	inst_simple ./create-root.sh /initqueue/01create-root.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>
>       # create an initramfs that will create the target root filesystem.
> @@ -46,7 +47,7 @@ test_setup() {
>       # devices, volume groups, encrypted partitions, etc.
>       $basedir/dracut -l -i overlay / \
>   	-m "dash crypt lvm mdraid udev-rules base rootfs-block kernel-modules" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod" \
>           --nomdadmconf \
>   	-f initramfs.makeroot $KVERSION || return 1
>       rm -rf overlay
> @@ -62,11 +63,12 @@ test_setup() {
>   	dracut_install poweroff shutdown
>   	inst_simple ./hard-off.sh /emergency/01hard-off.sh
>   	inst ./cryptroot-ask /sbin/cryptroot-ask
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>       sudo $basedir/dracut -l -i overlay / \
>   	-o "plymouth" \
>   	-a "debug" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod" \
>   	-f initramfs.testing $KVERSION || return 1
>   }
>
> diff --git a/test/TEST-11-LVM/99-idesymlinks.rules b/test/TEST-11-LVM/99-idesymlinks.rules
> new file mode 100644
> index 0000000..d557790
> --- /dev/null
> +++ b/test/TEST-11-LVM/99-idesymlinks.rules
> @@ -0,0 +1,8 @@
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hda", SYMLINK+="sda"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hda*", SYMLINK+="sda$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdb", SYMLINK+="sdb"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdb*", SYMLINK+="sdb$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdc", SYMLINK+="sdc"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdc*", SYMLINK+="sdc$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdd", SYMLINK+="sdd"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdd*", SYMLINK+="sdd$env{MINOR}"
> diff --git a/test/TEST-11-LVM/test.sh b/test/TEST-11-LVM/test.sh
> index f351114..ff6d751 100755
> --- a/test/TEST-11-LVM/test.sh
> +++ b/test/TEST-11-LVM/test.sh
> @@ -39,6 +39,7 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install sfdisk mke2fs poweroff cp umount
>   	inst_simple ./create-root.sh /initqueue/01create-root.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>
>       # create an initramfs that will create the target root filesystem.
> @@ -46,7 +47,7 @@ test_setup() {
>       # devices, volume groups, encrypted partitions, etc.
>       $basedir/dracut -l -i overlay / \
>   	-m "dash lvm mdraid udev-rules base rootfs-block kernel-modules" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod" \
>   	-f initramfs.makeroot $KVERSION || return 1
>       rm -rf overlay
>       # Invoke KVM and/or QEMU to actually create the target filesystem.
> @@ -60,11 +61,12 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install poweroff shutdown
>   	inst_simple ./hard-off.sh /emergency/01hard-off.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>       sudo $basedir/dracut -l -i overlay / \
>   	-o "plymouth" \
>   	-a "debug" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod" \
>   	-f initramfs.testing $KVERSION || return 1
>   }
>
> diff --git a/test/TEST-12-RAID-DEG/99-idesymlinks.rules b/test/TEST-12-RAID-DEG/99-idesymlinks.rules
> new file mode 100644
> index 0000000..d557790
> --- /dev/null
> +++ b/test/TEST-12-RAID-DEG/99-idesymlinks.rules
> @@ -0,0 +1,8 @@
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hda", SYMLINK+="sda"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hda*", SYMLINK+="sda$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdb", SYMLINK+="sdb"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdb*", SYMLINK+="sdb$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdc", SYMLINK+="sdc"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdc*", SYMLINK+="sdc$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdd", SYMLINK+="sdd"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdd*", SYMLINK+="sdd$env{MINOR}"
> diff --git a/test/TEST-12-RAID-DEG/test.sh b/test/TEST-12-RAID-DEG/test.sh
> index 9b76991..2d3d3c0 100755
> --- a/test/TEST-12-RAID-DEG/test.sh
> +++ b/test/TEST-12-RAID-DEG/test.sh
> @@ -74,14 +74,15 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install sfdisk mke2fs poweroff cp umount dd
>   	inst_simple ./create-root.sh /initqueue/01create-root.sh
> -    )
> + 	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
> +   )
>
>       # create an initramfs that will create the target root filesystem.
>       # We do it this way so that we do not risk trashing the host mdraid
>       # devices, volume groups, encrypted partitions, etc.
>       $basedir/dracut -l -i overlay / \
>   	-m "dash crypt lvm mdraid udev-rules base rootfs-block kernel-modules" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod" \
>   	-f initramfs.makeroot $KVERSION || return 1
>       rm -rf overlay
>       # Invoke KVM and/or QEMU to actually create the target filesystem.
> @@ -96,6 +97,7 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install poweroff shutdown
>   	inst_simple ./hard-off.sh /emergency/01hard-off.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>   	inst ./cryptroot-ask /sbin/cryptroot-ask
>           mkdir -p overlay/etc
>           echo "ARRAY /dev/md0 level=raid5 num-devices=3 UUID=$MD_UUID">  overlay/etc/mdadm.conf
> @@ -103,7 +105,7 @@ test_setup() {
>       sudo $basedir/dracut -l -i overlay / \
>   	-o "plymouth" \
>   	-a "debug" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod" \
>   	-f initramfs.testing $KVERSION || return 1
>   }
>
> diff --git a/test/TEST-13-ENC-RAID-LVM/99-idesymlinks.rules b/test/TEST-13-ENC-RAID-LVM/99-idesymlinks.rules
> new file mode 100644
> index 0000000..d557790
> --- /dev/null
> +++ b/test/TEST-13-ENC-RAID-LVM/99-idesymlinks.rules
> @@ -0,0 +1,8 @@
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hda", SYMLINK+="sda"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hda*", SYMLINK+="sda$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdb", SYMLINK+="sdb"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdb*", SYMLINK+="sdb$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdc", SYMLINK+="sdc"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdc*", SYMLINK+="sdc$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdd", SYMLINK+="sdd"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdd*", SYMLINK+="sdd$env{MINOR}"
> diff --git a/test/TEST-13-ENC-RAID-LVM/test.sh b/test/TEST-13-ENC-RAID-LVM/test.sh
> index ae3f870..2071a08 100755
> --- a/test/TEST-13-ENC-RAID-LVM/test.sh
> +++ b/test/TEST-13-ENC-RAID-LVM/test.sh
> @@ -39,6 +39,7 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install sfdisk mke2fs poweroff cp umount
>   	inst_simple ./create-root.sh /initqueue/01create-root.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>
>       # create an initramfs that will create the target root filesystem.
> @@ -46,7 +47,7 @@ test_setup() {
>       # devices, volume groups, encrypted partitions, etc.
>       $basedir/dracut -l -i overlay / \
>   	-m "dash crypt lvm mdraid udev-rules base rootfs-block kernel-modules" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod" \
>   	-f initramfs.makeroot $KVERSION || return 1
>       rm -rf overlay
>       # Invoke KVM and/or QEMU to actually create the target filesystem.
> @@ -60,12 +61,13 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install poweroff shutdown
>   	inst_simple ./hard-off.sh /emergency/01hard-off.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>   	inst ./cryptroot-ask /sbin/cryptroot-ask
>       )
>       sudo $basedir/dracut -l -i overlay / \
>   	-o "plymouth" \
>   	-a "debug" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod" \
>   	-f initramfs.testing $KVERSION || return 1
>   }
>
> diff --git a/test/TEST-14-IMSM/99-idesymlinks.rules b/test/TEST-14-IMSM/99-idesymlinks.rules
> new file mode 100644
> index 0000000..d557790
> --- /dev/null
> +++ b/test/TEST-14-IMSM/99-idesymlinks.rules
> @@ -0,0 +1,8 @@
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hda", SYMLINK+="sda"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hda*", SYMLINK+="sda$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdb", SYMLINK+="sdb"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdb*", SYMLINK+="sdb$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdc", SYMLINK+="sdc"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdc*", SYMLINK+="sdc$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdd", SYMLINK+="sdd"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdd*", SYMLINK+="sdd$env{MINOR}"
> diff --git a/test/TEST-14-IMSM/create-root.sh b/test/TEST-14-IMSM/create-root.sh
> index 2278878..78ec793 100755
> --- a/test/TEST-14-IMSM/create-root.sh
> +++ b/test/TEST-14-IMSM/create-root.sh
> @@ -4,7 +4,12 @@ for x in 61-dmraid-imsm.rules 65-md-incremental-imsm.rules 65-md-incremental.rul
>       >  "/etc/udev/rules.d/$x"
>   done
>   udevadm control --reload-rules
> -echo y|dmraid -f isw -C Test0 --type 1 --disk "/dev/sdb /dev/sdc"
> +# dmraid does not want symlinks in --disk "..."
> +if [ -e /dev/hda ] ; then
> +    echo y|dmraid -f isw -C Test0 --type 1 --disk "/dev/hdb /dev/hdc"
> +else
> +    echo y|dmraid -f isw -C Test0 --type 1 --disk "/dev/sdb /dev/sdc"
> +fi
>   udevadm settle
>
>   SETS=$(dmraid -c -s)
> diff --git a/test/TEST-14-IMSM/test.sh b/test/TEST-14-IMSM/test.sh
> index bfc186f..9215899 100755
> --- a/test/TEST-14-IMSM/test.sh
> +++ b/test/TEST-14-IMSM/test.sh
> @@ -61,6 +61,7 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install sfdisk mke2fs poweroff cp umount
>   	inst_simple ./create-root.sh /initqueue/01create-root.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>
>       # create an initramfs that will create the target root filesystem.
> @@ -68,7 +69,7 @@ test_setup() {
>       # devices, volume groups, encrypted partitions, etc.
>       $basedir/dracut -l -i overlay / \
>   	-m "dash lvm mdraid dmraid udev-rules base rootfs-block kernel-modules" \
> -	-d "ata_piix ext2 sd_mod dm-multipath dm-crypt dm-round-robin faulty linear multipath raid0 raid10 raid1 raid456" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod dm-multipath dm-crypt dm-round-robin faulty linear multipath raid0 raid10 raid1 raid456" \
>   	-f initramfs.makeroot $KVERSION || return 1
>       rm -rf overlay
>       # Invoke KVM and/or QEMU to actually create the target filesystem.
> @@ -82,11 +83,12 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install poweroff shutdown
>   	inst_simple ./hard-off.sh /emergency/01hard-off.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>       sudo $basedir/dracut -l -i overlay / \
>   	-o "plymouth" \
>   	-a "debug" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod" \
>   	-f initramfs.testing $KVERSION || return 1
>   }
>
> diff --git a/test/TEST-20-NFS/99-idesymlinks.rules b/test/TEST-20-NFS/99-idesymlinks.rules
> new file mode 100644
> index 0000000..d557790
> --- /dev/null
> +++ b/test/TEST-20-NFS/99-idesymlinks.rules
> @@ -0,0 +1,8 @@
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hda", SYMLINK+="sda"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hda*", SYMLINK+="sda$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdb", SYMLINK+="sdb"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdb*", SYMLINK+="sdb$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdc", SYMLINK+="sdc"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdc*", SYMLINK+="sdc$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdd", SYMLINK+="sdd"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdd*", SYMLINK+="sdd$env{MINOR}"
> diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
> index ad8e22d..53d0724 100755
> --- a/test/TEST-20-NFS/test.sh
> +++ b/test/TEST-20-NFS/test.sh
> @@ -272,19 +272,20 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install poweroff shutdown
>   	inst_simple ./hard-off.sh /emergency/01hard-off.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>
>       # Make server's dracut image
>       $basedir/dracut -l -i overlay / \
>   	-m "dash udev-rules base rootfs-block debug kernel-modules" \
> -	-d "ata_piix ext2 sd_mod e1000" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod e1000" \
>   	-f initramfs.server $KVERSION || return 1
>
>       # Make client's dracut image
>       $basedir/dracut -l -i overlay / \
>   	-o "plymouth" \
>   	-a "debug" \
> -	-d "e1000 nfs sunrpc" \
> +	-d "piix ide-gd_mod ata_piix sd_mod e1000 nfs sunrpc" \
>   	-f initramfs.testing $KVERSION || return 1
>   }
>
> diff --git a/test/TEST-30-ISCSI/99-idesymlinks.rules b/test/TEST-30-ISCSI/99-idesymlinks.rules
> new file mode 100644
> index 0000000..d557790
> --- /dev/null
> +++ b/test/TEST-30-ISCSI/99-idesymlinks.rules
> @@ -0,0 +1,8 @@
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hda", SYMLINK+="sda"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hda*", SYMLINK+="sda$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdb", SYMLINK+="sdb"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdb*", SYMLINK+="sdb$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdc", SYMLINK+="sdc"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdc*", SYMLINK+="sdc$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdd", SYMLINK+="sdd"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdd*", SYMLINK+="sdd$env{MINOR}"
> diff --git a/test/TEST-30-ISCSI/test.sh b/test/TEST-30-ISCSI/test.sh
> index b8ffc80..9f28942 100755
> --- a/test/TEST-30-ISCSI/test.sh
> +++ b/test/TEST-30-ISCSI/test.sh
> @@ -82,6 +82,7 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install sfdisk mke2fs poweroff cp umount
>   	inst_simple ./create-root.sh /initqueue/01create-root.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>
>       # create an initramfs that will create the target root filesystem.
> @@ -89,7 +90,7 @@ test_setup() {
>       # devices, volume groups, encrypted partitions, etc.
>       $basedir/dracut -l -i overlay / \
>   	-m "dash crypt lvm mdraid udev-rules base rootfs-block kernel-modules" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod" \
>   	-f initramfs.makeroot $KVERSION || return 1
>       rm -rf overlay
>
> @@ -111,11 +112,12 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install poweroff shutdown
>   	inst_simple ./hard-off.sh /emergency/01hard-off.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>       sudo $basedir/dracut -l -i overlay / \
>   	-o "plymouth dmraid" \
>   	-a "debug" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod" \
>   	-f initramfs.testing $KVERSION || return 1
>
>       # Make server root
> @@ -159,7 +161,7 @@ test_setup() {
>       # Make server's dracut image
>       $basedir/dracut -l -i overlay / \
>   	-m "dash udev-rules base rootfs-block debug kernel-modules" \
> -	-d "ata_piix ext2 sd_mod e1000" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod e1000" \
>   	-f initramfs.server $KVERSION || return 1
>
>   }
> diff --git a/test/TEST-40-NBD/99-idesymlinks.rules b/test/TEST-40-NBD/99-idesymlinks.rules
> new file mode 100644
> index 0000000..d557790
> --- /dev/null
> +++ b/test/TEST-40-NBD/99-idesymlinks.rules
> @@ -0,0 +1,8 @@
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hda", SYMLINK+="sda"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hda*", SYMLINK+="sda$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdb", SYMLINK+="sdb"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdb*", SYMLINK+="sdb$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdc", SYMLINK+="sdc"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdc*", SYMLINK+="sdc$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdd", SYMLINK+="sdd"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdd*", SYMLINK+="sdd$env{MINOR}"
> diff --git a/test/TEST-40-NBD/test.sh b/test/TEST-40-NBD/test.sh
> index 8b5cd8d..c57fd3f 100755
> --- a/test/TEST-40-NBD/test.sh
> +++ b/test/TEST-40-NBD/test.sh
> @@ -192,6 +192,7 @@ make_encrypted_root() {
>   	. $basedir/dracut-functions
>   	dracut_install mke2fs poweroff cp umount
>   	inst_simple ./create-root.sh /initqueue/01create-root.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>
>       # create an initramfs that will create the target root filesystem.
> @@ -199,7 +200,7 @@ make_encrypted_root() {
>       # devices, volume groups, encrypted partitions, etc.
>       $basedir/dracut -l -i overlay / \
>   	-m "dash crypt lvm mdraid udev-rules base rootfs-block kernel-modules" \
> -	-d "ata_piix ext2 sd_mod" \
> +	-d "piix ide-gd_mod ata_piix ext2 ext3 sd_mod" \
>   	-f initramfs.makeroot $KVERSION || return 1
>       rm -rf overlay
>
> @@ -290,18 +291,19 @@ test_setup() {
>   	. $basedir/dracut-functions
>   	dracut_install poweroff shutdown
>   	inst_simple ./hard-off.sh /emergency/01hard-off.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>   	inst ./cryptroot-ask /sbin/cryptroot-ask
>       )
>
>       sudo $basedir/dracut -l -i overlay / \
>   	-m "dash udev-rules rootfs-block base debug kernel-modules" \
> -	-d "ata_piix ext2 sd_mod e1000" \
> +	-d "piix ide-gd_mod ata_piix ext2 ext3 sd_mod e1000" \
>   	-f initramfs.server $KVERSION || return 1
>
>       sudo $basedir/dracut -l -i overlay / \
>   	-o "plymouth" \
>   	-a "debug" \
> -	-d "ata_piix ext2 ext3 sd_mod e1000" \
> +	-d "piix ide-gd_mod ata_piix ext2 ext3 sd_mod e1000" \
>   	-f initramfs.testing $KVERSION || return 1
>   }
>
> diff --git a/test/TEST-50-MULTINIC/99-idesymlinks.rules b/test/TEST-50-MULTINIC/99-idesymlinks.rules
> new file mode 100644
> index 0000000..d557790
> --- /dev/null
> +++ b/test/TEST-50-MULTINIC/99-idesymlinks.rules
> @@ -0,0 +1,8 @@
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hda", SYMLINK+="sda"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hda*", SYMLINK+="sda$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdb", SYMLINK+="sdb"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdb*", SYMLINK+="sdb$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdc", SYMLINK+="sdc"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdc*", SYMLINK+="sdc$env{MINOR}"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="disk", KERNEL=="hdd", SYMLINK+="sdd"
> +ACTION=="add|change", SUBSYSTEM=="block", ENV{DEVTYPE}=="partition", KERNEL=="hdd*", SYMLINK+="sdd$env{MINOR}"
> diff --git a/test/TEST-50-MULTINIC/test.sh b/test/TEST-50-MULTINIC/test.sh
> index 252d569..fca9947 100755
> --- a/test/TEST-50-MULTINIC/test.sh
> +++ b/test/TEST-50-MULTINIC/test.sh
> @@ -198,19 +198,20 @@ test_setup() {
>    	. $basedir/dracut-functions
>    	dracut_install poweroff shutdown
>    	inst_simple ./hard-off.sh /emergency/01hard-off.sh
> +	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
>       )
>
>       # Make server's dracut image
>       $basedir/dracut -l -i overlay / \
>   	-m "dash udev-rules base rootfs-block debug kernel-modules" \
> -	-d "ata_piix ext2 sd_mod e1000" \
> +	-d "piix ide-gd_mod ata_piix ext2 sd_mod e1000" \
>   	-f initramfs.server $KVERSION || return 1
>
>       # Make client's dracut image
>       $basedir/dracut -l -i overlay / \
>   	-o "plymouth" \
>   	-a "debug" \
> -	-d "e1000 nfs sunrpc" \
> +	-d "piix ide-gd_mod e1000 nfs sunrpc" \
>   	-f initramfs.testing $KVERSION || return 1
>   }
>
