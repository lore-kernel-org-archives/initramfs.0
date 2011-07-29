From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: 'make rpm' fails
Date: Fri, 29 Jul 2011 17:40:09 +0800
Message-ID: <CAM_iQpXAg1cCEq8wb52OP3_Jin4o3awwsn_eKxxCcyZGGiFbmg@mail.gmail.com>
References: <j0tqfa$2kj$1@dough.gmane.org>
	<4E327628.5040604@redhat.com>
	<CAM_iQpWGdyKxbZtMaDmV8oPuxnqjfazYToV6zGPO7yak-8yFLw@mail.gmail.com>
	<4E327AD1.8080009@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VFM/p5lSNfDeosTrFngwm5VlF6+ShKydZpoo6k/n614=;
        b=NJfE2JKe11Gzjs/7ss1bXpA0a+dbzCZndTmz4eSn5N8CVzaq6rzCgb+2I6KJpIvFSN
         4Ye5ivremgmXMYbywUExOTJ345xFu2quEbhI8MBLo2W9TIJnQr1EBvmZNrdgPYXmszLV
         Zp2AOmW5AM7FVnkW6913OniKOuN4k78pc8fR8=
In-Reply-To: <4E327AD1.8080009-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Jul 29, 2011 at 5:18 PM, Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> yes, pushed a patch for git2spec.pl
>
> dracut: harald master * raaced3f9909d /git2spec.pl:
> git2spec.pl: make rename diffs
> http://git.kernel.org/?p=boot/dracut/dracut.git;a=commitdiff;h=aaced3f9909dddc0ff858634711c3e97b80b09ec
>
> you probably will have to wait until the kernel.org cache is updated, until you
> can pull it.
>

Very cool! Thanks for the patch!
