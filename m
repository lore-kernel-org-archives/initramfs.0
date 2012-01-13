From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Q: mount initramfs as the final root fs
Date: Fri, 13 Jan 2012 09:40:07 +0800
Message-ID: <4F0F8B77.1000307@redhat.com>
References: <CAADET=cG8mdu-Je_MUGyKOP_G9sfU6sR3KHxybFMREjvexrKmg@mail.gmail.com> <4F0E3E0B.2080702@redhat.com> <A0D5581BE022624487D06FF31DA39EAC46DBF15B81@cs-mail.cloudshield.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A0D5581BE022624487D06FF31DA39EAC46DBF15B81-XBe2CvUQ4tsfmBx3fVEwjjKFCcWVdJTv@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Li, David" <LiD-H5gcd31RMI4yhQnFlXSU7w@public.gmane.org>
Cc: David Li <w.david.li-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 01/12/2012 11:17 PM, Li, David wrote:

> Dave,
> 
> I am not familiar with dracut internals. Two questions:
> 
> 1. Will rd.break=cmdline cause the kernel to mount initramfs before dropping into the shell?  I tried before "rdinit=/bin/sh". This forced the kernel to drop into a simple dash shell before /init was even started so not much useful.


initramfs is not need mount specially, it's supported in kernel

You can try different rd.break point. see dracut docs.
One thing is even if you don't need rootfs you still have to
add valid root= cmdline, or dracut init will fail

> 
> 2. Just saw you committed another patch in fstab-sys. You mentioned about mounting initramfs with --mount Dracut option. Is that the solution for the problem? 


I think It's not related to your problem.

> 
> Thanks.
> 
> David
> 
>> -----Original Message-----
>> From: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:initramfs-
>> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Dave Young
>> Sent: Wednesday, January 11, 2012 5:58 PM
>> To: David Li
>> Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Subject: Re: Q: mount initramfs as the final root fs
>>
>> On 01/12/2012 08:54 AM, David Li wrote:
>>
>>> Hi Everyone,
>>>
>>> I need to let the kernel to mount the initramfs (created by dracut) as
>>> the final root filesystem. No disk and no NFS either!
>>>
>>> I tried kernel option root=/dev/ram0 (the initrd way to mount init ram
>>> disk) but dracut didn't recognize this option. What should I use to
>>> accomplish this?
>>
>>
>> initramfs use root=xxx for switch_root to real rootfs. I also want this feature
>> but currently I can only use such as "rdbreak=cmdline" in kernel cmdline to
>> drop into shell
>>
>>>
>>> Thanks.
>>>
>>> David
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe initramfs"
>>> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Thanks
>> Dave
>> --
>> To unsubscribe from this list: send the line "unsubscribe initramfs" in the body
>> of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
