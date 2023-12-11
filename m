Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRVmx6We"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292D5A6
	for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 03:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702294163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vM0t8hPViA0eNOP9SZVmgjJzGSN6Lkze/xSvcWSZIIc=;
	b=CRVmx6WeadihrGccOjKzRBVCNbVUkXeLuBNw2bd4IKg5rqFzUiSRC9zbz3Xgzuu3f8mzyX
	ruQfPLIxiAYYp52Miv3xDl4/NHTqwY6s/HHtAijF3HpghTxEFfcwNV6jPFsVraQsizQaZ7
	g/B4ZLIoKZ9hFlG1jjK3989j/7FP0mk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-eltt-JK_P1WUpogEpkO8Eg-1; Mon, 11 Dec 2023 06:29:22 -0500
X-MC-Unique: eltt-JK_P1WUpogEpkO8Eg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-286a4fc4e9eso5263266a91.2
        for <initramfs@vger.kernel.org>; Mon, 11 Dec 2023 03:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702294161; x=1702898961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vM0t8hPViA0eNOP9SZVmgjJzGSN6Lkze/xSvcWSZIIc=;
        b=AVEps0Kc2LDDi+ZX3fzjGam1nqUkjo4/74u8NOZO9REhSEqupiL0aJg5d+/J3olXc3
         lRkb5hVpRPTxGX4SiJyl9okpi8sZ6wlzmm0v9CjjehgOMO+WtdkoCcdWks+qq/ThV5dG
         taXrsTsjaWzzn2jgZ4EuuQQ9NCMWQtNPM5rN65cy9mjYvwmLw36wZ8e9guNXep/Nlf2a
         eZ4wO7jL2U6DxSiwB+nGmOMIJjNtbX+03ntl1FBtRLgAMXKEsgIrU9B6q/4mQZUnjsx2
         ui4DSbCrxrFU7uKaDFYtOKwjbJb1reklMUSQ2GliaHTLNT0cuyCnAHVyb3HT05LmWqiu
         mvGQ==
X-Gm-Message-State: AOJu0YwFQO/C4sz4XShFfSxu34RydHhuQWFy5veT12+qTpT+BfEfsWrh
	QCSIPLVkHuBhv7NdnIo9FAVUogNGh7kgLEWQEGH6MT2PZxEQdiHlAdBSjVqLDuUrRGCU/BX8A30
	XG6yAmXgJu7CjhYQRBz47y+iTNHmuQJkou+/v
X-Received: by 2002:a17:90a:d255:b0:286:6cc0:cada with SMTP id o21-20020a17090ad25500b002866cc0cadamr2898450pjw.81.1702294161165;
        Mon, 11 Dec 2023 03:29:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxHso+6k1LmR/YGxDMldUYsTSj+zUxI6xR6082MNA2fcLivis+gvYsHoE1U1Zh0v4QDdP9kIFAlrjfGiH0iHo=
X-Received: by 2002:a17:90a:d255:b0:286:6cc0:cada with SMTP id
 o21-20020a17090ad25500b002866cc0cadamr2898442pjw.81.1702294160791; Mon, 11
 Dec 2023 03:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOgh=Fwbv7sUpHBACNNtXK+keQVBJZ1C-tonoYQtGNNY1ukpTw@mail.gmail.com>
 <ZXbdJp1Vz8M8c1MS@gardel-login> <CAOgh=Fxy8pKipkfKvk62_WfBVUrkM865a9TRLF=oHC2u_jjZKQ@mail.gmail.com>
In-Reply-To: <CAOgh=Fxy8pKipkfKvk62_WfBVUrkM865a9TRLF=oHC2u_jjZKQ@mail.gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Mon, 11 Dec 2023 11:28:44 +0000
Message-ID: <CAOgh=FwinY1KG=2mKvosQ1GX83hHsAdEC2WVob-irvFSum1NVA@mail.gmail.com>
Subject: Re: [RFC] initoverlayfs - a scalable initial filesystem
To: Lennart Poettering <mzerqung@0pointer.de>
Cc: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org, 
	Yariv Rachmani <yrachman@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>, 
	Douglas Landgraf <dlandgra@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Dec 2023 at 11:20, Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Mon, 11 Dec 2023 at 10:06, Lennart Poettering <mzerqung@0pointer.de> wrote:
