From: Felix Miata <mrmazda-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: too long to "hand off"(?) from bootloader to kernel/initrd (
Date: Tue, 12 Jan 2016 15:35:42 -0500
Message-ID: <5695639E.20802@earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

root (hd0,22)
 Filesystem type is ex2fs, partition type 0x83
kernel /boot/vmlinuz <yada...>
initrd /boot/initrd

Above used to display on screen barely long enough to notice. Since about a
year ago, maybe 11 months or less, on at least two different HDs and with
multiple distro, dracut and kernel versions, I have been seeing enormous
delays, with the above on screen several minutes with some
distro/kernel/initrd duos, but not with others. The delay is not counted by
kernel, so the normal boot process as indicated on vtty1 or in dmesg reports
complete in as little as under 40 seconds.

Smartctl reports nothing indicating trouble with any HD I recall this
happening with, all/both reportedly with 512 byte sectors, one made in 2008,
another in 2010, and these both Hitachi 3.5" form factor SATA.

Boot on host big31 with latest installed kernel took >11 minutes to hand off,
with 4.3.3-5 kernel (36562K initrd) in openSUSE TW on a 2.93GHz Core2Duo ICH7
machine, but many of Fedora's do it too (on one different host at least). A
prior TW kernel 4.1.6-3 (8862772 initrd) subsequently tried took just short
of 4 minutes to hand off. Same machine has a second TW installation, and its
4.1.6 (8663972 initrd) produces no delay, while its 4.3.3-5 (9589212 initrd)
delays just under 2 minutes. Fedora 22's 4.2.5 (10593K initrd), Fedora 23's
4.2.7 (11866K initrd) and Rawhide's 4.0rc5 (11192K initrd) on same machine
also produce no delay. Typically delays are much shorter than 11+ minutes,
but typically the delay is at least 3 minutes. Particular kernel/initrd pairs
always either have the problem, or not - never AFAIR does a particular pair
sometimes delay and sometimes not.

All my systems are multiboot, with at least 3 installed distros, and more
typically >10. Using bootloader on the distro's own partition vs. loading it
from a different bootloader has no apparent effect on whether or not a delay
occurs with any kernel/initrd pair. Bootloader reinstallations have had no
effect either. Filesystems hosting kernels are all EXT4 IIRC, possibly some
on EXT3.

It appears initrd size plays large part in delay, but it doesn't seem to be
the whole reason, based on the TW 4.1.6 results.

How can the initrd size be kept reasonable, enabling moving the HD to a
different but similar CPU/chipset motherboard, and yet not bloat the initrd
by having hostonly=no set? Before dracut replaced mkinitrd, which always
produces modest sizes initrds, migrating a disk (in openSUSE at least), was a
relatively painless process. Boot would quickly succeed, delayed usually only
by unconfigured NIC preventing network from coming up.

What's responsible for the delay besides initrd size? BIOS disk access sloth?
BIOS setting? Kernel? Bootloader? Initrd/Dracut? Initrd size exclusively?
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
