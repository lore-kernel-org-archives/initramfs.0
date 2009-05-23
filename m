From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: No stdout when using dash
Date: Sat, 23 May 2009 11:56:20 -0500
Message-ID: <DE699293-DABE-4AAC-BB8F-55F208D937A8@gmail.com>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net> <1243081747.29452.38.camel@sentry-no.us.dell.com> <Pine.LNX.4.58.0905231450240.2058@gate.bb.dicp.net>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=0nOOAXAbXgEdZebq5AASSUX6SEFs6CesOfCsMMvotUU=;
        b=HIBZGCDXRKu+BcjqhUSN5LPPN/2A2pIQEIzKzQqsdle4vFpaeyiAHK/s6M5UxlhSfk
         MHgdPUR4Fo+e8tH4nv2i8N3EFXnStKcGwjdQTfJ6bYAFvv6WtLLDt/xJcwdql/ImZgst
         /3yRfbu51EyaBWp8Xx+UhTcGTaCFIm9AhKuvc=
In-Reply-To: <Pine.LNX.4.58.0905231450240.2058-bvJ793YqIODNUDpmljszgg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Cc: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On May 23, 2009, at 7:51 AM, Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>  
wrote:

> On Sat, 23 May 2009, Victor Lowther wrote:
>
>>> I just triggered an update to dash in fedora F11 and rawhide  
>>> fixing this
>>> behaviour.
>>> This should make the emergency shell much easier to work with.
>> Can you also post the fix upstream?  That way those of us who are not
>> developing on Fedora can also benefit. :)
>
> No need. The patch has been pulled from upstream git.There just hasn't
> been a new upstream release:

Cool, just wanted to be sure.

>
> commit fcc4134a7b76d82d39dea635c41ec593a41d6d19
> Author: Herbert Xu <herbert-lOAM2aK0SrRLBo1qDEOMRrpzq4S04n8Q@public.gmane.org>
> Date:   Sun Feb 22 19:29:48 2009 +0800
>
>
> regards,
> andreas
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
