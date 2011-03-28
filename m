From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 009 release
Date: Mon, 28 Mar 2011 22:27:04 +0200
Message-ID: <4D90EF18.3020600@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

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


dracut-009
==========
- dracut generator
  - dracut-logger
  - xz compression
  - better argument handling

- initramfs
  - hooks moved to /lib/dracut/hooks in initramfs
  - rd.driver.{blacklist|pre|post} accept comma seperated driver list
  - iSCSI: iSCSI Boot Firmware Table (iBFT) support
  - support for /run
  - live image: support for generic rootfs.img (instead of ext3fs.img)
  - caps module
  - FCoE: EDD support
