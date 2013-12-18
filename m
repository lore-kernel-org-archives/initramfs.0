From: Alain Williams <addw-5g5TjK4KYV/QXOPxS62xeg@public.gmane.org>
Subject: Help needed on hardware change
Date: Wed, 18 Dec 2013 17:00:31 +0000
Message-ID: <20131218170030.GA16342@phcomp.co.uk>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I moved hard disks into a new machine. Previously when I have done this I just
booted off CD, ran mkinitrd in a chrooted file system to make a new initrd in /boot.

I did that, rebooted and straight after the grub prompt expires (ie the kernel
loaded) the monitor is put into some graphics mode (no characters/text is
visible, just horisontal streaks) and the system stops with caps lock & scroll
lock flashing.

I (as a temporary measure) installed another SATA disk and installed a small
system there (same distro version). It worked as expected.

I copied the /boot/initramfs... over into /boot on the original disks and if I
use that - it all works. I rebuild using dracut and it fails as described above.

I notice that the /boot/initramfs* files are very different sizes:

15M the one that works - new install to temp disk
23M the one that fails - rebuilt with dracut

What can I do to make this work ? This has been a few weeks on & off.

The old hardware was 32 bit intel something, the new is 64 bit AMD. There are
prob lots of other changes, but I don't think that the details matter too much -
I should be able to just rebuild the initrd.

The Operating system is CentOS 6.5. Kernel 2.6.32-358

-- 
Alain Williams
Linux/GNU Consultant - Mail systems, Web sites, Networking, Programmer, IT Lecturer.
+44 (0) 787 668 0256  http://www.phcomp.co.uk/
Parliament Hill Computers Ltd. Registration Information: http://www.phcomp.co.uk/contact.php
#include <std_disclaimer.h>
