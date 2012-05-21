From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] Avoid generating udev rules for vlan interface
Date: Mon, 21 May 2012 18:19:04 +0800
Message-ID: <4FBA1698.3090006@gmail.com>
References: <1337591686-31875-1-git-send-email-amwang@redhat.com> <1337591686-31875-3-git-send-email-amwang@redhat.com> <4FBA09F7.4030003@redhat.com> <4FBA0B8D.1070708@gmail.com> <4FBA0E7E.1070004@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yF1y+wlkmq6HxcUA7PxUP5NLKGqgeQWgB32iJnbr/Bs=;
        b=FAHl5paItKYhJQt6SgNBtqzD2D/rdMicwktHVM4qComJVnTagvvSR+xcadWCm9SVpO
         6aYzF4r4YHvlvCrx7C4EfGT8KFpRAaKZugmCzvxO26Z4AtBvFYIwgwef55FwY3i4RstU
         IEXmz4NjqJyKiy6+JyweOj3mk/J/7lyKZ6UJ4mvpjuaJQyOWz+kzaMSsEWEXTXE/H/KN
         utA5dMNQgfoyhH4SfoN9awEkt+N7zwli8Rz+IlIMNzh4SoeyC1TmkAeteAK2zS4N6+sE
         8k80lPdJUNOY1pvun7hNIPbr3YXU2Wlo4eAzbpWg7lVgRCew1ElkXjuM3YMiP4GBwaFv
         avoA==
In-Reply-To: <4FBA0E7E.1070004-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 05/21/2012 05:44 PM, Harald Hoyer wrote:
> Am 21.05.2012 11:31, schrieb Cong Wang:
>> On 05/21/2012 05:25 PM, Harald Hoyer wrote:
>>>> -        printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*",
>>>> ATTR{address}=="%s", ATTR{type}=="1", NAME="%s"\n' "$ifname_mac" "$ifname_if"
>>>> +        #Hack: vlan device has the same mac address with its physical device
>>>> +        [ -e /tmp/vlan.info ]&&   source /tmp/vlan.info
>>>> +        if [ "$ifname_if" != "$vlanname" ]; then
>>>> +            printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*",
>>>> ATTR{address}=="%s", ATTR{type}=="1", NAME="%s"\n' "$ifname_mac" "$ifname_if"
>>>> +        fi
>>>>        done
>>>>
>>>>        # Rename non named interfaces out of the way for named ones.
>>>
>>> Maybe one of the /sys attributes indicate, that it is a vlan interface?
>>
>> Hmm... I tried DRIVERS!="8021q", then I got:
>>
>> SUBSYSTEM=="net", ACTION=="add", DRIVERS!="8021q", ATTR{address}=="%s",
>> ATTR{type}=="1" NAME="eth0"
>>
>> SUBSYSTEM=="net", ACTION=="add", DRIVERS!="8021q", ATTR{address}=="%s",
>> ATTR{type}=="1" NAME="eth0.2"
>>
>> So, eth0 will be still renamed to eth0.2. :(
>
>
> DEVPATH!="*/virtual/*" should help

The problem is not in udev rules themselves, the problem is we generate 
two same lines for eth0 and eth0.2, even with DEVPATH!="*/virtual/*" we 
will have:

SUBSYSTEM=="net", ACTION=="add", DEVPATH!="*/virtual/*", 
ATTR{address}=="%s", ATTR{type}=="1" NAME="eth0"

SUBSYSTEM=="net", ACTION=="add", DEVPATH!="*/virtual/*", 
ATTR{address}=="%s", ATTR{type}=="1" NAME="eth0.2"

eth0 will be still override. Thus, we should only generate one line for 
eth0, and let ip/vconfig to name the eth0.2 upon eth0.

The reason why we have two lines is that I passed two ifname= cmdline, 
one for eth0 and the other for eth0.2, this is required by ip=, all 
interfaces in ip= should be passed in ifname= too.


Thanks!
