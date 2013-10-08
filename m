From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 034
Date: Tue, 08 Oct 2013 12:23:08 +0200
Message-ID: <5253DD0C.7050506@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Here comes a new dracut version. Thanks to all who have contributed to this release.

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



dracut-034
==========
- do not run dhcp on parts of assembled network interfaces (bond, bridge)
- add option to turn on/off prelinking
    --prelink, --noprelink
    do_prelink=[yes|no]
- add ACPI table overriding
- do not log to syslog/kmsg/journal for UID != 0
- lvm/mdraid: Fix LVM on MD activation
- bcache module removed (now in bcache-tools upstream)
- mdadm: also install configs from /etc/mdadm.conf.d
- fixes for mdadm-3.2.6+
- mkinitrd: better compat support for SUSE
- fcoe: add FCoE UEFI boot device support
- rootfs-block: add support for the rootfallback= kernel cmdline option

Contributions from:
Thomas Renninger
Alexander Tsoy
Peter Rajnoha
WANG Chao
Harald Hoyer
