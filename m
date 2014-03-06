From: glphvgacs <darwinskernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: cap on rootfs
Date: Thu, 6 Mar 2014 14:34:42 -0500
Message-ID: <20140306193442.GA498@localhost>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=QqgeNXfDzoTWT6OD63B26GcE73qFO5KqVDOOzLYfZX0=;
        b=XBcf1fXtQXBVn0COdqv44Wb8r5VKNg8GmHG1sMyui+eJSVghwLIcLCOXOG8S3S3/cj
         3bVIr7sGcgZdf1JUJ1k+4b7rPgFxIeRdxeCrpbaMHZWY5dHFUqw+dwL34hbmN6Jn3tR3
         OjE6wDCTIvMdjd/T4siGRrS4mZ3ayAu3FIjjGWJ81iub4gLX4f6DpuU67/SRk67G6TLQ
         TshhClaj57OGDRpqpOSFLY6z0SKEF+Jil+0pdjGQw21664MplwwVlkxFncv4bj0k/eYk
         U+VDAerakle5gbLuJXKsHQ+tdltNzA6H8/WaJyqTFZPyIIpQ0dUmguQC/KXEmJVlo73z
         Yhsw==
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


hello,
so after reading
Documentation/filesystems/ramfs-rootfs-initramfs.txt
and 
Documentation/filesystems/tmpfs.txt

i thought i would put everything in /* into initrd since i have 8G of
ram sitting around with pretty much no use.  crazy? maybe.
but i must have hit an old cap on how much one can shove into initramfs
which is not cool, IMHO. here are related sizes:

$ ls -lh /boot/initramfs.cpio.gz:
1.2G Mar  5 16:59 /boot/initramfs.cpio.gz

$ df -h:
Filesystem      Size  Used Avail Use% Mounted on
rootfs          3.3G  3.3G     0 100% /
devtmpfs        3.4G     0  3.4G   0% /dev


note that df -h on rootfs is not even consistent; last boot i had 2.8G!
in both cases it violates what Documentations say, which is 50% of the
availabe ram.

now services can't write to for example /var/tmp/ since we're out of
space. remounting / will *fix* it:

# mount -o remount,size=90% /

$ df -h:
Filesystem      Size  Used Avail Use% Mounted on
rootfs          7.0G  3.3G  3.8G  47% /

but that's no solution.

so my question:
where is this set in kernel? is there a kernel param i can pass to
kernel to give it the go ahead to use 90% of the availabe ram? i have
btw tried rootflags=size=90% thinking that it might work like it does in
fstab for tmpfs, no luck. or is there a CONFIG_* that sets this? i
didn't try messing with CONFIG_BLK_DEV_RAM_SIZE since that seemed to be
for ramdisk and in any case too small to be the one being used, in my
case:
CONFIG_BLK_DEV_RAM_SIZE=4096

kernel version btw:
3.14.0-rc5 #1 SMP PREEMPT x86_64 Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz


thanks
