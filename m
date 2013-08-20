From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 032
Date: Tue, 20 Aug 2013 16:07:17 +0200
Message-ID: <52137815.2030601@redhat.com>
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


dracut-032
==========
- add parameter --print-cmdline
    This prints the kernel command line parameters for the current disk
    layout.
    $ dracut --print-cmdline
    rd.luks.uuid=luks-e68c8906-6542-4a26-83c4-91b4dd9f0471
    rd.lvm.lv=debian/root rd.lvm.lv=debian/usr root=/dev/mapper/debian-root
    rootflags=rw,relatime,errors=remount-ro,user_xattr,barrier=1,data=ordered
    rootfstype=ext4
- dracut.sh: add --persistent-policy option and persistent_policy conf option
    --persistent-policy <policy>:
        Use <policy> to address disks and partitions.
        <policy> can be any directory name found in /dev/disk.
        E.g. "by-uuid", "by-label"
- dracut now creates the initramfs without udevadm
  that means the udev database does not have to populated
  and the initramfs can be built in a chroot with
  /sys /dev /proc mounted
- renamed dracut_install() to inst_multiple() for consistent naming
- if $libdirs is unset, fall back to ld.so.cache paths
- always assemble /usr device in initramfs
- bash module added (disable it, if you really want dash)
- continue to boot, if the main loop times out, in systemd mode
- removed inst*() shell pure versions, dracut-install binary is in charge now
- fixed ifcfg file generation for vlan
- do not include adjtime and localtime anymore
- fixed generation of zfcp.conf of CMS setups
- install vt102 terminfo
  dracut_install() is still there for backwards compat
- do not strip files in FIPS mode
- fixed iBFT interface configuration
- fs-lib: install fsck and fsck.ext*
- shutdown: fixed killall_proc_mountpoint()
- network: also wait for ethernet interfaces to setup
- fixed checking for FIPS mode

Contributions from:
Harald Hoyer
WANG Chao
Baoquan He
Daniel Schaal
Dave Young
James Lee
Radek Vykydal

