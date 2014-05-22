From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: Re: live rootfs from squashfs and read write ability
Date: Fri, 23 May 2014 01:04:25 +0400
Message-ID: <CACaajQvz1e=nYW1C49ExcWAAZHCy9e=tZMMJbtevFAA=37t3gQ@mail.gmail.com>
References: <CACaajQsj71mL4BciOPaNTx2wN_A2SiBM=babpsUK5QGzQ2Yreg@mail.gmail.com>
 <20140522095925.GG1859@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4zSv2ZSx0AySzGSUoQjeYO94qjrMuaRjWIEhWyoZpSY=;
        b=da+szM00SUxDNKGfh+tQnfEmIZjc1imUTIovFJEMdnD/VgUwzH1UNbrYs5dLlGCvCh
         Hutkvre/ZYDg1M/olmaPJCO8322gpClEWJiOMoniV6SibqXIJbSTEAcNnmERl/M/k59c
         enxBcbQGrhaDp2LTbu+7L8kbmbojLTANPV3xw=
In-Reply-To: <20140522095925.GG1859-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

2014-05-22 13:59 GMT+04:00 Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
>
> I don't think there's easy solution for read-write mount since it need stacked fs like
> unionfs. But maybe you can try mount some folder as tmpfs such as /tmp, /var etc.
> and only write to the specific folders.
>
> I imagine a simpe implement for unionfs specific for initramfs use..
>
> Thanks


I'm try to implement overlayfs mount (backend squashfs, frontend tmpfs).
Can you check https://github.com/haraldh/dracut/pull/20.patch or
https://github.com/haraldh/dracut/pull/20 and give to me some
suggestion, how can i best do this?


-- 
Vasiliy Tolstov,
e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
jabber: vase-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
