From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] Steal rules we need from the latest udev package.
Date: Wed, 4 Mar 2009 08:17:46 -0600
Message-ID: <0953040E-9CB6-43AB-84FF-4EA9B7FF6A95@gmail.com>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com> <462be3c3cfdf24ba51bc4d1a1f66cc30b8d29d82.1236124962.git.victor.lowther@gmail.com> <20090304002535.GB96609@redhat.com> <1236129369.6500.18.camel@sentry-no.fnordovax.org> <ac3eb2510903040212m5d68d812kbce03d831e8c3d12@mail.gmail.com> <1236166408.6500.37.camel@sentry-no.fnordovax.org> <ac3eb2510903040408w299b349aj791a2f9e0d154b9a@mail.gmail.com> <ac3eb2510903040606j63ed9992r273b97efeb9a6e73@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=8I27iGmupJMNnjd0Ht5mmKWzz4gog2zpMzkFp0zdJrM=;
        b=Sv3oHRuj+7U6geyzi6Vq5v8A+Docifitmno3+unRPfQENY1uRFIc8fpMDyjA03f5eu
         VFJPs07tOPDiliGcWrV2Ghg9DN9wmkm3P4mpsDUsD3OCnvTfn2dkrxMbiIAsU64OWnyl
         7M36RprEYy1Pr2rQCFQkIOS1nlfQ3eQBnQUzs=
In-Reply-To: <ac3eb2510903040606j63ed9992r273b97efeb9a6e73-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mar 4, 2009, at 8:06 AM, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org> wrote:

> On Wed, Mar 4, 2009 at 13:08, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>  
> wrote:
>> On Wed, Mar 4, 2009 at 12:33, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
>> > wrote:
>>> On Wed, 2009-03-04 at 11:12 +0100, Kay Sievers wrote:
>>
>>>>> Mmmm... sweet scent of politics.  I get the feeling that many  
>>>>> kilobytes
>>>>> have been spent flaming^Wdiscussing this topic.
>>>>
>>>> Yeah, it seems hard for some kids to share their toys. :) But it's
>>>> pretty much over, there is not much to discuss anymore. We all ship
>>>> the same stuff, and share the same bugs. If you want "Debian" use
>>>> Ubuntu. It's part of the upstream development, ships recent  
>>>> versions
>>>> which other stuff can develop against, and can depend on. :)
>>>
>>> Good to know, but I think I will stick with Fedora for now.
>>
>> Yeah, sorry, "you" did not mean you. :)
>>
>>> It seems
>>> like we have enough patches floating around on the mailing list  
>>> right
>>> now to have a good chance at making everything but Debian work  
>>> without
>>> too many distro-specific workarounds
>>
>> Sounds fine. After the next sync, and if we can resolve the libexec
>> thing, I'll make it work on SUSE.
>
> Here are the results of a quick try, without digging into it:
>
> These files are a Fedora invention, and the problem should be resolved
> differently:
>  cat: /lib/modules/2.6.27.10-2-default/modules.block: No such file  
> or directory
>  cat: /lib/modules/2.6.27.10-2-default/modules.block: No such file  
> or directory
>  cat: /lib/modules/2.6.27.10-2-default/modules.drm: No such file or  
> directory

The first patch in this series should take care of that.

> This does not exist, it's in /usr/share/terminfo/ here. Maybe it
> should be fixed here?
>  find: `/lib/terminfo': No such file or directory

Should we even bother with terminfo if we are not including debugging  
stuff? Will cryptsetup work without it?

> This does not exist here, seems Fedora specific, and dracut hangs in
> an endless loop:
>  Installing /lib/udev/console_*
>  cp: cannot stat `/lib/udev/console_*': No such file or directory
>  Installing /lib/udev/console_*
>  cp: cannot stat `/lib/udev/console_*': No such file or directory
>  ./dracut-functions: line 107: /lib/udev/console_*: No such file or  
> directory
>  ...

The second patch in this series should take care of this.

>
> This needs a "-p":
>  mkdir /usr/libexec/dracut/rules.d
>  mkdir: cannot create directory `/usr/libexec/dracut/rules.d': File  
> exists

There are a few patches floating around on the list that take care of  
this.

>
> Thanks,
> Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
