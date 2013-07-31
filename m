From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 031
Date: Wed, 31 Jul 2013 14:34:07 +0200
Message-ID: <51F9043F.40105@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Here comes a new dracut version. Thanks to all who have contributed to =
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

dracut-031
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- do not include the resume dracut module in hostonly mode,
  if no swap is present
- don't warn twice about omitted modules
- use systemd-cat for logging on systemd systems, if logfile is unset
- fixed PARTUUID parsing
- support kernel module signing keys
- do not install the usrmount dracut module in hostonly mode,
  if /sbin/init does not live in /usr
- add debian udev rule files
- add support for bcache
- network: handle bootif style interfaces
  e.g. ip=3D77-77-6f-6f-64-73:dhcp
- add support for kmod static devnodes
- add vlan support for iBFT

Contributions from:
Harald Hoyer
Amadeusz =C5=BBo=C5=82nowski
Brandon Philips
Colin Walters
James Lee
Kyle McMartin
Peter Jones
