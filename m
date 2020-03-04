From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 050
Date: Wed, 4 Mar 2020 14:55:50 +0100
Message-ID: <e838111c-697b-1073-4050-1ebe0c87a071@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583330158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eS4Q8pD7hyVygIMYJ4EYReJZIKqRK7cvzcLREMBNc/o=;
        b=hwcX7CAbYBr1IRwFSXOZT+xe38Q4+/FwtFYJ6dmPSylg3F5yvO7cyIFNu4ztH/gVLvbupg
        mG9RX0C03va8c15cSGZl1iVQDygeY64gQGT8w1pZyrk4qpz8et/J9QpcxSnyHhIwIAfrnW
        oeAqpNk/sP4TzG7hQMWSzFqrb+ntYKk=
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Long time, no release...

Here comes a new dracut version. Thanks to all who have contributed to this
release.

The tarball can be found here:
         http://www.kernel.org/pub/linux/utils/boot/dracut/
         ftp://ftp.kernel.org/pub/linux/utils/boot/dracut/
         https://github.com/dracutdevs/dracut/releases/

Report Issues:
         https://github.com/dracutdevs/dracut/issues

File Pull Requests:
         https://github.com/dracutdevs/dracut/pulls

Git:
         git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:dracutdevs/dracut.git
         https://github.com/dracutdevs/dracut.git
         git://git.kernel.org/pub/scm/boot/dracut/dracut.git
         http://git.kernel.org/pub/scm/boot/dracut/dracut.git
         https://git.kernel.org/pub/scm/boot/dracut/dracut.git

Git Web:
         https://github.com/dracutdevs/dracut
         http://git.kernel.org/?p=boot/dracut/dracut.git

Git Web RSS Feed:
         http://git.kernel.org/?p=boot/dracut/dracut.git;a=rss

Project Page:
         http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

Project Wiki:
         http://dracut.wiki.kernel.org

The ChangeLog can be found here:
         http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS


dracut-050
==========

dracut:
- support for running on a cross-compiled rootfs, see README.cross
- add support for creating secureboot signed UEFI images
- use microcode found in packed cpio images
- `-k/--kmodir` must now contain "lib/modules/$KERNEL_VERSION"
   use DRACUT_KMODDIR_OVERRIDE=1 to ignore this check
- support the EFI Stub loader's splash image feature.
   `--uefi-splash-image <FILE>`

dracut modules:
- remove bashism in various boot scripts
- emergency mode: use sulogin

fcoe:
- add rd.nofcoe option to disable the FCoE module from the command line

10i18n:
- fix keymaps not getting included sometimes
- use eurlatgr as default console font

iscsi:
- add option `rd.iscsi.testroute`

multipath:
- fix udev rules detection of multipath devices

network:
- support NetworkManager

network-legacy:
- fix classless static route parsing
- ifup: fix typo when calling dhclient --timeout
- ifup: nuke pid and lease files if dhclient failed
- fix ip=dhcp,dhcp6
- use $name instead of $env{INTERFACE} (systemd-udevd regression)

shutdown:
- fix for non-systemd reboot/halt/shutdown commands
- set selinux labels
- fix shutdown with console=null

lsinitrd:
- list squash content as well
- handle UEFI created with dracut --uefi
- make lsinitrd usable for images made with Debian mkinitramfs

dracut-install:
- fixed ldd parsing
- install kernel module dependencies of dependencies
- fixed segfault for hashing NULL pointers
- add support for compressed firmware files
- dracut_mkdir(): create parent directories as needed.

test suite:
- lots of cleanups
- add github actions

new modules:
- rngd
- network-manager
- ppcmac - thermal/fan control modules on PowerPC based Macs

