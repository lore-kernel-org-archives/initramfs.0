From: Mahesh Jagannath Salgaonkar <mahesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: Firmware assisted dump support in dracut
Date: Thu, 06 Jun 2013 14:04:05 +0530
Message-ID: <51B0497D.5060708@linux.vnet.ibm.com>
References: <50B73598.804@redhat.com> <50C03971.4050104@linux.vnet.ibm.com> <51A6E0E4.1000502@linux.vnet.ibm.com> <51A6F663.5030804@redhat.com> <20130530142318.GC2864@redhat.com> <51ADA343.2070100@linux.vnet.ibm.com> <20130604141403.GG4799@redhat.com> <20130604142123.GH4799@redhat.com> <51AF40BB.5010703@linux.vnet.ibm.com> <20130605145504.GE16339@redhat.com> <20130605155316.GI16339@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130605155316.GI16339-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Initramfs Dracut <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ananth Narayan <ananth-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>, Steven F Best <sbest-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org

On 06/05/2013 09:23 PM, Vivek Goyal wrote:
> On Wed, Jun 05, 2013 at 10:55:04AM -0400, Vivek Goyal wrote:
> 
> [..]
>>>> If first kernel and kdump kernel command line are same in fadump and
>>>> boot environment is same, I think it is worth exploring the option
>>>> of saving kdump from kdump service when system boots back. That will
>>>> do away with any need to tweak initramfs.
>>>
>>> This needs larger memory to be reserved. We may need to make sure that
>>> kdump service is invoked at very early stage before other services kicks
>>> in which may start requesting for memory and run into OOM issue. If we
>>> can make sure that no other services are invoked when kdump service is
>>> saving dump then it will help to fix the size of reserved memory. The
>>> systemd infrastructure provides aggressive parallelization capabilities.
>>> I am not expert on systemd but will need to explore whether with systemd
>>> is this possible.
>>
>> I think we can create a new service for saving dump and make some of
>> the systemd services dependent on start of this service. 
>>
>> Can't integrate with existing kdump service as that one can start
>> later and can take time in regenerating initramfs and holding back other
>> services for that duration will not make sense.
>>
>> By creating a seprate service, delay will be introduced only when there
>> s dump to be saved. Before this we will have bring up all networking
>> and storage in the system so that we can save dump to intended target.
>>
>> I think same service can be used to save dump from inside initramfs
>> too. (As systemd is now started inside initramfs too). 
>>
>> Other appraoch is dumping through initramfs and if you do things
>> conditionally (if dump is available), then any dracut parameter
>> used by kdump will have to have a conditional version too. Something
>> like
>>
>> mount=
>> mount.kdump_only=

Agree. The kdump_only options can be used to store the kdump related
required configs (e.g. lvm configs, network configs etc.) in a separate
directory and add a pre-udev hook that can check if dump is available
and move these configs to their original paths so that the normal
initramfs flow will do its job as per configs.

>>
>> mount.kdump_only will kick in only dump is available. Also we need to
>> make sure that effects of all kdump_only options are undone before
>> root is mounted or we create nice handover mechanism to systemd. I think

Agree.

>> there handover mechanism already between initramfs and systemd for complex
>> storage targets like multipathd.
>>
>> I will let harald comment on what does he think of kdump_only variant
>> options.
> 
> Thinking more about it, I think from kdump point of view, it is better
> to be able to dump from initrafs. We don't want different mechanism
> for different architecture which will result in more confusion and
> possibly code duplication.
> 

Agree. And if we rely on dracut to rebuild the initramfs (with original
dracut arguments) we can be sure that we wont run into issues like
unbootable system.

Thanks,
-Mahesh.
