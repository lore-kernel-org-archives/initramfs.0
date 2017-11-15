From: si-wei liu <si-wei.liu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: iscsi netboot failure in case of multiple interfaces
Date: Wed, 15 Nov 2017 11:47:39 -0800
Message-ID: <08997d6f-0b94-af50-d407-0c4803a70697@oracle.com>
References: <3d6d6a40-692f-6c7f-fadd-ef6ccaab510d@oracle.com>
 <98407a21-3e1d-6355-1ba5-f732afb674d7@oracle.com>
 <1510751540.17501.55.camel@suse.de>
 <d15c3567-509e-7bcd-62e9-6930b203753b@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d15c3567-509e-7bcd-62e9-6930b203753b-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Cathy Zhou <cathy.zhou-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>, Vasanth Vemula <vasanth.vemula-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>


On 11/15/2017 11:17 AM, Cathy Zhou wrote:
> Martin,
>
> Thank you very much for your insights. See inline:
>
> On 11/15/2017 5:12 AM, Martin Wilck wrote:
>> Hello Cathy,
>>
>> On Mon, 2017-11-13 at 10:43 -0800, Cathy Zhou wrote:
>>> Dracut experts,
>>>
>>> A gentle reminder ...  Looking forward to gaining some insights on
>>> below
>>> questions.
>> I haven't analyzed your scenario in detail, but IMHO this is a long-
>> standing issue. dracut is using both iscsid and iscsistart, which is
>> wrong. iscsistart is meant for situations where iscsid is not
>> available. It starts iscsid at startup, and stops it again when done.
>> If proper iscsid is running, iscsiadm should be used rather than
>> iscsistart to activate sessions.
> I agree. I was confused when I saw both iscsid and iscsistart were 
> started in dracut. That is why my proposal (a) was to stop the iscsid 
> service first before it starts iscsistart service. It fixed our 
> problem though I am not sure if it has some unexpected effect on some 
> other scenario.

Indeed, we got to ask here because we thought that iscsid first landed 
on dracut with this commit:

https://github.com/dracutdevs/dracut/commit/d94050ddaea8343d8adb8f151c8f4cad591d29d9

"
parse-cmdline sets up an initial initiator-name to let iscsid start.

iscsid is started before doing any iscsistart business.
"

We are not sure what iscsid was trying to manage if iscsistart can do 
the job well. Will it lose "robustness" if we remove iscsid from dracut? 
Specifically, iscsistart itself is able to launch iscsid automatically, 
and manage the life cycle of iscsid as needed. Why do we need a separate 
iscsid service managed by our own? What is the idea behind to coordinate 
these two when there are multiple interfaces involved?

>             systemctl try-restart iscsid
>             # FIXME: iscsid is not yet ready, when the service is :-/
>             sleep 1

Please let us know if it's desirable to keep iscsid around, or we can 
post patch to make iscsistart manage iscsid instead (or leave iscsid 
disabled).

Regards,
-Siwei

>>
>> In my experience, iscsistart will only work reliably if you have just a
>> single interface.
> Could you please elaborate on this? What issue you saw? It seems to me 
> as long as iscsistart works without iscsid is running, multiple 
> instances should also be fine?
>
> Thanks very much again
> - Cathy
>>
>> Martin
>>
>
