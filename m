From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 021 release
Date: Fri, 20 Jul 2012 12:05:55 +0200
Message-ID: <50092D83.1010003@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >> \"initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org\"" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

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


dracut-021
==========
- fixed systemd in the initramfs (requires systemd >= 187)
- dracut-install: massive speedup with /var on the same filesystem with COW copy
- dracut-install: moved to /usr/lib/dracut until it becomes a general
  purpose tool
- new options: "rd.usrmount.ro" and "rd.skipfsck"
- less mount/umount
- apply "ro" on the kernel command line also to /usr
- mount according to fstab, if neither "ro" or "rw" is specified
- skip fsck for xfs and btrfs. remount is enough
- give emergency_shell if /usr mount failed
- dracut now uses getopt:
  * options can be position independent now!!
  * we can now use --option=<arg>
- added option "--kver=<kernel-version>", and the image location can be omitted
  # dracut --kver 3.5.0-0.rc7.git1.2.fc18.x86_64
- dracut.sh: for --include copy also the symbolic links
- man pages: lsinitrd and mkinitrd added
- network: We do not support renaming in the kernel namespace anymore
  (as udev does that not anymore). So, if a user wants to use ifname, he has to
  rename to a custom namespace. "eth[0-9]+" is not allowed anymore. !!!!!
- resume: moved the resume process to the initqueue.
  This should prevent accidently mounting the root file system.
- testsuite: add support for: make V=1 TESTS="01 20 40" check
    $ sudo make V=1 clean check
    now runs the testsuite in verbose mode

    $ sudo make TESTS="01 20 40" clean check
    now only runs the 01, 20 and 40 tests.
