From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: including python in the initramfs
Date: Tue, 16 Jun 2009 13:22:14 -0500
Message-ID: <A4EC33E8-3A45-4A6B-AE97-5B48EA425F75@gmail.com>
References: <1245174031.2150.67.camel@polyethylene>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=yluMlFajGtuofUDLeHgIq8sVzF5ZvRp58jfqrLjlVhE=;
        b=Qc8vUY3TNhxbBg6D316ADuTVzz/QmFi0VQCm9cxFaF0kqtSyIbdIGkvtGCJbmF15yX
         SuRtNlTlgw2Mz3qX+4JUH+nd5Xj+LbJqsaMi2xXsplpgnUapPJzLUHnPaHjgaMA3cAWB
         UKlG7hVnvlj8cCOdYwyA8L6nmWuY6bkzDC4l4=
In-Reply-To: <1245174031.2150.67.camel@polyethylene>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Jun 16, 2009, at 12:40 PM, Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> wrote:

> Hi,
>
> OLPC have a security client that runs pre-root-mount in the initramfs
> which is quite complex. It is written in Python. As such, we need  
> python
> in the initramfs.

/me boggles.

Why can't it run after switching to the real root?

> What's the best way to include python in a dracut initramfs?

Don't if it is at all possible to avoid it. Maintaining such a thing  
will be a nightmare, especially if you want cross distro capability.

> One idea: we could create a separate module which installs all the  
> files
> identified by "rpm -q --filesbypkg python". But that's obviously not
> distro-portable. It could work for us but I'd prefer that we're able  
> to
> share the work we're doing with others. Any other ideas?

Split out the parts that have to run on the initramfs, and rewrite  
them in sh or C.

>
> Thanks,
> Daniel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
