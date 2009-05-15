From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 10/11] cleanup make-test-root
Date: Fri, 15 May 2009 09:39:55 -0500
Message-ID: <FB149EF3-5330-4A31-8BE5-C20525C24F53@gmail.com>
References: <4A0D62AF.6020804@redhat.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=kVCrBPQErzWodBmX4PTm5dGqa/pV2OfKqQNGPYpnNjg=;
        b=V0Bki0mqOh1Vk6EdE1nOrekCHivxjJYRnmh0JaZErAQPVzQhAABhO1Uv4iaomYP6XC
         G1iDRsCfVFNNQ3glDVfJi6oPLdi19HpxgFqda2b8Wmrcxpq+lilbS0gTYINGE0Ak4XuJ
         fl6qhKYzAQzsuhISciUIgVX3Is6rG8R0xVPRs=
In-Reply-To: <4A0D62AF.6020804-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

My current test patches go the other way. LUKS and mdraid work better  
when we create the test root block devices in the VM.



On May 15, 2009, at 7:40 AM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> ---
> test/make-test-root |   10 ----------
> 1 files changed, 0 insertions(+), 10 deletions(-)
>
>
> <9e551c90976caf75483065f8f4ba93d5b4258ec9.diff>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
