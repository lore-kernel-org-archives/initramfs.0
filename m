From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Live module for root=nfs using Aufs
Date: Mon, 8 Nov 2010 20:03:27 +0100
Message-ID: <AANLkTinNFeT8kuoe5FRJig=un76kE6bLoU4BzJKxp4OY@mail.gmail.com>
References: <AANLkTi=7coxwNNu22um=qO7Tz18QZj_N7h3=G5ABnjqV@mail.gmail.com>
	<4CD7B293.8050809@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=A8pjRauSPPDO52OOAmcPwA1eE3ZqBHY1oiMfIkUIf0c=;
        b=FK6xuHvAoFjza+KmlqQCgTctRNO3EPQL6vNddd7x0uVbzEctGdj8iTm0QPzPoRV6dO
         5fY/XRtO97I0VT6uSkszuDKc0z16R8O9q1lIbvZXdn0Tq4Af8IIhiHh5VSU/7u97/Gnt
         1AK5KUm8pSZIa1wixrDiQopml48e1MUM35Dts=
In-Reply-To: <4CD7B293.8050809-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

2010/11/8 Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>:

> I just had a quick look over the patch and in itself it looks ok. Although
> I'm not sure if having the aufs at this stage is necessary. What if you just
> mount it later inside the rootfs? (Background: I'm using aufs overlays for
> our read only nfs-roots, and I just put the necessary aufs mounts inside
> fstab)

I have to say that I haven't thought about it before.... It is really
a good idea, and is probably better than have a specific module. :-)

But something that worries me, is if the init process will cause
problems, since we will be mounting a new root over the old one once
we have processes which have previously opened files on the old /.

Regards,

Jon Ander.
