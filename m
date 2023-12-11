Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXPClQaY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F10B6
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 04:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702299165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kBOL0WC07NZaJqHJ3B9oi/jGwBBAMq/itGo9x3YIlo=;
	b=RXPClQaYCpmqVhSbwxBfqfWTOn72Fw7FWwG5UvSX2X1DEb4VGXsA4BEi1h5ICzWUqwZh1i
	znBifFq6InDu4U5RK5lCUkVov+XKg7d7mOD6mwvdcPZrKPhg2GoSq7ipVxSOrbLQBcr7Lu
	uz0ngcOfE3qpyiWlvyPo7dyNTbUhyvE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Rxu3REzeNGemFYEmT7FjWw-1; Mon, 11 Dec 2023 07:52:44 -0500
X-MC-Unique: Rxu3REzeNGemFYEmT7FjWw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2888414ac91so2605120a91.2
        for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 04:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702299163; x=1702903963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kBOL0WC07NZaJqHJ3B9oi/jGwBBAMq/itGo9x3YIlo=;
        b=jXjTItIV1yY4L0q8PfNrhWulkU9RUClt6zxoN4HrwhCh19b8t9ZfYkivVYBdsOmqlq
         TFx40aNzVZ/G00Hs/j+okZbUXDYO3kDjHbUX55VEZe3Ytrn8lb/tqsecyZ/pY4AIf9Hv
         bDoGUz/TvA2b5MD9YHs4GGSwnbHXCQQAYtAYGeuRFmgNE7JXRCxadSpkbaf0EbKeq6PE
         tj9ihqvxzA7VPY8vzqbrLEeuYrGtqtnNjyfNmcKfHrvunPPIb0Fk7uisgPHaN0X3ua4q
         IDLuA2ROwTzqVeOjDAdzAislyXUJe2YYqaO0+m2fa0oCLTdQuC62zPCIR46Zs81M2WJO
         RF0g==
X-Gm-Message-State: AOJu0YxbYfyBfPwZ2s2ZLlyEs5VZW9kz39yPPWjvCgd3AfpXEFRGe5Tx
	GF+AMXTJzW+jc1MuX1bHPR18ahLs7b4Ud0H7DUhMF7z9JHYteacauFm+WMfJsF5ddmYVkdOCpv2
	etsp3wlrPwPOj9eh2GKWX9DDjnuUMiBI+Mgxt61u9U6x9zv5kFg==
X-Received: by 2002:a17:90a:5797:b0:286:6cc1:5fde with SMTP id g23-20020a17090a579700b002866cc15fdemr1681604pji.97.1702299163385;
        Mon, 11 Dec 2023 04:52:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGI8zr0PYchKSwtatW1ZwruJi3dNHncJ/feOWOEtID2fEce60vMighP4RERZD6oTMptO4OsnSTJGTWkSdyR4M=
X-Received: by 2002:a17:90a:5797:b0:286:6cc1:5fde with SMTP id
 g23-20020a17090a579700b002866cc15fdemr1681594pji.97.1702299163034; Mon, 11
 Dec 2023 04:52:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login> <CAOgh=Fxy8pKipkfKvk62_WfBVUrkM865a9TRLF=oHC2u_jjZKQ@mail.gmail.com>
 <CAOgh=FwinY1KG=2mKvosQ1GX83hHsAdEC2WVob-irvFSum1NVA@mail.gmail.com>
 <ZXb3xhSswgjQAwlL@gardel-login> <CAOgh=FxHsOpDA7izWEd=eA886op17gdTFJPebxnvEwNOmWEyKQ@mail.gmail.com>
In-Reply-To: <CAOgh=FxHsOpDA7izWEd=eA886op17gdTFJPebxnvEwNOmWEyKQ@mail.gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Mon, 11 Dec 2023 12:52:06 +0000
Message-ID: <CAOgh=Fxm7vQm0fxZc27zPNAQW95Bkarp8s8cJ8G3fdvnaiT4wg@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Lennart Poettering <lennart@poettering.net>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org, 
	Yariv Rachmani <yrachman@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>, 
	Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Dec 2023 at 12:48, Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Mon, 11 Dec 2023 at 11:51, Lennart Poettering <lennart@poettering.net> wrote:
