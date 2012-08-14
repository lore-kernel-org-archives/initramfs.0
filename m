From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add option to bring up a device in initramfs
Date: Tue, 14 Aug 2012 14:27:27 +0800
Message-ID: <5029EFCF.4060005@redhat.com>
References: <20120809030848.GA10460@dhcp-16-143.nay.redhat.com> <20120813151029.GE24876@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120813151029.GE24876-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/13/2012 11:10 PM, Vivek Goyal wrote:

> On Thu, Aug 09, 2012 at 11:08:48AM +0800, Dave Young wrote:
>>
>> Kdump support dump to raw device which could be on top of complex storage
>> such as multipath and iscsi which are standalone dracut modules.
>>
>> Add a --device option to dracut which will add the device to host_devs so
>> dracut can add the dependent modules automaticlly and enable them in initramfs.
>>
> 
> You have not specified any format for --device argument? What do you expect
> there? Device name, UUID, udev persistent link, or what?


It's a device name, should metion it in doc as well.

> 
> Secondly, do we need some extra code to make sure somebody waits for
> this device to come up? Who makes sure that initqueue does not exit
> till this device node comes up.


I see there's a wait-mount-dev.sh in 95fstab-sys module which is for
waiting for the mount needed dev.

Currently dracut maintains host_devs and host_fs_types, host_fs_types
are mainly used inst the fs kernel modules. Other than the filesystem
modules we should use host_devs instead, ie. introduce
for_each_host_devs for modules such as multipath and iscsi using.

Another issue is waiting for host_devs should be handled in generic code
instead of 95fstab-sys.

This patch need an update to address these issues IMHO.

> 
> Thanks
> Vivek
> 
>> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Tested-by: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  dracut.8.asc |    3 +++
>>  dracut.sh    |    3 +++
>>  2 files changed, 6 insertions(+)
>>
>> --- dracut.orig/dracut.sh
>> +++ dracut/dracut.sh
>> @@ -133,6 +133,7 @@ Creates initial ramdisk images for prelo
>>    --mount "[DEV] [MP] [FSTYPE] [FSOPTS]"
>>                          Mount device [DEV] on mountpoint [MP] with filesystem
>>                          [FSTYPE] and options [FSOPTS] in the initramfs
>> +  --device "[DEV]"      Bring up [DEV] in initramfs
>>    -i, --include [SOURCE] [TARGET]
>>                          Include the files in the SOURCE directory into the
>>                           Target directory in the final initramfs.
>> @@ -261,6 +262,7 @@ TEMP=$(unset POSIXLY_CORRECT; getopt \
>>      --long fscks: \
>>      --long add-fstab: \
>>      --long mount: \
>> +    --long device: \
>>      --long nofscks: \
>>      --long ro-mnt \
>>      --long kmoddir: \
>> @@ -327,6 +329,7 @@ while :; do
>>          --fscks)       push fscks_l              "$2"; shift;;
>>          --add-fstab)   push add_fstab_l          "$2"; shift;;
>>          --mount)       push fstab_lines          "$2"; shift;;
>> +        --device)      push host_devs            "$2"; shift;;
>>          --nofscks)     nofscks_l="yes";;
>>          --ro-mnt)      ro_mnt_l="yes";;
>>          -k|--kmoddir)  drivers_dir_l="$2"; shift;;
>> --- dracut.orig/dracut.8.asc
>> +++ dracut/dracut.8.asc
>> @@ -321,6 +321,9 @@ provide a valid _/etc/fstab_.
>>      Mount _<device>_ on _<mountpoint>_ with _<filesystem type>_ and _<filesystem
>>      options>_ in the initramfs
>>  
>> +**--device** _<device>_ ::
>> +    Bring up _<device>_ in initramfs
>> +
>>  **-i, --include** _<SOURCE>_ _<TARGET>_::
>>      include the files in the SOURCE directory into the
>>      TARGET directory in the final initramfs. If SOURCE is a file, it will be



-- 
Thanks
Dave
