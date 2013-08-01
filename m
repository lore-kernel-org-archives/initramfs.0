From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Very specific initramfs image problem
Date: Thu, 01 Aug 2013 09:23:08 +0200
Message-ID: <51FA0CDC.3040606@redhat.com>
References: <20130731213716.GA5723@vuvuzela.stingr.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130731213716.GA5723-QlFyWrZdf16VhmCTJn09oNHuzzzSOjJt@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Paul Komkoff <i@stingr.net>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/31/2013 11:37 PM, Paul Komkoff wrote:
> Good morning.
> 
> I'm trying to achieve a very specific thing and I'm wondering if you can point
> me in the right direction.
> 
> I have a system that sets up dual-boot workstations and makes grub the
> bootloader. Now, I need to provide 2 network boot targets: one that will set
> grub default to windows, another one to fedora. For that, I have a script that
> updates grubenv; now, I need to package it into initramfs.
> 
> Before dracut/systemd what I did is just took mkinitrd result, unpacked, added
> my script to it, and modified init to run it and then reboot. With dracut I was
> hoping to try to reuse it as much as possible, as to run grub2-editenv I need
> /boot mounted - means device detection and that's something I have to use
> dracut/udev for.
> 
> I have the following ideas so far:
> - just stick my code somehow into mount triggers, and when root is mounted
>   mount /boot, run, and then reboot -f

don't forget to umount before "reboot -f"

> - stick my code into pre-pivot (mount /boot and edit env etc), then instead of
>   initrd-switch-root.target do reboot.target
> 
> I was wondering if there are better and/or cleaner ways for doing that (I'd
> probably start implementing a module for the second one in the meantime).
> 
> Thanks!

Both solutions will work.

For Fedora >= 19, it's even simpler. Just add the option "x-initrd.mount" to the
/boot /etc/fstab entry. The
/usr/lib/systemd/system-generators/systemd-fstab-generator takes care of
generating a mount unit, after root is mounted. systemd mounts it as part of
initrd-fs.target.

See man dracut.bootup(7).

You can put your custom service in initrd.target.wants with:

After:  initrd-fs.target
Before: initrd-cleanup.service

/boot is mounted at that point of time.

