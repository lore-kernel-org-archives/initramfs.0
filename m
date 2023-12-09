Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fo/ceSRJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23CE10E6
	for <initramfs@vger.kernel.org>; Sat,  9 Dec 2023 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702133017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G8ZhglJ/Pjp5nKfaE4PhxorKhqTlEQA6kV/ws26WmU8=;
	b=fo/ceSRJ7/CwKoT8Hpr1Z60N25wNXtm8qoHMviM92VTgYRMNlaqyNgp0qmma9gLC7wgspQ
	NXoxwK4/48gspxVCSb1mwEJEc+PNQKybYYsf/HYrhH425bbgBWoXZr3Mi3/awyZ6OTWppa
	/bXI9AqeoqxuAeLRRN3nqLH3kYnLDIU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-30rmBLuaOF6JzLNraLimOQ-1; Sat, 09 Dec 2023 09:43:35 -0500
X-MC-Unique: 30rmBLuaOF6JzLNraLimOQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2865681dcb4so2471280a91.3
        for <initramfs@vger.kernel.org>; Sat, 09 Dec 2023 06:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702133014; x=1702737814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8ZhglJ/Pjp5nKfaE4PhxorKhqTlEQA6kV/ws26WmU8=;
        b=XKY0AknbgtEGylCfv86BUqtijzj1GFIQ/O/kv8jwIXFlm5KAJZsQGAv7hIpGkpXnHY
         ZIUIFnbevxUGG9wOp9vL0BcdN05Lz1Qh3CdLF3MFaAcrvcNISwum9Fkw8TlTVxl7hXdX
         RBu+hGiL7Q8QsjlHRp+2C4nO/oq+kSec+4WKEXMYzYAj++MhP7+MYVz51hK3UkbryC8o
         Vpi4NuNncM89V13U/GApDwORFDgsjXxXMzIemslzzhEXFFGhCiYtzq9JeMOpnYj5x2kj
         CWyFobDIZv8/Z97CdVeIiQoXwxGk5BEkHLzCyoFFF5P/F/m6d8rlGwCa5s1nAUTIKFqx
         QGWg==
X-Gm-Message-State: AOJu0Yx5LD1nwDBXbCOcYiD3WP/P7jwHSjZovtccZeYDyp9esCEL81zQ
	NbsWE/f4dgkYnV6RwEfbObjCE3Ct3qUX0BqZ3Y+WxaaEjC+jAjlEwbo4w1Y9NYsHw7IcVn6TDt3
	MGd6ECZMl6DUU8g+5qIfHgxP9oFPYpFs7k9x1
X-Received: by 2002:a05:6a20:6714:b0:18c:41cd:c74d with SMTP id q20-20020a056a20671400b0018c41cdc74dmr878073pzh.5.1702133014328;
        Sat, 09 Dec 2023 06:43:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiWbSzL0I9UkD3yYAvBnoEh4CiovKnUvkBK1HgpLyTfRrw92GkeYqfOKxaO2q6qmFtR5msz6UsOL5qIDThrU4=
X-Received: by 2002:a05:6a20:6714:b0:18c:41cd:c74d with SMTP id
 q20-20020a056a20671400b0018c41cdc74dmr878065pzh.5.1702133014030; Sat, 09 Dec
 2023 06:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <CAMw=ZnRe_h6wmhYQStF8XaHTRYxF0YBbi4+aSuEZ5DOmgMbEkA@mail.gmail.com>
In-Reply-To: <CAMw=ZnRe_h6wmhYQStF8XaHTRYxF0YBbi4+aSuEZ5DOmgMbEkA@mail.gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Sat, 9 Dec 2023 14:42:58 +0000
Message-ID: <CAOgh=Fz9aVO3p=tWQuTtQf-+91dRxyFvNjCk9CGnzvbHWE0u-Q@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Luca Boccassi <bluca@debian.org>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org, 
	Yariv Rachmani <yrachman@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>, 
	Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Dec 2023 at 12:46, Luca Boccassi <bluca@debian.org> wrote:
>
> On Fri, 8 Dec 2023 at 19:00, Eric Curtin <ecurtin@redhat.com> wrote:
> >
> > We have been working on a new initial filesystem called initoverlayfs.
> > It is a new filesystem that provides a more scalable approach to
> > initial filesystems as opposed to just using initrds. We are writing
> > this RFC to the systemd and dracut mailing lists (feel free to forward
> > to UAPI group also) because although this solution works without
> > changing the code in these projects, it operates in the same area as
> > systemd, udev, dracut, etc. and uses these tools.
>
> It seems to me everything you described already exists? If you want to
> avoid having an initrd -> rootfs transition, you can already do that -

You need a initrd -> rootfs transition for generic linux operating
systems right? Or else you start building all sorts of things directly
into the kernel which isn't really scalable.

> the initrd code paths run because there's /etc/initrd-release, omit
> that and the transition/phase is avoided. If you want to have an
> overlay with r/o images, you can already do that with sysexts. You'll
> need to reimplement and maintain separately TPM support, LUKS support,
> fido2, etc etc

This is intended to be something you can use with or without sysexts,
not a competing alternative. There will be some reimplementations, but
our hope is to minimize that, leave as much as possible to systemd,
initoverlayfs stage, etc. where you don't pay the upfront cost for
decompressing and copying all the bytes.

We are open to executing minified systemd libraries/binaries in the
minified initramfs, we do that in the current version of storage-init
by calling systemd udev binaries.

>

