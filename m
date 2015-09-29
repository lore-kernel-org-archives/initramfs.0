From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Can't mount USB within initramfs
Date: Tue, 29 Sep 2015 16:04:02 +0800
Message-ID: <20150929080402.GC30623@dhcp-129-73.nay.redhat.com>
References: <CAB1R3shGMbuAh8HKSFq086VegXo7vLh=f7EH-49wjoBd_p69BQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAB1R3shGMbuAh8HKSFq086VegXo7vLh=f7EH-49wjoBd_p69BQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex <mysqlstudent-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/13/15 at 02:50pm, Alex wrote:
> Hi,
> 
> I have a fedora22 system with dracut-041-10 and initramfs created with
> it fails at "reached target basic system". I enabled some debugging,
> and it appears to just loop, unable to mount a root, until I get a
> dracut shell.
> 
> It's created an sosreport, but I'm unable to mount a USB stick to copy
> it. It displays info about the device when it's inserted, but no
> device name is assigned to it. Is this a problem with how the
> initramfs was created, a bug, or am I doing something wrong?
> 
> The only modules in /usr/lib/modules/drivers are gpu drivers,
> i2c/algos, and raid1 and raid456. The system has a RAID1 and a RAID5
> partition, but the kernel modules aren't loaded (have to load them
> manually), but then no devices are shown in /proc/mdstat there either.
> 
> Is filesystem support compiled into the kernel or must that be added
> to the initramfs manually?

You can try add them manually like below, assume you are using vfat filesystem..
--add-drivers "usb_storage vfat"

Thanks
Dave
