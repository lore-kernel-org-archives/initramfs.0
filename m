From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 038
Date: Mon, 30 Jun 2014 12:09:49 +0200
Message-ID: <53B1376D.5020905@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here comes a new dracut version. Thanks to all who have contributed to this
release.

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


dracut-038
==========
- "rd.cmdline=ask" will ask the user on the console to enter additional
  kernel command line parameters
- "rd.hostonly=0" removes all "hostonly" added custom files,
  which is useful in combination with "rd.auto" or other specific parameters,
  if you want to boot on the same hardware, but the compiled in configuration
  does not match your setup anymore
- inst* functions and dracut-install now accept the "-H" flag, which logs all
  installed files to /lib/dracut/hostonly-files. This is used to remove those
  files, if rd.hostonly is given on the kernel command line
- strstr now only does literal string match,
  please use strglob and strglobin for globs
- fixed unpacking of the microcode image on shutdown
- added systemd-gpt-auto-generator
- fcoe: wait for lldpad to be ready
- network: handle "ip=dhcp6"
- network: DCHPv6: set valid_lft and preferred_lft
- dm: support dm-cache
- fstab: do not mount and fsck from fstab if using systemd
- break at switch_root only for bare rd.break and not for any rd.break=...
- nbd: make use of "--systemd-mark", otherwise it gets killed on switch_root
- fcoe-uefi: fixed cmdline parameter generation
- iscsi: deprecate "ip=ibft", use "rd.iscsi.ibft[=1]" from now on
- "lsinitrd -m" now only lists the dracut modules of the image
- a lot of small bugfixes
