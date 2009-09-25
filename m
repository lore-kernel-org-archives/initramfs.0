From: Ersin Akinci <ersin.akinci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Failed to execute /init while booting
Date: Fri, 25 Sep 2009 00:41:17 -0400
Message-ID: <f8a051a90909242141mf000adap70841787b9caafc2@mail.gmail.com>
References: <f8a051a90909241511x1364267cte49cb60fc3e6d4a0@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=z5sVJWogMY3Y/vAM0CQWX47TYeMA8AfAH3j/atEstHU=;
        b=lcXjuMG8DbMpGrG+A+bQd3JeTcTGjyePXOpZXAoqOnFT/0ucAoTbd05BlzQLYeqWv7
         K5jdrZ7U4bpDx85lbtylGijO51zOg3lLdXbEpXNbjm9EdM+2LGl7nCp1ONs4jRoyIrTc
         u+1GgqVde7Tk1B4P2tFbouLK1h8lHllokKZBw=
In-Reply-To: <f8a051a90909241511x1364267cte49cb60fc3e6d4a0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I figured out the problem.  I just moved to a x64 platform and so my
toolchain was building for x64...doesn't work so well when your target
is a laptop from 15 years ago!

-Ersin

On Thu, Sep 24, 2009 at 6:11 PM, Ersin Akinci <ersin.akinci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
> Hi all,
>
> I've been trying to make a boot disk for a very old computer (Toshiba
> Satellite 420CDT, a fine laptop) using initramfs, but I haven't been
> able to get the thing to boot. =A0The kernel spits out the error "Fai=
led
> to execute /init". =A0Here are some details:
>
> 1) My init file exists (I've also tried passing rdinit=3D/bin/sh and
> init=3D/bin/sh but I still get the same error. =A0Note that /bin/sh i=
s a
> symlink to a statically linked busybox executable)
> 2) My init file has correct permissions (chmod +x init) and the owner=
 is root
> 3) My init file is a very simple script (#!/bin/sh.../bin/ash --login=
=2E..EOF)
> 4) I'm using an external initramfs image that's gzip compressed and
> passing it as an option using "initrd=3D/boot/initramfs.gz" in my
> menu.lst in GRUB.
>
> Here's what my screen output reads while booting:
>
> CPU: Intel Pentium 75 - 200 stepping 0c
> Checking 'hlt' instruction... OK.
> bio: create slab <bio-0> at 0
> Trying to unpack rootfs image as initramfs...
> Freeing initrdd memory: 676k freed
> platform rtc_cmos: registered platform RTC device (no PNP device foun=
d)
> msgmni has been set to 76
> io scheduler noop registered
> io scheduler deadline registered (default)
> Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margi=
n
> is 60 seconds).
> Hangcheck: Using get_cycles().
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is an 8272A
> brd: module loaded
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> mice: PS/2 mouse device common for all mice
> rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
> rtc0: alarms up to one day, 114 bytes nvram
> rtc_cmos rtc_cmos: setting system clock to 2009-09-24 15:48:55 UTC (1=
253807335)
> Freeing unused kernel memory: 152k freed
> Failed to execute /init
> Kernel panic - not syncing: No init found. =A0Try passing init=3D opt=
ion to kernel.
>
> I've also tried using an initrd image built from the same file
> directory structure and mounting it on /dev/ram0 and running the same
> init file from /sbin/init, but that results in the same error as abov=
e
> (except it reads Failed to execute /sbin/init). =A0Any ideas?
>
> Thanks,
> Ersin
>
> P.S.: My apologies if this seems like a hopelessly newbie question fo=
r
> this mailing list, but I could not find the answer anywhere else and
> everyone's initramfs/init/boot conditions vary so wildly that it woul=
d
> be hard to find "the right answer".
>
> --
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Ersin Y. Akinci -- http://www.ersinakinci.com
>



--=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D

Ersin Y. Akinci -- http://www.ersinakinci.com
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
