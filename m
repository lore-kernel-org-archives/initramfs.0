From: Alan L Scheinine <alscheinine-cCz0Lq7MMjlzbRFIqnYvSA@public.gmane.org>
Subject: mkblkdevs
Date: Fri, 4 Dec 2009 02:18:07 +0000 (UTC)
Message-ID: <loom.20091204T023914-815@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I search the web repeatedly and looked at all the kernel mailing lists, though
this may not be the appropriate choice I cannot find any better place to post my
question.  I built two new kernels 2.6.31.6 and then 2.6.32-rc8 while running
Centos kernel 5.4 2.6.18-164.el5.  Many variations of config parameters all
resulted in boot failure of "could not find file system /dev/root" on three
different computers.  I discovered that the error message can have a multitude
of causes and so I followed advice I found on the web to boot interatively using
busybox.  Both the kernel that fails (recent kernels) and the kernel that boots
correctly (RHEL/Centos 5.4) have an identical nash and using busybox I see that
the first discrepency is after the first mkblkdevs.  This command is called
twice inside the "init" script, once before loading drivers and once after
loading drivers.  After the first call the directory dev gets ram# files added,
after the second call directory dev gets sda# files added for the kernel that
successfully boots.  For the kernel that fails to boot, the ram# files are not
added after the first call to mkblkdevs, this is before the modules such as ahci
are loaded, so the problem is not the module.  Moreover, even for the kernel
that failed /proc/partitions is correct, so the boot process is able to read the
hard disk (two hard disks, actually).  The disk controller is Intel ICH9M-E/M
SATA AHCI Controller.  I was able to mount the root file system of the hard disk
if I first used the nash command "mknod".  I cannot find documentation on
mkblkdevs, moreover, it seems to be a nash command and as I wrote, the nash
versions are the same for both the correct and failing kernel boot.  I don't see
any difference at all during this first stage of booting that would explain why
mkblkdevs would work for booting the RHEL/Centos kernel but fail when booting a
kernel constructed myself from a kernel.org source.  Could you point me to the
correct mailing list, wiki or person that might know the cause of the problem?
Alan Scheinine

