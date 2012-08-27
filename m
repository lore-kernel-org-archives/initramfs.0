From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch v2 2/3] Add for_each_host_dev_and_slaves for device only
 checking
Date: Mon, 27 Aug 2012 16:00:42 +0800
Message-ID: <503B292A.70707@redhat.com>
References: <20120823030221.587864989@redhat.com> <20120823030628.133563734@redhat.com> <20120823152631.GI12232@redhat.com> <503B1A62.4010905@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <503B1A62.4010905-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 08/27/2012 02:57 PM, Dave Young wrote:

> On 08/23/2012 11:26 PM, Vivek Goyal wrote:
> 
>> On Thu, Aug 23, 2012 at 11:02:23AM +0800, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:
>>> For lvm, multipath, iscsi modules they do not care about the filesystem,
>>> Also there could be devcie in host_devs but it does not get formated.
>>>
>>> For these kind of modules, use for_each_host_dev_and_slaves will be better than use
>>> for_each_host_dev_fs, here add a new function to iterate the host_devs and
>>> their slave devices.
>>>
>>> In original for_each_host_dev_fs, it will call check_block_and_slaves which
>>> will return once helper function return 0, but this is not enough for kdump
>>> iscsi setup. For kdump iscsi case, it need setup each slave devices so that
>>> the iscsi target can be properly setuped in initramfs.
> 
> 
> Firstly, fix myself, check_block_and_slaves is not called in
> for_each_host_dev_fs. It's called when dracut.sh collect and push
> host_fs_types, so because there's no enough slave devices in
> host_fs_types is_iscsi will only check the target in host_fs_types.
> 
>>>
>>> Thus, this patch also add new functions check_block_and_slaves_all and
>>> for_each_host_dev_and_slaves_all.
>>
>> I think this patch should be broken in two parts for more clarity.
> 
> 
> Will do
> 
>>
>> - Fix the kdump iscsi issue where we don't expect to break out of the
>>   loop the moment first iscsi device is found.
>>
>> - Start using host_dev instead of host_dev_fs for modules which don't
>>   care about fs. Also why to have host_devs[] and host_fs_types[] both.
>>   Looks like host_fs_types contains both device and fs information. I
>>   think that includes strings like LVM etc.
>>
>>   So can we merge both into one and those modules who don't require fs
>>   info will ignore it. Or, keep one data structure host_dev_fs_types, 
>>   and provide two helper functions. One which provdes on $dev in $1
>>   and other which provides both dev and fs as argument to the function.
> 
> 
> Will try the host_fs_types with optional fs type like "dev|[fs]"
> 


Rethinking about this, it's not possible to fix this with host_fs_types.
Because dracut.sh check_block_and_slaves then add them to host_devs, if
we are going to use host_fs_types then we need push slaves into
host_devs as well, thus the patch 1/3 will wait for all host devices
including slaves...

This patchset works just because I created the new for_each_host_dev_and
slaves so it does not need slaves in host_devs.


So I would only split this patch into 2 patches without change the logic
any more...

-- 
Thanks
Dave
