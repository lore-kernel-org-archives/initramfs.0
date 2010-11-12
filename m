From: Vladislav Bogdanov <bubble-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Subject: Re: [PATCH] add fake root support
Date: Fri, 12 Nov 2010 09:54:48 +0200
Message-ID: <4CDCF2C8.8010901@hoster-ok.com>
References: <4CBDB007.4090802@hoster-ok.com>	<4CCECBB0.3030609@hoster-ok.com>	<4CDAAA70.1070302@redhat.com> <AANLkTim9GEHy0EDBNMS1+fDiZ_UGw6fA3kSMq21qR-Jx@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTim9GEHy0EDBNMS1+fDiZ_UGw6fA3kSMq21qR-Jx-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

10.11.2010 18:09, Jon Ander Hernandez wrote:
...
>> Which reminds me, that we should probably have the possibility to
>> concatenate several stages.
>>
>> root=nfs:xxx.yyy.zzz.www:/mnt|loop:test.img|live:blablabla
>>
>> comments?
> 
> I like this idea, it would be really useful.
> 
> But wouldn't this require some kind of union mount? I ask this because
> I have read Vladislav's patch, but I've been able to figure out how it
> sets/links the writable overlay. I'm missing something?

BTW I have a patch which skips writable overlay in liveimg completely if
'readonlyroot' is set in cmdline.

Will send it later when I port it to a git.

> 
> And if that is the case, I suppose that dracut will have to support
> different kind of union mount (unionfs, aufs, ...) till Valerie's
> Union Mount gets pushed into the kernel. Or could something be
> archived only using COW?
> 
> Regards,
> 
> Jon Ander.
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
