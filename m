From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Minimal initramfs Modification
Date: Mon, 27 Jul 2015 07:10:58 +0300
Message-ID: <20150727071058.52eedf20@opensuse.site>
References: <CAAZEOjsyDkv0ai9a96Jg0M7tX5hAKUXMgHW7NiAugf7Sf_xnEw@mail.gmail.com>
	<55B151B0.5020100@gmail.com>
	<CAAZEOjsavzT1GsBMENe9AbHYDUhrhbS5OWaZ4tpuqe7383GO3A@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=liycAYvJbOm7mwa5GnVxNjNLzZHfQO06uyZLJY4AQDo=;
        b=Ojqydlv+LOrtrO/spAuyixeOOWKt2sAF4SCioDn4O/v0Is/R+tJkrQ1cIwtovSs7Js
         GL1Y9eF8F7IerprH6EVMdypc8ffyUATXOBJyFs+02Buv3cFXdpJRPWYFvmZNnBiy/aYt
         M2edBTskXdtUpS2U5svhrqAx+io6fB1cpuVM72+q4KLbW2+VozvaIr5dZ6TMflD1azKD
         4tCV1JnaMVnQt98dJgEsNdK2AWDUCYaAm7wYUdQ2R7XkJfIrjVdaEnOoC5c1t8N5mu+B
         kIZdO+uBTkkOokmWGgoJer0y7fC7Wjc77z1aHTIardJ8pPmv6tafKrD6dEV78ema63PZ
         JMPQ==
In-Reply-To: <CAAZEOjsavzT1GsBMENe9AbHYDUhrhbS5OWaZ4tpuqe7383GO3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Rick Tillery <rtillerywork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Udvare <audvare-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=D0=92 Fri, 24 Jul 2015 10:26:10 -0500
Rick Tillery <rtillerywork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

>=20
> It's at that point that I looked closer at dracut.  It appears to be
> able to successfully construct the initrd from the existing
> environment.  Additionally, dracut recognizes the entire image,
> including the early_cpio portion (which likewise must be recognized b=
y
> grub (2?) as well), when used to examine the initrd/initramfs file.
>=20

Bootloaders do not care about content of initrd, they just load it in
memory and pass pointer to kernel.

> So back to my original question, can dracut build the image from an
> existing image (possibly unarchived as above), with changes, and
> including the early_cpio portion?

It is not implemented.

>                                   And if not, before I go trying to
> create my own scripts, are there are there any tools that can do this=
?
>=20

Not that I'm aware of. I have the same issue every now and then and it
would be good to have dracut support it. Something like "lsinitrd -x"
to extract archives and dracut options to use existing directories for
early cpio and main initrd.
