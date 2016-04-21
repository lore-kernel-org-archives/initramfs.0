From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7] dracut: add support for custom locale definitions
Date: Thu, 21 Apr 2016 15:41:10 +0300
Message-ID: <CAA91j0U0XaJBaWNzBmRE3hs0zV7UKMEvO-6nBx_jaxkwhEHckg@mail.gmail.com>
References: <1460758050.3211.2.camel@trentalancia.net>
	<5711D4E7.9070705@gmail.com>
	<1460815966.4296.13.camel@trentalancia.net>
	<57127BC9.70103@gmail.com>
	<1460835143.3201.10.camel@trentalancia.net>
	<1460837622.3201.14.camel@trentalancia.net>
	<1460838269.3201.18.camel@trentalancia.net>
	<1461026208.2262.1.camel@trentalancia.net>
	<1461157491.11229.3.camel@trentalancia.net>
	<5718AA77.8090600@redhat.com>
	<1461241841.10934.12.camel@trentalancia.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=LxksSIej3QwPwar7Lt3bFye3Rjw4cbkNXXsgRkmjdbI=;
        b=HxZ4NDRaoaWkSPp9geOHgUI5a9ZqrRpU0eo2rzOkUaV7JLGbDhB5BUPrVa6kqqtG4P
         Ykmolr9ZwdHyJARoQ18QYxDzd3iyRkR7bNskqkzrxuv683ppu1geoR8kncjn1kwkPwJB
         fCT/6xMT/i7r0q2HYg3s1rpS4GJGef1aLNSz8t7LqqFqM6rjFQb3uUxRNb4au/WbqMrt
         gHj3Uovr/4v8BB9M19odyDU4CTKPtiExmaF+tYpeBnBBQGHJHAqtpQxE/lFRI6nrp1/x
         5zmCCMG1PhdSKu5ygPx41Gj3CJW8MRsbKnyuo+i3ZkS4FcSZGpWVRQG9+KLdDuIs2Rtl
         EMtw==
In-Reply-To: <1461241841.10934.12.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Apr 21, 2016 at 3:30 PM, Guido Trentalancia
<guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org> wrote:
> Hello Harald !
>
> On Thu, 21/04/2016 Guido Trentalancia wrote:
>> > Compile and install locale definitions using localedef from GNU
>> > libc or,
>> > if locale definitions cannot be compiled but are available on the
>> > system
>> > as split definitions, just install them.
>> >
>> > The resulting locale definitions archive contains at most two
>> > different
>> > locale definitions, therefore its size is relatively small.
>> >
>> > Add support for localised messages from core packages
>> > (LC_MESSAGES).
>>
>> Do we really need this in the initramfs?
>
> It's a killer functionality !!! And it requires very little extra disk
> space compared to the actual initramfs. You know, we tend not to use
> the floppy disk anymore nowadays !...
>

Hmm ... how do you determine which message catalogs need to be
included? It obviously depends on modules and there is no 1-to-1
correspondence between programs and message catalogs.

Do you have actual results how much space message catalogs for all
components in typical initrd consume?
