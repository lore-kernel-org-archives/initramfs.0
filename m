From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 018 release
Date: Thu, 05 Apr 2012 14:38:13 +0200
Message-ID: <4F7D9235.4000501@redhat.com>
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

dracut-018
==========
- lvm: ignore lvm mirrors
- lsinitrd: handle LZMA images
- iscsi: add rd.iscsi.param
- iscsi: add iscsi interface binding
- new module cms to read and handle z-Series cms config files
- fixed fstab.sys handling
- new dracut option "--tmpdir"
- new dracut option "--no-hostonly"
- nbd: name based nbd connects
- converted manpage and documentation source to asciidoc
- write-ifcfg fixes and cleanups
- ifup is now done in the initqueue
- netroot cleanup
- initqueue/online is now for hooks, which require network
- no more /tmp/root.info
- 98pollcdrom: factored out the ugly cdrom polling in the main loop
- simplified rd.luks.uuid testing
- removed "egrep" and "ls" calls
- speedup kernel module installation
- make bzip2 optional
- lots of bugfixes
