From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/31] Some dracut cleanups and bashification.
Date: Tue, 10 Feb 2009 10:56:13 -0600
Message-ID: <87E83B3E-5AE1-4DA2-8D40-0A64A9915A6B@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com> <20090209171521.GA3646@redhat.com> <7FE9B1BD-31DA-4605-9881-3C42A05075E3@gmail.com> <20090210121745.GC15532@stro.at>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:cc:x-mailer;
        bh=DD04dPls5W/8Mmo+djPWb3FDVALiHxqz+fx4QixPwzM=;
        b=Or11uZFMtOQTK/Par3rQLnX1kDE/UFRB0pWLCJSYgvm62gleRDjpRvEXWsIoiihoGj
         kRp1zwCSLRsnilY3MAnljME5AqtXm/I1Y4rJHEyz7OL3UtF2oMfZV6rnZxcWH2P/j5to
         D78TX1SsFZTltIoXOcG1O+cNCd2n3WQdy9EEM=
In-Reply-To: <20090210121745.GC15532-U9r9yeDMy7A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Cc: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Feb 10, 2009, at 6:17 AM, maximilian attems <max-U9r9yeDMy7A@public.gmane.org> wrote:

> On Mon, 09 Feb 2009, Victor Lowther wrote:
>
>> Yeah, having the bits that end up in the initrd be posix is a good
>> design constraint.
>
> yep, please test with dash before introducing further bashism.

Will do, at least for the bits that get installed on the initrd. 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
