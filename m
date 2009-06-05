From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 5 Jun 2009 11:16:56 -0500
Message-ID: <E0B0F7E0-7880-4219-AE91-B7305665424D@gmail.com>
References: <4A2907E7.1080008@bfh.ch> <20090605155832.GH5107@nostromo.devel.redhat.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=xp0xAG3ulPN9VJHGuIYI9ERKu79900WNTkkma6eDGHk=;
        b=QQkLoJrBOLiqIQ0DcbNaDj5k28GI9gHY59l1p9V+s/u8kwSDHh//iC3BKMlQ+5px5B
         KWf96z9cGXXkBG2KPhwtp2u5u9GcqpgoRfA3VKjVxi9YWv1RXZPQ729QcAniAQYq0/f9
         gYtyZH8Ad0tkwEanBWFTnhiXvRXhlQHHz0SvE=
In-Reply-To: <20090605155832.GH5107-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Jun 5, 2009, at 10:58 AM, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said:
>> cat and grep just bloat the initrd, this patch removes dependencies  
>> on them.
>
> Are we really at a place where we're that worried about 100k? I'd
> rather not have to implement all of coreutils in shell where needed.

People have this crazy fetish with booting fast.

>
> Bill
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
