From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 07/11] dash echo does not support -e option
Date: Fri, 15 May 2009 09:36:28 -0500
Message-ID: <4F1A64A3-5CC8-403C-BCB1-E1FB1666F902@gmail.com>
References: <4A0D6294.1040509@redhat.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=iAD4gd7w6v+joHfMYyzGv9uCCL8yI9n/jiwiC6JEk74=;
        b=uit4IOgnoIGU33vCll8Nzlr4zQtUZHqlyrfM32JIEjjP63z3MJJZET25iardtI+ynq
         GHCOV5MnylCvuDMLoltUwBt79fY3xlZ4NT6B1aalSvOF7pWF5uyrqvIay6ZjAFlQL38j
         JBD3cH6G/V83RjzUwhZOVahWi0sQyYUrJGryU=
In-Reply-To: <4A0D6294.1040509-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

If you use printf (which is built in to dash), you do not have to  
include the actual echo binary.



On May 15, 2009, at 7:39 AM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

>
> use /bin/echo, instead of dash builtin echo
> do not use "sh -c"
> ---
> modules.d/95rootfs-block-udev/genrules.sh |    9 ++++-----
> modules.d/95rootfs-block-udev/install     |    1 +
> 2 files changed, 5 insertions(+), 5 deletions(-)
>
>
> <e419faf652b7323963df00046b0fa6109ea6d12e.diff>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
