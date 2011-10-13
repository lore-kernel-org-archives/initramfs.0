From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mount other than rootfs problem
Date: Thu, 13 Oct 2011 11:19:03 +0200
Message-ID: <4E96AD07.6040806@redhat.com>
References: <4E83DE33.4020204@redhat.com> <4E848C48.6050506@redhat.com> <4E8526A6.30003@redhat.com> <4E85370A.7020509@redhat.com> <4E853A1C.5070905@redhat.com> <20110930183839.GF25891@redhat.com> <20110930190311.GH25891@redhat.com> <4E9557F2.2060209@redhat.com> <4E955C5A.1010406@redhat.com> <20111012190744.GG12845@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111012190744.GG12845-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12.10.2011 21:07, Vivek Goyal wrote:
> On Wed, Oct 12, 2011 at 11:22:34AM +0200, Harald Hoyer wrote:
>> On 12.10.2011 11:03, Dave Young wrote:
>>> On 10/01/2011 03:03 AM, Vivek Goyal wrote:
>>>
>>>> On Fri, Sep 30, 2011 at 02:38:39PM -0400, Vivek Goyal wrote:
>>>>> On Fri, Sep 30, 2011 at 11:40:12AM +0800, Dave Young wrote:
>>>>>
>>>>> [..]
>>>>>>
>>>>>> Add lvm_scan in mount-sys.sh also works, so if we can make lvm_scan
>>>>>> being called automaticlly via dependencies it will be good. OTOH fstab
>>>>>> is better than cmdlines as an interface for multi-target dumping
>>>>>
>>>>> Agreed that fstab.sys looks like a good interface to mouting non-root devices.
>>>>
>>>> Having said that, looks like dracut builds all the state using command
>>>> line options. All the lvms, iscsi root, fcoe targets etc. So they might
>>>> expect everything to be passed on command line. In that case it will
>>>> become hard from kdump perspective.
>>>
>>>
>>> There's file injection feature in dracut, if the kdump.conf params can
>>> move to cmdline params we can just inject /etc/cmdline instead of pass
>>> them to kexec
>>>
>>
>> I will add /etc/cmdline.d/ as a drop in for configs. This can also be used
>> easily for combined initramfs images.
> 
> Harald,
> 
> We need something so that we can specify top level block device/uuid/label
> on either commandline or through /etc/cmdline.d/*.config and then dracut
> automatically figures out all the dependencies and packs all the relevant
> modules.
> 
> For example, one might say in kdump.conf that save the dump to a file
> system with UUID=xyz. Now one needs to figure out underlying devices,
> traverse through device stack, bring up associated networking and 
> traverse through networking stack.
> 
> I see in dracut seems to look for root device, and traverses through
> block device stack and every modules packs its relevant files if
> that type of device is found in stack.
> 
> So something like "extra_mount=dev/uuid/label" kind of command line
> will help where one can specify extra mount targets which are mounted.
> 
> Thanks
> Vivek

dracut only does this in hostonly mode... I guess, you will need hostonly, too,
to reduce the site of the initramfs.
