From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 020 release
Date: Fri, 29 Jun 2012 13:47:48 +0200
Message-ID: <4FED95E4.5080305@redhat.com>
References: <4FED9587.2050708@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FED9587.2050708-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
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
	http://git.kernel.org/?p=boot/dracut/dracut.git

Git Web RSS Feed:
	http://git.kernel.org/?p=boot/dracut/dracut.git;a=rss

Project Page:
	http://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html

Project Wiki:
	http://dracut.wiki.kernel.org

The ChangeLog can be found here:
        http://git.kernel.org/?p=boot/dracut/dracut.git;a=blob_plain;f=NEWS


> dracut-020
> ==========
> - changed rd.dasd kernel parameter
> - arm kernel modules added to kernel-modules
> - make udevdir systemdutildir systemdsystemunitdir global vars
>   your distribution should ship those settings in
>   /etc/dracut.conf.d/01-distro.conf
>   see dracut.conf.d/fedora.conf.example
> - kernel modules are now only handled with /sys/modules and modules.dep
> - systemd fixups
> - mdraid: wait for md devices to be clean, before shutdown
> - ifup fixed for ipv6
> - add PARTUUID as root=PARTUUID=<partition uuid> parameter
> - fixed instmods() return code and set pipefail globally
> - add 04watchdog dracut module
> - dracut-shutdown.service: fixed ordering to be before shutdown.target
> - make use of "ln -r" instead of shell functions, if new coreutils is installed
> - network: support vlan tagged bonding
> - new dracut module qemu and qemu-net to install all kernel driver
> - fs-lib/fs-lib.sh: removed test mounting of btrfs and xfs
> - no more "mknod" in the initramfs!!
> - replaced all "tr" calls with "sed"
> - speedup with lazy kernel module dependency resolving
> - lots of speedup optimizations and last but not least
> - dracut-install:
>   - new binary to significanlty speedup the installation process
>   - dracut-functions.sh makes use of it, if installed
> 
> 
> $ dracut-install --help
> Usage: dracut-install -D DESTROOTDIR [OPTION]... -a SOURCE...
>    or: dracut-install -D DESTROOTDIR [OPTION]... SOURCE DEST
> 
> Install SOURCE to DEST in DESTROOTDIR with all needed dependencies.
> 
>   -D --destrootdir    Install all files to DESTROOTDIR as the root
>   -a --all            Install all SOURCE arguments to DESTROOTDIR
>   -o --optional       If SOURCE does not exist, do not fail
>   -d --dir            SOURCE is a directory
>   -l --ldd            Also install shebang executables and libraries
>   -R --resolvelazy    Only install shebang executables and libraries for all
> SOURCE files
>   -f --fips           Also install all '.SOURCE.hmac' files
>   -v --verbose        Show more output
>      --debug          Show debug output
>      --version        Show package version
>   -h --help           Show this help
> 
> Example:
> # dracut-install -D /var/tmp/test-root --ldd -a sh tr
> # tree /var/tmp/test-root
> /var/tmp/test-root
> |-- lib64 -> usr/lib64
> `-- usr
>     |-- bin
>     |   |-- bash
>     |   |-- sh -> bash
>     |   `-- tr
>     `-- lib64
>         |-- ld-2.15.90.so
>         |-- ld-linux-x86-64.so.2 -> ld-2.15.90.so
>         |-- libc-2.15.90.so
>         |-- libc.so
>         |-- libc.so.6 -> libc-2.15.90.so
>         |-- libdl-2.15.90.so
>         |-- libdl.so -> libdl-2.15.90.so
>         |-- libdl.so.2 -> libdl-2.15.90.so
>         |-- libtinfo.so.5 -> libtinfo.so.5.9
>         `-- libtinfo.so.5.9
