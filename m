From: "wilbur.chan" <wilbur512-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Why get_fs_names return NULL?
Date: Sat, 26 Sep 2009 17:43:11 +0800
Message-ID: <e997b7420909260243h4c63222aod54727056384f9c3@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=EN7SQB2R2a6TfA+Qp6K4PTLFCW3D4iLimnsAclyA1sM=;
        b=JU2H12cJwB/fIbAqrukh46sW/K+J5yZ9axGWALUhL+EU7SiMho24k16HEGXvMewpLX
         EHwQNh16OsgH9ipnI4JtRz+tb6TKd2kuvkgUzG8C2rllmCMHVJq0nLFBgqOKpSjcQ0Fe
         sQp2phRUoYEtw2tKWd0iwve+Jg2yXPWO064Nw=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I am going to start a kernel(2.6.21.7)  using ramdisk, but  kernel panic  when
mounting the ramdisk fs.


After traped the code , I found that , when kernel invoked
get_fs_names, it got a NULL list of existing file system names.

That is to say,
prepare_namespace--->mount_root-->mount_block_root-->get_fs_names-->get_filesystem_list
 ,

return  a list of nothing...

I thought that , maybe module_init(init_ext2_fs) failed , but I don't
know why? and how to solve it ?

here is my ramdisk script:

mkdir initrd
dd if=/dev/zero of=initrd.img bs=1k count=4096
mke2fs -F -v -m0 initrd.img
mount -o loop initrd.img initrd
cp -av rootfs/* initrd
sync
umount initrd
sync
gzip -f -9 initrd.img
sync
./mkimage -T ramdisk -C gzip -n ' Ramdisk Image' -d initrd.img.gz
your.ramdisk.u-boot
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
