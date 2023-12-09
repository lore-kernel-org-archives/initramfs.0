Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWLntk5g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F0110DF
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702142724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qu2slhtt+67ifGuOKDOY6IDGXzJxGuiY7hSSLqfL9Jw=;
	b=XWLntk5gqmDnc/ZL+zHhRY/9qReQSfX7cQSc6inWMqNoKpxf+p0Km8YgZpfxN5U0voTWNs
	xlfYmU6BXDnjQiRfI7HFtXvHq8SI85MAPAOehDBeGnGrxckDK/J8xgKgtkP36mV5ZNVHxd
	kn/ya/b6AYPWR+4XHfLxI6bsfkv+2V4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-vnDVnRnIOKyGcUTg3DM6zg-1; Sat, 09 Dec 2023 12:25:22 -0500
X-MC-Unique: vnDVnRnIOKyGcUTg3DM6zg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ce99cc5f83so2611075b3a.0
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 09:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702142721; x=1702747521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qu2slhtt+67ifGuOKDOY6IDGXzJxGuiY7hSSLqfL9Jw=;
        b=h8hIyjWgrjSRjlFl+UIh/nDn2FzJ0TZklxmKzBLXwiNos8GmUnOj40/TCUkS8eLxrk
         l3GLkBH5nGQHAPQEgSrvkhptBv4e3PJ8wFMTD0Zg2mx17YZWWB+GimwsnyHKISnM5Q/d
         eX6rITqaBX4MlWZRMiK+s1LpgJckjBmSRvPGFZtsj65fSci2uq/iENg6bValE2k5HIwE
         WdIgD7Aue2wL7iRvDbkQUW6B1K/1jZol3QCzCD3ZAt1q+k4rfiQEptGFlGr4WtxCzNY2
         aZxLLSoatMdtVtY5jlRa1UQFTpuBeE0GCwrT/qg4lrmgU+CetOFlaxBhDqlUMlALSJOI
         bgmg==
X-Gm-Message-State: AOJu0YxfZyLiYZijqXPgwBwZ2NkKKLV25GuDreAmceTwNzW8G0sZEWUo
	XfasmUxWg0tlzN2gB+Udq7XDcuohOVp81MPUuQdykA0PdpNxzNjv9dZPgi27Fznrjw6Rzfhc/He
	z31qxq2OlcLNaGymiVyPk1RsBttzVd5CX93BG
X-Received: by 2002:a05:6a21:182:b0:190:1460:731d with SMTP id le2-20020a056a21018200b001901460731dmr1287411pzb.32.1702142721084;
        Sat, 09 Dec 2023 09:25:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5frGbyN2N8Pnh/AU9nVdQY85FHx0DRQu3uTbxC/z1+tfhWbFSJeCk0m1ydOw1XbI2ia9WJjK9/0bd4AxJaoc=
X-Received: by 2002:a05:6a21:182:b0:190:1460:731d with SMTP id
 le2-20020a056a21018200b001901460731dmr1287403pzb.32.1702142720772; Sat, 09
 Dec 2023 09:25:20 -0800 (PST)
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
In-Reply-To: <CAMw=ZnQ7eu7Czy0W5fh8TtM8y3+MGwdubZrrw6612ZTTBY8eWA@mail.gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Sat, 9 Dec 2023 17:24:44 +0000
Message-ID: <CAOgh=FwxR8gEXHnLqxjY_nabvg9uehY3Sqksq8LyakpVjh7AZA@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Luca Boccassi <bluca@debian.org>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, systemd-devel@lists.freedesktop.org, 
	initramfs@vger.kernel.org, Yariv Rachmani <yrachman@redhat.com>, 
	Stephen Smoogen <ssmoogen@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Dec 2023 at 17:19, Luca Boccassi <bluca@debian.org> wrote:
>
> On Sat, 9 Dec 2023 at 15:08, Eric Curtin <ecurtin@redhat.com> wrote:
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
>
> sd-stub already supports having a small initrd shipped in the UKI,
> that is extended via sysexts, and systemd already supports running
> from it, without any transition to a final rootfs. What else do you
> need? What problem is this attempting to solve?

I must give sd-stub a try. The bootloader I most commonly work with (and is one
of the target platforms this is intended for) isn't UEFI, we need something more
portable.

Is mise le meas/Regards,

Eric Curtin

>

