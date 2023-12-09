Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBJVvLPU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE8811F
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702144710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQmfPyhuAIvtc0i4ZUtex8OcVgTLNTzipCZe0JzsgVA=;
	b=XBJVvLPUvTJwM7Zs3eCRqVVEdDlVahur0ZIqzKBwmIIRtmGVUNPkn6puJRwKup/9vv7Kgl
	VarreOChDkid4fFC7/2hmmizIQ/ey9pM7ztWBv4IPcqNyTsavK7JcYjf3EayJpUZZ4dK8+
	EfPwa7W3czS2rm9NdpJsDFJrBFByafo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-7x6InxkINOqXLAVjcDxN2w-1; Sat, 09 Dec 2023 12:58:28 -0500
X-MC-Unique: 7x6InxkINOqXLAVjcDxN2w-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ced9c686easo1126826b3a.1
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 09:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702144707; x=1702749507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQmfPyhuAIvtc0i4ZUtex8OcVgTLNTzipCZe0JzsgVA=;
        b=MJ20A9vEV8lzdVmo2wW36kSCWoVGPXxnuxPYphL/4bMpWtFLLCs9Kp8MBFzzSI/d/f
         Gb4p8iYD66v/7vt+8vW/YZ9rfm2pipe+bsbbtPMFXDKK1rt4OGjFgwy+wfuKB9lbs4kR
         VHEez2JS/g4gpLj+aMgyg9+8FrkgrxajyJNH4BTI5B14wou09S3bEHiGneC1N0Kl6b2X
         /3DK0W6QxIbeRf9JbiMoYPnoxNCdbLWzgm8b82fLj3RZYFvstGUx5lP4ANMSBnlGkKOG
         Z3mx4FuhtM2JkK5yer1K1ONGNu0BQl9aPsXNyPXxPjVOJLVnM6iWQQRwVfc2kYAfKtzv
         97sA==
X-Gm-Message-State: AOJu0Yxsoq3yfhtRDoQ4WB7f/lOkknGbcgjilTOpWzl2GVgOXGVkMfGo
	MjwZukHiCYqYy7IEVomiNVtPg+zDDrqzGLQqaApfZL3EtA8bwp8spuWu2f+MtFLFsBLrKAdpUu/
	BVBu8d7ogIpZ7EkqXBSCD1GKAFwsfVGchUOUi
X-Received: by 2002:a17:90b:381:b0:286:6cc1:2cd1 with SMTP id ga1-20020a17090b038100b002866cc12cd1mr928007pjb.91.1702144707628;
        Sat, 09 Dec 2023 09:58:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAmeUmEjX+a5uIRV13P2md5jKcqsqDqLHP+/U7j7O7vmfoJDq0B9WleKDf3DRZH8pbY4mXZda4gGUXI1esYvU=
X-Received: by 2002:a17:90b:381:b0:286:6cc1:2cd1 with SMTP id
 ga1-20020a17090b038100b002866cc12cd1mr928002pjb.91.1702144707311; Sat, 09 Dec
 2023 09:58:27 -0800 (PST)
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
 <CAOgh=FwxR8gEXHnLqxjY_nabvg9uehY3Sqksq8LyakpVjh7AZA@mail.gmail.com> <CAMw=ZnQEk+LNUhbAzvhLnUOko16ARLyQ2eW4RmWtwHzBGsNq4Q@mail.gmail.com>
In-Reply-To: <CAMw=ZnQEk+LNUhbAzvhLnUOko16ARLyQ2eW4RmWtwHzBGsNq4Q@mail.gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Sat, 9 Dec 2023 17:57:50 +0000
Message-ID: <CAOgh=FyyrehtCNxcpo3HV7Yxn9Uv_Gout2t_os-pGCZcSgA3ew@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Luca Boccassi <bluca@debian.org>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, systemd-devel@lists.freedesktop.org, 
	initramfs@vger.kernel.org, Yariv Rachmani <yrachman@redhat.com>, 
	Stephen Smoogen <ssmoogen@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Dec 2023 at 17:46, Luca Boccassi <bluca@debian.org> wrote:
>
> On Sat, 9 Dec 2023 at 17:25, Eric Curtin <ecurtin@redhat.com> wrote:
> >
> > On Sat, 9 Dec 2023 at 17:19, Luca Boccassi <bluca@debian.org> wrote:
> > >
> > > On Sat, 9 Dec 2023 at 15:08, Eric Curtin <ecurtin@redhat.com> wrote:
> > > >
> > > > On Sat, 9 Dec 2023 at 14:56, Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> > > > >
> > > > > On 09.12.2023 17:42, Eric Curtin wrote:
> > > > > > On Sat, 9 Dec 2023 at 12:46, Luca Boccassi <bluca@debian.org> wrote:
> > > > > >>
> > > > > >> On Fri, 8 Dec 2023 at 19:00, Eric Curtin <ecurtin@redhat.com> wrote:
> > > > > >>>
> > > > > >>> We have been working on a new initial filesystem called initoverlayfs.
> > > > > >>> It is a new filesystem that provides a more scalable approach to
> > > > > >>> initial filesystems as opposed to just using initrds. We are writing
> > > > > >>> this RFC to the systemd and dracut mailing lists (feel free to forward
> > > > > >>> to UAPI group also) because although this solution works without
> > > > > >>> changing the code in these projects, it operates in the same area as
> > > > > >>> systemd, udev, dracut, etc. and uses these tools.
> > > > > >>
> > > > > >> It seems to me everything you described already exists? If you want to
> > > > > >> avoid having an initrd -> rootfs transition, you can already do that -
> > > > > >
> > > > > > You need a initrd -> rootfs transition for generic linux operating
> > > > > > systems right?
> > > > >
> > > > > No, you do not. Nothing stops you from running off initramfs (today you
> > > > > do not really have init*RAM Disk* - the content of initrd is unpacked
> > > > > into initramfs.
> > > >
> > > > Apologies if I am misinterpreting this response, I use terms initrd
> > > > and initramfs
> > > > interchangeably (not technically correct, but it's common to do this). The
> > > > point is to avoid unpacking as much as possible, because in many initrds
> > > > the majority of the software need not be unpacked, but is designed to work
> > > > with throwaway initial filesystems.
> > >
> > > sd-stub already supports having a small initrd shipped in the UKI,
> > > that is extended via sysexts, and systemd already supports running
> > > from it, without any transition to a final rootfs. What else do you
> > > need? What problem is this attempting to solve?
> >
> > I must give sd-stub a try. The bootloader I most commonly work with (and is one
> > of the target platforms this is intended for) isn't UEFI, we need something more
> > portable.
>
> Do we, though? All modern hardware platforms (and VMs) that matter are
> UEFI. Why would any of this be needed for legacy hardware platforms?
> The existing mechanisms can work just fine on those until they reach
> EOL, they won't stop working.

Respectfully, this is not true. Especially on ARM platforms. I would
like it to be true, but it's not true today.

I should have expanded, we are not trying to avoid transitioning to a
final rootfs, the goal is to transition to a final rootfs. But not to decompress
and copy all the bytes to a tmpfs up front, rather use something like erofs,
overlayfs, etc. sysexts uses erofs+overlayfs, but it's designed with
a different goal in mind.

>

