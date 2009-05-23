From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: No stdout when using dash
Date: Sat, 23 May 2009 11:57:23 -0500
Message-ID: <3CC7A938-990C-40BB-9BBD-77BFD56EA4D0@gmail.com>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net> <1243082881.29452.45.camel@sentry-no.us.dell.com> <ac3eb2510905230626k5a8b3d25l5c4de0c9017b9c80@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=eNOBZzMqZLdgherJLJy7K951lptts4hz2vU8FGMxW0U=;
        b=LRMatIeGcQG5Gc/96PTF8jFzdcjjYygCHQnYDCMWMz7GE/SiVEO/mh0nSZtlnNoj6W
         R6SUJpyGMlR97NSx5txFoo379EXkkzUn5lBQtUQLsAXKiRBMRoXgxfNCa7k4/8xDwDc3
         7LReOkGAxiF0zDeQVGlbSn54BTgiW9dBlCm2U=
In-Reply-To: <ac3eb2510905230626k5a8b3d25l5c4de0c9017b9c80-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On May 23, 2009, at 8:26 AM, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org> wrote:

> On Sat, May 23, 2009 at 14:48, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> > wrote:
>
>> +getarg ramfsdebug && set -x
>
> Btw, "ramfs" is a well known kernel filesystem type, I don't think we
> should use that name here.
>
> The kernel parameter which binary to start in initramfs is "rdinit",
> unlike "init" which is the binary to start in the real rootfs. Maybe
> we just keep the rd-prefix for such variables?

Sounds reasonable.

>
> Thanks,
> Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
