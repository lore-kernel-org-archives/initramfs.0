From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/31] Some dracut cleanups and bashification.
Date: Mon, 9 Feb 2009 15:32:03 -0600
Message-ID: <1DE1BD1F-F936-47CD-A04A-57895E2A6E8D@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com> <20090209171521.GA3646@redhat.com> <7FE9B1BD-31DA-4605-9881-3C42A05075E3@gmail.com> <20090209191333.GA8665@redhat.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=/oLoZqEGm/L/+luhkCflKfIPpRTehryYhum2gC+Ay7w=;
        b=HNIXbhEBK0pfrMGRq8LgSQXWAtP6e+pEPKvGCVdpil0dR5XfdcTn5rd+9MpvsqggTZ
         /snWWud3Srjy/59jyyEToMil20hMBNp67nU/MDao+uXN7Jr4vaw7eypGvoG+AhAC2g9o
         77Y6jEMZ8cVNjus5AF3xfp6Z2atrwiaKueTLE=
In-Reply-To: <20090209191333.GA8665-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Feb 9, 2009, at 1:13 PM, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Mon, Feb 09, 2009 at 12:57:15PM -0600, Victor Lowther wrote:
>
>>> The introduction of additional bashisms is something I'm not sold  
>>> on.
>>
>> Well, it seems that most of the concern about bashisms has to do with
>> the code that ends up on the initrd. Making that code strictly  
>> posix is
>> probably a good thing.
>>
>> There is no real benifit in having the initrd generating code be
>> strictly posix, IMHO. It could be written in C, python, haskell, or
>> INTERCAL.
>
> Good point.   I admit my comment was a knee-jerk reaction from reading
> the first post without having read the whole patchset.

Well, this patchset does introduce bashisms in init. I have another  
that takes them out at the same time it adds three hook points. More  
details later.

>
>    Dave
>
> -- 
> http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
