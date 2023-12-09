Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7Uqb7Rw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5797FA
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 07:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702136854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4hGpCvfG9DIOhExsPm3NMmfLpCov6rPNDECqESfPoDg=;
	b=K7Uqb7RwYT/p26QC2CP82OmZ+FRNxf4eYVLMq+T6YngpEaTZOw1Md7I469SoPuaECKRr8o
	iqyfQedYNLZYIYRJ3RN5Jk37ZFBhfBlBBABhWk//LNwo8EZ9wUo4WZXy5EgtmKadF8Zu17
	eHUg+h5yeIvwYJG2OUFcRuIKOgB1S1w=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-ivGM95VcPvWrkSzPhdsuEg-1; Sat, 09 Dec 2023 10:47:33 -0500
X-MC-Unique: ivGM95VcPvWrkSzPhdsuEg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d071654ba0so23598545ad.0
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 07:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702136852; x=1702741652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hGpCvfG9DIOhExsPm3NMmfLpCov6rPNDECqESfPoDg=;
        b=jbA6JK5vxq/q7/JQED6aw18KST3VWi7P33ebFLi79o5T6O2MDqo0CsS+Qlwfg4UKEV
         SEXT9cKiK6U4oasZCG6cvLPgb9uz9s2vktt4o3VQ4NWOb2gu2K4lqbtmOg2Oa8uiMcrl
         ub+7wDiURfeTpFQWPg23Kqemyci0/bPVs0qTJCFvW14SkdZ+te1wfTQtQfAHLL/2vxQX
         55YmwOxopJv6plnG57Dj4H1WkwXR3tZiaPq6oAL4txmYBRzsH1uwo9OxLuFNIXsGNI4p
         lci76LxAO8os1+MWok9A+TGG7QBnc9uifUU6CUDbVcJfwaWYB//oWrBMhQixKo+Vq93d
         Swjg==
X-Gm-Message-State: AOJu0YwKNFRQGcE7DqHSr9EL2SU2u0uFPZOR9WcXtdE6h+cLS9s6pYwa
	o4Fayad6Ba8SIgbo3mFyQ95fgwWp3RJuyVEcOdOrqdauYqQAQE/39Of7ptbrfzm68yR3kiH/rUx
	gmYh0ZQc6qQFpHTKKqVZzxRVgwI9HClGPi8zw
X-Received: by 2002:a17:902:e752:b0:1d0:b926:bbcd with SMTP id p18-20020a170902e75200b001d0b926bbcdmr1206138plf.54.1702136852433;
        Sat, 09 Dec 2023 07:47:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbKxVKSfidsLTiL6BVEAMjJcXyVryG3Oz89FT5aUviTrwN2M3ZFS2QYg2J+dVcUFxI7g6knBZFXaw2WAjvdn8=
X-Received: by 2002:a17:902:e752:b0:1d0:b926:bbcd with SMTP id
 p18-20020a170902e75200b001d0b926bbcdmr1206134plf.54.1702136852107; Sat, 09
 Dec 2023 07:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <CAMw=ZnRe_h6wmhYQStF8XaHTRYxF0YBbi4+aSuEZ5DOmgMbEkA@mail.gmail.com>
 <CAOgh=Fz9aVO3p=tWQuTtQf-+91dRxyFvNjCk9CGnzvbHWE0u-Q@mail.gmail.com>
 <ac1728d2-1e85-41fb-876b-adb98f0d2dff@gmail.com> <CAOgh=FyGVnyz-5TF_kDbHu+THESCRJ3sJ6HFBfWB_YGj93AzfQ@mail.gmail.com>
 <CAO8sHcnKm+Z5ZKZDJaFXJ5KVy4=VKGxCZqs7xq08XTp0ApW3wg@mail.gmail.com>
