From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5 branch usrmove v2] deal common part of etc passwd in 99base
Date: Thu, 29 Dec 2011 17:48:28 +0800
Message-ID: <CAM_iQpX6kWGPB_mGUWOaywQgxeWEC+Og6WjOZmknS+FPGuA0xQ@mail.gmail.com>
References: <20111226062910.GA3141@darkstar.nay.redhat.com>
	<jdcb3i$9bf$1@dough.gmane.org>
	<4EFBD882.2090707@redhat.com>
	<jdhbpl$s87$1@dough.gmane.org>
	<4EFC36CD.8040205@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aDXJP8qpnVjp0Op14Gyp8OaQKD6siIUd2jd7QktAOKo=;
        b=GHUfrf9kStVs0w6oGSofRVKhKxdVGT9KY66664RxI9un2OjKNCSTBecmZaMBadk8DF
         0t2DIdTH/eXg94gt6KwzFQd7tidsct4ImFuXabJEBThiKL6gUXOQuvXX6icTnvbDHxGZ
         N/KBBByKsSDeUPJcn7dfT09vF7FVko3Q04n3k=
In-Reply-To: <4EFC36CD.8040205-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Dec 29, 2011 at 5:45 PM, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 12/29/2011 05:27 PM, Cong Wang wrote:
>> The nfs module still uses "/" as home of root, while ssh module uses
>> "/root". With you patches, you changed to "/root" for both nfs and
>> ssh, which *maybe* a problem for nfs module since you didn't test it.
>
>
> I tested nfs boot as well, it works ok with $HOME=/root

Ok, will change to "/root" too.

>
> Also if you add both ssh-client and nfs, what's the result of /etc/passwd?

If the line "root:" exists before,

 egrep -q '^root:' "$initdir/etc/passwd" 2>/dev/null || echo
'root:x:0:0::/:/bin/sh' >> "$initdir/etc/passwd"

egrep will succeed and echo will not be executed...
