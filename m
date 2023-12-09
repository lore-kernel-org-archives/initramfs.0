Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AB810DA
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 09:46:39 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5c08c47c055so29914627b3.1
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 09:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143998; x=1702748798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAFvJz7EG+H5zseCL4R0dv6AH36YcHMdwtOkCQWo6xM=;
        b=XOs3abeYnvXKUCFLUYEjByv6f2ha6Q0h3yhnAshquUOOXe4lDGxZnB9DTKcowwvyP6
         vau2VrHMVbyDfEf1aUksROEXYV4ArmdTFUs3E4Ts/vI+a5P15DWenO52KZxZo9WuE7n9
         cvV8X5ETURrXBRuz0r1ytUYx8s1wDaMtAe+TRgIu8BxQYcHi7j1gG6+vNCBCwC08YBJZ
         uHovpUZl5m6/gUEKiR4l+muiHAZcE/xyJKwOi4KTtGj7/NOU+42lSRkm1aVQvdpWgLA8
         WJhMxB5j8mLP8AYD6nEjurzis1HPSNa2IIx86wgkFgTNeVq9aIe4fSSIyqx/2BnyAMQR
         HuMQ==
X-Gm-Message-State: AOJu0Yx0urXPXW2SbHwB3+TT09kyQuTfp9fHIe9UrQuYBZL7JiDXHd1A
	GYYQhKlQV+KHkMFJczTEMklkoQHQ601IVw==
X-Google-Smtp-Source: AGHT+IGd/0h8nA1Vx8Ycyaqk2mM6/c62Vl+9iqdHp52YQGcUQs8mhEguYDx8FoWhBeayhQRNyDrfzw==
X-Received: by 2002:a81:5cc6:0:b0:5d7:1940:53d4 with SMTP id q189-20020a815cc6000000b005d7194053d4mr1312459ywb.76.1702143998145;
        Sat, 09 Dec 2023 09:46:38 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id p194-20020a0de6cb000000b005956b451fb8sm1591821ywe.100.2023.12.09.09.46.37
        for <initramfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 09:46:37 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db548cd1c45so2981401276.2
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 09:46:37 -0800 (PST)
X-Received: by 2002:a25:ce43:0:b0:db5:4865:d604 with SMTP id
 x64-20020a25ce43000000b00db54865d604mr1442505ybe.53.1702143997354; Sat, 09
 Dec 2023 09:46:37 -0800 (PST)
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
 <CAMw=ZnQ7eu7Czy0W5fh8TtM8y3+MGwdubZrrw6612ZTTBY8eWA@mail.gmail.com> <CAOgh=FwxR8gEXHnLqxjY_nabvg9uehY3Sqksq8LyakpVjh7AZA@mail.gmail.com>
In-Reply-To: <CAOgh=FwxR8gEXHnLqxjY_nabvg9uehY3Sqksq8LyakpVjh7AZA@mail.gmail.com>
From: Luca Boccassi <bluca@debian.org>
Date: Sat, 9 Dec 2023 17:46:25 +0000
X-Gmail-Original-Message-ID: <CAMw=ZnQEk+LNUhbAzvhLnUOko16ARLyQ2eW4RmWtwHzBGsNq4Q@mail.gmail.com>
Message-ID: <CAMw=ZnQEk+LNUhbAzvhLnUOko16ARLyQ2eW4RmWtwHzBGsNq4Q@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Eric Curtin <ecurtin@redhat.com>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, systemd-devel@lists.freedesktop.org, 
	initramfs@vger.kernel.org, Yariv Rachmani <yrachman@redhat.com>, 
	Stephen Smoogen <ssmoogen@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Dec 2023 at 17:25, Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Sat, 9 Dec 2023 at 17:19, Luca Boccassi <bluca@debian.org> wrote:
> >
> > On Sat, 9 Dec 2023 at 15:08, Eric Curtin <ecurtin@redhat.com> wrote:
> > >
> > > On Sat, 9 Dec 2023 at 14:56, Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> > > >
> > > > On 09.12.2023 17:42, Eric Curtin wrote:
> > > > > On Sat, 9 Dec 2023 at 12:46, Luca Boccassi <bluca@debian.org> wrote:
> > > > >>
> > > > >> On Fri, 8 Dec 2023 at 19:00, Eric Curtin <ecurtin@redhat.com> wrote:
> > > > >>>
> > > > >>> We have been working on a new initial filesystem called initoverlayfs.
> > > > >>> It is a new filesystem that provides a more scalable approach to
> > > > >>> initial filesystems as opposed to just using initrds. We are writing
> > > > >>> this RFC to the systemd and dracut mailing lists (feel free to forward
> > > > >>> to UAPI group also) because although this solution works without
> > > > >>> changing the code in these projects, it operates in the same area as
> > > > >>> systemd, udev, dracut, etc. and uses these tools.
> > > > >>
> > > > >> It seems to me everything you described already exists? If you want to
> > > > >> avoid having an initrd -> rootfs transition, you can already do that -
> > > > >
> > > > > You need a initrd -> rootfs transition for generic linux operating
> > > > > systems right?
> > > >
> > > > No, you do not. Nothing stops you from running off initramfs (today you
> > > > do not really have init*RAM Disk* - the content of initrd is unpacked
> > > > into initramfs.
> > >
> > > Apologies if I am misinterpreting this response, I use terms initrd
> > > and initramfs
> > > interchangeably (not technically correct, but it's common to do this). The
> > > point is to avoid unpacking as much as possible, because in many initrds
> > > the majority of the software need not be unpacked, but is designed to work
> > > with throwaway initial filesystems.
> >
> > sd-stub already supports having a small initrd shipped in the UKI,
> > that is extended via sysexts, and systemd already supports running
> > from it, without any transition to a final rootfs. What else do you
> > need? What problem is this attempting to solve?
>
> I must give sd-stub a try. The bootloader I most commonly work with (and is one
> of the target platforms this is intended for) isn't UEFI, we need something more
> portable.

Do we, though? All modern hardware platforms (and VMs) that matter are
UEFI. Why would any of this be needed for legacy hardware platforms?
The existing mechanisms can work just fine on those until they reach
EOL, they won't stop working.
