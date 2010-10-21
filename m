From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Thu, 21 Oct 2010 16:48:03 +0100
Message-ID: <4CC060B3.3050508@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <4CBE44D3.6070000@googlemail.com> <1287580805-sup-6517@etiriah> <4CBF004F.9070201@googlemail.com> <1287586242-sup-9146@etiriah> <20101021132916.GC22186@nb.net.home> <4CC0462E.20507@googlemail.com> <20101021151802.GD22186@nb.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=tdTVnGm1yzap0zvLWVgMv3fewufHVlDUy6IbO5yfNn0=;
        b=OxdPIv41LO3izgp3V0UwMznI/ZQzT9+P7Lb/pGbkEH8eyGtZ92RLXYp8++crNpR79p
         QbOUAFjrBy7vmZoJlOE9eTVEENCLvYHwok8gWnjONmQkopfWYadMOrne3TeGVLC4P52Z
         rWp52wMDKhDutH41iQ9ZxYpVrjWswLxkevf1o=
In-Reply-To: <20101021151802.GD22186-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


> Well, rephrasing: The <key_dev_fs> is unnecessary if you want to use
> UUID or LABEL.
>   
I see.


>> I think specifying the target file system is important because by just  
>> executing 'mount' without indicating the target file system when I have,  
>> for example, HFS or HPFS mount just won't happen.
>>     
>
> Why? My mount(8) is able to detect HFS or HPFS.
>   
I have no such luck when trying to mount my (Macbook Pro) laptop 
partition, nor when I try to mount my OS/2 Warp (v3.01) server disk 
drive, hence why I always specify the target file system - then it works 
every time.

My point still stands though - leaving the 'guessing' of the target file 
system to mount is not a good idea and <key_dev_fs> should not be 
removed as a parameter (it may not be mandatory, but should always be 
catered for). I would also add that both <key_dev> and <luks_dev> should 
be able to support the Linux drive notation (sdXX, hdXX etc) in addition 
to label and uuid.
