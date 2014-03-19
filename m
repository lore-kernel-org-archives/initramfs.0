From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [ANNOUNCE] dracut 037
Date: Wed, 19 Mar 2014 17:18:44 +0100
Message-ID: <5329C364.5040706@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Here comes a new dracut version. Thanks to all who have contributed to =
this
release.

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


dracut-037
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- dracut: hostonly_cmdline variable and command line switch
    Toggle hostonly cmdline storing in the initramfs
    --hostonly-cmdline:
        Store kernel command line arguments needed in the initramfs
    --no-hostonly-cmdline:
        Do not store kernel command line arguments needed in the initra=
mfs
- dracut: --mount now understands full fstab lines
- dracut now also includes drivers from the /lib/modules/<version>/upda=
tes
directory
- dracut: only set the owner of files to 0:0, if generated as non-root
- dracut now directly writes to the initramfs file
- dracut: call lz4 with the legacy flag (linux kernel does not support =
the new
format)
- systemd: rootfs-generator generates JobTimeout=3D0 units for the root=
 device
- systemd: added the systemd-sysctl service
- systemd: add 80-net-setup-link.rules and .link files for persistent i=
nterface
renaming
- systemd: make dracut-shutdown.service failure non-fatal
- network: various IPv6 fixes
- network: DCHCP for IPv6
- network: understand ip=3D.....:<dns1>:<dns2>
- network: parse ibft nameserver settings
- shutdown: if kexec fails, just reboot
- lvm: handle one LV at a time with lvchange
- module-setup.sh:
    New functions require_binaries() and require_any_binary() to be use=
d
    in the check() section of module-setup.sh.
- a lot of small bugfixes

Contributions from:
Harald Hoyer
Alexander Tsoy
Till Maas
Amadeusz =C5=BBo=C5=82nowski
Brian C. Lane
Colin Guthrie
Dave Young
WANG Chao
Shawn W Dunn
