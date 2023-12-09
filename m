Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INVM5/uA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20333F2
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 10:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702146408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YGzDmioAP0SXrZvGW9Wi66ZZQY0OyrY37Q2U6evQSGg=;
	b=INVM5/uAcx/v38/outqO1CtKaAJ0uUTBakbWUrPa8vNvOX8xKLaqMBgOO9UWNTjMG1U2Ac
	Z73TjEXtK3PSsfKIfQR/nEI4PS0+6Zi4SBqIQMjHe5IlhOyYx9XyxjqpkEYTFjx//HpFlb
	/87vFvn2b2c4vBjprntuWsCsBIG5PPc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-t8-dtVknNgWXo8xXEkvYlA-1; Sat, 09 Dec 2023 13:26:46 -0500
X-MC-Unique: t8-dtVknNgWXo8xXEkvYlA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-58dc2d926e7so4024353eaf.0
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 10:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702146405; x=1702751205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGzDmioAP0SXrZvGW9Wi66ZZQY0OyrY37Q2U6evQSGg=;
        b=j5biMMRuwneFMNBcgIazcsmDXC4wiwHPr8Anm7ewVd7fH/DxDFZQ4Ezpp8ybjGWHAa
         Fa9gDrrOjNtHBqGk7UlwqCnnU4m/q2lpNK7rL0FTVkxkDJEZ2+SX9ePON7a5qLSa3/UT
         2hkjUpfiQbl093TMCGNEvTdu4cCsJpQJbmIbh3tJizf1G90mIcAivY5l8uGmv8t13zPz
         2SQDodJVj7CiZPcivA58LEjaFmWiFLOhYKULPZSac4xWbHCW5qBkV8l08yif68LdlbXv
         w2RiJ8gilSQmZgmU6fiE2b+uxKr7KF27FOqZ6snbZah1C7VfCV9VvRWD9RviXqlSFFSs
         SLVg==
X-Gm-Message-State: AOJu0Yzk3ntmA8j46G84lvBvEDdDl6hPvvP1gvb54cc4iR8w1h90i4QB
	ULFKxu1c8MmNIu0/0OU4wpq3yDMoDRi4a1s6BE0rYbR3EIkxqgtWZ1y+G3mr+qXeup3Slc7jlfL
	4wv7b758pcbnSiZ6W/69b/Fa0hPi+aEjkcqCU
X-Received: by 2002:a05:6359:4598:b0:170:6ba9:9dac with SMTP id no24-20020a056359459800b001706ba99dacmr2548907rwb.61.1702146405387;
        Sat, 09 Dec 2023 10:26:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEguVq8ufMXSul7cvPy9D4XZRJ9DavX+Bp0Ojuw6eg+sH6ORtBoWsm8TS/IKmgFBzqPgu0RxJ+wJ+CoS3x1LZA=
X-Received: by 2002:a05:6359:4598:b0:170:6ba9:9dac with SMTP id
 no24-20020a056359459800b001706ba99dacmr2548890rwb.61.1702146405036; Sat, 09
 Dec 2023 10:26:45 -0800 (PST)
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
 <CAMw=ZnQ7eu7Czy0W5fh8TtM8y3+MGwdubZrrw6612ZTTBY8eWA@mail.gmail.com>
 <CAOgh=FwxR8gEXHnLqxjY_nabvg9uehY3Sqksq8LyakpVjh7AZA@mail.gmail.com>
 <CAMw=ZnQEk+LNUhbAzvhLnUOko16ARLyQ2eW4RmWtwHzBGsNq4Q@mail.gmail.com>
 <CAOgh=FyyrehtCNxcpo3HV7Yxn9Uv_Gout2t_os-pGCZcSgA3ew@mail.gmail.com> <CAMw=ZnTZNY-KQgR8Vmd30Hh3wzywBqyuj1vUZ=t3R1PWug5-0Q@mail.gmail.com>
In-Reply-To: <CAMw=ZnTZNY-KQgR8Vmd30Hh3wzywBqyuj1vUZ=t3R1PWug5-0Q@mail.gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Sat, 9 Dec 2023 18:26:08 +0000
Message-ID: <CAOgh=Fw_VtK81m9FLbSJ2=x_HcYmcCmnM4sOnCLYL_WxSJypmA@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Luca Boccassi <bluca@debian.org>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, systemd-devel@lists.freedesktop.org, 
	initramfs@vger.kernel.org, Yariv Rachmani <yrachman@redhat.com>, 
	Stephen Smoogen <ssmoogen@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Dec 2023 at 18:12, Luca Boccassi <bluca@debian.org> wrote:
