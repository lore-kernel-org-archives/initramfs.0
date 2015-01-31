From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 041
Date: Sat, 31 Jan 2015 13:00:12 +0100
Message-ID: <54CCC3CC.8050409@redhat.com>
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


dracut-041
==========
- fixed the shutdown loop
- fixed gzip compression for versions, which do not have --rsyncable
- fixed ifcfg generation for persistent interface names
- multipath:
  * new option to turn off multipath "rd.multipath=0" completly
  * preload scsi dh modules
  * start multipathd via systemd service
- do not fail, if user pressed ESC during media check
- fixed systemd-journal by symlinking /var/log to /run/initramfs/log
- initrd-release moved to /usr/lib
- lots of iSCSI fixes
- new "rd.timeout" to specify the systemd JobTimeoutSec for devices
- if $initrd/etc/cmdline.d/* has a "root=" and the kernel cmdline does not,
  generate a mount unit for it
- increased the initqueue timeout for non systemd initramfs to 180s
- $initrd/etc/cmdline.d/ hostonly files are now generated for NFS
- make use of systemd-hibernate-resume, if available
- fixed ldconfig parsing for hwcap output
- network: add support for comma separated autoconf options like ip=eth0:auto6,dhcp
- new parameter "rd.live.overlay.size" to specify the overlay for live images
- changed the test suite for the new sfdisk syntax
- added cache tools for dm-cache setups

