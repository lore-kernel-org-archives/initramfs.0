Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0hySY9X"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7451700
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 07:23:06 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0bcc0c313so19604865ad.3
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 07:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702135386; x=1702740186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OEBWD++h05i0i1NWIOerL7Gp1Va0dKduT4K/vC1/TQM=;
        b=N0hySY9XBr+xvq+O/YRji+KFIoFH3mfxRgaor6+JnFdmRJzQt1WlmbnE0RM+REwuz+
         vA8OEZ/vk1U0AYxClbf7ahBUYeQ4XodgptlE3guPQz3SWzbCLjdE7x/ZEutsVixhZsS5
         qSwbmKLZpEUMzQ8YoBW93NtRyMix+wcV0di3d1GzX+kTpUzX9dbJuMdLWtvv7lss+XGu
         wkE8sYmb5wsL8zVVz9KC/Ga9As8EjtJ1hS7hlpxvbij8tqsfAKiicBO5O3j8SI+wDKsJ
         cjo5vNvMm4HLLwz9SaBE3XDg8BQ7O2o2OTEGGP3zk7kbFg/q5d3S5PPg02uCt9+m1YLH
         Ju4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702135386; x=1702740186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEBWD++h05i0i1NWIOerL7Gp1Va0dKduT4K/vC1/TQM=;
        b=sYtrPuwB4UbodEG0X6zl6e7k8GkkVKJPNxBkTeA4Hsw7GFhoTYc6k2D1OCso5gX1YN
         UwEC7ul2Av4/ZtrbHG0+uMfF6zEXNxQ0ZByog/S/EsGVKFoWPPu0H84vYNWpA8gDvaMG
         kgqoFlBdSr8lV/QHexCQdbO2wa2VkVLRr9prscxELRoT2Ht68U7veDFByHjhFOt8HDeF
         CQXWBzV3MMSkvX6gr6sw5ejUB8TLlN0V9Pdl1GMazfqJpaaQ8qJ+wjSVMFQ/TvD2xXYw
         8jcWzS17ZHctalsDMXlwp0Gb3hY7alg2CRLqz1KuOLZYbCZ/CRtF/R+FJCHZeH5reEpo
         1oSg==
X-Gm-Message-State: AOJu0YzRovWGpJWBaqP3Ph5i17dRIjK0/6MwxZxB6IGaoZXQAjy7HzLr
	eS686mA41+J3E04Pa4XrkCqH8A2tVOJ30YVqLMo=
X-Google-Smtp-Source: AGHT+IEyw6221WeuEAimef6kfHiwdvaZpCSBsaPeRGtgzRyIE3KNaEL4xzDhBf4UiJtiRvEk5OQzg/G6n5cCp67v3Nk=
X-Received: by 2002:a17:902:b588:b0:1d0:cfdc:10b8 with SMTP id
 a8-20020a170902b58800b001d0cfdc10b8mr693630pls.76.1702135385976; Sat, 09 Dec
 2023 07:23:05 -0800 (PST)
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
In-Reply-To: <CAOgh=FyGVnyz-5TF_kDbHu+THESCRJ3sJ6HFBfWB_YGj93AzfQ@mail.gmail.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Sat, 9 Dec 2023 16:22:54 +0100
Message-ID: <CAO8sHcnKm+Z5ZKZDJaFXJ5KVy4=VKGxCZqs7xq08XTp0ApW3wg@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Eric Curtin <ecurtin@redhat.com>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, initramfs@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, Stephen Smoogen <ssmoogen@redhat.com>, 
	Yariv Rachmani <yrachman@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>, 
	Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"

> We have been working on a new initial filesystem called initoverlayfs.
> It is a new filesystem that provides a more scalable approach to
> initial filesystems as opposed to just using initrds. We are writing
> this RFC to the systemd and dracut mailing lists (feel free to forward
> to UAPI group also) because although this solution works without
> changing the code in these projects, it operates in the same area as
> systemd, udev, dracut, etc. and uses these tools.

I like the concept of using erofs instead of a compressed cpio and we have
been discussing doing something similar within systemd. I very much dislike
the implementation though. I believe this should be implemented natively within
the Linux kernel instead of hacking around the missing kernel support
in userspace.

If the kernel would add support for supplying an erofs initramfs
instead of a cpio
initramfs, put a writable tmpfs on top of it and would unpack any
extra cpios provided
by the bootloader on top of the tmpfs, then there wouldn't be any need
for initoverlayfs.

Before adopting anything like this I believe there should be a serious
effort to get
this implemented within Linux itself. Only if that turns out to be
impossible should
we fall back to exploring userspace only solutions.

Cheers,

Daan


On Sat, 9 Dec 2023 at 16:08, Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Sat, 9 Dec 2023 at 14:56, Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> >
> > On 09.12.2023 17:42, Eric Curtin wrote:
> > > On Sat, 9 Dec 2023 at 12:46, Luca Boccassi <bluca@debian.org> wrote:
> > >>
> > >> On Fri, 8 Dec 2023 at 19:00, Eric Curtin <ecurtin@redhat.com> wrote:
> > >>>
> > >>> We have been working on a new initial filesystem called initoverlayfs.
> > >>> It is a new filesystem that provides a more scalable approach to
> > >>> initial filesystems as opposed to just using initrds. We are writing
> > >>> this RFC to the systemd and dracut mailing lists (feel free to forward
> > >>> to UAPI group also) because although this solution works without
> > >>> changing the code in these projects, it operates in the same area as
> > >>> systemd, udev, dracut, etc. and uses these tools.
> > >>
> > >> It seems to me everything you described already exists? If you want to
> > >> avoid having an initrd -> rootfs transition, you can already do that -
> > >
> > > You need a initrd -> rootfs transition for generic linux operating
> > > systems right?
> >
> > No, you do not. Nothing stops you from running off initramfs (today you
> > do not really have init*RAM Disk* - the content of initrd is unpacked
> > into initramfs.
>
> Apologies if I am misinterpreting this response, I use terms initrd
> and initramfs
> interchangeably (not technically correct, but it's common to do this). The
> point is to avoid unpacking as much as possible, because in many initrds
> the majority of the software need not be unpacked, but is designed to work
> with throwaway initial filesystems.
>
> >
> > > Or else you start building all sorts of things directly
> > > into the kernel which isn't really scalable.
> > >
> >
> > See above.
> >
>
