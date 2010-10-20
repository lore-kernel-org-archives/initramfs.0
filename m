From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Wed, 20 Oct 2010 16:37:07 +0100
Message-ID: <4CBF0CA3.1070801@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <4CBE44D3.6070000@googlemail.com> <1287580805-sup-6517@etiriah> <4CBF004F.9070201@googlemail.com> <1287586242-sup-9146@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=/Ba+6+7vWOBVtoYwsyNlPt/nPAExEIUbW8gsvatjw/Y=;
        b=pP6YoYWET6AmmypqLd13oyye2NjXKm9jQyt/D7ypXExMj+1jZPvwJT7fxbwvSDAgeF
         kDHdH4RgM/bEx5iXI+ZHuziA1MzkWxW4++Rf2+Pzq+xzMQJMCpXCixoPSalEeATUfs4X
         kKBr5DU+PCnjW7zLyipq3vDgHdMZjqoDJNYy4=
In-Reply-To: <1287586242-sup-9146@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


>   rd.luks.key=<key_path>:<key_dev>:<key_dev_fs>:<luks_dev>
>   
I still think the reversed form makes it better (when you look for a 
file you first look for a device, then a directory and then the file 
itself, not the other way around), but you are the rd.luks.key expert so 
it is up to you really how you are going to organise it. :-)

That's my two pence worth.


> But would be cool if you get idea how to do it without extra configs
> from outside.  Maybe it's possible to perform some settings guesses on
> run-time?
>   
I'll see what I can do - there are (at least) two additional processes 
which need to be running (that is it in addition to 
pkcs11-tool/pkcs15-tool which is responsible for fetching the key data 
from the token itself) and they are all dependant on what is in those 
two config files as that would require different modules (.ko files) to 
be loaded in order for this operation to succeed.

I have to spend some time and determine what I can leave out (i.e. run a 
bare-bones system configuration and start from there). As of right now, 
my hunch is that it *may* be possible to specify some core parameters to 
be included as part of the rd.luks.token syntax, but I am not at all 
sure if that is going to be enough - further analysis is needed, which I 
would probably do over the weekend when I have more time (I am not a 
student as you, unfortunately ;-) ) ...


>> One other query related to this: if I want to use crypttab for my root
>> (/) partition how is that handled by dracut?
>>     
>
> Password support only for now, but I'm gonna extended it.
>   
That is the problem though - there is no way you can have crypttab for 
root as there is nowhere to put it in, other than outside initrd or 
hard-code it in initrd in which case once there it cannot be changed. 
For all other partitions the solution is simple - use root, but for 
(encrypted) root itself the options are rather limited.
