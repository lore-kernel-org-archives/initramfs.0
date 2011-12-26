From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4 branch usrmove] deal common part of etc passwd in 99base
Date: Mon, 26 Dec 2011 12:58:56 +0800
Message-ID: <CAM_iQpW2FH_ob3u22nii3tAe-yUX-iPctDb2KEPwptrugdQbsw@mail.gmail.com>
References: <20111223080420.GA12664@darkstar.nay.redhat.com>
	<jd72k0$rf9$1@dough.gmane.org>
	<4EF7D46E.4000109@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RHajOKzDoc1gT+01rre6n+hVwZcIlITUpNwA+KQZOe4=;
        b=tav/kJ/MloqVvGHK3MTbZE22/XmDTQpTbkm/6MMT/P/u6sUTmJS4BT1/Hjp1UTQcgs
         a1cwplo8Ij+giIweLRIqxq4R9f7wsL+PSj5A80HohODBXs92+4XLOe3t8wecTQrg8zuU
         eGg5MpQiiuzJQf0ro+Pu8anbfKRxbQGyfBnlg=
In-Reply-To: <4EF7D46E.4000109-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Dec 26, 2011 at 9:57 AM, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 12/25/2011 07:49 PM, Cong Wang wrote:
>
>> On Fri, 23 Dec 2011 at 08:04 GMT, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> ssh module will need root user in /etc/passwd, so add root and nobody
>>> to /etc/passwd in 99base instead of nfs module
>>
>> Huh? Even for who don't use either ssh module or nfs module??
>>
>> I think you just need to copy these two lines into your ssh module...
>
>
> Thanks for your review.
>
> in 90mdraid module there's words in its comments about passwd, so there
> might be more modules need passwd.

But there are still more modules that don't need passwd, right?

>
> Dealing with same thing in multi module is not good, not only duplicate
> code, but also they could cause conflict. Ie. nfs set root home dir to /
> but we need /root, if nfs module added after ssh-client the home dir of
> root will be /.

If you don't want to duplicate the code, make it a function (maybe in
dracut-function?),
putting it in base module is confusing.
