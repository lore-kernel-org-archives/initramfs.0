From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: Re: live rootfs from squashfs and read write ability
Date: Thu, 22 May 2014 14:00:01 +0400
Message-ID: <CACaajQsdu_aLHBouN7P1kwKZv8JTmxqvDoqJtAssCwZipA25vg@mail.gmail.com>
References: <CACaajQsj71mL4BciOPaNTx2wN_A2SiBM=babpsUK5QGzQ2Yreg@mail.gmail.com>
 <20140522095925.GG1859@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=LebjRMU5+iq/iFhFIw+RmPEAnNNyb2jQsp47RCkmfX0=;
        b=H0SZ0BgqhejvkbR98XnaJsLTd/PGCZhWrbORo6nC7fE392XoxJdPmhmfMzULiJ7LNz
         D0nleXmaXO0C085ISfewBE37964NltDPsJSjEjTRkXwNJd8XC83udF/MivlbGq19AGZJ
         1/VbFmXUn2vLgt7XwM3kHkByE+caUPy8lUPA4=
In-Reply-To: <20140522095925.GG1859-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

2014-05-22 13:59 GMT+04:00 Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> I don't think there's easy solution for read-write mount since it need stacked fs like
> unionfs. But maybe you can try mount some folder as tmpfs such as /tmp, /var etc.
> and only write to the specific folders.
>
> I imagine a simpe implement for unionfs specific for initramfs use..
>
> Thanks


Now i'm try to implement such thing via overlayfs.  But i'm get base
from livenet and try to run my own stuff, but i have loop in
wait_for_dev -n /dev/root =(


-- 
Vasiliy Tolstov,
e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
jabber: vase-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