>
> On Sat, 9 Dec 2023 at 17:58, Eric Curtin <ecurtin@redhat.com> wrote:
> >
> > On Sat, 9 Dec 2023 at 17:46, Luca Boccassi <bluca@debian.org> wrote:
> > >
> > > On Sat, 9 Dec 2023 at 17:25, Eric Curtin <ecurtin@redhat.com> wrote:
> > > >
> > > > On Sat, 9 Dec 2023 at 17:19, Luca Boccassi <bluca@debian.org> wrote:
> > > > >
> > > > > On Sat, 9 Dec 2023 at 15:08, Eric Curtin <ecurtin@redhat.com> wrote:
> > > > > >
> > > > > > On Sat, 9 Dec 2023 at 14:56, Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> > > > > > >
> > > > > > > On 09.12.2023 17:42, Eric Curtin wrote:
> > > > > > > > On Sat, 9 Dec 2023 at 12:46, Luca Boccassi <bluca@debian.org> wrote:
> > > > > > > >>
> > > > > > > >> On Fri, 8 Dec 2023 at 19:00, Eric Curtin <ecurtin@redhat.com> wrote:
> > > > > > > >>>
> > > > > > > >>> We have been working on a new initial filesystem called initoverlayfs.
> > > > > > > >>> It is a new filesystem that provides a more scalable approach to
> > > > > > > >>> initial filesystems as opposed to just using initrds. We are writing
> > > > > > > >>> this RFC to the systemd and dracut mailing lists (feel free to forward
> > > > > > > >>> to UAPI group also) because although this solution works without
> > > > > > > >>> changing the code in these projects, it operates in the same area as
> > > > > > > >>> systemd, udev, dracut, etc. and uses these tools.
> > > > > > > >>
> > > > > > > >> It seems to me everything you described already exists? If you want to
> > > > > > > >> avoid having an initrd -> rootfs transition, you can already do that -
> > > > > > > >
> > > > > > > > You need a initrd -> rootfs transition for generic linux operating
> > > > > > > > systems right?
> > > > > > >
> > > > > > > No, you do not. Nothing stops you from running off initramfs (today you
> > > > > > > do not really have init*RAM Disk* - the content of initrd is unpacked
> > > > > > > into initramfs.
> > > > > >
> > > > > > Apologies if I am misinterpreting this response, I use terms initrd
> > > > > > and initramfs
> > > > > > interchangeably (not technically correct, but it's common to do this). The
> > > > > > point is to avoid unpacking as much as possible, because in many initrds
> > > > > > the majority of the software need not be unpacked, but is designed to work
> > > > > > with throwaway initial filesystems.
> > > > >
> > > > > sd-stub already supports having a small initrd shipped in the UKI,
> > > > > that is extended via sysexts, and systemd already supports running
> > > > > from it, without any transition to a final rootfs. What else do you
> > > > > need? What problem is this attempting to solve?
> > > >
> > > > I must give sd-stub a try. The bootloader I most commonly work with (and is one
> > > > of the target platforms this is intended for) isn't UEFI, we need something more
> > > > portable.
> > >
> > > Do we, though? All modern hardware platforms (and VMs) that matter are
> > > UEFI. Why would any of this be needed for legacy hardware platforms?
> > > The existing mechanisms can work just fine on those until they reach
> > > EOL, they won't stop working.
> >
> > Respectfully, this is not true. Especially on ARM platforms. I would
> > like it to be true, but it's not true today.
>
> Where any of this would actually matter, they mostly do, and where
> they don't one can put together uboot with uefi mode.

When you are trying to improve boot performance, introducing another
layer of bootloader with uboot doesn't help. You also have to port
every hardware platform you encounter to uboot. And if you can solve
the problem in the Linux stack somewhere rather than the bootloader.
Why would we choose to fix the problem in the bootloader?

>
> > I should have expanded, we are not trying to avoid transitioning to a
> > final rootfs, the goal is to transition to a final rootfs. But not to decompress
> > and copy all the bytes to a tmpfs up front, rather use something like erofs,
> > overlayfs, etc. sysexts uses erofs+overlayfs, but it's designed with
> > a different goal in mind.
>
> In what way is the goal different?

This project is basically build an initrd, but put it in a
erofs+overlayfs alternatively (technically it builds a really small
initrd to initialize some basic storage drivers etc. and build a
second initrd in an erofs format). All existing software that we've
tested "just works" with this approach, including all the systemd
stuff. And you can do transparent decompression with lz4hc
alternatively. It also means you don't have to be as afraid of
bloating your initial filesystem, because minimizing initrd's is
tedious work.

>

