From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut systemd cmdline service fix
Date: Thu, 30 May 2013 08:52:50 +0200
Message-ID: <51A6F742.5030400@redhat.com>
References: <51946b65.1SfwJA0QAkY6Gb83%dyoung@redhat.com> <51A48CC2.40500@redhat.com> <51A6DEA3.4060505@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A6DEA3.4060505-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/30/2013 07:07 AM, Dave Young wrote:
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
> 
> Hi, Harald
> 
> Kdump test still fails, looks like pre-pivot hooks scripts do not get
> the NEWROOT value.
> 
> How about move the NEWROOT= to dracut-lib.sh, any hooks want to use
> NEWROOT should source dracut-lib.sh?
> 

--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -2,6 +2,9 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh

+export DRACUT_SYSTEMD
+export NEWROOT
