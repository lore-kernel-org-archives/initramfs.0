From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] added extention to module files
Date: Wed, 18 Feb 2009 13:11:20 -0600
Message-ID: <512D2182-5B29-4D94-B39A-D8C474F774E0@gmail.com>
References: <1234960574-32612-1-git-send-email-ro@duskblue.org> <9594AD60-9303-4345-8FC6-B59FAA2C60EE@gmail.com> <82ecf08e0902180756u2e007426vdd7116c03e72925e@mail.gmail.com> <ac3eb2510902180817y380a7cddh940ba268bb46da97@mail.gmail.com> <82ecf08e0902180831k8f3fe85hc6e72b9687faa35c@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=J5+aFQxsCv2PKOmp1W+zsf5GcNg0Mdb0ohXeiAAAJ9A=;
        b=YHhSXK3l1/JxYpgmZfkVYXMmJCtJeGMeSJLWzASudO30gXpFnDlj+GUOMBqio3b3N4
         hbrD2uDZFFEgy63nWHVRSpsU6h4GKG7RJCFq4IU3cbLpJKJWlBFZURtHoXCH8QF5Z4WW
         xfunXPYPwK0ffnM3ysAJ9mHzUKvvKchcntAF0=
In-Reply-To: <82ecf08e0902180831k8f3fe85hc6e72b9687faa35c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Feb 18, 2009, at 10:31 AM, Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>  
wrote:

>>
>> You mean:
>> for f in "$dsrc/modules"/*.sh; do
>> ?
>
> Silly, silly me :)
> I was worried about the [^~] at the end , and couldn't make it work
> with the sh but, of course, *.sh does the trick

The [^~] says to skip everything that ends in ~. Since we are just  
looking for .sh now, we do not need it.

>
> -- 
> -
> Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
