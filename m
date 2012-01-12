From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Q: mount initramfs as the final root fs
Date: Thu, 12 Jan 2012 09:57:31 +0800
Message-ID: <4F0E3E0B.2080702@redhat.com>
References: <CAADET=cG8mdu-Je_MUGyKOP_G9sfU6sR3KHxybFMREjvexrKmg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAADET=cG8mdu-Je_MUGyKOP_G9sfU6sR3KHxybFMREjvexrKmg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Li <w.david.li-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/12/2012 08:54 AM, David Li wrote:

> Hi Everyone,
> 
> I need to let the kernel to mount the initramfs (created by dracut)
> as the final root filesystem. No disk and no NFS either!
> 
> I tried kernel option root=/dev/ram0 (the initrd way to mount init ram
> disk) but dracut didn't recognize this option. What should I use to
> accomplish this?


initramfs use root=xxx for switch_root to real rootfs. I also want this
feature but currently I can only use such as "rdbreak=cmdline" in kernel
cmdline to drop into shell

> 
> Thanks.
> 
> David
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
