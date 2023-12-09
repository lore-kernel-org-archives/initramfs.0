Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3orY2WB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF801710
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 07:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702134483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fXjk/oLtF2cnJuVFDsajMAgHa63jRMZqgHYpOcTOyQ=;
	b=X3orY2WB0UKlGwRWEMolFbYW/1hwuTugDIz7HQig+xPB4xM8rlxDlfqJD6D2PSeKmFG8rZ
	zIWV2eKEWuyosIYkxReOcp1Z9C/GcKd7OFWgglIdF5Xxv0mjlcM6Fbz/jAlPWRNQUYYcI3
	Qybp03e+B2/lpT/Ft6Wo5DZmQTNbK94=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-LrFYNvyIOKu0_O6FepWmtQ-1; Sat, 09 Dec 2023 10:08:01 -0500
X-MC-Unique: LrFYNvyIOKu0_O6FepWmtQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6cee63b2b58so596697b3a.1
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 07:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702134481; x=1702739281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fXjk/oLtF2cnJuVFDsajMAgHa63jRMZqgHYpOcTOyQ=;
        b=f6caNjE1TV+x6vxd3LLq/40GUeCl6g/dXziAr9dzbUvbK5rAhbNOdxeBCMxIQCzpul
         +VPb8L5non2dNCSoDMp6qXylnjoVlzZ3dSTtzCa+zXPWVFSMooepzaiFwMwp5jQgAfee
         wxf/Rwara3n8THo2nwECTH+3e7maUouc+Eys5hUnoA2/NtJ6Oemp833p0xrTIQQ+mWX2
         28z89uYd18ye9slpnl+kwVJKoPHD4zzDoMTePHZm+7VhM29ckYlUUomHHLh7XbouKln/
         3hyx06DvK2JY4iAtJedUYXv46z9gc9hM5mMwC4OsbECQzcZrZJEIOq1FjcY4Lu99OP6F
         cCNw==
X-Gm-Message-State: AOJu0YzbJqxeXcozoj1LH1SCmAnB1ZuLs3aWzay++Plx2vprnN3wRjlp
	VgFRgi4KxDFnW8NhN+nhLt9Y6VibnJLu4PswfaBfSx0nZlIyQyQNCq09TNra2lOcXTH2V8jiOb5
	3RzHZ7QZcbYhgAJr4851fjJmlB07BA/w+s8EG
X-Received: by 2002:a05:6a20:12c7:b0:18a:fbd1:8e6d with SMTP id v7-20020a056a2012c700b0018afbd18e6dmr797329pzg.27.1702134480777;
        Sat, 09 Dec 2023 07:08:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnWmM8KtGoHgZJVmN16KyYuTA1JjFZSRnkS8xvPvch/RPWCoDUqGOZXThJXiul1Am2OQHFTS1MiQ4EvpSkBR0=
X-Received: by 2002:a05:6a20:12c7:b0:18a:fbd1:8e6d with SMTP id
 v7-20020a056a2012c700b0018afbd18e6dmr797319pzg.27.1702134480487; Sat, 09 Dec
 2023 07:08:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <CAMw=ZnRe_h6wmhYQStF8XaHTRYxF0YBbi4+aSuEZ5DOmgMbEkA@mail.gmail.com>
 <CAOgh=Fz9aVO3p=tWQuTtQf-+91dRxyFvNjCk9CGnzvbHWE0u-Q@mail.gmail.com> <ac1728d2-1e85-41fb-876b-adb98f0d2dff@gmail.com>
In-Reply-To: <ac1728d2-1e85-41fb-876b-adb98f0d2dff@gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Sat, 9 Dec 2023 15:07:24 +0000
Message-ID: <CAOgh=FyGVnyz-5TF_kDbHu+THESCRJ3sJ6HFBfWB_YGj93AzfQ@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: Luca Boccassi <bluca@debian.org>, systemd-devel@lists.freedesktop.org, 
	initramfs@vger.kernel.org, Yariv Rachmani <yrachman@redhat.com>, 
	Stephen Smoogen <ssmoogen@redhat.com>, Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Dec 2023 at 14:56, Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>
> On 09.12.2023 17:42, Eric Curtin wrote:
> > On Sat, 9 Dec 2023 at 12:46, Luca Boccassi <bluca@debian.org> wrote:
> >>
> >> On Fri, 8 Dec 2023 at 19:00, Eric Curtin <ecurtin@redhat.com> wrote:
> >>>
> >>> We have been working on a new initial filesystem called initoverlayfs.
> >>> It is a new filesystem that provides a more scalable approach to
> >>> initial filesystems as opposed to just using initrds. We are writing
> >>> this RFC to the systemd and dracut mailing lists (feel free to forward
> >>> to UAPI group also) because although this solution works without
> >>> changing the code in these projects, it operates in the same area as
> >>> systemd, udev, dracut, etc. and uses these tools.
> >>
> >> It seems to me everything you described already exists? If you want to
> >> avoid having an initrd -> rootfs transition, you can already do that -
> >
> > You need a initrd -> rootfs transition for generic linux operating
> > systems right?
>
> No, you do not. Nothing stops you from running off initramfs (today you
> do not really have init*RAM Disk* - the content of initrd is unpacked
> into initramfs.

Apologies if I am misinterpreting this response, I use terms initrd
and initramfs
interchangeably (not technically correct, but it's common to do this). The
point is to avoid unpacking as much as possible, because in many initrds
the majority of the software need not be unpacked, but is designed to work
with throwaway initial filesystems.

>
> > Or else you start building all sorts of things directly
> > into the kernel which isn't really scalable.
> >
>
> See above.
>

