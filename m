From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add option --printsize
Date: Mon, 21 May 2012 16:57:58 +0800
Message-ID: <4FBA0396.60705@redhat.com>
References: <20120521083706.GA3040@localhost.localdomain> <4FBA003D.50103@gmail.com> <4FBA01ED.2000001@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FBA01ED.2000001-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 05/21/2012 04:50 PM, Harald Hoyer wrote:

> Am 21.05.2012 10:43, schrieb Cong Wang:
>> On 05/21/2012 04:37 PM, Dave Young wrote:
>>> Add --printsize for measuring module installed size to initramfs
>>>
>> ...
>>> +
>>> +        #print the module install size
>>> +        if [ -n "$printsize" ]; then
>>> +            _isize_new=$(du -sk ${initdir}|cut -f1)
>>> +            _isize_delta=$(($_isize_new - $_isize))
>>> +            echo "$_d_mod install size: ${_isize_delta}k"
>>> +            _isize=$_isize_new
>>> +        fi
>>>       fi
>>
>> Yeah, it is a nice feature, to calculate the module installation size by delta
>> of the whole initrd size.
>>
>> Could you include the sample output in the changelog?


Hi cong, I just reply here of a sample, will add it if need a v2 patch:

[dave@localhost dracut]$ ./dracut.sh -l --printsize test.img 2>/dev/null
dash install size: 2372k
caps install size: 1148k
i18n install size: 3144k
rpmversion install size: 4k
network install size: 8688k
ifcfg install size: 8k
plymouth install size: 26000k
btrfs install size: 336k
crypt install size: 2572k
dm install size: 252k
dmraid install size: 356k
kernel-modules install size: 55548k
lvm install size: 2016k
mdraid install size: 800k
multipath install size: 748k
fcoe install size: 780k
iscsi install size: 520k
nfs install size: 22096k
resume install size: 12k
rootfs-block install size: 12k
terminfo install size: 60k
udev-rules install size: 956k
virtfs install size: 380k
biosdevname install size: 92k
usrmount install size: 4k
base install size: 1348k
fs-lib install size: 2324k
shutdown install size: 396k

>>
>> Thanks.
> 
> What about files used by many modules, like shared libraries and tools? The
> output should be taken with a grain of salt.


This rough printing at least can help use measure the module install
size which is not shared. It is the increased size directly caused by
the specific module_install.

Shared libraries is not considered here. It's hard to measure the shared
part.. Do you have any idea or suggestions?

> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
