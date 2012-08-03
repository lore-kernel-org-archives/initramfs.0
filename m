From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: multipath device issue
Date: Fri, 03 Aug 2012 16:55:22 +0800
Message-ID: <501B91FA.6010703@redhat.com>
References: <501A0B87.9070506@redhat.com> <501A3532.7010907@redhat.com> <501A7590.3010701@redhat.com> <501A7E2A.4020601@redhat.com> <501A8078.1020208@redhat.com> <501B635B.1090703@redhat.com> <501B7FCE.1050502@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <501B7FCE.1050502-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 08/03/2012 03:37 PM, Harald Hoyer wrote:

> Am 03.08.2012 07:36, schrieb Dave Young:
>> Hi, harald
>>
>> It has nothing to do with the udev rules.
>>
>> There's two issues:
>> 1) 90multipath install multipath.sh to pre-trigger hook, but seems
>> /dev/mapper/mpathX depends on /dev/dm-* population which will be created
>> after udev trigger.
>>
>> 2) fstab-sys call wait_for_dev /dev/mapper/mpathb in initqueue,
>> /dev/mapper/mpathb does not geting change to create, so dracut drop to
>> emergency shell.
>>
>> I'm not sure what's the right way to resolve this, move multipath.sh to
>> pre-mount hook looks resolve the issue 1), how to resolve the issue 2)?
>> comment out it works, but it looks not a right fix.
>>
>> I'm not familiar with multipath, please correct me for anything wrong.
>>

> 
> I think it _has_ to do with the udev rules.


What I should say is "It has nothing to do with the udev rules patches
you mentioned previously" ;)

> 
> 1. the multipathd daemon has to be started before udevd is started.
> 2. when udev is triggered, 62-multipath.rules should kick in and call
> "multipath" for every disk, which adds disks to the daemon, if they fit.
> 3. of course /etc/multipath.conf has to be configured correctly.
> 
> So, if you see /dev/mapper/mpathb be correctly created, when you start multpathd
> after all devices exist in /dev, then the 62-multipath.rules
> mechanism does not seem to work,

>

> With the next systemd release "rd.udev.log-priority=debug" does work again and
> we might be able to debug this issue.


Ok, will see if I can get something from the 62-multipath.rules. Thanks
for the suggestion.


-- 
Thanks
Dave
