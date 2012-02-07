From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 015 release
Date: Tue, 07 Feb 2012 21:56:11 +0100
Message-ID: <4F318FEB.8070704@redhat.com>
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


dracut-015
==========
- hostonly mode automatically adds command line options for root and /usr
- --add-fstab --mount parameters
- ssh-client module
- --ctty option: add job control
- openvte: add job control via openvte, if installed
- cleanup /run/initramfs
- convertfs module
- /sbin/ifup can be called directly
- support kernel modules compressed with xz
- s390 iscsi modules added
- terminfo module
- lsinitrd can handle concatened images
- lsinitrd can sort by size
