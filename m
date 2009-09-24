From: Ersin Akinci <ersin.akinci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Failed to execute /init while booting
Date: Thu, 24 Sep 2009 18:11:01 -0400
Message-ID: <f8a051a90909241511x1364267cte49cb60fc3e6d4a0@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Plr6TEEaGDWZ8ruuI/8k7WHRZRNztJNh42lwkFYOriE=;
        b=kWF/vBhSLqWDqKTbNlOxty6oAA1TwPzVZpr2Xj8PcZGOnN/R61cfsiRbfnvk85rKdl
         IRoFIjRR/gH05yM5TnR6drkp1EecQ9v8+Bdh9CHmwGf1y0G5Y0GJIisqgKJMQYXI/vMH
         6dkh6jc1paY8TrVPm1g56kpCHUsrcH2DOrHA0=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi all,

I've been trying to make a boot disk for a very old computer (Toshiba
Satellite 420CDT, a fine laptop) using initramfs, but I haven't been
able to get the thing to boot.  The kernel spits out the error "Failed
to execute /init".  Here are some details:

1) My init file exists (I've also tried passing rdinit=/bin/sh and
init=/bin/sh but I still get the same error.  Note that /bin/sh is a
symlink to a statically linked busybox executable)
2) My init file has correct permissions (chmod +x init) and the owner is root
3) My init file is a very simple script (#!/bin/sh.../bin/ash --login...EOF)
4) I'm using an external initramfs image that's gzip compressed and
passing it as an option using "initrd=/boot/initramfs.gz" in my
menu.lst in GRUB.

Here's what my screen output reads while booting:

CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
bio: create slab <bio-0> at 0
Trying to unpack rootfs image as initramfs...
Freeing initrdd memory: 676k freed
platform rtc_cmos: registered platform RTC device (no PNP device found)
msgmni has been set to 76
io scheduler noop registered
io scheduler deadline registered (default)
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin
is 60 seconds).
Hangcheck: Using get_cycles().
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
brd: module loaded
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one day, 114 bytes nvram
rtc_cmos rtc_cmos: setting system clock to 2009-09-24 15:48:55 UTC (1253807335)
Freeing unused kernel memory: 152k freed
Failed to execute /init
Kernel panic - not syncing: No init found.  Try passing init= option to kernel.

I've also tried using an initrd image built from the same file
directory structure and mounting it on /dev/ram0 and running the same
init file from /sbin/init, but that results in the same error as above
(except it reads Failed to execute /sbin/init).  Any ideas?

Thanks,
Ersin

P.S.: My apologies if this seems like a hopelessly newbie question for
this mailing list, but I could not find the answer anywhere else and
everyone's initramfs/init/boot conditions vary so wildly that it would
be hard to find "the right answer".

-- 

=========

Ersin Y. Akinci -- http://www.ersinakinci.com
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
