From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: dracut
Date: Tue, 26 Oct 2010 12:36:39 +0100
Message-ID: <4CC6BD46.6060809@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <4CC17713.4030504@googlemail.com> <4CC6B6E5.50402@redhat.com> <1288091666-sup-5419@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7KyO0eFrTQ06Vn967d2F9IWbwvj/JqgAgAfTzTTqCg0=;
        b=Iab+h6aiDQ0ucvhKBEmzopZYGkGzeZX6+FDUMrlSagQjsWvLw+3/jszYLrN1VrmWMo
         SNpaA0mu+h0CZPMKpJJnWmPWbDuMVfR+A+KaAItYF8gzfZ9a6LVXva10ksRrxPLgdl1V
         8dhBkcNe6b6UNunh3wYuDkE7hArpDfAeqPP1I=
In-Reply-To: <1288091666-sup-5419@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


> But we cannot do this with Dracut itself, if Mr Dash Four was asking
> about it.  We need to compile all binaries we're including for specified
> architecture.  Similar tool has such a feature - Gentoo's Genkernel.
> But it uses sources and compilies them specially for initramfs with
> hardcoded instructions.
>   
That would be my preference too!

Relying on what is currently installed on client's desktop machines is 
NOT a good idea as I found out to my cost - most of the 'standard' and 
already-compiled smartcard core libraries will NOT work on initramfs at 
all and need to be pre-compiled with certain options in order to strip 
down the dependencies to the bare minimum and allow them to function in 
initramfs environment.

As I already pointed out in my previous post just picking up those 
libraries from the client desktop machines will NOT work. I spent two 
days tearing my hair apart to come to this conclusion, but the good news 
is that I made the smartcard module WORK, so I am currently fine-tuning 
it and stripping the dependencies even further, though this module will 
have to be architecture (and therefore kernel) dependent!
