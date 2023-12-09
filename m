Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80971C2
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 10:12:10 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbc666461daso689908276.0
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 10:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702145529; x=1702750329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOz8kOiRnZWtp1DjF2Ji+2n8tgrSexJI55p3t9VZs3Y=;
        b=sD4Vy8/t70breunNjJHfEU7MOjd57Lj0xdNuj6JNET4mYmGuSjTFmhgco95+PYG3dB
         D1XTELpm3Ox0MbCDrZJbkvw5acfJf8CNbsUOyG3p+lYefPuXiPtBQsTR7OxPIrshKm6Z
         lqXuekqXQE6M60aIQ48kVVpX8lH0kX9JTHEKTfxEPesIABYnm7ep4pQapsGDUMDhsFU8
         ZbRYo05BNqAZ678cxKen1/U7SoUH/0rNoGpUHE4VF4z9049YrTIwCTIma6x4XNgxV0Ap
         EjioQWwjLlzLZ1heiDoyVcB9GJuC4WT4LPZu0Q5liDZuPgRFSdFy6ES3NdsmG7/IivWl
         tBYQ==
X-Gm-Message-State: AOJu0YxAqywaVwjagvJSD13LHdjGGeQmOBcgWzpt3t0In5dC0KYYEFTn
	ihd428xf+S8b4Z3R66Eth8b0LTO4d5M76Q==
X-Google-Smtp-Source: AGHT+IFrkICfTXulhgayZ2Slc18kN739adziLx8SfkYzbk1Uj7mvrV78GGE5KWi5veo13atyx1KagA==
X-Received: by 2002:a81:5c88:0:b0:5d7:1940:f3ef with SMTP id q130-20020a815c88000000b005d71940f3efmr1356110ywb.87.1702145529469;
        Sat, 09 Dec 2023 10:12:09 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id x125-20020a817c83000000b005a4da74b869sm1620645ywc.139.2023.12.09.10.12.09
        for <initramfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 10:12:09 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dae7cc31151so3077411276.3
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 10:12:09 -0800 (PST)
X-Received: by 2002:a25:ce4f:0:b0:db7:dacf:6fda with SMTP id
 x76-20020a25ce4f000000b00db7dacf6fdamr1302334ybe.98.1702145528768; Sat, 09
 Dec 2023 10:12:08 -0800 (PST)
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
 <CAMw=ZnQEk+LNUhbAzvhLnUOko16ARLyQ2eW4RmWtwHzBGsNq4Q@mail.gmail.com> <CAOgh=FyyrehtCNxcpo3HV7Yxn9Uv_Gout2t_os-pGCZcSgA3ew@mail.gmail.com>
In-Reply-To: <CAOgh=FyyrehtCNxcpo3HV7Yxn9Uv_Gout2t_os-pGCZcSgA3ew@mail.gmail.com>
From: Luca Boccassi <bluca@debian.org>
Date: Sat, 9 Dec 2023 18:11:57 +0000
X-Gmail-Original-Message-ID: <CAMw=ZnTZNY-KQgR8Vmd30Hh3wzywBqyuj1vUZ=t3R1PWug5-0Q@mail.gmail.com>
Message-ID: <CAMw=ZnTZNY-KQgR8Vmd30Hh3wzywBqyuj1vUZ=t3R1PWug5-0Q@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Eric Curtin <ecurtin@redhat.com>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, systemd-devel@lists.freedesktop.org, 
	initramfs@vger.kernel.org, Yariv Rachmani <yrachman@redhat.com>, 
	Stephen Smoogen <ssmoogen@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Dec 2023 at 17:58, Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Sat, 9 Dec 2023 at 17:46, Luca Boccassi <bluca@debian.org> wrote:
> >
> > On Sat, 9 Dec 2023 at 17:25, Eric Curtin <ecurtin@redhat.com> wrote:
> > >
> > > On Sat, 9 Dec 2023 at 17:19, Luca Boccassi <bluca@debian.org> wrote:
> > > >
> > > > On Sat, 9 Dec 2023 at 15:08, Eric Curtin <ecurtin@redhat.com> wrote:
> > > > >
> > > > > On Sat, 9 Dec 2023 at 14:56, Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> > > > > >
> > > > > > On 09.12.2023 17:42, Eric Curtin wrote:
> > > > > > > On Sat, 9 Dec 2023 at 12:46, Luca Boccassi <bluca@debian.org> wrote:
> > > > > > >>
> > > > > > >> On Fri, 8 Dec 2023 at 19:00, Eric Curtin <ecurtin@redhat.com> wrote:
> > > > > > >>>
> > > > > > >>> We have been working on a new initial filesystem called initoverlayfs.
> > > > > > >>> It is a new filesystem that provides a more scalable approach to
> > > > > > >>> initial filesystems as opposed to just using initrds. We are writing
> > > > > > >>> this RFC to the systemd and dracut mailing lists (feel free to forward
> > > > > > >>> to UAPI group also) because although this solution works without
> > > > > > >>> changing the code in these projects, it operates in the same area as
> > > > > > >>> systemd, udev, dracut, etc. and uses these tools.
> > > > > > >>
> > > > > > >> It seems to me everything you described already exists? If you want to
> > > > > > >> avoid having an initrd -> rootfs transition, you can already do that -
> > > > > > >
> > > > > > > You need a initrd -> rootfs transition for generic linux operating
> > > > > > > systems right?
> > > > > >
> > > > > > No, you do not. Nothing stops you from running off initramfs (today you
> > > > > > do not really have init*RAM Disk* - the content of initrd is unpacked
> > > > > > into initramfs.
> > > > >
> > > > > Apologies if I am misinterpreting this response, I use terms initrd
> > > > > and initramfs
> > > > > interchangeably (not technically correct, but it's common to do this). The
> > > > > point is to avoid unpacking as much as possible, because in many initrds
> > > > > the majority of the software need not be unpacked, but is designed to work
> > > > > with throwaway initial filesystems.
> > > >
> > > > sd-stub already supports having a small initrd shipped in the UKI,
> > > > that is extended via sysexts, and systemd already supports running
> > > > from it, without any transition to a final rootfs. What else do you
> > > > need? What problem is this attempting to solve?
> > >
> > > I must give sd-stub a try. The bootloader I most commonly work with (and is one
> > > of the target platforms this is intended for) isn't UEFI, we need something more
> > > portable.
> >
> > Do we, though? All modern hardware platforms (and VMs) that matter are
> > UEFI. Why would any of this be needed for legacy hardware platforms?
> > The existing mechanisms can work just fine on those until they reach
> > EOL, they won't stop working.
>
> Respectfully, this is not true. Especially on ARM platforms. I would
> like it to be true, but it's not true today.

Where any of this would actually matter, they mostly do, and where
they don't one can put together uboot with uefi mode.

> I should have expanded, we are not trying to avoid transitioning to a
> final rootfs, the goal is to transition to a final rootfs. But not to decompress
> and copy all the bytes to a tmpfs up front, rather use something like erofs,
> overlayfs, etc. sysexts uses erofs+overlayfs, but it's designed with
> a different goal in mind.

In what way is the goal different?
