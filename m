From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: dracut
Date: Tue, 26 Oct 2010 12:26:58 +0100
Message-ID: <4CC6BB02.9040901@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <4CC17713.4030504@googlemail.com> <4CC6B6E5.50402@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2pywo4uboBOPKwYRlyXpg6At1UGkiPAeIfDb7bG/wno=;
        b=PzbPXpzISGcIuHI4Bfx/9aasv65+TPp93/WElxjUh6RIQhrTZ/H+Gb8dsAHJPiVx2Q
         xvRhAkDONgO9J+W3+Q/UODhWR8Ts67Yzdwq0i54FMn22HmX1vKeOPcaRsL+Rvjljb+LV
         67S+oeXiuz9jTP+9ftC3Vs7Y6D3Ao0eKHSzp4=
In-Reply-To: <4CC6B6E5.50402-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


> Cross building for other architectures is difficult, because all the 
> tools like "ldd", "modprobe", etc. would have to be cross tools.
>
> Kernel could be solved by specifying the kernel version and having 
> that version installed.
That isn't the best, though I understand the rationale behind this now.

There was another reason I asked this: the module which I am currently 
developing for login to LUKS with smartcard tokens requires the core 
modules (smartcard udev drivers as well as core executables) to be 
compiled/build with certain options (the standard/desktop-related builds 
will NOT work - i.e. using inst_* from dracut_functions on these on the 
already installed libraries/executables will NOT work), so for this 
module I need to carry quite a few .so and executable files, which will 
be architecture-dependent and have to be compiled in advance.
