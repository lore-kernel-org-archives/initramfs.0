From: "Christoph Pleger" <Christoph.Pleger-ogaGWlaKng3jEoi5djuKH7NAH6kLmebB@public.gmane.org>
Subject: IP configuration with dhcp
Date: Thu, 2 Jul 2015 11:08:12 +0200
Message-ID: <a82892e788a77d505b9b4bedd690e480.squirrel@postweb.cs.tu-dortmund.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I want to create a Debian Live DVD, with dracut as initrd tool. That is, I
already had the Live system running successfully, but IP configuration had
to be entered manually after boot from DVD. The grub menuitem for that
contains the following line to define the kernel and its parameters:

linux   /vmlinuz root=/dev/cdrom ro aufs

Then, I had the idea to add an option for automatic IP configuration by
DHCP. I expected it to work by adding a new grub menuitem with the
following line for the kernel:

linux   /vmlinuz root=/dev/cdrom ip=dhcp ro aufs

But that does not work, no configuration is set for eth0. But if the
chroot-Directory I created the DVD from is taken as NFSROOT and the
computer is booted by PXE, with the following in pxelinux.cfg/default

DEFAULT vmlinuz initrd=initrd.img root=dhcp ip=dhcp ro aufs

then eth0 gets its configuration from DHCP.

So, does dracut only support automatic IP configuration by DHCP if
"root=dhcp" is set, or is there something I can change in the kernel
parameters to make automatic IP configuration work when booting from DVD?

Regards
  Christoph
