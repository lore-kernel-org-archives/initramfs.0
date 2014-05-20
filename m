From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-pre-pivot pulls in remote-fs.target
Date: Tue, 20 May 2014 13:28:41 +0200
Message-ID: <537B3C69.1000202@redhat.com>
References: <1396593462-29865-1-git-send-email-chaowang@redhat.com> <20140519142641.GA11572@dhcp-17-89.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140519142641.GA11572-2coKmSd1Zb6BYdNaKHuJJRcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 19.05.2014 16:26, WANG Chao wrote:
> On 04/04/14 at 02:37pm, WANG Chao wrote:
>> It turns out that commit f30b74e (dracut-initqueue service runs before
>> remote-fs-pre.target) is partial fix for remote fs mounts. Because no
>> one pulls in remote-fs.target, we can never start remote fs mounts.
>> Now pull in remote-fs.target in dracut-pre-pivot.
>>
>> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> Hi, Harald
> 
> Would you like to pick up this one?
> 
> People run into issue that nfs isn't mount in kdump kernel:
> https://bugzilla.redhat.com/show_bug.cgi?id=1091785
> 
> Thanks
> WANG Chao
> 
>> ---
>>  modules.d/98systemd/dracut-pre-pivot.service | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/modules.d/98systemd/dracut-pre-pivot.service b/modules.d/98systemd/dracut-pre-pivot.service
>> index 6db1f2c..d7c7b1d 100644
>> --- a/modules.d/98systemd/dracut-pre-pivot.service
>> +++ b/modules.d/98systemd/dracut-pre-pivot.service
>> @@ -13,6 +13,8 @@ Documentation=man:dracut-pre-pivot.service(8)
>>  After=initrd.target initrd-parse-etc.service sysroot.mount
>>  After=dracut-initqueue.service dracut-pre-mount.service dracut-mount.service
>>  Before=initrd-cleanup.service
>> +Wants=remote-fs.target
>> +After=remote-fs.target
>>  ConditionPathExists=/etc/initrd-release
>>  ConditionDirectoryNotEmpty=|/lib/dracut/hooks/pre-pivot
>>  ConditionDirectoryNotEmpty=|/lib/dracut/hooks/cleanup
>> -- 
>> 1.8.5.3
>>

Thanks!

http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=ce7f408dfd473b3c2f4fdb9ddc2b2131e08007d3
