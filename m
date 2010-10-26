From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: udev question
Date: Tue, 26 Oct 2010 12:20:51 +0100
Message-ID: <4CC6B993.1040808@googlemail.com>
References: <4CC5C26B.9060002@googlemail.com> <4CC6B5BD.2020603@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4BIU3teAcqspqx7wzjQkSqmALBtVFG4EPVwK3lh2gzA=;
        b=ewUxcKNBMk+QVJtAqcUYNpoC58TMJkacwo5yi1+RXPPqgR4b5JVSfZYMGwaN/Zmg9X
         IYySUftoW0uGR+VNtME0+tO2Ro0P1vEOWE6LejFffMvltJ8nK4UARuP9VIlRPqncdOrv
         qyd1tVn1yVOJQ/tpSoP5Xcx8XCKz0kIA4T4Mc=
In-Reply-To: <4CC6B5BD.2020603-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


>>
>> Am I missing something fundamental here?
>
> udev runs a second time in the real root, just because of this 
> limitation of the initramfs.
Yeah, I sort of figured it out yesterday after running a 'probe' version 
of the '90crypt; module. I have another udev-related query though - if 
multiple rules register for the same udev triggers (like 
ENV{ID_FS_TYPE}=='crypto_LUKS') how are they executed and can the order 
of execution be controlled?

The reason I am asking this is because, as it turns out, I may need to 
design a separate module for smartcard tokens to be used with LUKS and 
the way I see this is when LUKS partition gets matched by udev the 
smartcard module needs to get the first go (for all smartcard-specified 
LUKS partitions) then 90crypt (with key file login, possibly falling 
back on password authentication if the key file data is not successful - 
though this, as far as I can see, is not yet implemented!).

Unfortunately, my udev knowledge is not that much to know is that 
possible, hence the my query.
