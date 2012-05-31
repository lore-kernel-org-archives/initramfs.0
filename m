From: Dan Williams <dan.j.williams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Remove scsi_wait_scan module
Date: Thu, 31 May 2012 09:45:16 -0700
Message-ID: <CAA9_cmeU3Lmk6OE=qk0QF99U3Uzku1zf+bL9AsUr3G3Um1jk1w@mail.gmail.com>
References: <1338110026.2957.5.camel@dabdike.int.hansenpartnership.com>
	<20120528100015.GB10036@vostochny.stro.at>
	<1338206866.6330.22.camel@dabdike>
	<CAA9_cmfh9ZtepX+hjLVRM95u_pAe90kZTkBeVmFPWm8AMaqJ5g@mail.gmail.com>
	<1338420752.3069.20.camel@dabdike>
	<CAA9_cmfZFm5+9ARB7tNVwNzwxJh3bPD=h7gMWhByjy00-qZvgg@mail.gmail.com>
	<4FC7288C.302@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+zhEQiY6/L/8q6Rouo2Hl3+pHwAz9/ZGU8NyMYuQlUs=;
        b=lF2ViJw34lhfVwRntF4gBRAf7eYkInwpr5sdhmaNJTXHaSGZfeEws97cESGj7wJ4zG
         UpikFtn0R8AMkXw8GAtsn2qu29aYbgYmNQBpN+hj9Bl0ALPo3ecLfBBkQanWkO0yzy5S
         vUMpQ/aOldFra5uUh55ZDtFy7vlPiepA4e3Mj7geDO7qxtq4BpICcyTUgfDAEGa/IL0e
         /zBT9p7GlI6X/k043mNG9i8LCIO0hma1MIBLxop5DnQzcQNdvv0kTYjvEXgb2rG7oO3n
         eCvhi8EBIGbB6zBrD3V27T255ozi4jwiccXCNyC7d44Pwt6nFoh3eEjIGYnli7SwlQBD
         XMyw==
In-Reply-To: <4FC7288C.302-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: James Bottomley <James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, maximilian attems <max-U9r9yeDMy7A@public.gmane.org>, linux-scsi <linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jeff Mahoney <jeffm-l3A5Bk7waGM@public.gmane.org>, Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, May 31, 2012 at 1:15 AM, Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> For Fedora17 scsi_wait_scan is not used anymore in the normal initramfs. I
> removed it and raid is only tried to be started in degraded mode after a timeout
> (several udevadm settle waits plus some extra 10 seconds).

I'm probably missing something, but that sounds like "sprinkle
timeouts until it magically works"?  If udevadm settle is being used
as a discovery barrier shouldn't it be closing the loop with
wait_for_device_probe() in the kernel?

--
Dan