> >
> > On Fr, 08.12.23 17:59, Eric Curtin (ecurtin@redhat.com) wrote:
> >
> > > Here is the boot sequence with initoverlayfs integrated, the
> > > mini-initramfs contains just enough to get storage drivers loaded and
> > > storage devices initialized. storage-init is a process that is not
> > > designed to replace init, it does just enough to initialize storage
> > > (performs a targeted udev trigger on storage), switches to
> > > initoverlayfs as root and then executes init.
> > >
> > > ```
> > > fw -> bootloader -> kernel -> mini-initramfs -> initoverlayfs -> rootfs
> > >
> > > fw -> bootloader -> kernel -> storage-init   -> init ----------------->
> > > ```
> >
> > I am not sure I follow what these chains are supposed to mean? Why are
> > there two lines?
>
> The top line is the filesystem transition, the bottom is more like a
> process perspective. Will make this clearer in future.
>
> >
> > So, I generally would agree that the current initrd scheme is not
> > ideal, and we have been discussing better approaches. But I am not
> > sure your approach really is useful on generic systems for two
> > reasons:
> >
> > 1. no security model? you need to authenticate your initrd in
> >    2023. There's no execuse to not doing that anymore these days. Not
> >    in automotive, and not anywhere else really.
>
> Yes you are right, there is no excuse, the plan was to mount using
> dm-verity most likely with the details from the initramfs, but
> admittedly we had not looked into that into great detail.
>
> >
> > 2. no way to deal with complex storage? i.e. people use FDE, want to
> >    unlock their root disks with TPM2 and similar things. People use
> >    RAID, LVM, and all that mess.
>
> We had 3 thoughts on this:
>
> 1. Just worry about the common use-cases and leave everyone else
> fallback to the approaches we use today.
> 2. Try and split up systemd to make it even smaller. We do use
> systemd-udev in the small initramfs storage-init process so far.
> 3. Reimplement some things? But as little as possible, on a case by
> case basis, we certainly don't want to fall into the trap of rewriting
> systemd that's for sure, systemd does these things very well.
>
> Tbh, if we try and implement this in kernelspace a lot of these
> questions go away. You just teach the kernel to deal with the
> filesystem image early (say erofs or whatever other filesystem) and
> have that data where initramfs data currently is. You still pay for
> the initial read, but you still save a bunch of kernel time.
>
> >
> > Actually the above are kinda the same problem in a way: you need
> > complex storage, but if you need that you kinda need udev, and
> > services, and then also systemd and all that other stuff, and that's
> > why the system works like the system works right now.
>
> True, but there is also a bunch of stuff in current initrd's today
> that aren't required to mount basic storage, but are designed around
> the whole idea of having an early throwaway filesystem.
>
> >
> > Whenever you devise a system like yours by cutting corners, and
> > declaring that you don't want TPM, you don't want signed initrds, you
> > don't want to support weird storage, you just solve your problem in a
> > very specific way, ignoring the big picture. Which is OK, *if* you can
> > actually really work without all that and are willing to maintain the
> > solution for your specific problem only.
> >
> > As I understand you are trying to solve multiple problems at once
> > here, and I think one should start with figuring out clearly what
> > those are before trying to address them, maybe without compromising on
> > security. So my guess is you want to address the following:
> >
> > 1. You don't want the whole big initrd to be read off disk on every
> >    boot, but only the parts of it that are actually needed.
> >
> > 2. You don't want the whole big initrd to be fully decompressed on every
> >    boot, but only the parts of it that are actually needed.
> >
> > 3. You want to share data between root fs and initrd
> >
> > 4. You want to save some boot time by not bringing up an init system
> >    in the initrd once, then tearing it down again, and starting it
> >    again from the root fs.
>
> It's mainly the top 3 that were the goals. And that people have the
> freedom to consider using heavier weight generic libraries, tools,
> etc. if they want. You want to use Rust (or languages X, Y, Z) to
> write something early boot, go ahead! You'll only pay the cost for the
> larger binary if you actually use it. The week I started tinkering at
> this, there was a mini-debate on whether we should include glib or not
> in the initrd. And we are regularly under pressure to reduce boot time
> at the moment.
>
> Number 4 was a convenient way to do an early version of this, stick a
> process in between systemd and the kernel. But it turns out, it works
> very well, the only problem is the reimplementation problem really.
>
> Theoretically this could be systemd-storage-init -> systemd also. Or
> systemd and dlopen more libraries as they become available later down
> the line.
>
> >
> > For the items listed above I think you can find different solutions
> > which do not necessarily compromise security as much.
> >
> > So, in the list above you could address the latter three like this:
> >
> > 2. Use an erofs rather than a packed cpio as initrd. Make the boot
> >    loader load the erofs into contigous memory, then use memmap=X!Y on
> >    the kernel cmdline to synthesize a block device from that, which
> >    you then mount directly (without any initrd) via
> >    root=/dev/pmem0. This means yout boot loader will still load the
> >    whole image into memory, but only decompress the bits actually
> >    neeed. (It also has some other nice benefits I like, such as an
> >    immutable rootfs, which tmpfs-based initrds don't have.)

What I am unsure about here, is the "make the bootloader load the
erofs into contiguous memory" part. I wonder could we try and use the
existing initramfs data as is. I dunno if
bootloaders make much assumptions about the format of that data, worst
case scenario we could encapsulate erofs in the initramfs, cpio looking
data. Teach the kernel not to decompress and process the whole
thing and mount it like an erofs alternatively. Does this sound crazy
or reasonable?
Sometimes you cannot change the code in a bootloader and it would be
nice if we could avoid introducing another layer of bootloader.


>
> Yes, lets explore this approach with the kernel community to gather
> their thoughts. I'm still happy I did the userspace version first,
> even if we end up doing it in kernelspace because it allowed me to
> test on various pieces of hardware to see if the benefits are genuine
> and they are....
>
> >
> > 3. Simply never transition to the root fs, don't marke the initrds in
> >    systemd's eyes as an initrd (specifically: don't add an
> >    /etc/initrd-release file to it). Instead, just merge resources of
> >    the root fs into your initrd fs via overlayfs. systemd has
> >    infrastructure for this: "systemd-sysext". It takes immutable,
> >    authenticated erofs images (with verity, we call them "DDIs",
> >    i.e. "discoverable disk images") that it overlays into /usr/. [You
> >    could also very nicely combine this approach with systemd's
> >    portable services, and npsawn containers, which operate on the same
> >    authenticated images]. At MSFT we have a major product that works
> >    exactly like this: the OS runs off a rootfs that is loaded as an
> >    initrd, and everything that runs on top of this are just these
> >    verity disk images, using overlayfs and portable services.
> >
> > 4. The proposal in 3 also addresses goal 4.
> >
>
> I'm hoping we can benefit both use cases, the case where you want to
> transition to a rootfs and the case where you never want to transition
> to a rootfs.
>
> > Which leaves item 1, which is a bit harder to address. We have been
> > discussing this off an on internally too. A generic solution to this
> > is hard. My current thinking for this could be something like this,
> > covering the UEFI world: support sticking a DDI for the main initrd in
> > the ESP. The ESP is per definition unencrypted and unauthenticated,
> > but otherwise relatively well defined, i.e. known to be vfat and
> > discoverable via UUID on a GPT disk. So: build a minimal
> > single-process initrd into the kernel (i.e. UKI) that has exactly the
> > storage to find a DDI on the ESP, and set it up. i.e. vfat+erofs fs
> > drivers, and dm-verity. Then have a PID 1 that does exactly enough to
> > jump into the rootfs stored in the ESP. That latter then has proper
> > file system drivers, storage drivers, crypto stack, and can unlock the
> > real root. This would still be a pretty specific solution to one set
> > of devices though, as it could not cover network boots (i.e. where
> > there is just no ESP to boot from), but I think this could be kept
> > relatively close, as the logic in that case could just fall back into
> > loading the DDI that normally would still in the ESP fully into
> > memory.
> >
>
> I'm certainly a little biased here because I work with ARM, I would
> like it to be UEFI world, but it's not and convincing every SoC vendor
> you must use UEFI is hard. I know a UEFI covering solution only would
> not have much value for my team at least.
>
> > (If you are focussing on systems lacking UEFI, then replace the word
> > "ESP" in the above with a similar concept, i.e. a well discoverable,
> > unauthenticated relatively simple file system, such as vfat).
>
> Yeah, agree, this baseline, I think, is common enough to assume. Like
> Android Boot Images as an example are basically a UKI binary stuff in
> a boot partition.
>
> >
> > Anyway, I can't tell you how to solve your specific problems, but if
> > there's one thing I'd suggest you to keep in mind then it's the
> > security angle, i.e. keep in mind from the beginning how
> > authentication of every component of your process shall work, how
> > unatteneded disk encryption shall operate and how measurement shall
> > work. Security must be built into things from the beginning, not be
> > added as an afterthought.
>
> Yes and we certainly want something that fits with the UKI models and
> the other commonplace models around.
>
> >
> > Lennart
> >
> > --
> > Lennart Poettering, Berlin
> >

