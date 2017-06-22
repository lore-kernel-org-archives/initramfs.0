From: "Ali H.M. Hoseini" <alihmh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: kernel 4.4 and 4.9 different reactions to initrd.
Date: Fri, 23 Jun 2017 01:00:03 +0430
Message-ID: <CADV=gjHjd+cXh6Xmd0UBtb3dEzsYhKNR0XvF_BzK_0z-3r2WFg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0ZEqLrvCnHJ5/1VsFOVnaNhlrUreQSxLY6dZZXwWo8s=;
        b=GS8eiVvYwLaquiMTOURQZ4ZKAeIUkQ7d4drhJ2TTy1w9F4cwOjb84/rylAXdEQF/NM
         NU1owGn/PJmJK/f4QEq6bPT/kY6S7k86qhlWwx7cIjlTDYoilfSb6SXxVcETgPBnLsT9
         WsGIo48B3RYKtTeZ/N1QyMLGdWDUD0yFmvVmu4AMfbaUCvKWEG+aCvSzYbQX64dlzu9r
         FHw0U4T78UEqFiTTd9pwMadkBjj6e7aKG+M6Cez+d1uLv9waV8jmMEFKggSEjhHpC+85
         iTaXeUgapJddAkyvrUPDcGzZoCb533BwXHff7Ff90LinXNF8EIQh4p0lgtW0PyIlHEPH
         QGQA==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I'm not sure am I supposed to ask this question here, But I did not
find anywhere more suitable!

I'm using a complete root fs compressed in gz as my initrd for last
couple of years.
until kernel 4.4.x when I chose to boot kernel with my initrd, I got
these messages in boot process:

...
[    0.000000] Krrne  oomman  iie: BOOT_IMAGE=vvmlinuz-4.4117
initrd=/utvos44.0.6.gz console=tty console=ttyS09900
...
[   38.920053] Trying to unpack rootfs image as initramfs...
[   39.103577] rootfs image is not initramfs (no cpio magic); looks
like an initrd
[   39.488596] Freeing initrd memory: 46576K (ffff88007d284000 -
ffff880080000000)
....
[   60.815224] RAMDISK: gzip image found at block 0
[   64.617699] EXT4-fs (ram0): couldn't mount as ext3 due to feature
incompatibilities
[   64.835669] EXT4-fs (ram0): couldn't mount as ext2 due to feature
incompatibilities
[   65.168935] EXT4-fs (ram0): mounted filesystem with ordered data
mode. Opts: (null)
[   65.498876] VFS: Mounted root (ext4 filesystem) on device 1:0.
mounting fstab entries
...

and system boots correctly.



But when I switched to kernel 4.9.30, everything went wrong:

....
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.9.30
initrd=/utvos.4.1.0.gz root=/dev/ram0 console=tty console=ttyS0,9600
....
[   29.156899] Unpacking initramfs...
[   29.330796] Initramfs unpacking failed: no cpio magic
...
[   50.444213] VFS: Cannot open root device "ram0" or
unknown-block(0,0): error -6
[   50.656876] Please append a correct "root=" boot option; here are
the available partitions:
[   51.012293] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(0,0)
....

I've tried adding root=/dev/ram0, removing it, adding keepinitrd
kernel switch, changing archive compression to cpio, and multiple
other kernel paramters, but nothing helped.

Basically it seems old kernel detects image is initrd
(rootfs image is not initramfs (no cpio magic); looks like an initrd),
but new kernel doesn't even try to mount image as initrd.

What is wrong? how should I fix this problem.

Best regards.
