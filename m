From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: kernel 4.4 and 4.9 different reactions to initrd.
Date: Fri, 23 Jun 2017 06:36:56 +0300
Message-ID: <78b51168-8f82-3ebe-1de0-b2955ee85db5@gmail.com>
References: <CADV=gjHjd+cXh6Xmd0UBtb3dEzsYhKNR0XvF_BzK_0z-3r2WFg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=80ca86JE+5PBAH9vEgRvMQsTrmKxd3jVjP6aUpYInQY=;
        b=X52uUcYfH7RwHpVZLXKIMwtwUBiv/gprKG0hn/1MWUoM9MLGl4O6Bnk61yMuc6l8FA
         WF5npUYosLFD9kxJuusBwEakuNFQWuC/+GJA173pm7XBkVjMVrLOVdH9rtAF5yzQo1dz
         O7DkuXVWtzpsK/pE5qqbCrLjmuVTjDtoyS0hrG9y40lEs2nK/vz6rCdvNPcLFY20D2wk
         tFkshsbI2JKxhoKRGpo9tYGLyQ+Kd55Hvy/drIikWEnZT4HxeWvkuKd9bG23D7HB3cNY
         Wz4YpisOMbZatl8HLa81sBMxtxCFBONua3RFinQ/CJIcYh622GOpxUMa7Q4DD5W2kHPu
         Lrbg==
In-Reply-To: <CADV=gjHjd+cXh6Xmd0UBtb3dEzsYhKNR0XvF_BzK_0z-3r2WFg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "Ali H.M. Hoseini" <alihmh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

22.06.2017 23:30, Ali H.M. Hoseini пишет:
> Hi,
> 
> I'm not sure am I supposed to ask this question here, But I did not
> find anywhere more suitable!
> 
> I'm using a complete root fs compressed in gz as my initrd for last
> couple of years.
> until kernel 4.4.x when I chose to boot kernel with my initrd, I got
> these messages in boot process:
> 
> ...
> [    0.000000] Krrne  oomman  iie: BOOT_IMAGE=vvmlinuz-4.4117
> initrd=/utvos44.0.6.gz console=tty console=ttyS09900
> ...
> [   38.920053] Trying to unpack rootfs image as initramfs...
> [   39.103577] rootfs image is not initramfs (no cpio magic); looks
> like an initrd
> ...
> 
> and system boots correctly.
> 
> 
> 
> But when I switched to kernel 4.9.30, everything went wrong:
> 
> ....
> [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.9.30
> initrd=/utvos.4.1.0.gz root=/dev/ram0 console=tty console=ttyS0,9600
> ....
> [   29.156899] Unpacking initramfs...
> [   29.330796] Initramfs unpacking failed: no cpio magic
> ...

You need CONFIG_BLK_DEV_RAM enabled. Looks like it is not define in this
case.
