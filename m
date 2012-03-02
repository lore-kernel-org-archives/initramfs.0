From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fail to mount a ext2 partition /dev/mmcblk0p1 on SD card as root file
 system in kernel 3.2
Date: Fri, 2 Mar 2012 18:53:23 +0800
Message-ID: <CAJxxZ0NNb6981fpLyiH97Q3Y6ucWm=XB5-MmMRnBCr-dmQrpyw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2TW5DDwBm+TtfZPUVeL19t65fcUi41raQSv7qHMSMng=;
        b=n6lC+0dsBqscvA+EU1ScNcLFy8VZlscTkW3nr4Gmi8b8vO3/7+kmUq/jEjfieg6UzD
         fTVlWnkvdejvePgC7ERqGJO+ytW2dD3nLpzCoqBBXoh64yw7YnjLwrceEFsPPpkxFL1A
         cgCbXFk7qbSFIamNziIv5TcV0xZwi9eSZdEF6ftQfSYOmZgsKtSlmudOmgO0tedVu5eQ
         q0CQ6DKm29/EFghRd2VAYptpFx1Ry9vZ4IPcTlDbWdrgqD+yCjGk5CE7GYumobqmV0/X
         Z9Mp6cqP1uSdgIScDPVZTaUYwL2e8w5VeZ7kIh2zEb5iZLvIu4bm9NIhm/Fax/1Quv2C
         GJMg==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

Kernel 3.2 panic when I mount a ext2 partition /dev/mmcblk0p1 on SD
card as root file system.

My boot parameter line is "root=/dev/mmcblk0p1 rw rootwait
earlyprintk=serial,uart0,57600 console=ttyBF0,57600".

After reading init/do_mounts.c a bit, I find VFS folders "/dev" and
"/root" don't exist when mount_root() tries to create block device
node "/dev/root" and mount this device at  path "/root". If I create
these folders by mkdir() before line create_dev() in function
mount_root(), kernel boots up on SD card properly.

Where should folders "/dev" and "/root" be created? Any hint?

Thanks

void __init mount_root(void)
{
.......
#ifdef CONFIG_BLOCK
        create_dev("/dev/root", ROOT_DEV);
        mount_block_root("/dev/root", root_mountflags);
#endif
}

static int __init do_mount_root(char *name, char *fs, int flags, void *data)
{
        int err = sys_mount(name, "/root", fs, flags, data);
        if (err)
                return err;
......
}

Sonic Zhang
