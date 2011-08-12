From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 013 release
Date: Fri, 12 Aug 2011 16:26:19 +0200
Message-ID: <4E45380B.8050905@redhat.com>
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


dracut-013
==========
- speedup of initramfs creation
- fixed inst_dir for symbolic links
- add unix kernel module

dracut-012
==========
- better fsck handling
- fixed wait condition for LVM volumes
- fix for hardlinks (welcome Debian! :-)
- shutdown bugfixes
- automatic busybox symlink creation
- try to mount /usr, if init points to a path in /usr
- btrfs with multiple devices
- "--force-add" option for dracut, to force-add dracut modules,
  without hostonly checks
- lsinitrd also display the initramfs size in human readable form
- livenet module, to mount live-isos over http
- masterkey,ecryptfs,integrity security modules
- initqueue/timeout queue e.g. for starting degraded raids
- "make rpm" creates an rpm with an increasing release number from any
  git checkout
- support lvm mirrors
- start degraded lvm mirrors after a timeout
- start degraded md raids after a timeout
- getarg() now returns wildcards without file matching to the current fs
- lots of bugfixes

    58  Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
     5  Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
     4  Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
     4  Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
     3  Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
     1  Thomas Lange <lange-jNDFPZUTrfRKC+uPiMyuu7CDI8haxt8Z@public.gmane.org>
