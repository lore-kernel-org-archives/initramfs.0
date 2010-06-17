From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 006 release
Date: Thu, 17 Jun 2010 14:01:42 +0200
Message-ID: <4C1A0EA6.7070601@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Here comes a new dracut version. Thanks to all who have contributed to
this release.

The tarball can be found here:
  http://sourceforge.net/projects/dracut/files/

The development repository can be found here:
  http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut;a=summary

dracut-006
==========
- fixed mdraid with IMSM
- fixed dracut manpages
- dmraid parse different error messages
- add cdrom polling mechanism for slow cdroms
- add module btrfs
- add btrfsctl scan for btrfs multi-devices (raid)
- teach dmsquash live-root to use rootflags
- trigger udev with action=add
- fixed add_drivers handling
- add sr_mod
- use pigz instead of gzip, if available
- boot from LVM mirrors and snapshots
- iscsi: add support for multiple netroot=iscsi:
- Support old version of module-init-tools
- got rid of rdnetdebug
- fixed "ip=auto6"
- dracut.conf: use "+=" as default for config variables
- bugfixes
