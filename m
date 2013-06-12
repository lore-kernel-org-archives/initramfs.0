From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 028
Date: Wed, 12 Jun 2013 15:28:05 +0200
Message-ID: <51B87765.4040207@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

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
        http://git.kernel.org/?p=3Dboot/dracut/dracut.git

Git Web RSS Feed:
        http://git.kernel.org/?p=3Dboot/dracut/dracut.git;a=3Drss

Project Page:
        http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

Project Wiki:
        http://dracut.wiki.kernel.org

The ChangeLog can be found here:
        http://git.kernel.org/?p=3Dboot/dracut/dracut.git;a=3Dblob_plai=
n;f=3DNEWS


dracut-028
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- full integration of crypto devs in systemd logic
- support for bridge over team and vlan tagged team
- support multiple bonding interfaces
- new kernel command line param "rd.action_on_fail"
  to control the emergency action
- support for bridge over a vlan tagged interface
- support for "iso-scan/filename" kernel parameter
- lsinitrd got some love and does not use "file" anymore
- fixed issue with noexec mounted tmp dirs
- FIPS mode fixed
- dracut_install got some love
- fixed some /usr mounting problems
- ifcfg dracut module got some love and fixes
- default installed font is now latarcyrheb-sun16
- new parameters rd.live.dir and rd.live.squashimg
- lvm: add tools for thin provisioning
- also install non-hwcap libs
- setup correct system time and time zone in initrd
- s390: fixed cms setup
- add systemd-udevd persistent network interface naming

Contributions from:
Harald Hoyer
Kamil Rytarowski
WANG Chao
Baoquan He
Adam Williamson
Colin Guthrie
Dan Hor=E1k
Dave Young
Dennis Gilmore
Dennis Schridde
