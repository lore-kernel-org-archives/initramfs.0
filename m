From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 029
Date: Fri, 14 Jun 2013 15:35:46 +0200
Message-ID: <51BB1C32.7050105@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Release early, release often... Before you run into those problems found after
releasing 028, here comes a new dracut version. Thanks to all who have
contributed to this release.

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


dracut-029
==========
- wait for IPv6 autoconfiguration
- i18n: make the default font configurable
  To set the default font for your distribution, add
  i18n_default_font="latarcyrheb-sun16"
  to your /lib/dracut/dracut.conf.d/01-dist.conf distribution config.
- proper handle "rd.break" in systemd mode before switch-root
- systemd: make unit files symlinks
- build without dash requirement
- add dracut-shutdown.service.8 manpage
- handle MACs for "ip="
  "ip=77-77-6f-6f-64-73:dhcp"
- don't explode when mixing BOOTIF and ip=
- 90lvm/module-setup.sh: redirect error message of lvs to /dev/null

Contributions from:
Harald Hoyer
Will Woods
Baoquan He
