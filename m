From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 042 and 043
Date: Mon, 15 Jun 2015 15:30:35 +0200
Message-ID: <557ED37B.9060904@redhat.com>
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

dracut-043
==========
- add missing dmsquash-generator

dracut-042
==========
- fixed dmsetup shutdown
- new kernel command line option "rd.live.overlay.thin"
    This option changes the underlying mechanism for the overlay in the
    dmsquash module.
    Instead of a plain dm snapshot a dm thin snapshot is used. The advantage
    of the thin snapshot is, that the TRIM command is recognized, which
    means that at runtime, only the occupied blocks will be claimed from
    memory, and freed blocks will really be freed in ram.
- dmsquash: Add squashfs support to rd.live.fsimg
    Previously rd.live.fsimg only supported filesystems residing in
    (compressed) archives.
    Now rd.live.fsimg can also be used when a squashfs image is used.
    This is achieved by extracting the rootfs image from the squashfs and
    then continue with the default routines for rd.live.fsimg.
- lvm: add support for LVM system id
- split up the systemd dracut module
    Basic systemd functionality is in 00systemd now.
    Switching root and the initrd.target is in 00systemd-initrd.
    Dracut additions to the systemd initrd are in 98dracut-systemd.
- support for creating a UEFI boot executable via argument "--uefi"
    With an EFI stub, the kernel, the initramfs and a kernel cmdline can be
    glued together to a single UEFI executable, which can be booted by a
    UEFI BIOS.
- network: split out kernel-network-modules, now in 90kernel-network-modules
- support for ethernet point-to-point connections configured via DHCP
- kernel-modules: install all HID drivers
- dracut.pc pkg-config file
- mount /dev, /dev/shm and /run noexec
