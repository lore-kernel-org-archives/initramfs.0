From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 19/33] Restore original IFS value
Date: Fri, 21 Nov 2014 13:37:52 +0100
Message-ID: <546F3220.6020701@redhat.com>
References: <1416495428-36978-1-git-send-email-trenn@suse.de> <1416495428-36978-20-git-send-email-trenn@suse.de> <546F019E.2030906@redhat.com> <1663155.urKhXtjdun@skinner>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1663155.urKhXtjdun@skinner>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: hare-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 21.11.2014 11:53, Thomas Renninger wrote:> On Friday, November 21, 2014
10:10:54 AM Harald Hoyer wrote:
>> On 20.11.2014 15:56, Thomas Renninger wrote:
>>> From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> ..
>>> diff --git a/modules.d/95iscsi/module-setup.sh
>>> b/modules.d/95iscsi/module-setup.sh index 9975e59..f551c49 100755
>>> --- a/modules.d/95iscsi/module-setup.sh
>>> +++ b/modules.d/95iscsi/module-setup.sh
>>> @@ -29,16 +29,18 @@ check() {
>>>
>>>  }
>>>
>>>  get_ibft_mod() {
>>>
>>> -    local ibft_mac=$1
>>> +    local ibft_mac=$1 IFS
>>>
> ...
>>>      done
>>>
>>>  }
>>
>> That's a valid point.
>
> Wait, this function is touched in a later patch, nuking
> IFS modifcations totally.
> I removed the whole patch and adjusted the later patch now.
> Which, eh..., is missing.

Then squash them please.

> I had not the whole series applied when sending.
> Patches 34..42 are missing.
> I'll resend. No need to go through all. It's just the
> ones in the end which are new.
> New series will have your 2 mentioned fixes added already.
>
> I also add the fcoe patches, will take the one or other hour...
>
> Thanks,
>
>       Thomas
>
