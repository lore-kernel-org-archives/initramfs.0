From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 90multipath: add hostonly multipath.conf in case hostonly
 mode
Date: Tue, 7 Jul 2015 13:01:00 +0200
Message-ID: <559BB16C.9030302@redhat.com>
References: <20150706073126.GC22559@dhcp-128-51.nay.redhat.com>
 <559A5279.9010101@redhat.com> <20150707015252.GA8343@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150707015252.GA8343-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bmarzins-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 07.07.2015 03:52, Dave Young wrote:
> On 07/06/15 at 12:03pm, Harald Hoyer wrote:
>> On 06.07.2015 09:31, Dave Young wrote:
>>> For large machine, suppose there's a lot of multipath devices, multipath layer
>>> will use a lot of memory. For kdump kernel memory is very limited thus it causes
>>> oom. To avoid oom, we only add necessary multipath devices in kdump kernel
>>> multipath.conf.
>>>
>>> This is done by use mpathconf --allow, a new option which is like whitelist.
>>>
>>> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  modules.d/90multipath/module-setup.sh | 42 ++++++++++++++++++++++++++++-------
>>>  1 file changed, 34 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/modules.d/90multipath/module-setup.sh b/modules.d/90multipath/module-setup.sh
>>> index 29643d4..321f13e 100755
>>> --- a/modules.d/90multipath/module-setup.sh
>>> +++ b/modules.d/90multipath/module-setup.sh
>>> @@ -1,18 +1,28 @@
>>>  #!/bin/bash
>>>  
>>> +is_mpath() {
>>> +    local _dev=$1
>>> +    [ -e /sys/dev/block/$_dev/dm/uuid ] || return 1
>>> +    [[ $(cat /sys/dev/block/$_dev/dm/uuid) =~ mpath- ]] && return 0
>>> +    return 1
>>> +}
>>> +
>>> +majmin_to_mpath_dev() {
>>> +    local _dev
>>> +    for i in `ls -1 /dev/mapper/mpath*`; do
>>> +        dev=$(get_maj_min $i)
>>> +        if [ "$dev" = "$1" ]; then
>>> +            echo $i
>>> +            return
>>> +        fi
>>> +    done
>>> +}
>>>  # called by dracut
>>>  check() {
>>>      local _rootdev
>>>      # if there's no multipath binary, no go.
>>>      require_binaries multipath || return 1
>>>  
>>> -    is_mpath() {
>>> -        local _dev=$1
>>> -        [ -e /sys/dev/block/$_dev/dm/uuid ] || return 1
>>> -        [[ $(cat /sys/dev/block/$_dev/dm/uuid) =~ mpath- ]] && return 0
>>> -        return 1
>>> -    }
>>> -
>>>      [[ $hostonly ]] || [[ $mount_needs ]] && {
>>>          for_each_host_dev_and_slaves is_mpath || return 255
>>>      }
>>> @@ -79,7 +89,18 @@ installkernel() {
>>>  
>>>  # called by dracut
>>>  install() {
>>> -    local _f
>>> +    local _f _allow
>>> +    add_hostonly_mpath_conf() {
>>> +        is_mpath $1 && {
>>> +            local _dev
>>> +
>>> +            _dev=$(majmin_to_mpath_dev $1)
>>> +            [ -z "$_dev" ] && return
>>> +            strstr "$_allow" "$_dev" && return
>>> +            _allow="$_allow --allow $_dev"
>>> +        }
>>> +    }
>>> +
>>>      inst_multiple -o  \
>>>          dmsetup \
>>>          kpartx \
>>> @@ -93,6 +114,11 @@ install() {
>>>          /etc/multipath.conf \
>>>          /etc/multipath/*
>>>  
>>> +    [[ $hostonly ]] && {
>>> +        for_each_host_dev_and_slaves_all add_hostonly_mpath_conf
>>
>> don't we have to just check all $host_devs if it is a /dev/mapper/mpath* ??
> 
> Harald, I worry about stacked devices, host_devs are the top level devices,
> if slave deivces are multipath we should use for_each_host_dev_and_slaves,
> right?

sorry, brain failure... too hot in here. You are right, of course.

> 
>>
>>> +        [ -n "$_allow" ] && mpathconf $_allow --outfile ${initdir}/etc/multipath.conf
>>> +    }
>>> +
>>>      inst $(command -v partx) /sbin/partx
>>>  
>>>      inst_libdir_file "libmultipath*" "multipath/*"
>>>
>>
