From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: dracut
Date: Sat, 30 Oct 2010 12:18:41 +0100
Message-ID: <4CCBFF11.7020808@googlemail.com>
References: <4CBDA328.40401@googlemail.com>	<4CC17713.4030504@googlemail.com> <AANLkTinO0edPay_HxUW93Dm2PpHkchxKDC1yezhV-u2K@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=6v6m56v8S1ORuU3OFYfwszok0ab6e/aSrK1uUIovv9o=;
        b=cNETlFzI0Q2+UEIZFTBZ3ZN3bHbcIju+5rPILACvWAk5OLiN/ozqv0sMdTr5ydytIj
         v6MWM4dzffSicvN/UDXrYb2hjKkVXMfKCKZ7B0oKKlq20PKibdgS/upAdvTPdb9h61xz
         JuuD6meR/KaIj5IoVmcoJic0olOuVeDevk+wE=
In-Reply-To: <AANLkTinO0edPay_HxUW93Dm2PpHkchxKDC1yezhV-u2K-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ambroz Bizjak <ambrop7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


>> Is it possible to build dracut for system/architecture which is different
>> from the host on which dracut is run?
>>     
>
> I have been interested in this before. However I decided it would be
> too much work to add this functionality to dracut. Instead I wrote my
> own initramfs generator which can do that by design.
>   
I succeeded in incorporating initramfs for a different architecture from 
the building host yesterday - by using kickstart. See my previous post 
on this very thread.
