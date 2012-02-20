From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading IMA
 custom policies
Date: Mon, 20 Feb 2012 20:11:03 +0100
Message-ID: <4F429AC7.6020208@polito.it>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it> <1329312229-11856-2-git-send-email-roberto.sassu@polito.it> <20120220171229.GB26356@tango.0pointer.de> <4F428FB0.3000200@polito.it> <20120220185236.GB360@tango.0pointer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+LJzW1Q+4Rn1551cp0XZxkeW3ebIcf7n23u3prYSYRY=;
        b=al6X2e5LJJMqXQTqjs59fK5WvZ+R4Zxk7Ffyhp9ic/Yc67HRpOCyrNQmqiKJEOUdhu
         L5cvKc1+a8x89jwWodfmfos5Lsf/CIf4Ko8tmZlBpoEnXVo9Fb0EVk3a9yD8qUqYaEmG
         a/mOJ7d7X0Jtk1o4P8MlZxvM6OLCTwkarcAnc=
In-Reply-To: <20120220185236.GB360-kS5D54t9nk0aINubkmmoJbNAH6kLmebB@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On 02/20/2012 07:52 PM, Lennart Poettering wrote:
> On Mon, 20.02.12 19:23, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:
>
>>>> +               log_error("mmap() failed (%s), freezing", strerror(errno));
>>>> +               result = -errno;
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       while(written<   policy_size) {
>>>> +               ssize_t len = write(imafd, policy + written,
>>>> +                                   policy_size - written);
>>>> +               if (len<= 0) {
>>>> +                         log_error("Failed to load the IMA custom policy "
>>>> +                                   "file %s (%s), ignoring.", IMA_POLICY_PATH,
>>>> +                                   strerror(errno));
>>>> +                         goto out_mmap;
>>>> +               }
>>>> +               written += len;
>>>> +       }
>>>
>>> It might make sense to use loop_write() here instead, which does more or
>>> less this loop, and is defined in util.c anyway.
>>
>> I briefly looked at the code and i'm not sure to use it, because i want
>> to add some extra information in the output message (for example the
>> line number of the rule in the policy file that was rejected by IMA).
>
> Line number? The policy is text? Your code above doesn't print any line
> numbers?
>

Sorry, this is not done in the current patch. But i think it may be
useful for a user to know what rule is being rejected by IMA.
Yes, the policy is text.

Thanks

Roberto Sassu


> Lennart
>
