From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 029
Date: Wed, 17 Jul 2013 15:54:04 +0200
Message-ID: <51E6A1FC.1090403@redhat.com>
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


dracut-030
==========
- support new persistent network interface names
- fix findmnt calls, prevents hang on stale NFS mounts
- add systemd.slice and slice.target units
- major shell cleanup
- support root=PARTLABEL= and root=PARTUUID=
- terminfo: only install l/linux v/vt100 and v/vt220
- unset all LC_* and LANG, 10% faster
- fixed dependency loop for dracut-cmdline.service
- do not wait_for_dev for the root devices
- do not wait_for_dev for devices, if dracut-initqueue is not needed
- support early microcode loading with --early-microcode
- dmraid, let dmraid setup its own partitions
- sosreport renamed to rdsosreport

Contributions from:
Harald Hoyer
Konrad Rzeszutek Wilk
WANG Chao
