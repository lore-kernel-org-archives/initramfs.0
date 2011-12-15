From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 014 release
Date: Thu, 15 Dec 2011 13:40:32 +0100
Message-ID: <4EE9EAC0.4060700@redhat.com>
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


dracut-014
==========
- new dracut arguments:
  --lvmconf
  --nolvmconf
  --fscks [LIST]
  --nofscks
- new .conf options:
  install_items
  fscks
  nofscks
- new kernel options:
  rd.md.ddf
  rd.md.waitclean
  plymouth.enable
- dracut move from /sbin to /usr/bin
- dracut modules dir moved from /usr/share/dracut to /usr/lib/dracut
- profiling with "dracut --profile"
- new TEST-16-DMSQUASH, test for Fedora LiveCDs
- speedup of initramfs creation
- ask_for_password fallback to CLI
- mdraid completely switched to incremental assembly
- no more cdrom polling
- "switch_root" breakpoint is now very late
- /dev/live is gone
- /dev/root is gone
- fs-lib dracut module for fscks added
- xen dracut module removed
- usb mass storage kernel drivers now included
- usrmount dracut module added:
  mount /usr if found in /sysroot/etc/fstab
- only include fsck helper needed for hostonly
- fcoe: support for bnx2fc
- support iSCSI drivers: qla4xxx, cxgb3i, cxgb4i, bnx2i, be2iscsi
- fips-aesni dracut module added
- add install_items to dracut.conf
    install_items+=" <file>[ <file> ...] "
- speedup internal testsuite
- internal testsuite: store temporary data in a temporary dir

dracut-013
==========
- speedup of initramfs creation
- fixed inst_dir for symbolic links
- add unix kernel module