> >
> > On Mo, 11.12.23 11:28, Eric Curtin (ecurtin@redhat.com) wrote:
> >
> > > > > For the items listed above I think you can find different solutions
> > > > > which do not necessarily compromise security as much.
> > > > >
> > > > > So, in the list above you could address the latter three like this:
> > > > >
> > > > > 2. Use an erofs rather than a packed cpio as initrd. Make the boot
> > > > >    loader load the erofs into contigous memory, then use memmap=X!Y on
> > > > >    the kernel cmdline to synthesize a block device from that, which
> > > > >    you then mount directly (without any initrd) via
> > > > >    root=/dev/pmem0. This means yout boot loader will still load the
> > > > >    whole image into memory, but only decompress the bits actually
> > > > >    neeed. (It also has some other nice benefits I like, such as an
> > > > >    immutable rootfs, which tmpfs-based initrds don't have.)
> > >
> > > What I am unsure about here, is the "make the bootloader load the
> > > erofs into contiguous memory" part. I wonder could we try and use the
> > > existing initramfs data as is.
> >
> > Today's initrds are packed cpio archives of an OS file system
> > hierarchy. What I proposed means you'd have to put the OS file system
> > hiearchy into an erofs image instead. Which is a trivial operation,
> > just unpack and repack.
> >
> > Note that there are two concepts of "initrd" out there.
> >
> > a) from the kernel perspective an initrd/initramfs (which both are
> >    badly named, because its a tmpfs these days) is that packed cpio
> >    archive that is unpacked into a tmpfs, and then jumped into.
> >
> > b) from systemd's perspective an initrd is an OS image that carries an
> >    /etc/initrd-release file. If that file exists then systemd will not
> >    boot up the system regularly, but instead just prepare everything
> >    that it can transition into some other root fs.
> >
> > While most often in real life the initrds currently qualify under both
> > definitions. But there's no reason to always do this. You can also
> > have images the kernel would consider an initrd, but systemd does not,
> > which is something we use in the "USI" concept, i.e. "unified system
> > images", which are basically UKIs (large UKIs) with a complete rootfs
> > that is the main system of the OS. And you can also do it the other
> > way round, which is potentially what I am suggesting to you here: use
> > an erofs image that would not be considered an initrd by the kernel,
> > but that systemd would consider one, and transition out of.
> >
> > > I dunno if
> > > bootloaders make much assumptions about the format of that data, worst
> > > case scenario we could encapsulate erofs in the initramfs, cpio looking
> > > data.
> >
> > boot loaders generally don't bother with the cpio, it's just "data"
> > for them. Compression algorithms have changed in the past, and it only
> > mattered that the kernel could decompress it, the boot loader doesn't care.
> >
> > > Teach the kernel not to decompress and process the whole
> > > thing and mount it like an erofs alternatively. Does this sound crazy
> > > or reasonable?
> >
> > You are re-inventing the traditional "initrd" logic of the kernel
> > which was a ramdisk (i.e. a block device /dev/ram0), that was filled
> > with some fs of your choice loaded by the boot loader.
>
> Sort of yes, but preferably using that __initramfs_start /
> initrd_start buffer as is without copying any bytes anywhere else and
> without teaching the bootloaders to do things.
>
> The "memmap=" approach you suggested sounds like what we are thinking,
> but do you think we could do this without teaching bootloaders to do
> new things?

Like could we do that with a "initrd3.0=on" karg and it just uses the
__initramfs_start and __initramfs_size to memmap? (that probably
wouldn't be the arg name, it's just for description purposes here,
maybe it's even a build time flag, etc.)

>
> Although the nice thing about a storage-init like approach is there's
> basically zero copies up front. What storage-init is trying to be, is
> a tool to just call systemd storage things, without also inheriting
> all the systemd stack.
>
> >
> > Lennart
> >
> > --
> > Lennart Poettering, Berlin
> >

