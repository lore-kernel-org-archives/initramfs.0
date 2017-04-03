From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 045
Date: Mon, 3 Apr 2017 10:49:40 +0200
Message-ID: <a2ab4f0c-10a4-2c02-d781-ee6854b1793a@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 2517B8124B
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Long time, no release...

Here comes a new dracut version. Thanks to all who have contributed to this
release.

The tarball can be found here:
        http://www.kernel.org/pub/linux/utils/boot/dracut/
        ftp://ftp.kernel.org/pub/linux/utils/boot/dracut/
        https://github.com/dracutdevs/dracut/releases/

Report Issues:
        https://github.com/dracutdevs/dracut/issues

File Pull Requests:
        https://github.com/dracutdevs/dracut/pulls

Git:
        git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:dracutdevs/dracut.git
        https://github.com/dracutdevs/dracut.git
        git://git.kernel.org/pub/scm/boot/dracut/dracut.git
        http://git.kernel.org/pub/scm/boot/dracut/dracut.git
        https://git.kernel.org/pub/scm/boot/dracut/dracut.git

Git Web:
        https://github.com/dracutdevs/dracut
        http://git.kernel.org/?p=boot/dracut/dracut.git

Git Web RSS Feed:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=rss

Project Page:
        http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

Project Wiki:
        http://dracut.wiki.kernel.org

The ChangeLog can be found here:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS


dracut-045
==========

Important: dracut now requires libkmod for the dracut-install binary helper,
           which nows handles kernel module installing and filtering.

dracut.sh:
- restorecon final image file
- fail hard, if we find modules and modules.dep is missing
- support --tmpdir as a relative path
- add default path for --uefi

dracut-functions.sh:
- fix check_vol_slaves() volume group name stripping

dracut-install:
- catch ldd message "cannot execute binary file"
- added kernel module handling with libkmod
  Added parameters:
    --module,-m
    --mod-filter-path, -p
    --mod-filter-nopath, -P
    --mod-filter-symbol, -s
    --mod-filter-nosymbol, -S
    --mod-filter-noname, -N
    --silent
    --kerneldir
    --firmwaredirs
- fallback to non-hostonly mode if lsmod fails

lsinitrd:
- new option "--unpack"
- new option "--unpackearly"
- and "--verbose"

general initramfs fixes:
- don't remove 99-cmdline-ask on 'hostonly' cleanup
- call dracut-cmdline-ask.service, if /etc/cmdline.d/*.conf exists
- break at switch_root only for bare rd.break
- add rd.emergency=[reboot|poweroff|halt]
  specifies what action to execute in case of a critical failure
- rd.memdebug=4 gives information, about kernel module memory consumption
  during loading

dmsquash-live:
- fixed livenet-generator execution flag
  and include only, if systemd is used
- fixed dmsquash-live-root.sh for cases where the fstype of the liveimage is squashfs
- fixed typo for rootfs.img
- enable the use of the OverlayFS for the LiveOS root filesystem
  Patch notes:
    Integrate the option to use an OverlayFS as the root filesystem
    into the 90dmsquash-live module for testing purposes.

    The rd.live.overlay.overlayfs option allows one to request an
    OverlayFS overlay.  If a persistent overlay is detected at the
    standard LiveOS path, the overlay & type detected will be used.

    Tested primarily with transient, in-RAM overlay boots on vfat-
    formatted Live USB devices, with persistent overlay directories
    on ext4-formatted Live USB devices, and with embedded, persistent
    overlay directories on vfat-formatted devices. (Persistent overlay
    directories on a vfat-formatted device must be in an embedded
    filesystem that supports the creation of trusted.* extended
    attributes, and must provide valid d_type in readdir responses.)

    The rd.live.overlay.readonly option, which allows a persistent
    overlayfs to be mounted read only through a higher level transient
    overlay directory, has been implemented through the multiple lower
    layers feature of OverlayFS.

    The default transient DM overlay size has been adjusted up to 32 GiB.
    This change supports comparison of transient Device-mapper vs.
    transient OverlayFS overlay performance.  A transient DM overlay
    is a sparse file in memory, so this setting does not consume more
    RAM for legacy applications.  It does permit a user to use all of
    the available root filesystem storage, and fails gently when it is
    consumed, as the available free root filesystem storage on a typical
    LiveOS build is only a few GiB.  Thus, when booted on other-
    than-small RAM systems, the transient DM overlay should not overflow.

    OverlayFS offers the potential to use all of the available free RAM
    or all of the available free disc storage (on non-vfat-devices)
    in its overlay, even beyond the root filesystem available space,
    because the OverlayFS root filesystem is a union of directories on
    two different partitions.

    This patch also cleans up some message spew at shutdown, shortens
    the execution path in a couple of places, and uses persistent
    DM targets where required.

dmraid:
- added "nowatch" option in udev rule, otherwise udev would reread partitions for raid members
- allow booting from degraded MD RAID arrays

shutdown:
- handle readonly /run on shutdown

kernel-modules:
- add all HID drivers, regardless of hostonly mode
  people swap keyboards sometimes and should be able to enter their disk password
- add usb-storage
  To save the rdsosreport.txt to a USB stick, the usb-storage module is needed.
- add xennet
- add nvme

systemd:
- add /etc/machine-info
- fixed systemd-escape call for names beginning with "-"
- install missing drop-in configuration files for
    /etc/systemd/{journal.conf,system.conf}

filesystems:
- add support to F2FS filesystem (fsck and modules)

network:
- fix carrier detection
- correctly set mac address for ip=...:<mtu>:<mac>
- fixed vlan, bonding, bridging, team logic
  call ifup for the slaves and assemble afterwards
- add mtu to list of variables to store in override
- for rd.neednet=0 a bootdev is not needed anymore
- dhclient-script.sh: add classless-static-routes support
- support for iBFT IPv6
- support macaddr in brackets [] (commit 740c46c0224a187d6b5a42b4aa56e173238884cc)
- use arping2, if available
- support multiple default gateways from DHCP server
- fixup VLAN handling
- enhance team support
- differ between ipv6 local and global tentative
- ipv6: wait for a router advertised route
- add 'mtu' parameter for bond options
- use 'ip' instead of 'brctl'

nbd:
- add systemd generator
- use export names instead of port numbers, because port number based
  exports are deprecated and were removed.

fcoe:
- no more /dev/shm state copying

multipath:
- check all /dev/mapper devices if they are multipath devices, not only mpath*

fips:
- fixed .hmac installation in FIPS mode

plymouth:
- also trigger the acpi subsystem

syslog:
- add imjournal.so to read systemd journal
- move start from udev to initqueue/online

caps:
- make it a non default module

livenet:
- support nfs:// urls in livenet-generator

nfs:
- install all nfs modules non-hostonly

crypt:
- support keyfiles embedded in the initramfs

testsuite:
- add TEST-70-BONDBRIDGETEAMVLAN
- make "-cpu host" the default
