From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: udev question
Date: Tue, 26 Oct 2010 12:30:23 +0100
Message-ID: <4CC6BBCF.7040204@googlemail.com>
References: <4CC5C26B.9060002@googlemail.com> <4CC6B5BD.2020603@redhat.com> <4CC6B993.1040808@googlemail.com> <4CC6BA51.5030906@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=elc3b1xr3iO42I4HNjCrz7PSopNB0MVPYiGUelpiE8w=;
        b=TIpZrMJheogooliSBQGotrqhcEo79Ikm9A0rmOz8XWum0aYRXiSbtSy4RjQuNQe1O3
         /NIDI3sQ5HW7qCLPgTFg1X9ysxhrtZ39HLj+VFHJSnXRAL0749aidoeoZQ17YwQBoW89
         CPBekI1h+s2fyA6SwQEVqf1CdvAO0aNVGJBHo=
In-Reply-To: <4CC6BA51.5030906-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


>> Unfortunately, my udev knowledge is not that much to know is that 
>> possible,
>> hence the my query.
>
> place it in a udev rules file with a lower number... first come, first 
> serve.
In other words if I do udev/rules.d/65token.rules that should be enough, 
right? I also presume that once the /tmp/crypt-root-asked-$2 is set 
90crypt won't touch it. Is that right?
