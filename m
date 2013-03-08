From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut-026
Date: Fri, 08 Mar 2013 11:38:57 +0100
Message-ID: <5139BFC1.7000601@redhat.com>
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


dracut-026
==========
- introduce /usr/lib/dracut/dracut.conf.d/ drop-in directory

  /usr/lib/dracut/dracut.conf.d/*.conf can be overwritten by the same
  filenames in /etc/dracut.conf.d.

  Packages should use /usr/lib/dracut/dracut.conf.d rather than
  /etc/dracut.conf.d for drop-in configuration files.

  /etc/dracut.conf and /etc/dracut.conf.d belong to the system administrator.

- uses systemd-198 native initrd units
- totally rely on the fstab-generator in systemd mode for block devices
- dracut systemd now uses dracut.target rather than basic.target
- dracut systemd services optimize themselves away
- fixed hostonly parameter generation
- turn off curl globbing (fixes IPv6)
- modify the udev rules on install and not runtime time
- enable initramfs building without kernel modules (fixed regression)
- in the initqueue/timeout,
  reset the main loop counter, as we see new udev events or initqueue/work
- fixed udev rule installation
