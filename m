From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: Re: live rootfs from squashfs and read write ability
Date: Thu, 29 May 2014 12:37:47 +0400
Message-ID: <CACaajQvm0qVo0=-wikoswd2-hiazrr4aSF9GJBJBW1yoPw=7+w@mail.gmail.com>
References: <CACaajQsj71mL4BciOPaNTx2wN_A2SiBM=babpsUK5QGzQ2Yreg@mail.gmail.com>
 <20140522095925.GG1859@darkstar.nay.redhat.com> <CACaajQvz1e=nYW1C49ExcWAAZHCy9e=tZMMJbtevFAA=37t3gQ@mail.gmail.com>
 <20140529063926.GJ2068@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=xjcDwxLurzG799znqcDsynTLCSfMfdOGEsgIN0pTAR4=;
        b=CkTySZTe72QbikD1Z4cGZdIPBJmM59/hxTyEQ45RHdn5GaYU0XSArgXLaiuOAEPEtH
         rh7szX0aGyfDThRsBNChbqcO2XJ3Z64plK/VV8IETXWtYQPhuSV6cRX3STC08yu4+QI8
         k2ikzbmLKh8vSP44LknzFE+WqXNnl719sXrZA=
In-Reply-To: <20140529063926.GJ2068-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

2014-05-29 10:39 GMT+04:00 Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> Sorry I'm not familar with livenet I can not comment anything now.
> BTW, overlayfs is not in mainline kernel yet.
>
> What I would like to see is something like squashinitramfs, a squashed initrd can be
> automatilly recognized and union mounted while kernel booting without any userspace
> hacks. But seems nobody is doing like this.


Can you please give me the link to union mount without haks? Wikipedia
says that it can be doing with aufs or something like this...


-- 
Vasiliy Tolstov,
e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
jabber: vase-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
