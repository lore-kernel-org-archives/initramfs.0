From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 007 release
Date: Wed, 11 Aug 2010 18:10:17 +0200
Message-ID: <4C62CB69.5000907@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Here comes a new dracut version. Thanks to all who have contributed to
this release.

The tarball can be found here:
  http://sourceforge.net/projects/dracut/files/

The development repository can be found here:
  http://dracut.git.sourceforge.net/git/gitweb.cgi?p=3Ddracut/dracut;a=3D=
summary

dracut-007
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- module i18n is no longer fedora/red hat specific (Amadeusz =C5=BBo=C5=
=82nowski)
- distribution specific conf file
- bootchartd support
- debug module now has fsck
- use "hardlink", if available, to safe some space
- /etc/dracut.conf can be overwritten by settings in /etc/dracut.conf.d=
/*.conf
- gentoo splash module
- --ignore-kernel-modules option
- crypto keys on external devices support
- bugfixes
