From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] add fake root support
Date: Wed, 10 Nov 2010 17:09:03 +0100
Message-ID: <AANLkTim9GEHy0EDBNMS1+fDiZ_UGw6fA3kSMq21qR-Jx@mail.gmail.com>
References: <4CBDB007.4090802@hoster-ok.com>
	<4CCECBB0.3030609@hoster-ok.com>
	<4CDAAA70.1070302@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=rSqFd0Xx8w4lR7cK8i/CLTJa82HdF5zUCdIfuG9eX8c=;
        b=UA717n134TtIXQg66hR6BShHAUNex7aHt/0cY5zJFEv4WZ/ktyMntsMsQxcnjWUyC0
         mqqYhiMoad8c/wFF7v1gT216VD5kRI3DACrYh4NLwh260xALKvaueT4BKjQJPi4qZlrc
         UnSxjHBe8MoYAbcTu0jq0zIGiHKCA8jLKCBNM=
In-Reply-To: <4CDAAA70.1070302-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2010/11/10 Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> On 11/01/2010 03:16 PM, Vladislav Bogdanov wrote:
>>
>> 19.10.2010 17:49, Vladislav Bogdanov wrote:
>>>
>>> Attached is a patch for "fake" root functionality,
>>> I'm (mostly) duplicating issue's description from my previous e-mail
>>> (for commit message if this is to be pushed):
>>>
>>
>> Sorry for being annoying, but... Any comments?
>>
>> Best,
>> Vladislav
>>
>
> I like it, but I don't like the parameters...
>
> Maybe we can express it like this:
>
> netroot=fake:xxx.yyy.zzz.www:/mnt root=live:blablabla
>
> and find another name for "fake".. maybe "container"?
>
> netroot=container:nfs:xxx.yyy.zzz.www:/mnt root=live:blablabla
>
> Which reminds me, that we should probably have the possibility to
> concatenate several stages.
>
> root=nfs:xxx.yyy.zzz.www:/mnt|loop:test.img|live:blablabla
>
> comments?

I like this idea, it would be really useful.

But wouldn't this require some kind of union mount? I ask this because
I have read Vladislav's patch, but I've been able to figure out how it
sets/links the writable overlay. I'm missing something?

And if that is the case, I suppose that dracut will have to support
different kind of union mount (unionfs, aufs, ...) till Valerie's
Union Mount gets pushed into the kernel. Or could something be
archived only using COW?

Regards,

Jon Ander.