In-Reply-To: <CAO8sHcnKm+Z5ZKZDJaFXJ5KVy4=VKGxCZqs7xq08XTp0ApW3wg@mail.gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Sat, 9 Dec 2023 15:46:55 +0000
Message-ID: <CAOgh=FwuXeyysnzCmR+PDvdTxKp=vdOuOpwpqFsAjYfbpSM2fw@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, initramfs@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, Stephen Smoogen <ssmoogen@redhat.com>, 
	Yariv Rachmani <yrachman@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>, 
	Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Dec 2023 at 15:23, Daan De Meyer <daan.j.demeyer@gmail.com> wrote:
>
> > We have been working on a new initial filesystem called initoverlayfs.
> > It is a new filesystem that provides a more scalable approach to
> > initial filesystems as opposed to just using initrds. We are writing
> > this RFC to the systemd and dracut mailing lists (feel free to forward
> > to UAPI group also) because although this solution works without
> > changing the code in these projects, it operates in the same area as
> > systemd, udev, dracut, etc. and uses these tools.
>
> I like the concept of using erofs instead of a compressed cpio and we have
> been discussing doing something similar within systemd. I very much dislike
> the implementation though. I believe this should be implemented natively within
> the Linux kernel instead of hacking around the missing kernel support
> in userspace.
>

I'm not against eventually implementing this in kernelspace, it's
something I've thought about. Implementing in userspace made more
sense to start as a lot of this tooling is much easier to work with in
userspace. It was much faster to write this in userspace to prove the
benefits, test, etc.

It is easier to maintain and develop software in userspace though. So
we would need to have serious thought on why we are pushing this into
kernelspace, what are the benefits, etc.

> If the kernel would add support for supplying an erofs initramfs
> instead of a cpio
> initramfs, put a writable tmpfs on top of it and would unpack any
> extra cpios provided
> by the bootloader on top of the tmpfs, then there wouldn't be any need
> for initoverlayfs.

Do we have to unpack extra cpio's, could that be optional? Mounting
erofs with transient overlay is really fast. Of course if people want
to do that it's fine :)


>
> Before adopting anything like this I believe there should be a serious
> effort to get
> this implemented within Linux itself. Only if that turns out to be
> impossible should
> we fall back to exploring userspace only solutions.
>
> Cheers,
>
> Daan
>
>
> On Sat, 9 Dec 2023 at 16:08, Eric Curtin <ecurtin@redhat.com> wrote:
> >
> > On Sat, 9 Dec 2023 at 14:56, Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> > >
> > > On 09.12.2023 17:42, Eric Curtin wrote:
> > > > On Sat, 9 Dec 2023 at 12:46, Luca Boccassi <bluca@debian.org> wrote:
> > > >>
> > > >> On Fri, 8 Dec 2023 at 19:00, Eric Curtin <ecurtin@redhat.com> wrote:
> > > >>>
> > > >>> We have been working on a new initial filesystem called initoverlayfs.
> > > >>> It is a new filesystem that provides a more scalable approach to
> > > >>> initial filesystems as opposed to just using initrds. We are writing
> > > >>> this RFC to the systemd and dracut mailing lists (feel free to forward
> > > >>> to UAPI group also) because although this solution works without
> > > >>> changing the code in these projects, it operates in the same area as
> > > >>> systemd, udev, dracut, etc. and uses these tools.
> > > >>
> > > >> It seems to me everything you described already exists? If you want to
> > > >> avoid having an initrd -> rootfs transition, you can already do that -
> > > >
> > > > You need a initrd -> rootfs transition for generic linux operating
> > > > systems right?
> > >
> > > No, you do not. Nothing stops you from running off initramfs (today you
> > > do not really have init*RAM Disk* - the content of initrd is unpacked
> > > into initramfs.
> >
> > Apologies if I am misinterpreting this response, I use terms initrd
> > and initramfs
> > interchangeably (not technically correct, but it's common to do this). The
> > point is to avoid unpacking as much as possible, because in many initrds
> > the majority of the software need not be unpacked, but is designed to work
> > with throwaway initial filesystems.
> >
> > >
> > > > Or else you start building all sorts of things directly
> > > > into the kernel which isn't really scalable.
> > > >
> > >
> > > See above.
> > >
> >
>

