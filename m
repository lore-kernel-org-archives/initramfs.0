From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 023 release
Date: Wed, 01 Aug 2012 15:33:20 +0200
Message-ID: <50193020.4000002@redhat.com>
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

dracut-023
==========
- resume from hibernate fixes
- -N option for --no-hostonly
- support for systemd crypto handling
- new dracut module "crypt-loop"
- deprecate the old kernel command line options
- more documentation
- honor CFLAGS for dracut-install build
- multipath fixes
- / is mounted according to rootflags parameter but forced ro at first.
  Later it is remounted according to /etc/fstab + rootflags parameter
  and "ro"/"rw".
- support for xfs / reiserfs separate journal device
- new "ro_mnt" option to force ro mount of / and /usr
- root on cifs support
- dracut-install: fixed issue for /var/tmp containing a symlink
- only lazy resolve with ldd, if the /var/tmp partition is not mounted with "noexec"
- i18n: fixed inclusion of "include" keymaps
