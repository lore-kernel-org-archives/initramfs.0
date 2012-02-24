From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 017 release
Date: Fri, 24 Feb 2012 15:42:03 +0100
Message-ID: <4F47A1BB.8060104@redhat.com>
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

dracut-017
==========
- a _lot_ faster than dracut-016 in image creation
- systemd service dracut-shutdown.service
- livenet fixes
- ssh-client module install fix
- root=iscsi:... fixed
- lots of restructuring and optimizing in dracut-functions.sh
- usrmount: honor fs_passno in /etc/fstab
- renamed all shell scripts to .sh
- new option "--omit-drivers" and config option "omit_drivers"
- hostonly mode fixups
