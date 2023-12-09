Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CBB10DA
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 09:19:27 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5d3758fdd2eso29562167b3.0
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 09:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702142367; x=1702747167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WD6XTtw0Q1MJ282OoaC82d2feh7XYmOQ5Hcm4mDWPjU=;
        b=iumqbaxD1XwmX8yhBAj/pU1hV0nVOIP150y7JVUMh2rw/oSHDl0avroLJaU5FWS2NL
         szKWahiW6ItIZxRMEVAskRpPyi5/5Ny6fyVZ7oP7eBNoSTHfr1lKcWMqsyQun7Tb0aoH
         +2XcKnyb6HbR8n3cJhN8XO9smu3L3TMX8nawBaVdVaqcyg+qBqWR08iFAxuUIsH4jvCA
         FafNSmpBweOmWTJQ1wj3vFz7SYa/MVIM1MPnBolZD4yzZeJuREcwwBQZgUKytBpkwEut
         4ADX3ca1Xyb8T3oWaJY9YteX/PwFI1w6bEeQ9Q4pfF+0oT49nkH0bD7XbgQSdnMLf42G
         DKIA==
X-Gm-Message-State: AOJu0YzoE3zX17bDGq2jcq9aLODTZxmyre+qRkqAmmHhSgQfFtCyxIYa
	MUZelgMIrtgz+G76bPcD4kCQJuapaI0SAQ==
X-Google-Smtp-Source: AGHT+IHf6DOqshrOLej+N/wOpczixzjvRyIZTFPuz7ePyQDLF8/PIHukFHcauKCDbJ/Ki/BQnedXtw==
X-Received: by 2002:a81:4e17:0:b0:5de:7c46:8eb with SMTP id c23-20020a814e17000000b005de7c4608ebmr1197909ywb.80.1702142366801;
        Sat, 09 Dec 2023 09:19:26 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id r5-20020a818105000000b005a7f676f305sm1576673ywf.106.2023.12.09.09.19.26
        for <initramfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 09:19:26 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-db53f8cf4afso2823145276.3
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 09:19:26 -0800 (PST)
X-Received: by 2002:a25:50c8:0:b0:db5:4238:631c with SMTP id
 e191-20020a2550c8000000b00db54238631cmr1115407ybb.6.1702142366365; Sat, 09
 Dec 2023 09:19:26 -0800 (PST)
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
From: Luca Boccassi <bluca@debian.org>
Date: Sat, 9 Dec 2023 17:19:13 +0000
X-Gmail-Original-Message-ID: <CAMw=ZnQ7eu7Czy0W5fh8TtM8y3+MGwdubZrrw6612ZTTBY8eWA@mail.gmail.com>
Message-ID: <CAMw=ZnQ7eu7Czy0W5fh8TtM8y3+MGwdubZrrw6612ZTTBY8eWA@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Eric Curtin <ecurtin@redhat.com>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, systemd-devel@lists.freedesktop.org, 
	initramfs@vger.kernel.org, Yariv Rachmani <yrachman@redhat.com>, 
	Stephen Smoogen <ssmoogen@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Dec 2023 at 15:08, Eric Curtin <ecurtin@redhat.com> wrote:
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

sd-stub already supports having a small initrd shipped in the UKI,
that is extended via sysexts, and systemd already supports running
from it, without any transition to a final rootfs. What else do you
need? What problem is this attempting to solve?
