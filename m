From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2 2/2] let user specify action after systemd start dracut-emergency
Date: Thu, 30 May 2013 12:33:24 +0200
Message-ID: <51A72AF4.6070700@redhat.com>
References: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369816679.git.bhe@redhat.com> <dc98d3640cb7f265d9a84a11b87e494635485e8d.1369816679.git.bhe@redhat.com> <51A712D0.80002@redhat.com> <51A718C8.9070406@redhat.com> <51A726D0.9070509@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A726D0.9070509-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/30/2013 12:15 PM, Baoquan wrote:
> On 05/30/2013 05:15 PM, Harald Hoyer wrote:
> 
>>>> Hi Harald,
>>>>
>>>> Since adding ConditionKernelCommandLine=!action_on_fail=continue doesn't
>>>> work, do you mind applying this patch? Or do you have other suggestions?
>>>>
>>>> Baoquan
>>>> Thanks a lot
>> Hmm, "ConditionKernelCommandLine=!action_on_fail=continue" _has_ to work.
>> Otherwise I would consider that a serious bug in systemd.
>>
>> Care to elaborate how you tested it?
>>
>> If you are dropped to the shell, can you run:
>>
>> # systemctl status dracut-emergency.service
>> # systemctl status emergency.service
>>
>> to confirm you are not dropped to the emergency.service, which I think this is
>> the case in your test setup.
>>
>> So, we have to add "ConditionKernelCommandLine=!action_on_fail=continue" to
>> emergency.service, too.
>>
> 
> 
> Hi Harald,
> 
> I added this to dracut-emergency.service, and add
> action_on_fail=continue to kdump command line, then change
> dracut_initqueue.sh to make the RDENTRY=0, then mount won't succeed.
> 
> From my side, the ConditionKernelCommandLine=!action_on_fail=continue
> doesn't work.
> 
> And I also tried ConditionKernelCommandLine=action_on_fail=continue, but
> remove the kdump command line action_on_fail=continue, it didn't work
> either.
> 
> 
> Baoquan
> Thanks a lot
> 
> 

worksforme... with
http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=b78e6ac2c328c76057b17059a761ab44707f9aa0
and
"rd.shell rd.break action_on_fail=continue"

dracut-pre-pivot[227]: /lib/dracut-lib.sh@933(_emergency_shell): systemctl start
dracut-emergency.service
Trying to enqueue job dracut-emergency.service/start/replace
Installed new job dracut-emergency.service/start as 39
Enqueued job dracut-emergency.service/start as 39
Starting of dracut-emergency.service requested but condition failed. Ignoring.
Job dracut-emergency.service/start finished, result=done

.. no rd.shell on rd.break...
