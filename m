From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Wed, 20 Oct 2010 15:48:19 +0100
Message-ID: <4CBF0133.2070709@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <1287580112-sup-97@etiriah> <4CBEF768.90908@googlemail.com> <1287583979-sup-416@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Q8UYD7pmXEtiiLIv9F2FZILAOpXuJPpDwU6v4M2dGYs=;
        b=NbSc2YVFMM9HzL3/4PyOf7nXtZSiJZWrnE8ZS6Oup2ZrgVFkN8dhVyb6pskBrlKQbS
         7x9JiulRE8rDmD8ol4oVxa4FLgE2+r0lDZNqGKjQQgyP95cIMQePV3ESV6eyqYvbCXD+
         4AHao8GSn+eGDJh9F2UbUKw1Sp1yLOzb3YmAs=
In-Reply-To: <1287583979-sup-416@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


>> I don't think this is such a good idea as having the crypto keys
>> reside in the same place as the kernel would completely defeats the
>> purpose of using crypto devices.
>>     
>
> It does not.  You can have kernel and initramfs on removable media.  You
> have this media secure and don't need separate media for keys.  It's
> even more secure than having kernel and initramfs on harddrive because
> it protects you from case when someone replaces your initramfs to stole
> the key (e.g. sends to some remote machine).
>
> And of course keys inside initramfs will be optional extra solution.
>   
Good point - I haven't thought of that, it makes sense then.


> I hope I've answered to your concerns above in previous e-mail.
>   
I did a reply - there are 2 configuration files in order to run/read 
tokens and these configuration files should be easily tailored to each 
user's settings without the need to rebuilt initrd.



>> One other thing I forgot to mention in my last post that with the
>> proposed parameter changes there is a third possible scenario with the
>> password authentication, in which case, the format of the parameter in
>> the kernel would simply be:
>>
>> c) rd.luks.<luks_uuid>[=]
>>     
>
> You don't have to specify anything for password scenario. root=<dev> is
> just enough.  Have you tried using crypt module?
>   
I am using dracut-006 (I think - the last which comes out of FC13 
repository) and currently I have to specify rd_LUKS_UUID=luks-<UUID> in 
order to make it work, which is not very convenient.
