From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount option
Date: Mon, 23 Apr 2012 09:40:26 +0200
Message-ID: <4F95076A.9060504@redhat.com>
References: <20120418222829.GG2224@redhat.com> <4F8FD3E5.90103@redhat.com>  <20120420135156.GE22419@redhat.com> <1335154319.18028.14.camel@cr0>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335154319.18028.14.camel@cr0>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 23.04.2012 06:11, schrieb Cong Wang:
> On Fri, 2012-04-20 at 09:51 -0400, Vivek Goyal wrote:
>> On Thu, Apr 19, 2012 at 10:59:17AM +0200, Harald Hoyer wrote:
>>> Am 19.04.2012 00:28, schrieb Vivek Goyal:
>>>> Hi,
>>>>
>>>> I am trying to dump kernel vmcore to an software iscsi target (kdump).
>>>> kdump specifies the dump destination using "--mount" option. But dracut
>>>> does not even include the "iscsi" module and associated device is not
>>>> mounted in second kernel.
>>>>
>>>> Following is the dracut command line as called by /sbin/mkdumprd.
>>>>
>>>> dracut -m kdumpbase --add dash --add fstab-sys --add kernel-modules -c /dev/null -I /sbin/makedumpfile --mount '/dev/mapper/vg-lv_root / ext4 rw,seclabel,relatime,user_xattr,barrier=1,data=ordered' --mount '/dev/mapper/mpatha /mnt/common ext4 rw,seclabel,relatime,user_xattr,barrier=1,stripe=16,data=ordered' -M -f /boot/initramfs-3.3.2-1.fc17.x86_64kdump.img 3.3.2-1.fc17.x86_64
>>>
>>> "-m kdumpbase" - This tells dracut to only use the kdumpbase dracut module
>>> So, because the iscsi dracut module is not added, dracut does not even check() it.
>>>
>>> Why is it "-m kdumpbase" and not "--add kdumpbase" ???
>>
>> I don't know why -m is being used instead of --add. I tried changing it
>> to --add and uncompressed initramfs size changed from 36MB to 72MB.
>>
>> To me 32MB size itself is big. IIRc, in RHEL6 using our own mkinitrd, we had
>> uncomressed initrd size close to 25MB.
>>
>> In kdump environment we work in very restricted memory conditions.
>> Currently we reserve 128MB and there are calls to reduce it further. This
>> 128MB should load kernel, initramfs and run all the tools in initramfs
>> to actually save the vmcore to the target.
>>
>> So we need to figure out how can we reduce the size of initramfs for
>> kdump case. In the next mail I will add the output of --debug both for
>> -m kdumpbase and --add kdumpbase.
>>
>> From kdump perspective, we only need to mount targets as specified by
>> --mount option. We might not want to mount even root and it depends on
>> kdump.conf. If root is needed, we will pass that too on command line
>> using --mount. So this is little different from -H option.
>>
>> Can we modify dracut in such a way so that it packs only those modules
>> need to mount targets as specified --mount options?
> 
> Yeah, I noticed this too, I think this is due to the dracut module
> "kernel-modules" includes more than enough kernel modules into
> initramfs, thus the size increased so much.
> 
> Harald, if you have any idea to improve this? We need to find a way to
> tell "kernel-modules" module to only include the ones we want.

Just activate the host-only mode "--hostonly" or "-H"

> 
> Thanks.
> 
