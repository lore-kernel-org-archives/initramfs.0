From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] remove the global --sshkey parameter
Date: Fri, 13 Jan 2012 17:03:30 +0800
Message-ID: <4F0FF362.2000208@gmail.com>
References: <1326208786-24344-1-git-send-email-xiyou.wangcong@gmail.com> <1326208786-24344-2-git-send-email-xiyou.wangcong@gmail.com> <4F0CFB08.6030800@redhat.com> <4F0D5C64.1080203@gmail.com> <4F0E4247.1010501@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+DDa/pvwGCeKwUvEj1dyZjw/+VdLOccYjt2cpU0m/l4=;
        b=UqbiX13d/Eu0rvWSZPK0dyB+l6sAC5Ya1CAnOcNi46NmGoVev9mjrOOHjlho92trcU
         M6lPucGmuZ+/5UJFG7fBWqXXI9Sutvr2nE1esRidLxJVFO64qqAvbC7D1TK2Msoa0oS6
         foDtShSWLz8FPuFAHv6TmNAP7IztlHnHdhCDU=
In-Reply-To: <4F0E4247.1010501-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 01/12/2012 10:15 AM, Dave Young wrote:
> On 01/11/2012 05:54 PM, Cong Wang wrote:
>
>> On 01/11/2012 10:59 AM, Dave Young wrote:
>>>
>>> Hi,
>>
>> Hi,
>>
>>>
>>> After removing --sshkey we need to parse dracut_module_args for module
>>> use. Maybe in a general function of dracut-lib will be fine.
>>>
>>> Also need consider the multi-param case like below:
>>> module:a=b,c=d,e=f,...
>>>
>>> Ie. in ssh-client module we need to parse "sshkey=/root/.ssh/id_rsa" for
>>> installing sshkey
>>>
>>
>> It is already done by the first patch. :)
>
>
> During my test, the $sshkey is only available in check() function,
> finally the key was not installed to initramfs. Please see my another reply
>   before.

Hmm, so sshkey= parameter should be passed to both check() and 
install()... I think I need to redesign the command line interface.

>
>>
>> Note that, I designed to use colons to separate parameters, not commas,
>> even if you pass multiple parameters.
>
>
> I think A:b,c,d looks better, but I have no strong opinion about this
> because right half of first colon can be seen as param which can be
> defined and parsed by specific module.
>

Makes sense, I will check if this is hard to be done.
