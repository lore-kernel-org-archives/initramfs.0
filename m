From: si-wei liu <si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: iscsi netboot failure in case of multiple interfaces
Date: Fri, 17 Nov 2017 16:42:38 -0800
Message-ID: <c8e88ebe-4a91-738a-d1c4-067e9f0c4df6@oracle.com>
References: <3d6d6a40-692f-6c7f-fadd-ef6ccaab510d@oracle.com>
 <98407a21-3e1d-6355-1ba5-f732afb674d7@oracle.com>
 <1510751540.17501.55.camel@suse.de>
 <d15c3567-509e-7bcd-62e9-6930b203753b@oracle.com>
 <08997d6f-0b94-af50-d407-0c4803a70697@oracle.com>
 <1510837385.10823.6.camel@suse.de>
 <0a3f48bc-d110-e163-22a5-795c2d554297@oracle.com>
 <1510945872.16284.37.camel@suse.de>
 <70c4311d-ef4b-ee59-712d-930e173e289e@oracle.com>
 <1510964277.7555.4.camel@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1510964277.7555.4.camel-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>, Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Vasanth Vemula <vasanth.vemula-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>



On 11/17/2017 4:17 PM, Martin Wilck wrote:
> On Fri, 2017-11-17 at 16:09 -0800, si-wei liu wrote:
>> On 11/17/2017 11:11 AM, Martin Wilck wrote:
>>> Please note that I'm not the author of the patch I linked, and that
>>> this link I sent was also just a starting point:
>>>
>>> https://github.com/danimo/dracut/commits/obs_from_git/modules.d/95i
>>> scsi
>>>
>>> Note also that this branch is quite a bit behind upstream dracut in
>>> other areas, so porting the iSCSI changes may not be trivial.
>> Is there a plan to upstream these patches soon?
> I don't know. I'll try to find out.

OK. Thanks!
>
>>   Without getting the divergence into the
>> upstream it effectively prohibits other folks from contributing bug
>> fixes to the long standing issue as the nature of the two approaches
>> (fix iscsid v.s. overhaul with iscsiadm) are in conflict? Is there a
>> tradeoff in between - we fix the iscsistart issue first then once
>> you're
>> ready to upstream you overwrite what we had done?
> If you think you're able to fix iscsistart for good, go ahead.
> I have my doubts that it'll work in complex situations.
Yeah I understand the current mix use of iscsid and iscsistart is not 
quite good. Some may work by chance while some resorts to good timing 
thanks to various places of delay (sleep 1) in the script. I like the 
proposal of new design of replacing iscsistart, that looks clean indeed.

Thanks,
-Siwei



> Martin
>
