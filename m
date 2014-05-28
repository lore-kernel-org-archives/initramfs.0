From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: Re: failed to bring up bonding interface (dracut+system)
Date: Wed, 28 May 2014 16:20:28 +0400
Message-ID: <CACaajQsa2skgRFp7C1_19CXceMyp0MJa7Gw-dsWLnHGGjETb7w@mail.gmail.com>
References: <CACaajQtBpFPPpt01LLDsubnKczQCAO4SaQF+8G7BnjAQCss20A@mail.gmail.com>
 <5385CF3A.1040306@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Ks/wnltSkbNlSWMdrbyx9hPnPPnV4buz1pL3KHMqacU=;
        b=gJfGKr8HeKqbvtAD04YQfSfIYzPMmNJTLB6qc3kVHJBJ6UvVAva1CrtjTCI6m6cFv2
         Qd5Kr+TeyfTRq10t8cAGEU8Vh2ur7dfiGDB3nomcAQFNWr4gAoGkPOirwLzuUXHyfqBM
         TwZJr4oTklpIF10HFj6BA/2Tbq2eD7qrg9mIk=
In-Reply-To: <5385CF3A.1040306-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: systemd-devel <systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2014-05-28 15:57 GMT+04:00 Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
>
> ?? something in your real root system assigning MAC adresses to the interfaces?
>
> which distribution?


I'm using exherbo (gentoo like system) with latest systemd release.


-- 
Vasiliy Tolstov,
e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
jabber: vase-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
