From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mount other than rootfs problem
Date: Wed, 12 Oct 2011 17:03:46 +0800
Message-ID: <4E9557F2.2060209@redhat.com>
References: <4E83DE33.4020204@redhat.com> <4E848C48.6050506@redhat.com> <4E8526A6.30003@redhat.com> <4E85370A.7020509@redhat.com> <4E853A1C.5070905@redhat.com> <20110930183839.GF25891@redhat.com> <20110930190311.GH25891@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110930190311.GH25891-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 10/01/2011 03:03 AM, Vivek Goyal wrote:

> On Fri, Sep 30, 2011 at 02:38:39PM -0400, Vivek Goyal wrote:
>> On Fri, Sep 30, 2011 at 11:40:12AM +0800, Dave Young wrote:
>>
>> [..]
>>>
>>> Add lvm_scan in mount-sys.sh also works, so if we can make lvm_scan
>>> being called automaticlly via dependencies it will be good. OTOH fstab
>>> is better than cmdlines as an interface for multi-target dumping
>>
>> Agreed that fstab.sys looks like a good interface to mouting non-root devices.
> 
> Having said that, looks like dracut builds all the state using command
> line options. All the lvms, iscsi root, fcoe targets etc. So they might
> expect everything to be passed on command line. In that case it will
> become hard from kdump perspective.


There's file injection feature in dracut, if the kdump.conf params can
move to cmdline params we can just inject /etc/cmdline instead of pass
them to kexec

> 
> Thanks
> Vivek
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
