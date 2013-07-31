From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Change the implementation of action_on_fail
Date: Wed, 31 Jul 2013 16:25:57 +0200
Message-ID: <51F91E75.3070102@redhat.com>
References: <73cc07330929ba4b226f2a0623a5459cd42932b9.1374574542.git.bhe@redhat.com> <51F91A14.4020601@redhat.com> <20130731142050.GG31151@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130731142050.GG31151-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 07/31/2013 04:20 PM, Vivek Goyal wrote:
> On Wed, Jul 31, 2013 at 04:07:16PM +0200, Harald Hoyer wrote:
>> On 07/23/2013 12:16 PM, Baoquan He wrote:
>>> Currently when action_on_fail is enabled, the emergency_shell won't be called.
>>> In kdump even though user specify the default action as emergency_shell,
>>> dracut skip it. Now change the implementation of action_on_fail to depend
>>> on a file which is created by kdump when making kdump initrd, then remove it
>>> at the beginning of kdump. This can solve the explicit emergency_shell problem.
>>>
>>> And action_on_fail won't need paramenters, remove the relevant description in
>>> dracut man page.
>>
>> I like it.
>>
>> Vivek: would that solve one of your systemd problems?
> 
> Hi Harald,
> 
> Yes this should solve one of the problems of being able to call emergency
> shell from kdump module.
> 
> I was thinking of modirying emergency.service on the fly and then reload
> systemd config. But I guess this solution is simpler.
> 
> It also takes away the flexibility of being able to specify "reboot" or
> some other actions as failure actions. But nobody as asked for those
> yet.
> 
> So yes, agreed, this will solve atleast one problem. So makes sense
> to take it in.
> 
> Thanks
> Vivek
> 

pushed, thanks!
