From: Xunlei Pang <xpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] kernel-modules: handle nfs host fstype properly
Date: Wed, 26 Oct 2016 15:49:46 +0800
Message-ID: <5810601A.5010809@redhat.com>
References: <1465983624-12964-1-git-send-email-xlpang@redhat.com>
 <57612785.1030200@redhat.com>
 <462e1435-0412-904c-e8df-05b1e71b1d39@redhat.com>
Reply-To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <462e1435-0412-904c-e8df-05b1e71b1d39-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 2016/10/26 at 15:43, Harald Hoyer wrote:
> This should be fixed by:
> https://github.com/dracutdevs/dracut/blob/master/modules.d/95nfs/module-setup.sh#L28
>
> right?

exactly :-)

>
> On 15.06.2016 12:01, Xunlei Pang wrote:
>> Hi Harald,
>>
>> On 2016/06/15 at 17:40, Xunlei Pang wrote:
>>> There are scenarios that support fstype target not mounted
>>> beforehand, kdump can utilize this feature to avoid imposing
>>> severe overload on the shared nfs server when thousands of
>>> diskless clients with nfs kdumping boot and trigger kdump
>>> initramfs rebuild synchronously.
>>>
>>> Because target is not mounted beforehand, some of the kernel
>>> modules will fail to be installed in hostonly mode. Dracut
>>> actually can support this by instmods all "host_fs_types" with
>>> hostonly unset in 90kernel-modules/module-setup.sh installkernel().
>>>
>>> This works properly for most host fstypes(ext[234]/xfs, etc), but
>>> that's not the case for nfs.
>>>
>>> From nfs manpage, we can clearly see:
>>> "The fstype field contains "nfs". Use of the "nfs4" fstype in
>>> /etc/fstab is deprecated."
>>>
>>> It means "nfs" specified can be actually mounted as "nfs[3-4]", so
>>> for these cases, the current 90kernel-modules implementation only
>>> installs ko modules for "nfs"(nfs.ko, etc), lacking nfsv[3-4].ko,
>>> so it cannot work properly. In order to address the issue, we should
>>> install all the possbile kernel modules for "nfs" fstype:
>>> "nfs sunrpc ipv6 nfsv2 nfsv3 nfsv4 nfs_acl nfs_layout_nfsv41_files".
>> The list is directly copied from "95nfs/module_setup.sh installkernel()",
>> I am not sure if it is enough for all the nfs cases.
>>
>> I also tried to use insmods "=fs/nfs" instead, it installed more kernel
>> modules compared with the list, for example installed extra:
>>
>>   fs/nfs/blocklayout/blocklayoutdriver.ko
>>   fs/nfs/flexfilelayout/nfs_layout_flexfiles.ko
>>   fs/nfs/objlayout/objlayoutdriver.ko
>>
>>
>> I don't know if these kernel modules are necessary, if so I can change
>> to use "=fs/nfs" instead.
>>
>> Regards,
>> Xunlei
>>
>>> Additionally, we need a special remapping for "nfs[3-4]" deprecated
>>> cases, for example, we should map "nfs4" to "nfsv4.ko" not "nfs4.ko".
>>>
>>> Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  modules.d/90kernel-modules/module-setup.sh | 20 +++++++++++++++++++-
>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
>>> index 7904c02..1f57ec7 100755
>>> --- a/modules.d/90kernel-modules/module-setup.sh
>>> +++ b/modules.d/90kernel-modules/module-setup.sh
>>> @@ -44,7 +44,25 @@ installkernel() {
>>>                  dracut_instmods -o -P ".*/(kernel/fs/nfs|kernel/fs/nfsd|kernel/fs/lockd)/.*" '=fs'
>>>              fi
>>>          else
>>> -            hostonly='' instmods "${host_fs_types[@]}"
>>> +            for i in "${host_fs_types[@]}"; do
>>> +                if [[ $i = nfs ]]; then
>>> +                    # nfs manpage says:
>>> +                    # "The fstype field contains "nfs". Use of the "nfs4" fstype in
>>> +                    # /etc/fstab is deprecated."
>>> +                    #
>>> +                    # It means "nfs" can be actually mounted as "nfs4", so for "nfs"
>>> +                    # host fstype we better install all the possible kernel modules,
>>> +                    # this is useful for kdump "nfs" dumping not mounted beforehand.
>>> +                    #
>>> +                    # The list is copied from "95nfs/module_setup.sh installkernel()".
>>> +                    i="nfs sunrpc ipv6 nfsv2 nfsv3 nfsv4 nfs_acl nfs_layout_nfsv41_files"
>>> +                elif [[ $i = nfs[3-4] ]]; then
>>> +                    # Deprecated cases, we provide support, but need a name mapping:
>>> +                    # For example, should map "nfs4" to use "nfsv4.ko" not "nfs4.ko".
>>> +                    i=${i/nfs/nfsv}
>>> +                fi
>>> +                hostonly='' instmods $i
>>> +            done
>>>          fi
>>>      fi
>>>      :
>> --
>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
