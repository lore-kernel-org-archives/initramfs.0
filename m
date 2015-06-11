From: dennis vadura <dennis.vadura-Ksp6LzbG4zcWhyVFc8JwjA@public.gmane.org>
Subject: CentOS 6.6 base, when updated to 3.19.8 custom kernel fails boot.
Date: Thu, 11 Jun 2015 12:25:08 -0700
Message-ID: <CA+DYQ9G9trnPuPCQYhd_7e2ZJ3Bj7Xs5gkeDr7qG3SQSkn+e_w@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

3.19.8 on CentOS 6.6 fails to boot because it cannot find root:

"No root device block:/dev/disk/by-uuid/..."

After looking into this more there are two issues:

a) scsi_wait_scan is not found, and no longer exists in the 3.xx kernels
b) the particular box that is failing has 20+ SSD SATA drives.

This appears to be an interaction between the updated kernel, and the
older 6.6 dracut scripts. Since this is a customer box, I need to be
able to mod the scripts or kernel boot line so that it boots but still
works if an older rev kernel is re-installed.

Any ideas appreciated, I'm somewhat new to dracut and friends. Also,
new kernel boots fine when number of SATA disks is <= 4 (based on
tests on similar hardware -- just fewer disks).

-thanks for any help in advance.
-- 
Dennis Vadura
