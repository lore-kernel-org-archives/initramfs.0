From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: Re: WIP patch for mptcp support
Date: Mon, 25 Aug 2014 15:16:11 +0400
Message-ID: <CACaajQtSU9px6y5twL9-Kjf_Ot9qWxe5Q=Sw=6faJsMqYRGvbw@mail.gmail.com>
References: <CACaajQsCm357hgssTWBP6pHkTK_nz_3Ojy3H=bFNSmevHk-8Ew@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Nbs4LCUKKtX5jMt9ew8oqTwibet9F6W4/XxWK6Inyeo=;
        b=fwkk6hAQR/Viv5wC9nuOySRZmzn9Rrndz/KIHg+stdE0no66F9cSKvsTZFPuRmGsve
         PxmoJqqi60N/pUI3lpwAdeCdfh4SW0DKV7TJYYbJSEBJqt1x29jJ3OSlg1DU+t+kcwUB
         YvXoh6+P135Qfc4QyW9nQswbFQK0a4ZUIe86c=
In-Reply-To: <CACaajQsCm357hgssTWBP6pHkTK_nz_3Ojy3H=bFNSmevHk-8Ew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

2014-08-19 18:50 GMT+04:00 Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>:
> Hi. I have a patch that enables mptcp (create needed routes and
> rules), can you check it ?
> https://github.com/haraldh/dracut/pull/27
>
> Also i don't know hot to best wait for completing network interfaces
> configuration but before anything else.
> Can somebody helps me?


Nobody knows?

-- 
Vasiliy Tolstov,
e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
jabber: vase-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
