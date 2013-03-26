From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut-027
Date: Tue, 26 Mar 2013 17:06:20 +0100
Message-ID: <5151C77C.3020807@redhat.com>
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


dracut-027
==========
- dracut now has bash-completion
- require bash version 4
- systemd module now requires systemd >= 199
- dracut makes use of native systemd initrd units
- added hooks for new-kernel-pkg and kernel-install
- hostonly is now default for fedora
- comply with the BootLoaderSpec paths
  http://www.freedesktop.org/wiki/Specifications/BootLoaderSpec
- added rescue module
- host_fs_types is now a hashmap
- new dracut argument "--regenerate-all"
- new dracut argument "--noimageifnotneeded"
- new man page dracut.bootup
- install all host filesystem drivers
- use -D_FILE_OFFSET_BITS=64 to build dracut-install
