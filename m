From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut does not mount iscsi targets specified using --mount option
Date: Fri, 20 Apr 2012 10:42:34 +0200
Message-ID: <4F91217A.6080905@redhat.com>
References: <20120418222829.GG2224@redhat.com> <4F8FD3E5.90103@redhat.com> <1334904333.20684.23.camel@cr0>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334904333.20684.23.camel@cr0>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 20.04.2012 08:45, schrieb Cong Wang:
> On Thu, 2012-04-19 at 10:59 +0200, Harald Hoyer wrote:
>> Am 19.04.2012 00:28, schrieb Vivek Goyal:
>>> Hi,
>>>
>>> I am trying to dump kernel vmcore to an software iscsi target (kdump).
>>> kdump specifies the dump destination using "--mount" option. But dracut
>>> does not even include the "iscsi" module and associated device is not
>>> mounted in second kernel.
>>>
>>> Following is the dracut command line as called by /sbin/mkdumprd.
>>>
>>> dracut -m kdumpbase --add dash --add fstab-sys --add kernel-modules -c /dev/null -I /sbin/makedumpfile --mount '/dev/mapper/vg-lv_root / ext4 rw,seclabel,relatime,user_xattr,barrier=1,data=ordered' --mount '/dev/mapper/mpatha /mnt/common ext4 rw,seclabel,relatime,user_xattr,barrier=1,stripe=16,data=ordered' -M -f /boot/initramfs-3.3.2-1.fc17.x86_64kdump.img 3.3.2-1.fc17.x86_64
>>
>> "-m kdumpbase" - This tells dracut to only use the kdumpbase dracut module
>> So, because the iscsi dracut module is not added, dracut does not even check() it.
> 
> Interesting, multipath and lvm etc. modules are added by dracut when it
> is needed by --mount, so why iscsi is special here?
> 
>>
>> Why is it "-m kdumpbase" and not "--add kdumpbase" ???
> 
> I thought "--add" is plus for "-m", so the initial module has to be
> added via "-m" in cmdline? Seems I was wrong, but could this be the
> reason that causes iscsi module not loaded?
> 
> Thanks!
> 

You can send me the output of dracut with the "--debug" option added to inspect
it further.
