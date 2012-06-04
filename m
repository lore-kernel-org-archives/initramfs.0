From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 019 release
Date: Mon, 04 Jun 2012 14:28:45 +0200
Message-ID: <4FCCA9FD.6030208@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here comes a new dracut version. Thanks to all who have contributed to
this release.

The tarball can be found here:
	http://www.kernel.org/pub/linux/utils/boot/dracut/
	ftp://ftp.kernel.org/pub/linux/utils/boot/dracut/

Git:
	git://git.kernel.org/pub/scm/boot/dracut/dracut.git
	http://git.kernel.org/pub/scm/boot/dracut/dracut.git
	https://git.kernel.org/pub/scm/boot/dracut/dracut.git

Git Web:
	http://git.kernel.org/?p=boot/dracut/dracut.git

Git Web RSS Feed:
	http://git.kernel.org/?p=boot/dracut/dracut.git;a=rss

Project Page:
	http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

Project Wiki:
	http://dracut.wiki.kernel.org

The ChangeLog can be found here:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS

dracut-019
==========
- initqueue/online hook
- fixes for ifcfg write out
- rootfs-block: avoid remount when options don't change
- Debian multiarch support
- virtfs root filesystem support
- cope with systemd-udevd
- mount tmpfs with strictatime
- include all kernel/drivers/net/phy drivers
- add debug_on() and debug_off() functions
- add arguments for source_hook() and source_all()
- cleanup hook
- plymouth: get consoledev from /sys/class/tty/console/active
- experimental systemd dracut module for systemd in the initramfs
- install xhci-hcd kernel module
- dracut: new "--mount" option
- lsinitrd: new option --printsize
- ARM storage kernel modules added
- s390 cms conf file support
- /etc/initrd-release in the initrd
- vlan support
- full bonding and bridge support
- removed scsi_wait_scan kernel module from standard install
- support rd.luks.allow-discards and honor options in crypttab
- lots of bugfixes
