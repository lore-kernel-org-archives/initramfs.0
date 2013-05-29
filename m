From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut systemd cmdline service fix
Date: Wed, 29 May 2013 10:38:45 +0200
Message-ID: <51A5BE95.3070303@redhat.com>
References: <51946b65.1SfwJA0QAkY6Gb83%dyoung@redhat.com> <51A48CC2.40500@redhat.com> <51A5614C.8090606@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A5614C.8090606-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/29/2013 04:00 AM, Dave Young wrote:
> On 05/28/2013 06:53 PM, Harald Hoyer wrote:
>> On 05/16/2013 07:15 AM, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:
>>>
>>> Kdump test failed since below commits 
>>> dbfaae0e34507d2d1f3c186ffe26af3e8028b9f8
>>>
>>> Fedora bug is here:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=963159
>>>
>>> The reason is the hooks afterwards need NEWROOT env which
>>> is set in dracut-cmdline.sh.
>>>
>>> In this case there's no files under /etc/cmdline.d/ and
>>> /lib/dracut/hooks/cmdline/. Conditions checking failed, so
>>> the cmdline service failed to startup.
>>>
>>> Fix this issue by remove the Conditions thus cmdline service
>>> always run if /etc/initrd-release exists.
>>>
>>> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  modules.d/98systemd/dracut-cmdline.service |    5 -----
>>>  1 file changed, 5 deletions(-)
>>>
>>> --- dracut.orig/modules.d/98systemd/dracut-cmdline.service
>>> +++ dracut/modules.d/98systemd/dracut-cmdline.service
>>> @@ -16,11 +16,6 @@ Before=systemd-vconsole-setup.service
>>>  After=systemd-journald.socket
>>>  Wants=systemd-journald.socket
>>>  ConditionPathExists=/etc/initrd-release
>>> -ConditionPathExistsGlob=|/etc/cmdline.d/*.conf
>>> -ConditionDirectoryNotEmpty=|/lib/dracut/hooks/cmdline
>>> -ConditionKernelCommandLine=|rd.break=cmdline
>>> -ConditionKernelCommandLine=|resume
>>> -ConditionKernelCommandLine=|noresume
>>>  
>>>  [Service]
>>>  Type=oneshot
>>
>> Will be fixed by setting
>>
>> Environment=DRACUT_SYSTEMD=1
>> Environment=NEWROOT=/sysroot
>>
>> in the service files.
>>
> Hi, Harald
> 
> Thanks for your fix, but I'm still worrying about below code:
> -ConditionPathExistsGlob=|/etc/cmdline.d/*.conf
> -ConditionDirectoryNotEmpty=|/lib/dracut/hooks/cmdline
> 
> Is the above Conditions 'or' or 'and' relations?
> will it just skip cmdline service in case any of the conditions do es not match?

It is OR and it will start dracut-cmdline.service if any of the |= conditions is
matched.

> 
> If above is true then I'm still worrying about we will cause more problems. grep "inst_hook cmdline" shows a lot of stuff which is not limited to parsing /etc/cmdline.d/*.conf, such as:
> 04watchdog/module-setup.sh:    inst_hook cmdline   50 "$moddir/watchdog.sh"
> 40network/module-setup.sh:    inst_hook cmdline 91 "$moddir/dhcp-root.sh"
> 96securityfs/module-setup.sh:    inst_hook cmdline 60 "$moddir/securityfs.sh"
> 
> Even for hooks parsing cmdline, the cmdline params are not limited to /etc/cmdline.d/*.conf, they can also be specified in grub cmdline, isn't it?
> 

If anything is installed in the cmdline hook via "inst_hook cmdline" the
dracut-cmdline.service will be started because of
ConditionDirectoryNotEmpty=|/lib/dracut/hooks/cmdline
