From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Wed, 20 Oct 2010 15:06:32 +0100
Message-ID: <4CBEF768.90908@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <1287580112-sup-97@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MitVPIxV0a4E7zTwQg7nVgZIpuNOCmlR/1W5o7cy7vc=;
        b=TS3uwnjscjdpnQ9Xo8Aio66iV0zECst8h6I+I1sQEsJjNAen4y5BdbURpTCpCrkT9E
         /GTOAgV+qDx7mWJbeRxHchKffTU9a0AV93rAfEUriD7koyJtJQUbeNh6poe7mF3g3nEz
         enVo4NfRFuSGb9CLpbcF1DsyLjPTr5TN2rtRY=
In-Reply-To: <1287580112-sup-97@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


> Next thing is give possibility to put keys inside initramfs.
>   
I don't think this is such a good idea as having the crypto keys reside 
in the same place as the kernel would completely defeats the purpose of 
using crypto devices.


> If you'd like to write support for smartcard, I'd be glad to see it as
> a separate module.  Don't hesitate to post your progress on ml for our
> review.
>   
I am not sure it would be as a separate module though (may be, at a 
later stage) - for now I'll try to use the existing module/framework in 
place and extend its functionality, hence why I posted some of my ideas 
late last night to canvass an opinion - from what I can gather, as you 
and Harald are the two main contributors to the crypto side of dracut it 
is good to know what you think?

The way I see it simplifying the various kernel parameters (particularly 
those designed to deal with luks-related partitions) is the way forward.

The one issue I am facing right now before I can even begin coding 
smartcard support in dracut is that I am not at all clear how it deals 
with the various dependencies when I ask a program to be installed 
(using the '-I' option) as 'pkcs11-tool' for example, would need at 
least 2 more executables available (with half-a-dozen other .ko library 
files) and at least two configuration files present and available at the 
time of execution.

The configuration files present another challenge in itself - most 
(default) settings work in about 90% of all cases, but for the rest 
these settings have to be changed (card reader types, various attributes 
set etc) and for that there are two options: either 1) create initrd 
image which is tailored to a specific configuration (and therefore these 
configuration files are embedded, so to speak, into the initrd image 
itself); or 2) take these configuration files out of the initrd 
altogether and make them available in the /boot directory/partition (in 
/boot/dracut for example!) when dracut is instantiated (hence why I 
asked in my previous post does dracut have at least 'read' access to 
that directory/partition)?

One other thing I forgot to mention in my last post that with the 
proposed parameter changes there is a third possible scenario with the 
password authentication, in which case, the format of the parameter in 
the kernel would simply be:

c) rd.luks.<luks_uuid>[=]

The equal sign (=) would not be mandatory and may not be specified. For 
example 'rd.luks.def0269e-424b-4752-acf3-1077bf96ad2c' will opens LUKS 
drive with UUID=def0269e-424b-4752-acf3-1077bf96ad2c after asking for a 
password at the console (as is the case now).
