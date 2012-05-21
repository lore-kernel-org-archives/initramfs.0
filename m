From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut:fstab-sys: Wait for devices specified using --mount
 option
Date: Mon, 21 May 2012 11:12:25 +0200
Message-ID: <4FBA06F9.6070000@redhat.com>
References: <20120515172301.GB24585@redhat.com> <20120515173611.GC24585@redhat.com> <20120517132332.GB16297@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120517132332.GB16297-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 17.05.2012 15:23, schrieb Vivek Goyal:
> On Tue, May 15, 2012 at 01:36:11PM -0400, Vivek Goyal wrote:
>> [Regenerated the patch on top of git repo. Should be easier to apply now]
>>
>> dracut allows passing --mount option which mounts the specified devices.
>> But it does not wait for these devices to show up and mounting will fail
>> if devices do not show up by the time "mount" was called.
>>
>> I am writing some patches to support kdump on iscsi target and I noticed
>> that one of the initqueue script was not called as we found the root
>> device and broke out of main loop.
>>
>> There are two possible enancements to this patch.
>>
>> - Introduce a time limited wait (rd.timeout something along the lines of
>>   rd.retry). That will allow kdump to try to dump to a backup target if
>>   primary targets fails to come up.
>>
>> - Wait for UUID= and LABEL= to show up too. Right now kdump converts
>>   UUID= and LABEL= to respective devices and passes /dev/* to dracut
>>   --mount option. So I am not introducing the wait for UUID= or LABEL=
>>  in this patch.
>>
>> Signed-off-by: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> Hi Harald,
> 
> Any feedback on the patch? Do let me know if you want some changes.
> 
> Thanks
> Vivek

pushed! Thanks!
