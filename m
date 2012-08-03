From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: multipath device issue
Date: Fri, 03 Aug 2012 13:36:27 +0800
Message-ID: <501B635B.1090703@redhat.com>
References: <501A0B87.9070506@redhat.com> <501A3532.7010907@redhat.com> <501A7590.3010701@redhat.com> <501A7E2A.4020601@redhat.com> <501A8078.1020208@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <501A8078.1020208-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 08/02/2012 09:28 PM, Dave Young wrote:

> On 08/02/2012 09:18 PM, Harald Hoyer wrote:
> 
>> Am 02.08.2012 14:41, schrieb Dave Young:
>>> On 08/02/2012 04:07 PM, Harald Hoyer wrote:
>>>
>>>> Am 02.08.2012 07:09, schrieb Dave Young:
>>>>> Hi,
>>>>>
>>>>> The multipath device node was not created during testing kdump on
>>>>> multipath target. dracut drop into emergency shell,  I checked that
>>>>> 'multipathd -B' was running in background. Any idea?
>>>>>
>>>>> Attached the full log of debug info.
>>>>>
>>>>
>>>> hmm.. I hope, this did not introduce a regression:
>>>> http://git.kernel.org/?p=boot/dracut/dracut.git;a=commitdiff;h=c0cae7f702b5ccf27a80913642aec8bf15fe710e
>>>
>>>
>>> Revert this commit does not help in this case.
>>>
>>> I tried manually run `multipath` in the emergency shell the
>>> /dev/mapper/mpathb will be created..
>>>
>>
>> oh.. can you retry with dracut-023? I think your version is missing this patch:
>>
>> http://git.kernel.org/?p=boot/dracut/dracut.git;a=blobdiff;f=modules.d/90multipath/module-setup.sh;h=31d11088bd65932460f036cabbd7a33cab5c5ec7;hp=f9c1f81354f8932a28561822452107da3aa6c349;hb=24a38bc1cbe461c344ce61c7e10b6d51d5689c93;hpb=82b1739dcee8853c07675d3e79b2f4623c60a364
>>
>> from
>>
>> http://git.kernel.org/?p=boot/dracut/dracut.git;a=commitdiff;h=24a38bc1cbe461c344ce61c7e10b6d51d5689c93
> 
> 
> I in fact use the dracut-023, but I found I have no 66-kpartx.rules,
> maybe I should upgrade udev as well.
> 
> Will have a test tomorrow.


Hi, harald

It has nothing to do with the udev rules.

There's two issues:
1) 90multipath install multipath.sh to pre-trigger hook, but seems
/dev/mapper/mpathX depends on /dev/dm-* population which will be created
after udev trigger.

2) fstab-sys call wait_for_dev /dev/mapper/mpathb in initqueue,
/dev/mapper/mpathb does not geting change to create, so dracut drop to
emergency shell.

I'm not sure what's the right way to resolve this, move multipath.sh to
pre-mount hook looks resolve the issue 1), how to resolve the issue 2)?
comment out it works, but it looks not a right fix.

I'm not familiar with multipath, please correct me for anything wrong.

-- 
Thanks
Dave
