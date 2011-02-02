From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 008 release
Date: Wed, 02 Feb 2011 18:15:35 +0100
Message-ID: <4D499137.4070903@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Here comes a new dracut version. Thanks to all who have contributed to
this release.

The tarball can be found here:
 http://sourceforge.net/projects/dracut/files/

The development repository can be found here:
 http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut;a=summary

dracut-008
==========
- removed --ignore-kernel-modules option (no longer necessary)
- renamed kernel command line arguments to follow the rd. naming scheme
- merged check, install, installkernel to module-setup.sh
- support for bzip2 and xz compressed initramfs images.
- source code beautification
- lots of documentation
- lsinitrd: "catinitrd" functionality
- dracut: --list-modules
- lvm: support for dynamic LVM SNAPSHOT root volume
- 95fstab-sys: mount all /etc/fstab.sys volumes before switch_root
- 96insmodpost dracut module
- rd.shell=1 per default
- rootfs-block:mount-root.sh add fsck
- busybox shell replacements module
- honor old "real_init="
- 97biosdevname dracut module
