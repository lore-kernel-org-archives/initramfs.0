From: Andrey Sapegin <andrey-/eMlXOy4en9AfugRpC6u6w@public.gmane.org>
Subject: include ata into initrd
Date: Thu, 11 Mar 2010 11:23:31 +0100
Message-ID: <4B98C4A3.7010307@sapegin.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Dear ladies and gentlemen.

Can I ask You if you know how to solve my problem.
I have an ExpressCard SSD in my laptop. And I installed Ubuntu 9.10 
(kernel 2.6.31-14) on it. But after grub2 boots kernel, kernel is not 
able to recognise my SSD (it's recognised by grub because I added 
--disk-module=ata to grub-install).
I have another copy of Ubuntu on my primary HDD and after booting kernel 
from my primary HDD and mounting filesystem, it also mounts my SSD with:
ata5.00: ATA-7: ExpressCard... (dmesg output).

So I think that I need to add ata drivers to initrd to be able to run 
Ubuntu from SSD.
Can You help me and write how to do this?

Thank You in advance,
Kind Regards,

-- 
Andrey Sapegin,
PhD Student,
Universitaet Leipzig,
Project manager,
HTWK Leipzig (FH),
+4915778339304,
andrey-/eMlXOy4en+bup2nOX2J7Q@public.gmane.org
