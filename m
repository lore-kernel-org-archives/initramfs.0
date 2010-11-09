From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Tue, 9 Nov 2010 14:53:38 +0100
Message-ID: <AANLkTi=59UTHLmWj00KcDWTugUXGWFW+XzV=Vno-txv3@mail.gmail.com>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com>
	<4CD9102B.7030702@bfh.ch>
	<AANLkTi=EkL7ivKKj6ck3w6RuOOq++cGwtP_pX0HHhVWu@mail.gmail.com>
	<20101109125820.GO19612@vostochny.stro.at>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=7fYvZVKHBUdBUMBQgwi7f+oO8Z889FjEogrvwdc9jko=;
        b=Tqc7HKmlvOgrNLwvyHrswg0qBCUbHtXtPp47q1BcimlsPa52nXtofBBCeNNc5CDddb
         XLQoQq4cqSrxJquMOvV8ENWjZdLTfHIBoW+x3wJYAm8fJHeqwkAEc76CMuxEACxHvvZ5
         n+2xYkRrh4xARNDMt4MnveygA0dpkfhDiWUXo=
In-Reply-To: <20101109125820.GO19612-VJknIhvjf2Ov8OlOgJ4AIV6hYfS7NtTn@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

2010/11/9 Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>:
>
>
> On 11/09/2010 12:19 PM, Jon Ander Hernandez wrote:
> [snip]
>>>
>>> We need iputils-arping and not the standard arping. Mind checking if you
>>> are
>>> using the correct package?
>>
>> $ dpkg -S `which arping `
>> iputils-arping: /usr/bin/arping
>>
>> $ arping -V
>> arping utility, iputils-sss20100418
>
> Thanks for checking. Now i'm confused. Because arping's invocation (sudo
> arping -f -w 60 -I eth0 ...) on my 10.10 works flawless.

Well now I'm also confused... I tested it sometime ago and it failed,
but now it works. May be I did something strange at that time, because
I was doing weird things to discover what was failing till I found the
arping issue. Maybe I should test everything with a different switch.

> Is dracut
> "throwing" an error when calling arping or is it the "Resolving $dest via
> ARP on $netif failed" message?

I've tested dracut without commenting the arping line and yes, I get :

dracut: FATAL: Resolving 192.168.30.1 via ARP on eth0 failed
dracut: Refusing to continue

No root device found

Boot has failed, sleeping forever
