From: Tim Mohlmann <muhlemmer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dracut dmsquash-live: can't mount /dev/mapper/live-rw. (WAS
 dmsquash-live fails for Gentoo squashed root)
Date: Sun, 22 Dec 2013 15:40:35 +0100
Message-ID: <CAHOCc1-2804RWqp3BOozfHiUKmJMveHSy+Zjh2zresxSXSCSWg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=uO5swZ3okKDrgYGPxhowBAC9BESA6AlBD4vk4QyZTX0=;
        b=ebUZmJUlrq7C/aBhvy6W0kGoaMuDrcs3XgXvgmAdBzxDNxXvALDcDSbGkdlEMCABbc
         C5nkjjTv59oNSJ1SSUUxB2R8eHRrEbwP9jTsM0xFuZ+f/IXoxDr3sAXCxgiQugqkiuEE
         N/5QHiomfwCF7YoRrFqg61jBSkDZWWGSx+po0VzINK9nAgK1yTrTNFeboLF1FHAAhKyz
         01MR12rrSPh8INsKdiFdI8QHB8ufWkYtjr1AzyWqueFZvvvuieD9C5Tx/zYsweRsEa2N
         85Z02dXWUZyMT3X1gUXDwEYp1+pE69uulYuSnr26Y4Q/tBd1ZHXQrT4ujjnmnfy8WGZ7
         MZRw==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Update:

It seems that the squash image is properly attached to a loop device,
as well the RW part. From the rdsosreport.txt:
/sbin/rdsosreport@14(): blkid
/dev/sdb1: UUID="81689ddf-98ab-4314-b420-ce78d505f919" TYPE="ext2"
/dev/loop0: TYPE="squashfs"
/dev/loop1: TYPE="DM_snapshot_cow"
...
/dev/mapper/live-rw: TYPE="DM_snapshot_cow"


Trying to mount /dev/mapper/live-rw from the emergency shell gives the
same error.

#> modprobe dm_snapshot
#> mkdir /mnt
#> mount /dev/mapper/live-rw /mnt
mount: unknown filesystem type 'DM_snapshot_cow'
#> mount -v -t dm_snapshot /dev/mapper/live-rw /mnt
mount: unknown filesystem type 'dm_snapshot'
#>mount /dev/loop0 /mnt
#> ls /mnt
bin etc ...

Seems to be a filesystem / kernel config option, still.

Attached full rdsosreport.txt and liveroot output, generated after
adding rd.debug and rd.live.debug to the command line. Devices and
LVM's prefixed with an asterisk are on the internal drive of the PC
and are not used in this context.

Regards, Tim

2013/12/21 Tim Mohlmann <muhlemmer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi,
>
> I am playing around with a Gentoo root filesystem on a squash image on
> a USB stick. I am trying to boot it with dracut dmsquash-live module.
>
> It fails with error mount: unknown filesystem type 'DM_snapshot_cow'
> repeated quite some times.
>
> I checked if it is a kernel config problem: DM_SNAPSHOT [=y].
> So I guess that is fine. Searching for COW does not five me anything
> usefull, except for BLK_DEV_COW_COMMON [=n]. But it is not mentioned
> where in the menuconfig it is mentioned to select.
>
> Setting this option directly in .config gets undone when compiling the kernel.
>
> kernel-3.10.17-gentoo
> sys-kernel/dracut-034-r2  USE="device-mapper -debug -net (-selinux)"
> DRACUT_MODULES="dmsquash-live lvm plymouth -biosdevname -bootchart
> -btrfs -caps -cifs -crypt -crypt-gpg -crypt-loop -dash -dmraid
> -gensplash -iscsi -livenet -mdraid -multipath -nbd -nfs -ssh-client
> -syslog -systemd"
>
> Kernel command line:
> "root=live:UUID=81689ddf-98ab-4314-b420-ce78d505f919 rw
> init=/usr/lib/systemd/systemd"
>
> squashfs.img resides in LiveOS directory on root of USB stick with above UUID.
>
> Regards, Tim
