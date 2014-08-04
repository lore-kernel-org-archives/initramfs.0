From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: Re: Readonly root filesystem
Date: Mon, 4 Aug 2014 14:59:52 +0400
Message-ID: <CACaajQvjyE6ZhGUU3kraE3=dvcEdSYUGa-SWpHMAprNaJPv+yQ@mail.gmail.com>
References: <CAAXZ8mcdNna12Tfz2AShs6nFxxgqpFmOzpvKHa1x0Jb74NmnWA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9UN2pWthgSM2U+ZeyzZHBpDhGyaS64XgT3XdMcfBhQo=;
        b=RHt1vqpkfKClHlRowk4F+p27Iz3n2FyGLo6Qbq7MDSCX+4PjV2bp2dofCGpSDx8Jur
         uWEh9v+5pepGbrSlwhAY5C1KDOPYJGKup6mZbiBA8Q1Av8pxrIgp+kHcqqlAnliZGDTL
         3zwP/Sr/OciFif5rXow9nWLT7xBD5WzlKtVNA=
In-Reply-To: <CAAXZ8mcdNna12Tfz2AShs6nFxxgqpFmOzpvKHa1x0Jb74NmnWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Perepelica <perepelica.alex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2014-08-04 12:08 GMT+04:00 Alexander Perepelica <perepelica.alex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hello!
> I try to make my root filesystem read only. I need this to create
> power failsafe linux for headless router. I want use unionfs where
> write layer would tmpfs (or always recreate small partition) and root
> filesystem within read only layer. I try to do this how in debian make
> fsprotect (but in opensuse 13.1 i can't find aufs, so use unionfs).
> And question is anybody do such things?
> I can make root filesystem ro with rootflags=ro, but where I must add
> hook to create another layers pre-mount, mount or switch_root?
> Regards,
> Alexander Perepelica


Please see github patches for aufs and overlayfs support.

-- 
Vasiliy Tolstov,
e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
jabber: vase-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
