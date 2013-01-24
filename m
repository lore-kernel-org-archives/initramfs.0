From: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] Add an exception handle check function
Date: Thu, 24 Jan 2013 11:12:46 +0800
Message-ID: <5100A6AE.5020003@redhat.com>
References: <76d7b2f339455dcea6a2827b004bfcd9c6fa2315.1356080083.git.bhe@redhat.com> <50F7CC85.5060303@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50F7CC85.5060303-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/17/2013 06:03 PM, Dave Young wrote:
>> In some cases, exception happened, default handling is called. However,
>> >  user may not like the handling, want to specify a handler for these
>> >  exceptions.
>> >  
>> >  Add an exception handle check function. Call it where exceptions happened,
>> >  and specify a extra special handler. If user want the special handler handles
>> >  this exception, related cmdline is added.
>> >  
>> >  Then Dracut will check the cmdline, if related cmdline exists, call the
>> >  specified handler; if not, call the default handler.
>> >  
>> >  The function can be called like below:
>> >  exception_handle_check -h continue_on_fail
> I think exception_handle is not a good name, how about use "failaction"
> instead?
>
> And maybe use below action names:
> failaction=continue/shell
>
> IMHO, reboot is not useful for usual initrd. For kdump add a "continue"
> is enough because kdump module will handle failure of itself as long as
> dracut ignore previous failures.
>
> These 3 patches should better to be one patch. Or split them to 2
> patches as below
> 1/2: make emergency_shell as a fail action
> 2/2: add a new fail action of "continue"
>
I hesitated to name this function, maybe failaction is a good name.

I thought at least there were 3 options, 'continue_on_fail', 
'emergency_shell'  and 'reboot'. After thinking, maybe 'reboot' is not 
necessary. After all rebooting system may not be wanted by user after a 
fail occurred,.

If only 'continue_on_fail' and 'emergency_shell', things will be easier. 
The only question is all insert point of the failaction will take the 
same action. e.g mount loop for rootfs, inirqueue loop and dump target 
mount loop, if user add the  cmdline:
failaction=continue_on_fail
Then all insert point will do the continue on fail.

Anyway, I will repost based on two options 'continue_on_fail' and 
'emergency_shell'.

Baoquan
Thanks a lot!


