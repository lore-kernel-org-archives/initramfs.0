From: Jan Engelhardt <jengelh-9+2X+4sQBs8@public.gmane.org>
Subject: Re: too long to "hand off"(?) from bootloader to kernel/initrd (
Date: Tue, 12 Jan 2016 23:35:20 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1601122246470.14519@nerf40.vanv.qr>
References: <5695639E.20802@earthlink.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5695639E.20802-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Felix Miata <mrmazda-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


On Tuesday 2016-01-12 21:35, Felix Miata wrote:
> Filesystem type is ex2fs, partition type 0x83
>kernel /boot/vmlinuz <yada...>
>initrd /boot/initrd
>
>Above used to display on screen barely long enough to notice. Since about a
>year ago, maybe 11 months or less, on at least two different HDs and with
>multiple distro, dracut and kernel versions, I have been seeing enormous
>delays, with the above on screen several minutes with some
>distro/kernel/initrd duos, but not with others.[...]
>What's responsible for the delay besides initrd size? BIOS disk access sloth?
>BIOS setting?

The BIOS certainly plays a role in it, in particular, how it
implements the int13 disk access. You see that with the huge
discrepancy of (openSUSE) DVD boot times with real (non-EFI)
hardware, and with a virtual machine (still non-EFI) "hardware".

The bootloader probably also factors in; harddisk booting is commonly
done with GRUB, but if you have some bootstick, it may be with
syslinux/extlinux. Or you use pxelinux over network - even there, the
speed differs vastly between hardware generations, even though
network is (even on old hardware) pretty much the same speed.
