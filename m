From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: dracut
Date: Fri, 29 Oct 2010 22:40:17 +0100
Message-ID: <4CCB3F41.7070208@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <4CC17713.4030504@googlemail.com> <4CC6B6E5.50402@redhat.com> <4CC6BB02.9040901@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KId/1boZ/fgi+t5GCHML9Clg2Wn9wJMl9hZXqcqomw0=;
        b=Es+LjcYY19hF+S6m2ukPtIBT/HoBYbpTZSgFNTPDgLpBBS4g3iwvkVlxNX9Y6vNzOX
         GCWWmNYVTGRxaqHG+YGTxf06eyc37qcMsPrCsD/koVoCSXnWRnudy+Z277dFQjGPLP9z
         H8LNAPY7P5hFLM82NP8Sbp9EY5TPjMRN/LE7Y=
In-Reply-To: <4CC6BB02.9040901-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


>
>> Cross building for other architectures is difficult, because all the 
>> tools like "ldd", "modprobe", etc. would have to be cross tools.
>>
>> Kernel could be solved by specifying the kernel version and having 
>> that version installed.
> That isn't the best, though I understand the rationale behind this now.
>
> There was another reason I asked this: the module which I am currently 
> developing for login to LUKS with smartcard tokens requires the core 
> modules (smartcard udev drivers as well as core executables) to be 
> compiled/build with certain options (the standard/desktop-related 
> builds will NOT work - i.e. using inst_* from dracut_functions on 
> these on the already installed libraries/executables will NOT work), 
> so for this module I need to carry quite a few .so and executable 
> files, which will be architecture-dependent and have to be compiled in 
> advance.
A bit further on this.

I was able to build initramfs, which is for a different architecture 
from the host by using image built with kickstart.

Kickstart used dracut resources on the host, but built all the 
dependencies within the image itself which had a different architecture 
(my development host is on FC13 and x86_64, the image built was for 
P2-specific machine using custom-built-and-heavily-patched kernel, i.e. 
i686 architecture). It runs beautifully - cross-building is indeed 
possible!

In my new module I did insert architecture-probing code to install 
different architecture-dependent libraries, which isn't ideal, but it 
does the trick - for now.
