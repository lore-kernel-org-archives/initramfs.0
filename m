From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2 2/2] let user specify action after systemd start dracut-emergency
Date: Fri, 31 May 2013 11:45:13 +0200
Message-ID: <51A87129.4070307@redhat.com>
References: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369816679.git.bhe@redhat.com> <dc98d3640cb7f265d9a84a11b87e494635485e8d.1369816679.git.bhe@redhat.com> <51A712D0.80002@redhat.com> <51A718C8.9070406@redhat.com> <51A86FDC.1050606@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A86FDC.1050606-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/31/2013 11:39 AM, Baoquan wrote:
> On 05/30/2013 05:15 PM, Harald Hoyer wrote:
> 
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
> 
> 
> Hi Harald,
> 
> It is emergency.service takes care of emergency. Now I add
> "ConditionKernelCommandLine=!action_on_fail=continue" to
> emergency.service, the process just hang there. below is the console output:
> 
> [    1.366071] bio: create slab <bio-1> at 1
> dracut-initqueue[124]: Warning: Could not boot.
> dracut-initqueue[124]: Warning: Not dropping to emergency shell, because
> 'action_on_fail=continue' was set on the kernel command line.
> [  OK  ] Started dracut initqueue hook.
>          Mounting /sysroot...
> [FAILED] Failed to mount /sysroot.
> See 'systemctl status sysroot.mount' for details.
> [DEPEND] Dependency failed for Initrd Root File System.
> [DEPEND] Dependency failed for Reload Configuration from the Real Root.
> [  185.641729] systemd[1]: Unit sysroot.mount entered failed state.
> [  185.642906] systemd[1]: Starting Journal Service...
> [  185.644860] systemd[1]: Stopped udev Kernel Device Manager.
> [  185.645337] systemd[1]: Stopping dracut pre-udev hook...
> [  185.645743] systemd[1]: Stopped dracut pre-udev hook.
> [  185.647077] systemd[1]: Stopping dracut cmdline hook...
> [  185.647498] systemd[1]: Stopped dracut cmdline hook.
> [  185.647884] systemd[1]: Starting Setup Virtual Console...
> [  185.649641] systemd-journald[49]: Received SIGTERM
> [  185.650284] systemd[1]: Stopping udev Kernel Socket.
> [  185.650690] systemd[1]: Closed udev Kernel Socket.
> [  185.652039] systemd[1]: Stopping udev Control Socket.
> [  185.652469] systemd[1]: Closed udev Control Socket.
> [  185.656516] systemd[1]: Starting Journal Service...
> [  185.657075] systemd[1]: Started Journal Service.
> 
> 
> Baoquan
> Thanks
> 

emergency.service is the last resort emergency.

[harald@lenovo rules (master)]$ fgrep OnFail /lib/systemd/system/*.target
/lib/systemd/system/initrd-fs.target:OnFailure=emergency.target
/lib/systemd/system/initrd-fs.target:OnFailureIsolate=yes
/lib/systemd/system/initrd-root-fs.target:OnFailure=emergency.target
/lib/systemd/system/initrd-root-fs.target:OnFailureIsolate=yes
/lib/systemd/system/initrd.target:OnFailure=emergency.target
/lib/systemd/system/initrd.target:OnFailureIsolate=yes

Maybe we should refrain from isolating to the emergency.target, which starts
emergency.service.

I'll ask on the systemd-devel list.
