From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4 branch usrmove] Add ssh client module code
Date: Mon, 26 Dec 2011 13:09:13 +0800
Message-ID: <CAM_iQpUZ-1Utz9wX1puWx18GY+d76y5F0VHNjywtxxTKb9iKoQ@mail.gmail.com>
References: <20111223080430.GA12670@darkstar.nay.redhat.com>
	<jd732n$rf9$2@dough.gmane.org>
	<4EF7D46F.2030908@ziu.info>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tCoXf7W1t05NAXJE432AuIj/jTispYw02CXTg8anITE=;
        b=SVH3l0emldvyQJTfva51du8O8BV8Q2wX4egA2DI2HbPBWnu5bIAVDWDfTiHnBLwnHo
         cm5zHI/TCj4FOcttrX8ypuEk5HLJ2z3glIOQ+2LqSsccZdZB2i0GItAoJ21Z5W7R+d3A
         znQ2/+5G+JkcaPP/GaJ9yIlhMgTQWJ4yDnOn4=
In-Reply-To: <4EF7D46F.2030908-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Dec 26, 2011 at 9:57 AM, Michal Soltys <soltys-R61QfzASbfY@public.gmane.org> wrote:
>
> For the record - ctty part was meant as a general feature - tty with control
> is pretty useful thing to have - and pretty trivial to add, so why not.
>
> Though the patches I made earlier also included a few other things, dunno
> what's the state of them (probably none ;) ). HEAD differs significantly by
> now, so maybe I should redo them as v2.
>

Thanks for teaching this.

As ssh-module needs --ctty, it is good to let Dave send them as a
whole patchset,
of course, you are still the author of that patch. :)
