From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 011 release
Date: Mon, 18 Jul 2011 18:13:07 +0200
Message-ID: <4E245B93.4090205@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
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


dracut-011
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- use udev-168 features for shutting down udev
- introduce "--prefix" to put all initramfs files in e.g "/run/initramf=
s"
- new shutdown script (called by systemd >=3D 030) to disassemble the r=
oot device
- lots of bugfixes
- new module for gpg-encrypted keys - 91crypt-gpg


   107  Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
    11  Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
     8  Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
     3  Marian Ganisin <mganisin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
     2  Alan Pevec <apevec-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
     1  Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
