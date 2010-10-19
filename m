From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Tue, 19 Oct 2010 15:33:33 +0100
Message-ID: <4CBDAC3D.7050906@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=uT78N33Srn6hj8Lksa6C7tVxmi07V5AVQaBlCROdhBs=;
        b=BIjA5J+h+opSFi7NKVkLwHxFi7oOnT8l55JgnnMg2xBhXWxqbvM/qJFUpgx6sBzQVW
         affo4Pim91+gks/PUY0ARA67yTBzOkIzOfvlRcsMJ7G6zLgtL3e8zqTvbWWV+/MTfx4q
         B7/fSE+FkVzuf5BgE77xYjDFg6uU1v3b6I6Rg=
In-Reply-To: <1287497223-sup-3606@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


> Experimental support is in Dracut 007.  In future 008 it will be even
> better (see my latest patches).
Where are they? FC Rawhide or somewhere else?

>   There are some improvements I'm working
> on.  Although I'm not sure which version Fedora supports, will support
> and when.
>   
Glad to see there is progress made. What are the plans? As I pointed out 
I am currently interested in making dracut work with external key files 
and tokens (the latter is a much-pressing need on my as I am going to 
rely on it heavily!).

>> I am also interested to see whether there are plans (or, indeed
>> attempted implementations) to introduce smartcard support to LUKS
>> partitions (boot or not)? Many thanks
>>     
>
> I haven't planned that and haven't heard of anybody planning that, but
> if I would have such a gadget I'd probably be happy to implement support
> for it soon or later.
>   
I am still in a learning curve as far as dracut is concerned - hence why 
I was glad when I found your patch as I intend to use it as a template 
to implement token support.

It won't be easy as there are dependencies on (at least) 3 packages, but 
if I finally manage to overcome these the 'login' is very similar to the 
'password' authentication currently present - once the password (PIN 
token in this case) is captured then there is a program (pkcs11-tool 
and/or pkcs15-tool) which reads the relevant key data and which then 
could present it to luksOpen (as a pipe, i.e. 'cat keydata | cryptsetup 
luksOpen --key-file=-') without further need for input from the user.

I have 'manually' done this (via command line shell script) and it works 
without a problem, so once I get to grips with dracut and find out how 
to install dependancies/packages in the initramfs image then it won't be 
difficult.
